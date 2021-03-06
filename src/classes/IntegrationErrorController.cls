/*
Name:  IntegrationErrorController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: IntegrationError

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Sylvain P     2016-08-10  Initial development.
*/
public with sharing class IntegrationErrorController extends TransactionStepControllerBase {

    public String title {get; set;}
    public String body {get; set;}
    public String link {get; set;}
   
    // Constructors.
    public IntegrationErrorController() {
        super();

        if (isPageInitialised) initialiseStep();
    }
    // End Constructors.

    // Instance methods.
    private void initialiseStep() {
        title = 'Sorry, we\'re experiencing technical problems.';
        body = 'Your return may not have been filed, but your responses so far have been saved.<br/><br/> <a class="govuk-link" href="https://www.gov.uk/contact-companies-house" >Call the helpdesk for further assistance</a>.';

     
        return;
    }

    private void persistStep() {
        submissionMgr.submission.submissionTime__c = String.valueOf(system.now().time());
        submissionMgr.submission.submissionDate__c = String.valueOf(system.today().format());
        submissionMgr.persist();
    }

    public PageReference startAgain(){
        if (Test.isRunningTest()) {
            system.debug('test is running');
        } else {
        FormAPISubmissionManager submissionMgrAPI = new FormAPISubmissionManager();
        if(submissionMgr.submission.Form_Name__c.contains('DS02'))
        {
            submissionMgr.submission = submissionMgrAPI.sendForm(submissionMgr.submission);
        }
        else{
            if(submissionMgr.submission.PrePaymentIntegrationStatus__c == AppConstants.REQUEST_STATUS_SUBMITTED)
                submissionMgr.submission = submissionMgrAPI.updatePayment(submissionMgr.submission);
            else if(submissionMgr.submission.PrePaymentIntegrationStatus__c == AppConstants.REQUEST_STATUS_ERROR)
            {
                submissionMgr.submission = submissionMgrAPI.sendForm(submissionMgr.submission);
                submissionMgr.submission = submissionMgrAPI.updatePayment(submissionMgr.submission);
            }
                
        }
        //FormAPISubmissionManager submissionMgrAPI = new FormAPISubmissionManager();
        //
        
        }
        submissionMgr.submission.AmendmentHistory__c += '<br/>-----------------------------------------------------------------------------------';
        submissionMgr.submission.AmendmentHistory__c += '<br/> Number Of Call static (Integration Page Fail): ' + FormsApiClient.numberOfTimeCalled;
        submissionMgr.submission.AmendmentHistory__c += '<br/>-----------------------------------------------------------------------------------';
        
        persistStep();

        if(submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_ERROR)
        {
            PageReference pg = new PageReference('/IntegrationError');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }
        
        return nextStep();
    }

    // End Instance methods.

}