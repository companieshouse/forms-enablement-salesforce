/*
Name:  ConfirmationController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Confirmation

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class ConfirmationFrameworkController extends TransactionStepControllerBase {
    
    // Public properties.

    public String title {get; private set;}

    public String size {get; private set;}

    public String todayThreeMonths {get; set;}

    public Id attachmentId {get; private set;}

    public String submissionId {get; private set;}
    public String companyName {get; set;}

    public Boolean showDoc {get; private set;}
    public String displayText3 {get; set;}

            
    // Constructors.
    public ConfirmationFrameworkController(){
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
                submissionMgr.submission.Status__c = 'Awaiting Submission';
            }

            submissionId = submissionMgr.submission.SubmissionId__c;
            companyName = submissionMgr.submission.CompanyName__c;
            displayText3 = transactionMgr.currentStep.Display_Text_3__c;

            if(displayText3.contains('COMPANYNAME'))
            {
                displayText3 = displayText3.replace('COMPANYNAME', companyName);
            }

            if(submissionMgr.submission.attachments != null)
            {
                if(submissionMgr.submission.attachments.size() > 0)
                {
                    showDoc = true;
                    attachmentId = submissionMgr.submission.attachments[0].Id;
                    title = submissionMgr.submission.attachments[0].Name;
                    Integer sizeInt = submissionMgr.submission.attachments[0].BodyLength;
                    String tempSize = String.valueOf(sizeInt);
                    size = tempSize.left(3);
                    //MB
                    if(tempSize.length() >= 9)
                    {   
                        size += 'M';
                    }
                    //KB
                    else if(tempSize.length() >= 6 && tempSize.length() < 9)
                    {   
                        size += 'K';
                    }
                }
            }
            else
            {
                title = 'NA';
                size = 'NA';
                attachmentId = null;
            }

            todayThreeMonths = system.today().day() + '-' + system.today().addMonths(3).month() + '-' +  system.today().year();


      } catch (Exception e){ return; } 

        
      return;
    }

    public void saveTransaction(){
        persistStep();      
    }
  
  private void persistStep(){
    submissionMgr.persist();    
  }
  // End Instance methods.  
  
    
    public PageReference previousAction(){
      if (!validatePageState()) return Page.TransactionException;
            
      return previousStep();
    }
    // End Action methods.    
}