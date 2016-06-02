/*
Name:  PresenterDirectorController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: DirectorsInputList

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-02-04  Initial development.
*/
public with sharing class PresenterDirectorController extends TransactionStepControllerBase {

    public Boolean hasPageErrors { get; set; }
    public Boolean hasPageErrorsDirector {get; set;}

    public String companyName {get; set;}
    public String companyNumber {get; set;}
    public List<officerContainer> listOfDirectors {get; set;}
    public Boolean directorPresenter {get; set;}
    public Id selectedId {get; set;}
    public String presenterName {get; set;}
    public String phoneNumber {get; set;}

    public String behalfName {get; set;}
    public String behalfEmail {get; set;}
    public Boolean signBehalf {get; set;}
    public Integer behalfSelected {get; set;}
    public Id selectedBehalfId {get; set;}
    public Boolean isLLPCompany { get;
        set; }

    public PresenterDirectorController(){
        super();
        if (isPageInitialised) initialiseStep();

    }
    
    public void initialiseStep() {

        //Set up the company name
        directorPresenter = false;
        hasPageErrorsDirector = false;
        phoneNumber = '';
        presenterName = '';
        behalfName = '';
        behalfEmail = '';
        behalfSelected = 0;
        signBehalf = false;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        listOfDirectors = new List<officerContainer>();
		isLLPCompany = submissionMgr.submission.isLLP__c;

        

        return;
       
    }

    private void persistStep(){
    	if(directorPresenter)
        {
        	for(Officer__c off :submissionMgr.submission.Officers__r)
	        {
	            for(officerContainer offCont :listOfDirectors)
	            {
	                if(off.Id == offCont.officer.Id)
	                {
                        if(offCont.isPresenter)
                        {
	                        off.isPresenter__c = offCont.isPresenter;
                            off.isSignatory__c = true;
                            off.Email__c = submissionMgr.submission.Presenter__r.Name;
							//ab populate Presenter Name field with Director Name
                            submissionMgr.submission.PresenterName__c = convertName(off.Name);
                        }
                        off.isDeceased__c = false;
                        off.isCorporateDirector__c = false;
                        off.isPowerOfAttorney__c = false;
	                }
	            }
	        }

            behalfSelected = 0;
            //Remove presenter details from trsansaction if the officer is selected.
            submissionMgr.submission.PresenterPhoneNumber__c = null;
            submissionMgr.submission.PresenterName__c = null;

	    }
	    else
	    {
	    	submissionMgr.submission.PresenterPhoneNumber__c = phoneNumber;
        	submissionMgr.submission.PresenterName__c = presenterName;
            
            //remove existing flag in case of previous from officer
            for(Officer__c off :submissionMgr.submission.Officers__r)
            {
                for(officerContainer offCont :listOfDirectors)
                {
                    if(off.Id == offCont.officer.Id)
                    {
                        off.isPresenter__c = false;
                        off.isSignatory__c = false;
                        off.Email__c = null;
                        
                        off.isDeceased__c = false;
                        off.isCorporateDirector__c = false;
                        off.isPowerOfAttorney__c = false;
                    }
                }
            }
	    }

        
        //We are presenter signing on behalf
        if(behalfSelected != 0)
        {
            for(Officer__c off :submissionMgr.submission.Officers__r)
            {
                for(officerContainer offCont :listOfDirectors)
                {
                    if(off.Id == offCont.officer.Id)
                    {
                        if(offCont.isSignatory)
                        {
                            off.isPresenter__c = true;
                            off.isSignatory__c = offCont.isSignatory;
                            off.Email__c = behalfEmail;
                            off.AuthorizedSigner__c = presenterName;
                            if(behalfSelected == 1)
                            {
                                off.isDeceased__c = true;
                                off.isCorporateDirector__c = false;
                                off.isPowerOfAttorney__c = false;
                            }
                            else if(behalfSelected == 2)
                            {
                                off.isDeceased__c = false;
                                off.isCorporateDirector__c = true;
                            }
                            else if(behalfSelected == 3)
                            {
                                off.isDeceased__c = false;
                                off.isPowerOfAttorney__c = true;
                            }
                        }
                        else{
                            off.isDeceased__c = false;
                            off.isCorporateDirector__c = false;
                            off.isPowerOfAttorney__c = false;
                        }
                    }
                }
            }
        }


        submissionMgr.persist();    
    }
    // End Instance methods.    

    public Boolean isPresentorCorrect(){
        if(!directorPresenter)
        {
            if(phoneNumber.length() > 11 || phoneNumber.isAlphanumeric())
                return false;
            //Not mandatory
            //if(String.isEmpty(phoneNumber) || String.isEmpty(presenterName))
               // return false;

        }
        hasPageErrors = false;
        return true;
    }

    // Action methods.     
    public PageReference nextAction(){     
        if(!isPresentorCorrect())
        {
            hasPageErrors = true;
            return null;
        }

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
        
        //Get the list officer already created
        if(submissionMgr.submission.Officers__r != null)
        {
            if(submissionMgr.submission.Officers__r.size() > 0)
            {
                for(Officer__c off :submissionMgr.submission.Officers__r)
                {
                    listOfDirectors.add(new officerContainer(off));
                    if(off.isPresenter__c)
                    {
                    	directorPresenter = true;
                    	selectedId = off.Id;
                    }
                }
            }
        }

        if(submissionMgr.submission.PresenterPhoneNumber__c != null || submissionMgr.submission.PresenterName__c != null)
        {
        	phoneNumber = submissionMgr.submission.PresenterPhoneNumber__c;
        	presenterName = submissionMgr.submission.PresenterName__c;
        	directorPresenter = false;
        }

        
    }


    public PageReference updateBDCPA(){
        return null;
    }

    public PageReference updatePresenter()
    {
        if(directorPresenter == true)
            hasPageErrorsDirector = true;
        else
            hasPageErrorsDirector = false;
    	return null;
    }

    public PageReference updateBehalf()
    {
        return null;
    }

	public PageReference updateSelectedPresenter()
    {
        hasPageErrorsDirector = false;

    	if(selectedId != null)
    	{
    		for(officerContainer off :listOfDirectors)
            {
                if(off.officer.Id != selectedId)
                {
                	off.isPresenter = false;
                }
                else
                {
                	off.isPresenter = true;
                }
            }
    	}
    	return null;
    }

    public PageReference updateSelectedBehalf()
    {
        if(selectedBehalfId != null)
        {
            for(officerContainer off :listOfDirectors)
            {
                if(off.officer.Id != selectedBehalfId)
                {
                    off.isSignatory = false;
                }
                else
                {
                    off.isSignatory = true;
                }
            }
        }
        return null;
    }
	
	// API is returning last name + first Name
    // This function set name in the correct order
    private String convertName(String name) {
        String firstName;
        String lastName;

        firstName = name.substringAfter(',') + ' ';

        lastName = name.substringBefore(',');
        lastName = lastName.toLowerCase();
        lastName = lastName.capitalize();

        return firstName + lastName;
    }
    

    public with sharing class officerContainer{

        public Officer__c officer {get; set;}
        public String officerTXT {get; set;}
        public Boolean isPresenter {get; set;}
        public Boolean isSignatory {get; set;}

        public officerContainer(Officer__c off)
        {
            officer = off;
            officerTXT = off.Name;
            isPresenter = (off.isPresenter__c == null ? false : off.isPresenter__c);
            isSignatory = (off.isSignatory__c == null ? false : off.isSignatory__c);
        }
    }
}