/*
Name:  BehalfWhichSignatoryController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: BehalfWhichSignatory

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  SylvainP      2016-06-17  Initial development.
*/
public with sharing class BehalfWhichSignatoryController extends TransactionStepControllerBase {

    public Boolean hasPageErrors { get; set; }
    public Boolean showNoError {get; set;}

    public Boolean behalfValidation {get; set;}
    public Boolean isLLPCompany {get; set;}

    public String textBox1 {get; set;}
    public String headerBox1 {get; set;}

    public Id selectedId {get; set;}
    public List<officerContainer> listOfDirectors {get; set;}

    public BehalfWhichSignatoryController(){
        super();
        if (isPageInitialised) initialiseStep();
    }

    
    
    public void initialiseStep() {
       
        showNoError = false;
        isLLPCompany = submissionMgr.submission.isLLP__c;

        textBox1 = (transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c);
        headerBox1 = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c );

        if(isLLPCompany)
        {
            headerBox1 = headerBox1.replace('Director', 'Member');
            headerBox1 = headerBox1.replace('Directors', 'Members');

            headerBox1 = headerBox1.replace('director', 'member');
            headerBox1 = headerBox1.replace('directors', 'members');

            textBox1 = textBox1.replace('Director', 'Member');
            textBox1 = textBox1.replace('Directors', 'Members');

            textBox1 = textBox1.replace('director', 'member');
            textBox1 = textBox1.replace('directors', 'members');
        }  

        return; 
    }

    private void persistStep(){
        if(listOfDirectors == null)
            return;
            
    	for(Officer__c off :submissionMgr.submission.Officers__r)
        {
            for(officerContainer offCont :listOfDirectors)
            {
                if(off.Id == offCont.officer.Id)
                {
                    if(offCont.isSignatoryBehalf)
		    		{
		    			off.isSignatoryBehalf__c = offCont.isSignatoryBehalf;
		    		}
                }
            }
        }

        submissionMgr.persist();    
    }
    // End Instance methods.    
    
    // Action methods.     
    public PageReference nextAction(){ 
        if (!validatePageState()) return Page.TransactionException;

        persistStep();      

        return nextStep();      
    }
    
    public void updateDirectorList(){
    }

    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }

    public PageReference initPage(){
        initialiseAction();

        if(submissionMgr.submission.SoleDirectorPresenter__c || !submissionMgr.submission.isBehalfSignatoryEnable__c)
        {
            return nextAction();
        }

        listOfDirectors = new List<officerContainer>();
        //Initialise the list of directors
        for(Officer__c off : submissionMgr.submission.Officers__r){
        	if(off.isSignatory__c && !off.IsPresenter__c)
        	{
        		listOfDirectors.add(new officerContainer(off));
        	}
        }

        return null;
    }

    public PageReference updateSelectedPresenter()
    {
    	if(selectedId != null)
    	{
    		for(officerContainer off :listOfDirectors)
            {
                if(off.officer.Id != selectedId)
                {
                	off.isSignatoryBehalf = false;
                }
                else
                {
                	off.isSignatoryBehalf = true;
                }
            }
    	}

    	return null;
    }

    public with sharing class officerContainer{

        public Officer__c officer {get; set;}
        public String officerTXT {get; set;}
        public Boolean isPresenter {get; set;}
        public String email {get; set;}
        public Boolean isSignatory {get; set;}
        public String authName {get; set;}
        public Boolean deceased {get; set;}
        public Boolean corp {get; set;}
        public Boolean poa {get; set;}
        public Boolean isSignatoryBehalf {get; set;}

        public officerContainer(Officer__c off)
        {
            officer = off;
            officerTXT = off.Name;
            email = off.Email__c;
            authName = off.AuthorizedSigner__c;
            deceased = (off.isDeceased__c == null ? false : off.isDeceased__c);
            corp = (off.isCorporateDirector__c == null ? false : off.isCorporateDirector__c);
            poa = (off.isPowerOfAttorney__c == null ? false : off.isPowerOfAttorney__c);
            isPresenter = (off.isPresenter__c == null ? false : off.isPresenter__c);
            isSignatory = (off.isSignatory__c == null ? false : off.isSignatory__c);
            isSignatoryBehalf = (off.isSignatoryBehalf__c == null ? false : off.isSignatoryBehalf__c);

        }
    }
}