/*
Name:  ApplicationDateController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: ApplicationDateController

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-06  Initial development.
*/
public with sharing class ApplicationDateController extends TransactionStepControllerBase {
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
    public Date applicationDate {
        get;
        set;
    }
    public ApplicationDateController() {
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
        applicationDate = submissionMgr.submission.ApplicationDate__c;
        //throw new Form_CustomException('custom exception here');
    }
    private void persistStep() {
    	submissionMgr.submission.ApplicationDate__c = applicationDate;
        submissionMgr.persist();
    }
    public PageReference nextAction() {
        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
}
