/*
Name:  SigningController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: SigningController

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-06  Initial development.
*/
public with sharing class SigningController extends TransactionStepControllerBase {
    public String companyName {
        get;
        set;
    }
    public String companyNumber {
        get;
        set;
    }
    public String signingOptions {
        get;
        set;
    }
    public Boolean signingchoice {
        get;
        set;
    }
    public String whoAuthorised {
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
    public String continueButtonText {
        get;
        set;
    }
    public Boolean standardView {
        get;
        set;
    }
    public Boolean customView {
        get;
        set;
    }
    public SigningController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void initialiseStep() {
        standardView = transactionMgr.currentStep.StandardView__c;
        customView = transactionMgr.currentStep.CustomView__c;
        displayText = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        displayText4 = transactionMgr.currentStep.Display_Text_4__c;
        displayText5 = transactionMgr.currentStep.Display_Text_5__c;
        displayText6 = transactionMgr.currentStep.Display_Text_6__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        headerText2 = transactionMgr.currentStep.Header_Text_2__c;
        headerText3 = transactionMgr.currentStep.Header_Text_3__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
    }
    public List < SelectOption > getItems() {
        List < SelectOption > options = new List < SelectOption > ();
        options.add(new SelectOption('True', 'Yes'));
        options.add(new SelectOption('False', 'No'));
        return options;
    }
    public PageReference setSigningvalue() {
        return nextAction();
    }
    private void persistStep() {
        if (signingchoice) {
            submissionMgr.submission.Status__c = 'Signed';
        }
        // persist stuff here
        submissionMgr.persist();
    }
    public void setAuthorizerValue() {}
    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;
        if (!signingchoice) {
            currentErrorMessage = '<span class="error-message">You must select Yes to Proceed</span>';
            hasPageErrors = true;
            return null;
        } else if (signingchoice) {
            currentErrorMessage = '';
            hasPageErrors = false;
        } else if (String.valueOf(signingchoice) == 'undefined') {
            currentErrorMessage = '<span class="error-message">You must select Yes to Proceed</span>';
            hasPageErrors = true;
            return null;
        }
        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
}