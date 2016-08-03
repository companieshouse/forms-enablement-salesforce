/*
Name:  UpdateCompanyDirectorsController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Summary

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Sylvain P     2016-06-16  Initial development.
*/
public with sharing class UpdateCompanyDirectorsController extends TransactionStepControllerBase {

    public String body {get; set;}
    public String link {get; set;}
    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}
    public Boolean signingFinished {get; set;}

    // Constructors.
    public UpdateCompanyDirectorsController() {
        super();

        if (isPageInitialised) initialiseStep();
    }
    // End Constructors.

    // Instance methods.
    private void initialiseStep() {
        stepValidator = isPageAlreadyValidStep;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;


        body = 'You must update details of company OFFICERTERM before you can proceed with your request to close the company.<br/><br/>Once you\'ve updated these details, you\'ll need to return to this service to complete your request.';
        link = 'Update company OFFICERTERM now';

        body = body.replace('OFFICERTERM', submissionMgr.submission.officerTerminology__c);
        link = link.replace('OFFICERTERM', submissionMgr.submission.officerTerminology__c);
        return;
    }

    public PageReference redirectUser() {
        //The framework has been decomissioned to now redirect to the company details page once you click the link start again
        if (isPageAlreadyValidStep)
            if (submissionMgr.submission.isDigitalSignatureNeeded__c && !submissionMgr.submission.isSigningFinished__c) {
                if (submissionMgr.submission.Id != null) {
                    //update the transaction first
                    submissionMgr.submission.Status__c = 'deleteContact';
                    //Save the transaction type
                    String transactionType = submissionMgr.submission.Transaction_Type__c;
                    Id presenterID = submissionMgr.submission.Presenter__c;
                    String presenterEmail = submissionMgr.submission.ContactEmail__c;
                    Account companyId = submissionMgr.submission.Company__r;
                    update submissionMgr.submission;
                    delete submissionMgr.submission;
                    Id submissionId = submissionMgr.initialise(transactionType, presenterID, presenterEmail, companyId, transactionMgr.td);
                    PageReference pg = transactionMgr == null ? null : transactionMgr.firstStep(submissionId);

                    pg.setRedirect(true);
                    return pg;
                }
            }
        return null;
    }

    // End Instance methods.

}