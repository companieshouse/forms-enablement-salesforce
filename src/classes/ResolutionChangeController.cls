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
                        showAssignedDate = true;

        }
    }
    private void persistStep() {
        if (submissionMgr.submission.Form_Name__c == 'SH15') {} else if (submissionMgr.submission.Form_Name__c == 'SH14') {}
        //if (classofshares == null || classofshares.length() == 0) {
        //    hasPageErrors = true;
        //    currentErrorMessage = 'Must add a class of shares';
        //    return null;
        //}
        //if (numberofshares.toPlainString() == '0') {
        //    hasPageErrors = true;
        //    currentErrorMessage = 'Must add the number of shares';
        //    return null;
        //}
        //if (aggregateNominalValue.toPlainString() == '0') {
        //    hasPageErrors = true;
        //    currentErrorMessage = 'Aggregate nominal value must be greater than 0';
        //    return null;
        //}
        //if (aggregateunpaidAmount.toPlainString() == '0') {
        //    hasPageErrors = true;
        //    currentErrorMessage = 'Must add the  total amount unpaid on each share (if any)';
        //    return null;
        //submissionMgr.submission.redenominateDate__c = redenominateDate;
        //submissionMgr.submission.reduceCapitalDate__c = reduceCapitalDate;
        // submissiongMgr.submission.AssignmentDate__c = assignmentDate
        submissionMgr.persist();
    }
    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;
        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
}
