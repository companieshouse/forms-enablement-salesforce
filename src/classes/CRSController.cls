/*
Name:  CRSController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------
Controller class for the Visualforce Page: CRS
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-06  Initial development.
*/
public with sharing class CRSController extends TransactionStepControllerBase {
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String currentErrorMessage1 {
        get;
        set;
    }
    public String currentErrorMessage2 {
        get;
        set;
    }
    public String errorVal1 {
        get;
        set;
    }
    public String errorVal2 {
        get;
        set;
    }
    public String selectedShareChange {
        get;
        set;
    }
    public String selectedShareClass {
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
    public String previousButton {
        get;
        set;
    }
    public String continueButton {
        get;
        set;
    }
    public CRSController() {
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
        continueButton = transactionMgr.currentStep.ContinueButtonText__c;
        previousButton = transactionMgr.currentStep.PreviousButtonText__c;
    }
    public PageReference goForward() {
        if (submissionMgr.submission.finishedpart1__c == true) {
            return nextStep();
        }
        return null;
    }
    public void setSelectedClass() {
        submissionMgr.submission.shareClassSelection__c = selectedShareClass;
        System.debug('Currency Changed to   ' + selectedShareClass);
    }
    public void setSelectedShareChange() {
        System.debug('Currency Changed to   ' + selectedShareChange);
    }
    private void persistStep() {
        submissionMgr.submission.shareClassSelection__c = selectedShareClass;
        submissionMgr.submission.shareChangeSelection__c = selectedShareChange;
        submissionMgr.persist();
    }
    public PageReference nextAction() {
        if (selectedShareClass == null) {
            errorVal1 = 'error';
            errorVal2 = '';
            currentErrorMessage1 = 'Please select the type of class yoou would like to change';
            currentErrorMessage2 = '';
            hasPageErrors = true;
            return null;
        }
        if (selectedShareClass == '') {
            errorVal1 = 'error';
            errorVal2 = '';
            currentErrorMessage1 = 'Please provide a share class name';
            currentErrorMessage2 = '';
            hasPageErrors = true;
            return null;
        }
        if (selectedShareChange == null) {
            errorVal1 = '';
            errorVal2 = 'error';
            currentErrorMessage1 = '';
            currentErrorMessage2 = 'Please select the type of changes you would like to make';
            hasPageErrors = true;
            return null;
        }
        if (!validatePageState()) return Page.TransactionException;
        persistStep();
        PageReference pg = new PageReference('/ChangeCRS');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
}
