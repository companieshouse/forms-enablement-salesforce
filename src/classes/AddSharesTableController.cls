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
public with sharing class AddSharesTableController extends TransactionStepControllerBase {
    public Decimal totalnumberofShares {
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
    public String button1 {
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
    public AddSharesTableController() {
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
        button1 = transactionMgr.currentStep.ContinueButtonText__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        selectedCurrency = submissionMgr.submission.sharecurrencyselection__c;
        currentShares = new List < Shares__c > ();
        allShares = submissionMgr.submission.Shares__r;
        checkFinishedAddingShares();
    }
    public PageReference checkFinishedAddingShares() {
        if (submissionMgr.submission.finishedAddingShares__c) {
            return nextAction();
        } else {
            statusvalue = 'No Shares here yet and not finsished';
            selectCurrentCurrencyTable();
            return null;
        }
    }
    public void selectCurrentCurrencyTable() {
        //currentShares.clear();
        if (submissionMgr.submission.Shares__r.size() > 0) {
            for (Shares__c previousShares: submissionMgr.submission.Shares__r) {
                if (previousShares.Currency__c == selectedCurrency) {
                    // throw new Form_CustomException(' current shares are ' + previousShares);
                    if (previousShares.Total_aggregate_amount_unpaid__c != null && previousShares.Total_aggregate_amount_unpaid__c.toPlainString() != '0') {
                        aggregateunpaidAmount = previousShares.Total_aggregate_amount_unpaid__c;
                    }
                    currentShares.add(previousShares);
                }
            }
            if (currentShares.size() == 0) {
                showTable = false;
                statusvalue = 'No Shares here that match current currency selection';
            } else if (currentshares.size() > 0) {
                showTable = true;
                statusvalue = 'Shares here';
            }
        } else if (submissionMgr.submission.Shares__r.size() == 0) {
            showTable = false;
            statusvalue = 'No Shares here';
        }
    }
    public void setSelectedShare() {
        //throw new Form_CustomException(' here is your  selected class of  shares' + classofshares);
    }
    public void numofSharesCalculation() {
        //throw New Form_CustomException(' your value for totalnumberofShares is '+ totalnumberofShares);
    }
    public void totalNumAggregate() {
       // persistStep();
        //throw New Form_CustomException(' your value for totalnumberofShares is '+ totalnumberAggregate);
    }
    private void persistStep() {
        if (submissionMgr.submission.Shares__r.size() > 0) {
            for (Shares__c previousShares: submissionMgr.submission.Shares__r) {
                if (previousShares.Currency__c == selectedCurrency) {
                    if (aggregateunpaidAmount != null && aggregateunpaidAmount.toPlainString() != '0') {
                        previousShares.Total_aggregate_amount_unpaid__c = aggregateunpaidAmount;
                        previousShares.totalNumofShares__c = totalnumberofShares;
                        previousShares.totalNumAggregate__c = totalnumberAggregate;
                    }
                }
            }
        }
        // persist stuff here
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
        //PageReference pg = new PageReference('/AddSharesBase');
        //pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        //pg.setRedirect(true);
        //return pg;
    }
    public PageReference addShare() {
        //List < Shares__c > previousSharesList = submissionMgr.submission.Shares__r;
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
        if (aggregateunpaidAmount.toPlainString() == '0') {
            hasPageErrors = true;
            currentErrorMessage = 'Must add the  total amount unpaid on each share (if any)';
            return null;
        }
        sharesToAdd.add(new Shares__c(Total_aggregate_amount_unpaid__c = aggregateunpaidAmount, Name = classofshares, Transaction__c = submissionMgr.submission.Id, Number_of_Shares__c = numberofshares, Currency__c = selectedCurrency, Class_of_Shares__c = classofshares, Aggregate_nominal_value__c = aggregateNominalValue, ActiveData__c = true));
        insert sharesToAdd;
        PageReference pg = new PageReference('/TabularData');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
        //resetAddShare();
        //selectCurrentCurrencyTable();
    }
    public void updateShares() {
        List < Shares__c > sharestoUpdate = new List < Shares__c > ();
        for (Shares__c sharesUPDATED: submissionMgr.submission.Shares__r) {
            if (sharesUPDATED.Id == selectedId) {
                sharesUPDATED.Name = classofshares;
                sharesUPDATED.Number_of_Shares__c = numberofshares;
                sharesUPDATED.Class_of_Shares__c = classofshares;
                sharesUpdated.Aggregate_nominal_value__c = aggregateNominalValue;
                shareUpdaterMap.put(sharesUPDATED.Id, sharesUPDATED);
            }
        }
        sharestoUpdate.addAll(shareUpdaterMap.values());
        update sharestoUpdate;
    }
    public PageReference finishAddingShares() {
        if (!validatePageState()) return Page.TransactionException;
        submissionMgr.submission.finishedAddingShares__c = true;
        persistStep();
        return nextStep();
    }
    public PageReference addPreparticularRights() {
        if (allShares.isEmpty()) {
            hasPageErrors = true;
            currentErrorMessage = 'Cannot add preparticular rights without shares';
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
