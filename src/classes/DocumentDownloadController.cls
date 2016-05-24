/*
Name:  DocumentDownloadControler.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------
Controller class for the Visualforce Page: DocumentDownloadController
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-18-5    Framework Controller for client PDF Viewing/Downloading 
*/


public class DocumentDownloadController extends TransactionStepControllerBase{
    
// Public properties.
    public Boolean hasPageErrors { get; set; }

    public Id attachmentId {get; private set;}

    public String submissionId {get; private set;}
    public String companyName {get; set;}

    public Boolean showDoc {get; private set;}
    public String displayText3 {get; set;}

    public String title {get; private set;}
    public String transactionType {get;  set;}

    public String size {get; private set;}
    
    public DocumentDownloadController() {
        super();
        if (isPageInitialised) initialiseStep();

    }
    
    public void initialiseStep() {
   			submissionId = submissionMgr.submission.SubmissionId__c;
            companyName = submissionMgr.submission.CompanyName__c;
            displayText3 = transactionMgr.currentStep.Display_Text_3__c;
			transactionType	= submissionMgr.submission.Transaction_Type__c;


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

        return;
    }

    // this should be removed as there will be nothing persisted
    private void persistStep(){
        submissionMgr.persist();    
    }
    // End Instance methods.    
    
      // next/previous actions will be removed from this module as this will be a standalone

    // Action methods.   
    /*  
    public PageReference nextAction(){ 
        if (!validatePageState()) return Page.TransactionException;
        
        persistStep();      

        return nextStep();      
    }
    
    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }
    // End Action methods.    
        */

}