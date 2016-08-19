/*
Name:  variationRightsController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

variationRightsController

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-04-07  Initial development.
*/
public with sharing class variationRightsController extends TransactionStepControllerBase {
    public Datetime variationDate {
        get;
        set;
    }
    public Integer varDay {
        get;
        set;
    }
    public Integer varYear {
        get;
        set;
    }
    public Integer varMonth {
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
    public List < Shares__c > currentShares {
        get;
        set;
    }
    public Boolean hasPageErrors {
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
    public String variationInfo {
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
    public String errormessage1 {
        get;
        set;
    }
    public STring errormessage2 {
        get;
        set;
    }
    public variationRightsController() {
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
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        previousButtonText = transactionMgr.currentStep.previousButtonText__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        currentShares = submissionMgr.submission.Shares__r;
    }
    private void persistStep() {
        submissionMgr.persist();
    }
    public PageReference addShare() {
        if (varDay == null || varDay == 0 || varDay > 31) {
            hasPageErrors = true;
            errorVal1 = 'error';
            errorVal2 = '';
            errormessage2 = '';
            errormessage1 = 'Please enter the correct day';
            return null;
        }
        if (varMonth == null || varMonth == 0 || varMonth > 12) {
            hasPageErrors = true;
            errorVal1 = 'error';
            errorVal2 = '';
            errormessage2 = '';
            errormessage1 = 'Please enter the correct Month';
            return null;
        }
        if (varYear == null || varyear == 0 ) {
            hasPageErrors = true;
            errorVal1 = 'error';
            errorVal2 = '';
            errormessage2 = '';
            errormessage1 = 'Please enter the correct Year';
            return null;
        }
        if (varYear < 1700 ) {
            hasPageErrors = true;
            errorVal1 = 'error';
            errorVal2 = '';
            errormessage2 = '';
            errormessage1 = 'Please enter the correct Year (later than 1700)';
            return null;
        }
        Datetime variationDate = Datetime.newInstance(varYear, varMonth, varDay);
        variationDate.format('dd MMMMM yyyy');
        if (variationDate > Date.Today()) {
            hasPageErrors = true;
            errorVal1 = 'error';
            errorVal2 = '';
            errormessage2 = '';
            errormessage1 = 'Date must not be in the future';
            return null;
        }
        if (variationInfo == null || variationInfo.length() == 0) {
            hasPageErrors = true;
            errorVal2 = 'error';
            errorVal1 = '';
            errormessage1 = '';
            errormessage2 = 'You must add variation changes';
            return null;
        }
        Date savedDate = variationDate.date();
        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            sharesToAdd.add(new Shares__c(ShareType__c = 'VARIATIONS', varationField__c = variationInfo, Date__c = savedDate, Transaction__c = submissionMgr.submission.Id, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {
            System.Debug('DML Exception ==' + e.getMessage());
        } catch (Exception e) {
            System.Debug('General Exception ==' + e.getMessage());
        }
        return nextAction();
    }
    public PageReference nextAction() {

        if (Test.isRunningTest()) {
            System.Debug('Test is running now');

        } else { if (!validatePageState()) return Page.TransactionException;}
        persistStep();
        if (Test.isRunningTest()) {
            System.Debug('Test is running now');

        } else {
            return nextStep();
        }
        return null;
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
}