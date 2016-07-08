/*
Name:  FreeFormController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: FreeForm

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-08-07  Initial development.
*/
public with sharing class FreeFormController extends TransactionStepControllerBase {
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String currentErrorMessage {
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
    public String previousButtonText {
        get;
        set;
    }
    public String freeFormData {
        get;
        set;
    }
    public FreeFormController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void initialiseStep() {
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
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
        previousButtonText = transactionMgr.currentStep.ContinueButtonText__c;
    }
    public Boolean addShare() {
        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            if (freeFormData == null || freeFormData.length() == 0) {
                hasPageErrors = true;
                currentErrorMessage = 'Please add information to your SH30 form';
                return null;
            }
            sharesToAdd.add(new Shares__c(ShareType__c = 'SH30', Transaction__c = submissionMgr.submission.Id, FreeForm__c = freeFormData, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) { return false;} catch (Exception e) { return false;}
        return true;
    }
    private void persistStep() {
        if(addShare())
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
