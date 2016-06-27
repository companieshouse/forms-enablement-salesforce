/*
Name:  BehalfDecisionController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: BehalfDecision

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  SylvainP      2016-06-16  Initial development.
*/
public with sharing class BehalfDecisionController extends TransactionStepControllerBase {

    public Boolean hasPageErrors { get; set; }
    public Boolean showNoError {get; set;}

    public Boolean behalfValidation {get; set;}
    public Boolean isLLPCompany {get; set;}

    public String textBox1 {get; set;}
    public String headerBox1 {get; set;}

    public BehalfDecisionController(){
        super();
        if (isPageInitialised) initialiseStep();

    }

    
    
    public void initialiseStep() {
        
       
        showNoError = false;
        isLLPCompany = submissionMgr.submission.isLLP__c;

        textBox1 = (transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c);
        textBox1 += (transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c);
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
        if(behalfValidation != null)
            submissionMgr.submission.isBehalfSignatoryEnable__c = behalfValidation;
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

        if(submissionMgr.submission.SoleDirectorPresenter__c)
        {
            return nextAction();
        }

        return null;
    }
}