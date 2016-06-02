/*
Name:  SubmissionController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Submission

======================================================
======================================================
History
------- 
Ver. Author         Date        Detail
1.0  Antonio Bravo  2016-05-27  Initial development.
*/
public with sharing class SubmissionController extends TransactionStepControllerBase {
    
    // Public properties.

    public String title {get; private set;}

    public String size {get; private set;}

    public String todayThreeMonths {get; set;}

    public Id attachmentId {get; private set;}

    public String submissionId {get; private set;}
    public String companyName {get; set;}

    public Boolean showDoc {get; private set;}
    public String displayHeader {get; set;}
    public String displayText1 {get; set;}
    public String displayText2 {get; set;}
    public String displayText3 {get; set;}

            
    // Constructors.
    public SubmissionController(){
      super();
      if (isPageInitialised) initialiseStep();
    }
    // End Constructors.
    
    // Instance methods.
    private void initialiseStep(){
      try {

            if(submissionMgr.submission.SubmissionId__c == null)
            {
                // we need to submit the transaction to chips..... or change the status 
                // we need to change the submissionID__c to be our internal ID: SF ConfirmationID
                // the SubmissionID__c will generated from CHIPS and passed back to us eventually
                Blob b = Crypto.GenerateAESKey(128);
                String h = EncodingUtil.ConvertTohex(b);
                String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
                submissionMgr.submission.SubmissionId__c =  guid;
                submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_PENDING_SUBMISSION; //  'Awaiting Submission';
            }

            submissionId = submissionMgr.submission.SubmissionId__c;
            companyName = submissionMgr.submission.CompanyName__c;
            displayHeader = transactionMgr.currentStep.Header_Text_1__c;
            displayText1 = transactionMgr.currentStep.Display_Text_1__c;
            displayText2 = transactionMgr.currentStep.Display_Text_2__c;
            displayText3 = transactionMgr.currentStep.Display_Text_3__c;

            if(displayText3.contains('COMPANYNAME'))
            {
                displayText3 = displayText3.replace('COMPANYNAME', companyName);
            }


            todayThreeMonths = system.today().day() + '-' + system.today().addMonths(3).month() + '-' +  system.today().year();


      } catch (Exception e){ return; } 

        
      return;
    }
    // End Instance methods.  
  
  
    private void persistStep(){
        submissionMgr.persist();    
    }
  
  
    public PageReference nextAction(){ 
        if(submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_PENDING_SUBMISSION){
            FormAPISubmissionManager submissionMgrAPI = new FormAPISubmissionManager();
            submissionMgr.submission = submissionMgrAPI.sendForm(submissionMgr.submission);
        }

        system.debug('Before save tx: ' + submissionMgr.submission);

        persistStep();

        if(!validatePageState() || submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_ERROR)
            return Page.TransactionException;

        return nextStep();      
    }

    public PageReference previousAction(){
      if (!validatePageState()) return Page.TransactionException;
            
      return previousStep();
    }
    // End Action methods.    
}