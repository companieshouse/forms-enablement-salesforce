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

	public String companyName {get; set;}
	public String companyNumber {get; set;}
	public Boolean validationDirector {get; set;}
	public List<String> listOfDirectors {get; set;}

	public DirectorsListController(){
    	super();
        if (isPageInitialised) initialiseStep();

    }
    
    public void initialiseStep() {
    	//Set up the company name 
    	companyName = submissionMgr.submission.CompanyName__c;
    	companyNumber = submissionMgr.submission.CompanyNumber__c;
    	listOfDirectors = new List<String>();

    	return;
       
    }

    private void persistStep(){
        submissionMgr.persist();    
    }
    // End Instance methods.    
    
    // Action methods.     
    public PageReference nextAction(){ 
        if (!validatePageState()) return Page.TransactionException;
        
        persistStep();      

        return nextStep();      
    }
    
    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }

    public void populateDirectorList(){
    	initialiseAction();
    	if(companyNumber == null)
    	{
    		listOfDirectors.add('Sylvain Picory');
    		return;
    	}

    	//Make the call to the list of directors
        List<CompaniesHouse.OfficerDetails> directorDetailsList = OfficersQueryAction.getOfficers(companyNumber);

        List<Officer__c> officerList = new List<Officer__c>();

        //We want only director that haven't resign and or will resign in futur 
        for(CompaniesHouse.OfficerDetails officer : directorDetailsList){
            if(officer.officer_role == 'director' && (officer.resigned_on == null || officer.resigned_on > date.today()))
            {
                listOfDirectors.add(officer.name);
                //Temporary save an address email against each officer and save officer to the transaction
                officerList.add(new Officer__c(Name= officer.name, Email__c = 'sylvain.picory@methodsdigital.co.uk' , Transaction__c =submissionMgr.submission.Id ));

            }
        }

        //Insert the officer
        insert officerList;
    }
}