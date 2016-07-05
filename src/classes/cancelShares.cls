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
public with sharing class cancelShares extends TransactionStepControllerBase {
    public Decimal totalnumberofShares {
        get;
        set;
    }
    public Date cancellationDate {
        get;
        set;
    }
    public Decimal totalnumberAggregate {
        get;
        set;
    }
    public Decimal numberofshares {
        get;
        set;
    }
    public Decimal aggregateunpaidAmount {
        get;
        set;
    }
    public String classofshares {
        get;
        set;
    }
    public Decimal aggregateNominalValue {
        get;
        set;
    }
    public String selectedCurrency {
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
    public Shares__c shareCapital {
        get;
        set;
    }
    public Boolean showTable {
        get;
        set;
    }
    public String statusvalue {
        get;
        set;
    }
    public Boolean sharesAvailable {
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
    public Map < Id, Shares__c > shareUpdaterMap {
        get;
        set;
    }
    public Id selectedId {
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
    public List < Shares__c > allShares {
        get;
        set;
    }
    public Boolean cancelledShares {
        get;
        set;
    }
    public Boolean showDates {
        get;
        set;
    }
    public String previousButton {
        get;
        set;
    }
    public String labelText {
        get;
        set;
    }
    public String dateQuestionText {
        get;
        set;
    }
    public String variationText {
        get;
        set;
    }
    public String hintText {
        get;
        set;
    }
    public Boolean cancelledSharesVar {get;set;}
    public cancelShares() {
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
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        previousButton = transactionMgr.currentStep.previousButtonText__c;
        selectedCurrency = submissionMgr.submission.sharecurrencyselection__c;
        currentShares = new List < Shares__c > ();
        checkSharestoCancel();
        buildLABELS();
    }
    public void buildLABELS() {
        if (submissionMgr.submission.Form_Name__c.contains('SH05')) {
            labelText = 'Number of shares cancelled';
            hintText = 'Total number of shares cancelled in this class';
            dateQuestionText = 'Enter date(s) shares were cancelled';
            variationText = '';
            cancelledSharesVar = true;
            showdates = true;
        } else if (submissionMgr.submission.Form_Name__c.contains('SH04')) {
            labelText = 'Number of shares sold or transferred';
            hintText = '';
            dateQuestionText = 'Enter date(s) shares were sold or transferred';
            variationText = '';
            cancelledSharesVar = false;
            showdates = true;
        }
    }
    public void checkSharestoCancel() {
        //throw new Form_CustomException(' my true transaction name is ' + submissionMgr.submission.trueTransactionName__c);
        if (submissionMgr.submission.trueTransactionName__c != null && submissionMgr.submission.trueTransactionName__c == 'SH05') {
            showDates = true;
        }
        for (Shares__c previouslycancelledshares: submissionMgr.submission.Shares__r) {
            if (previouslycancelledshares.cancelled_shares__c == true) {
                currentShares.add(previouslycancelledshares);
            }
        }
        if (currentShares.size() > 0) {
            showTable = true;
        }
    }
    public PageReference checkFinishedAddingShares() {
        return null;
    }
    private void persistStep() {
        submissionMgr.persist();
    }
    public void resetAddShare() {
        classofshares = '';
        numberofshares = null;
        aggregateNominalValue = null;
    }
    public PageReference addtoPreviousShare() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
    public PageReference addShare() {
        List < Shares__c > sharesToAdd = new List < Shares__c > ();
        if (classofshares == null || classofshares.length() == 0) {
            hasPageErrors = true;
            currentErrorMessage = 'Must add a class of shares';
            return null;
        }
        if (numberofshares.toPlainString() == '0') {
            hasPageErrors = true;
            currentErrorMessage = 'Must add the number of shares';
            return null;
        }
        if (aggregateNominalValue.toPlainString() == '0') {
            hasPageErrors = true;
            currentErrorMessage = 'Aggregate nominal value must be greater than 0';
            return null;
        }
        if (cancellationDate > date.today()) {
            hasPageErrors = true;
            currentErrorMessage = 'Date cannot be in the future';
            return null;
        }
        //if (cancellationDate == null) {
        //    hasPageErrors = true;
        //    currentErrorMessage = 'Must add the cancellation date';
        //    return null;
        //}
        sharesToAdd.add(new Shares__c(Date__c = cancellationDate, cancelled_shares__c = cancelledSharesVar, Total_aggregate_amount_unpaid__c = aggregateunpaidAmount, Name = classofshares, Transaction__c = submissionMgr.submission.Id, Number_of_Shares__c = numberofshares, Currency__c = selectedCurrency, Class_of_Shares__c = classofshares, Aggregate_nominal_value__c = aggregateNominalValue, ActiveData__c = true));
        insert sharesToAdd;

        PageReference pg = new PageReference('/CancelledShares');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
    }
    public void setSelectedShare() {}
    public PageReference nextPage() {
        if (currentShares.size() == 0) {
            hasPageErrors = true;
            currentErrorMessage = 'Cannot continue unless you add shares to cancel';
            return null;
        }
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