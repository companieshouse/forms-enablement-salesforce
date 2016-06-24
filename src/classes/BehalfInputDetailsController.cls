/*
Name:  BehalfInputDetailsController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: BehalfInputDetails

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  SylvainP      2016-06-17  Initial development.
*/
public with sharing class BehalfInputDetailsController extends TransactionStepControllerBase {

    public Boolean hasPageErrors { get; set; }
    public Boolean showNoError {get; set;}

    public Boolean behalfValidation {get; set;}
    public Boolean isLLPCompany {get; set;}

    public String textBox1 {get; set;}
    public String textBox2 {get; set;}
    public String textBox3 {get; set;}

    public String headerBox1 {get; set;}

    public Officer__c currentOfficer {get; set;}

    public String nameAuthorized {get; set;}
    public String emailDirector {get; set;}

    public Integer behalfSelection {get; set;} //0 for nothing 1 poa 2 deceased 3 corp

    public BehalfInputDetailsController(){
        super();
        if (isPageInitialised) initialiseStep();
    }

    
    
    public void initialiseStep() {
       
        showNoError = false;
        isLLPCompany = submissionMgr.submission.isLLP__c;

        textBox1 = (transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c);
        textBox2 = (transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c);
        textBox3 = (transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c);
        headerBox1 = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c );

        nameAuthorized = '';	
        emailDirector = '';	
        behalfSelection = 0;

        return; 
    }

    private void persistStep(){
    	if(currentOfficer == null)
    		return;

    	for(Officer__c off :submissionMgr.submission.Officers__r)
        {
            if(off.Id == currentOfficer.Id)
            {
                off.hasInputBehalfDetails__c = true;
                off.AuthorizedSigner__c = nameAuthorized;
                off.Email__c = emailDirector;
                
                if(behalfSelection == 1)
                {
                	off.isPowerOfAttorney__c = true;
                }
                else if(behalfSelection == 2)
                {
                	off.isDeceased__c = true;
                }
                else if(behalfSelection == 3)
                {
                	off.isCorporateDirector__c = true;
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

        Boolean hasFinishedOfficerList = true;

        for(Officer__c off :submissionMgr.submission.Officers__r)      
        {
        	if(!off.hasInputBehalfDetails__c && !off.IsPresenter__c && off.isSignatoryBehalf__c)
        	{
        		hasFinishedOfficerList = false;
        	}
        }

        //Refresh the screen to pick the next officer...
        if(!hasFinishedOfficerList)
        {
        	PageReference pg = new PageReference('/BehalfInputDetails');
        	pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id+AppConstants.ID_DELIM_CHAR+transactionMgr.currentStep.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));
        	pg.setRedirect(true);

        	return pg;
        }


        return nextStep();      
    }
    
    public void updateSelectedBehalf(){
    }

    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }

    public PageReference initPage(){
        initialiseAction();

        if(submissionMgr.submission.SoleDirectorPresenter__c)
        {
            return nextAction();
        }

        System.debug(LoggingLevel.ERROR,'New Run' + currentOfficer);

        //Initialise the current directors
        for(Officer__c off : submissionMgr.submission.Officers__r){
        	if(!off.hasInputBehalfDetails__c && !off.IsPresenter__c && off.isSignatoryBehalf__c)
        	{
        		currentOfficer = off;
        	}
        }

        System.debug(LoggingLevel.ERROR,'After loop' + currentOfficer);

        if(currentOfficer == null)
        	return nextAction();

        headerBox1 = headerBox1.replace('DIRECTORNAME', currentOfficer.Name);

        textBox3 = textBox3.replace('DIRECTORNAME', currentOfficer.Name);

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

            textBox2 = textBox2.replace('Director', 'Member');
            textBox2 = textBox2.replace('Directors', 'Members');

            textBox2 = textBox2.replace('director', 'member');
            textBox2 = textBox2.replace('directors', 'members');

            textBox3 = textBox1.replace('Director', 'Member');
            textBox3 = textBox1.replace('Directors', 'Members');

            textBox3 = textBox1.replace('director', 'member');
            textBox3 = textBox1.replace('directors', 'members');
        }  

        return null;
    }

}