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
public with sharing class ChangeShareClassName extends TransactionStepControllerBase {
    public String classofshares {
        get;
        set;
    }
    public String classofsharesNew {
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
    public String newcurrentErrorMessage {
        get;
        set;
    }
    public String oldcurrentErrorMessage {
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
    public List < Shares__c > currentShares {
        get;
        set;
    }
    public Boolean showTable {
        get;
        set;
    }
    public String olderrorsClass {
        get;
        set;
    }
    public String newerrorsClass {
        get;
        set;
    }
    public ChangeShareClassName() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void initialiseStep() {
        //throw new Form_CustomException(' ERror here ');
        displayText = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        displayText4 = transactionMgr.currentStep.Display_Text_4__c;
        displayText5 = transactionMgr.currentStep.Display_Text_5__c;
        displayText6 = transactionMgr.currentStep.Display_Text_6__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        headerText2 = transactionMgr.currentStep.Header_Text_2__c;
        headerText3 = transactionMgr.currentStep.Header_Text_3__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        showShares();
    }
    public void showShares() {
        if (submissionMgr.submission.Shares__r.size() > 0) {
            showTable = true;
            currentShares = submissionMgr.submission.Shares__r;
        } else {
            showTable = false;
        }
    }
    public void setOldSelectedShare() {}
    public void setNewSelectedShare() {}
    private void persistStep() {
        submissionMgr.persist();
    }
    public PageReference addShare() {
        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            if (classofshares == null || classofshares.length() == 0) {
                hasPageErrors = true;
                olderrorsClass = 'error';
                oldcurrentErrorMessage = 'Must add the old class of shares name';
                newerrorsClass = '';
                newcurrentErrorMessage = '';
                return null;
            }
            if (classofsharesNew == null || classofsharesNew.length() == 0) {
                hasPageErrors = true;
                newerrorsClass = 'error';
                newcurrentErrorMessage = 'Must add a new class of shares name';
                olderrorsClass = '';
                oldcurrentErrorMessage = '';
                return null;
            }
            if (classofshares == classofsharesNew) {
                hasPageErrors = true;
                olderrorsClass = 'error';
                newerrorsClass = 'error';
                oldcurrentErrorMessage = 'Old share name cannot be the same as the new share name';
                newcurrentErrorMessage = 'New share name cannot be the same as the old share name';
                return null;
            }
            sharesToAdd.add(new Shares__c(ShareType__c = submissionMgr.submission.Form_Name__c, Name = classofshares, Transaction__c = submissionMgr.submission.Id, Class_of_Shares__c = classofshares, Class_of_Share_new__c = classofsharesNew, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
        //PageReference pg = new PageReference('/ChangeShareClassName');
        //pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        //pg.setRedirect(true);
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
