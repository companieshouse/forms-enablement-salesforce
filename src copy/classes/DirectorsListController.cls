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
            PageReference pg = Page.UpdateCompanyDirectors;
            pg.getParameters().put('c', ApexPages.currentPage().getParameters().get('c'));
            pg.setRedirect(true);
            //throw new Form_CustomException(' here is your exception. .adf.a,sdfasdf ===='+ pg);
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

            //We want only director that haven't resign and or will resign in futur 
            Integer recipientID = 1;
            for(CompaniesHouse.OfficerDetails officer : directorDetailsList){
                if(officer.officer_role == 'director' && (officer.resigned_on == null || officer.resigned_on > date.today()))
                {
					isLLPCompany = false;
                    listOfDirectors.add(officer.name);
                    //Temporary save an address email against each officer and save officer to the transaction
                    officerList.add(new Officer__c(Name= officer.name , RecipientId__c = String.valueOf(recipientID), Transaction__c =submissionMgr.submission.Id ));
                    recipientID++;

                }else if (officer.officer_role == 'llp-designated-member' && (officer.resigned_on == null || officer.resigned_on > date.today())) {
                    isLLPCompany = true;
                    listOfDirectors.add(officer.name);
                    //Temporary save an address email against each officer and save officer to the transaction
                    officerList.add(new Officer__c(Name = officer.name, RecipientId__c = String.valueOf(recipientID), Transaction__c = submissionMgr.submission.Id));
                    recipientID++;
                }
            }

            nbOfOfficers = listOfDirectors.size();

            //Insert the officer
            insert officerList;
        }
        
    }
}