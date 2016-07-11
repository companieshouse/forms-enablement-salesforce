/*
Name:  DirectorsListController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: DirectorsList

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class DirectorsListController extends TransactionStepControllerBase {

    public Boolean hasPageErrors { get; set; }
    public Boolean showNoError {get; set;}
    public Boolean hasAlreadyLoadedOfficers {get; set;}

    public String companyName {get; set;}
    public String companyNumber {get; set;}
    public Boolean validationDirector {get; set;}
    public List<String> listOfDirectors {get; set;}
    public Integer nbOfOfficers {get; set;}
	public Boolean isLLPCompany {get; set;}

    public DirectorsListController(){
        super();
        hasAlreadyLoadedOfficers = false;
        if (isPageInitialised) initialiseStep();

    }

    
    
    public void initialiseStep() {
        
        //Set up the company name
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        listOfDirectors = new List<String>();
        showNoError = false;
		isLLPCompany = submissionMgr.submission.isLLP__c;
        if(isPageAlreadyValidStep)
        {
            hasAlreadyLoadedOfficers = true;
        }
        //Get the list officer already created
        if(submissionMgr.submission.Officers__r != null)
        {
            if(submissionMgr.submission.Officers__r.size() == 0)
            {
                hasAlreadyLoadedOfficers = false;
            }
        }

        nbOfOfficers = 0;
        return;
       
    }

    private void persistStep(){
        submissionMgr.submission.CompanyName__c = companyName;
        submissionMgr.submission.OfficerCount__c = nbOfOfficers;
		submissionMgr.submission.isLLP__c = isLLPCompany;
        submissionMgr.persist();    
    }
    // End Instance methods.    
    
    // Action methods.     
    public PageReference nextAction(){ 
        if (!validatePageState()) return Page.TransactionException;
        
        hasPageErrors=!validateStep();
        if (hasPageErrors) {

            return null;
        }

        if(validationDirector == false)
        {
                        PageReference pg = new PageReference('/UpdateCompanyDirectors');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id+AppConstants.ID_DELIM_CHAR+transactionMgr.currentStep.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }

        persistStep();      

        return nextStep();      
    }

    private Boolean validateStep(){
        if(validationDirector == null)
            return false;

        return true;
    }
    
    public void updateDirectorList(){
        if(validationDirector == false)
            showNoError = true;
        else
            showNoError = false;
        hasPageErrors = false;
    }

    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }

    //Method used to extract the title from the name of an officer, return null if no title found
    // 0 = surname 1= forename and middlename 2 = title null incorrect module value or corporate name -_-
    public String extractOfficerName(Integer module, String name)
    {
        if(name.contains(','))
        {
            String[] extract = name.split(',');
            if(extract.size()-1 >= module)
                if(!String.isBlank(extract[module]))
                {
                    return extract[module];
                }
        }

        return null;
    }

    public void populateDirectorList(){
        initialiseAction();
        if(companyNumber == null)
        {
            listOfDirectors.add('No Officers found.');
            return;
        }
        
        
        if(hasAlreadyLoadedOfficers)
        {
			isLLPCompany = submissionMgr.submission.isLLP__c; 
            //Get the list officer already created
            if(submissionMgr.submission.Officers__r != null)
            {
                if(submissionMgr.submission.Officers__r.size() > 0)
                {
                    for(Officer__c off :submissionMgr.submission.Officers__r)
                    {
                        listOfDirectors.add(off.Name);
                    }
                }
            }
        }
        else
        {

            //Make the call to the list of directors
            List<CompaniesHouse.OfficerDetails> directorDetailsList = OfficersQueryAction.getOfficers(companyNumber);

            List<Officer__c> officerList = new List<Officer__c>();

            for(CompaniesHouse.OfficerDetails officer : directorDetailsList){
                if(officer.officer_role == 'director' && (officer.resigned_on == null || officer.resigned_on > date.today()))
                {
					isLLPCompany = false;
                    listOfDirectors.add(officer.name);
                    //Temporary save an address email against each officer and save officer to the transaction
                    officerList.add(new Officer__c(Name= officer.name ,Title__c = extractOfficerName(2, officer.name),
                    Forename__c = (extractOfficerName(1, officer.name) != null ? (extractOfficerName(1, officer.name).substringAfter(' ').substringBefore(' ')) : null),
                    Middlenames__c = (extractOfficerName(1, officer.name) != null ? (extractOfficerName(1, officer.name).substringAfter(' ').substringAfter(' ')): null),
                      Surname__c = (extractOfficerName(0, officer.name) == null ? officer.name : extractOfficerName(0, officer.name)), Transaction__c =submissionMgr.submission.Id ));

                }else if (officer.officer_role == 'llp-designated-member' && (officer.resigned_on == null || officer.resigned_on > date.today())) {
                    isLLPCompany = true;
                    listOfDirectors.add(officer.name);
                    //Temporary save an address email against each officer and save officer to the transaction
                    officerList.add(new Officer__c(Name= officer.name ,Title__c = extractOfficerName(2, officer.name),
                    Forename__c = (extractOfficerName(1, officer.name) != null ? (extractOfficerName(1, officer.name).substringAfter(' ').substringBefore(' ')) : null),
                    Middlenames__c = (extractOfficerName(1, officer.name) != null ? (extractOfficerName(1, officer.name).substringAfter(' ').substringAfter(' ')): null),
                      Surname__c = (extractOfficerName(0, officer.name) == null ? officer.name : extractOfficerName(0, officer.name)),  Transaction__c =submissionMgr.submission.Id ));
                }
            }

            nbOfOfficers = listOfDirectors.size();

            //Insert the officer
            insert officerList;
        }
        
    }
}