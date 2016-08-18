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

    public Id attachmentId {get; private set;}

    public String submissionId {get; private set;}
    public String companyName {get; set;}

    public Boolean showDoc {get; private set;}
    public String displayHeader {get; set;}
    public String displayText1 {get; set;}
    public String subDate {get; set;}
    public String subTime {get; set;}


    // Constructors.
    public SubmissionController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    // End Constructors.

    // Instance methods.
    private void initialiseStep() {
        try {

            if (submissionMgr.submission.SubmissionId__c == null) {
                // we need to submit the transaction to chips..... or change the status
                // we need to change the submissionID__c to be our internal ID: SF ConfirmationID
                // the SubmissionID__c will generated from CHIPS and passed back to us eventually
                
                submissionMgr.submission.SubmissionId__c =  'FE' + submissionMgr.submission.Id;
                submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_PENDING_SUBMISSION; //  'Awaiting Submission';
            }

            submissionId = submissionMgr.submission.SubmissionId__c;
            companyName = submissionMgr.submission.CompanyName__c;
            displayHeader = transactionMgr.currentStep.Header_Text_1__c;
            
            displayText1 = transactionMgr.currentStep.Display_Text_1__c;

        } catch (Exception e) { return; }


        return;
    }
    // End Instance methods.


    private void persistStep() {
        submissionMgr.submission.submissionTime__c = String.valueOf(system.now().time());
        submissionMgr.submission.submissionDate__c = String.valueOf(system.today().format());
        submissionMgr.persist();
    }

    public PageReference nextAction() {
        if (submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_PENDING_SUBMISSION) {
            FormAPISubmissionManager submissionMgrAPI = new FormAPISubmissionManager();
            submissionMgr.submission = submissionMgrAPI.sendForm(submissionMgr.submission);
        }

        system.debug('Before save tx: ' + submissionMgr.submission);

        persistStep();

        if(submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_ERROR)
        {
            PageReference pg = new PageReference('/IntegrationError');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }
        // if(!validatePageState() || submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_ERROR)
        //   return Page.TransactionException;

        return nextStep();
    }

    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }
    // End Action methods.
}