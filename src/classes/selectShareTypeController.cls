/*
Name:  AddSharesTableController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: AddShares

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-06  Initial development.
*/
public with sharing class selectShareTypeController extends TransactionStepControllerBase {
    public String selectedTransactionType {
        get;
        set;
    }
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
    public String button1 {
        get;
        set;
    }
    public String continueButtonText {
        get;
        set;
    }
    public Boolean showprevious {
        get;
        set;
    }
    public selectShareTypeController() {

        super();
        if (isPageInitialised) initialiseStep();

    }
    public void initialiseStep() {
                                                //throw new Form_CustomException('here is the submissionID' + submissionId);

        displayText = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        displayText4 = transactionMgr.currentStep.Display_Text_4__c;
        displayText5 = transactionMgr.currentStep.Display_Text_5__c;
        displayText6 = transactionMgr.currentStep.Display_Text_6__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        headerText2 = transactionMgr.currentStep.Header_Text_2__c;
        headerText3 = transactionMgr.currentStep.Header_Text_3__c;
        button1 = transactionMgr.currentStep.ContinueButtonText__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        showprevious = false;
    }
    private void persistStep() {
        if (selectedTransactionType == 'Normal') {
            submissionMgr.submission.trueTransactionName__c = 'SH06';
        } else if (selectedTransactionType == 'Treasury') {
            submissionMgr.submission.trueTransactionName__c = 'SH05';
        } else if (selectedTransactionType == 'Public Company') {
            submissionMgr.submission.trueTransactionName__c = 'SH07';
        }
        submissionMgr.persist();
    }
    public void setErrors() {
        if (hasPageErrors == true) {
            currentErrorMessage = 'Please make a valid share selection before going to the next step';
        } else if (hasPageErrors == false) {
            currentErrorMessage = '';
        }
    }

    public PageReference selectShareType() {
        return nextAction();
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
