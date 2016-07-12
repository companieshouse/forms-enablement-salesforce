/*
Name:  ResolutionChangeController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: ResolutionChange

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-06-05  Initial development.
*/
public with sharing class ResolutionChangeController extends TransactionStepControllerBase {
    public String companyName {
        get;
        set;
    }
    public String companyNumber {
        get;
        set;
    }
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String currentErrorMessage {
        get;
        set;
    }
    public String displayText {
        get;
        set;
    }
    public String displayText2 {
        get;
        set;
    }
    public String displayText3 {
        get;
        set;
    }
    public String displayText4 {
        get;
        set;
    }
    public String displayText5 {
        get;
        set;
    }
    public String displayText6 {
        get;
        set;
    }
    public String headerText1 {
        get;
        set;
    }
    public String headerText2 {
        get;
        set;
    }
    public String headerText3 {
        get;
        set;
    }
    public String previousButton {
        get;
        set;
    }
    public String continueButtonText {
        get;
        set;
    }
    public Date redenominateDate {
        get;
        set;
    }
    public Date reduceCapitalDate {
        get;
        set;
    }
    public Date assignmentDate {
        get;
        set;
    }
    public Boolean showRedenom {
        get;
        set;
    }
    public Boolean showReducedCap {
        get;
        set;
    }
    public Boolean showAssignedDate {
        get;
        set;
    }
    public String shareType {
        get;
        set;
    }
    public ResolutionChangeController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void initialiseStep() {
        displayText = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        displayText4 = transactionMgr.currentStep.Display_Text_4__c;
        displayText5 = transactionMgr.currentStep.Display_Text_5__c;
        displayText6 = transactionMgr.currentStep.Display_Text_6__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        headerText2 = transactionMgr.currentStep.Header_Text_2__c;
        headerText3 = transactionMgr.currentStep.Header_Text_3__c;
        previousButton = transactionMgr.currentStep.previousButtonText__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        shareType = submissionMgr.submission.Form_Name__c;
        buildFields();
    }
    public void buildFields() {
        if (submissionMgr.submission.Form_Name__c == 'SH13') {
            showAssignedDate = true;
        } else if (submissionMgr.submission.Form_Name__c == 'SH14') {
            showRedenom = true;
        } else if (submissionMgr.submission.Form_Name__c == 'SH15') {
            showRedenom = true;
            showReducedCap = true;
        } else if (submissionMgr.submission.Form_Name__c == 'SH02') {
            showReducedCap = true;
        }
    }
    private void persistStep() {
        List < Shares__c > sharesToAdd = new List < Shares__c > ();

        try {
            if (submissionMgr.submission.Form_Name__c == 'SH13') {
                sharesToAdd.add(new Shares__c(ShareType__c = shareType, Name = shareType, Transaction__c = submissionMgr.submission.Id, AssignmentDate__c = assignmentDate, ActiveData__c = true));
            } else if (submissionMgr.submission.Form_Name__c == 'SH14') {
                sharesToAdd.add(new Shares__c(ShareType__c = shareType, Name = sharetype, Transaction__c = submissionMgr.submission.Id, redenominateDate__c = redenominateDate, ActiveData__c = true));
            } else if (submissionMgr.submission.Form_Name__c == 'SH15') {
                sharesToAdd.add(new Shares__c(ShareType__c = shareType, Name = sharetype, Transaction__c = submissionMgr.submission.Id, redenominateDate__c = redenominateDate, reduceCapitalDate__c = reduceCapitalDate, ActiveData__c = true));
            } else if (submissionMgr.submission.Form_Name__c == 'SH02') {
                sharesToAdd.add(new Shares__c(ShareType__c = shareType, Name = sharetype, Transaction__c = submissionMgr.submission.Id, redenominateDate__c = redenominateDate, reduceCapitalDate__c = reduceCapitalDate, ActiveData__c = true));
            }
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
        submissionMgr.persist();
    }
    public PageReference nextAction() {
        if (submissionMgr.submission.Form_Name__c == 'SH13') {
            if (assignmentDate > date.today()) {
                hasPageErrors = true;
                currentErrorMessage = 'Date cannot be in the future';
                return null;
            }
            if (assignmentDate == null) {
                hasPageErrors = true;
                currentErrorMessage = 'You must enter the date of assignment.';
                return null;
            }
        } else if (submissionMgr.submission.Form_Name__c == 'SH14') {
            if (redenominateDate > date.today()) {
                hasPageErrors = true;
                currentErrorMessage = 'Date cannot be in the future';
                return null;
            }
            if (redenominateDate == null) {
                hasPageErrors = true;
                currentErrorMessage = 'You must enter the date on which the resolution passed.';
                return null;
            }
        } else if (submissionMgr.submission.Form_Name__c == 'SH15') {
            if (redenominateDate > date.today()) {
                hasPageErrors = true;
                currentErrorMessage = 'Redenomination date cannot be in the future';
                return null;
            }
            if (redenominateDate == null) {
                hasPageErrors = true;
                currentErrorMessage = 'You must enter the date on which the resolution to redenominate passed.';
                return null;
            }
            if (reduceCapitalDate > date.today()) {
                hasPageErrors = true;
                currentErrorMessage = 'Resolution to reduce capital date cannot be in the future';
                return null;
            }
            if (reduceCapitalDate == null) {
                hasPageErrors = true;
                currentErrorMessage = 'You must enter the date on which the resolution to reduce capital passed.';
                return null;
            }
        } else if (submissionMgr.submission.Form_Name__c == 'SH02') {
            if (reduceCapitalDate > date.today()) {
                hasPageErrors = true;
                currentErrorMessage = 'Date cannot be in the future';
                return null;
            }
            if (reduceCapitalDate == null) {
                hasPageErrors = true;
                currentErrorMessage = 'You must enter a resolution date.';
                return null;
            }
        }
        if (!validatePageState()) return Page.TransactionException;
        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
}
