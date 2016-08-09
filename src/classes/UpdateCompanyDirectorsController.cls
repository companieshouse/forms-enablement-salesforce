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

    public String title {get; set;}
    public String body {get; set;}
    public String link {get; set;}
    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}
    public Boolean signingFinished {get; set;}
    public Boolean isLLPf {get; set;}

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

        title = 'Update company OFFICERTERM';
        body = 'You must update details of company OFFICERTERM before you can proceed with your request to close the company.<br/><br/>Once you\'ve updated these details, you\'ll need to return to this service to complete your request.';
        link = 'Update company OFFICERTERM now';

        title = title.replace('OFFICERTERM', submissionMgr.submission.officerTerminology__c);
        body = body.replace('OFFICERTERM', submissionMgr.submission.officerTerminology__c);
        link = link.replace('OFFICERTERM', submissionMgr.submission.officerTerminology__c);

        isLLPf = submissionMgr.submission.isLLP__c;
        return;
    }

    // End Instance methods.

}