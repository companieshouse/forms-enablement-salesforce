/*
Name:  ChangeCRSController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: ChangeCRS

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-07-7  Initial development.
*/
public with sharing class ChangeCRSController extends TransactionStepControllerBase {
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
    public Boolean showTable {
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
    public String previousButtonText {
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
    public String selectedNotice {
        get;
        set;
    }
    public Decimal oldIssuedShares {
        get;
        set;
    }
    public Decimal newIssuedShares {
        get;
        set;
    }
    public Decimal valOfStock {
        get;
        set;
    }
    public Decimal oldNomVal {
        get;
        set;
    }
    public Decimal newNomVal {
        get;
        set;
    }
    public Boolean showValueField {
        get;
        set;
    }
    public Boolean showNewStructure {
        get;
        set;
    }
    public String selectionTitle {
        get;
        set;
    }
    public String helpText {
        get;
        set;
    }
    public String tableHelperText {
        get;
        set;
    }
    public ChangeCRSController() {
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
        headerText2 = transactionMgr.currentStep.Header_Text_2__c;
        headerText3 = transactionMgr.currentStep.Header_Text_3__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        previousButtonText = transactionMgr.currentStep.PreviousButtonText__c;
        selectedNotice = submissionMgr.submission.shareChangeSelection__c;
        currentShares = new List < Shares__c > ();
        selectShareTypeTable();
        allShares = submissionMgr.submission.Shares__r;
    }
    public void selectShareTypeTable() {
        if (submissionMgr.submission.Shares__r.size() > 0) {
            for (Shares__c previousShares: submissionMgr.submission.Shares__r) {
                if (previousShares.SHARETYPE__c == selectedNotice) {
                    currentShares.add(previousShares);
                }
            }
            if (currentShares.size() == 0) {
                showTable = false;
            } else if (currentshares.size() > 0) {
                showTable = true;
            }
        } else if (submissionMgr.submission.Shares__r.size() == 0) {
            showTable = false;
        }
        // now build the fields
        if (selectedNotice == 'CONSOLIDATION') {
            headerText1 = 'Notice of consolidation of shares';
            showNewStructure = true;
            selectionTitle = 'Consolidation';
            helpText = 'Please show the amendments to each class of share.';
            tableHelperText = '';
        } else if (selectedNotice == 'SUBDIVISION') {
            headerText1 = 'Notice of Sub-division of shares';
            showNewStructure = true;
            helpText = 'Please show the amendments to each class of share.';
            tableHelperText = '';
        } else if (selectedNotice == 'REDEMPTION') {
            headerText1 = 'Notice of Redemption of shares';
            showNewStructure = false;
            helpText = 'Please show the class number and nominal value of shares that have been redeemed. Only redeemable shares can be redeemed.';
            tableHelperText = '';
        } else if (selectedNotice == 'RECONVERSION') {
            headerText1 = 'Re-conversion of stock into shares';
            showValueField = true;
            showNewStructure = false;
            helpText = 'Please show the class number and nominal value of shares following re-conversion from stock.';
            tableHelperText = 'New share structure';
        }
    }
    public void setSelectedShare() {
        //throw new Form_CustomException(' here is your  selected class of  shares' + classofshares);
    }
    private void persistStep() {
        // persist stuff here
        submissionMgr.persist();
    }
    public PageReference addAnotherNotice() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
    public void addReconversion() {
        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            //if (classofshares == null || classofshares.length() == 0) {
            //    hasPageErrors = true;
            //    currentErrorMessage = 'Must add a class of shares';
            //    return null;
            //}
            sharesToAdd.add(new Shares__c(SHARETYPE__c = 'RECONVERSION', Name = classofshares, Transaction__c = submissionMgr.submission.Id, oldNumSharesIssued__c = oldIssuedShares, valOfStock__c = valOfStock, Class_of_Shares__c = classofshares, OldNominalValue__c = oldNomVal, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
    }
    public void addRedemption() {
        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            //if (classofshares == null || classofshares.length() == 0) {
            //    hasPageErrors = true;
            //    currentErrorMessage = 'Must add a class of shares';
            //    return null;
            //}
            sharesToAdd.add(new Shares__c(SHARETYPE__c = 'REDEMPTION', Name = classofshares, Transaction__c = submissionMgr.submission.Id, oldNumSharesIssued__c = oldIssuedShares, OldNominalValue__c = oldNomVal, Class_of_Shares__c = classofshares, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
    }
    public void addConsolidation() {
        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            //if (classofshares == null || classofshares.length() == 0) {
            //    hasPageErrors = true;
            //    currentErrorMessage = 'Must add a class of shares';
            //    return null;
            //}
            sharesToAdd.add(new Shares__c(SHARETYPE__c = 'CONSOLIDATION', newNumSharesIssued__c = newIssuedShares, OldNominalValue__c = oldNomVal, NewNominalValu__c = newNomVal, Name = classofshares, Transaction__c = submissionMgr.submission.Id, oldNumSharesIssued__c = oldIssuedShares, Class_of_Shares__c = classofshares, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
    }
    public void addSubdivision() {
        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            //if (classofshares == null || classofshares.length() == 0) {
            //    hasPageErrors = true;
            //    currentErrorMessage = 'Must add a class of shares';
            //    return null;
            //}
            sharesToAdd.add(new Shares__c(SHARETYPE__c = 'SUBDIVISION', newNumSharesIssued__c = newIssuedShares, OldNominalValue__c = oldNomVal, NewNominalValu__c = newNomVal, Name = classofshares, Transaction__c = submissionMgr.submission.Id, oldNumSharesIssued__c = oldIssuedShares, Class_of_Shares__c = classofshares, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
    }
    public PageReference addShare() {
        if (selectedNotice == 'CONSOLIDATION') {
            addConsolidation();
        } else if (selectedNotice == 'SUBDIVISION') {
            addSubdivision();
        } else if (selectedNotice == 'REDEMPTION') {
            addRedemption();
        } else if (selectedNotice == 'RECONVERSION') {
            addReconversion();
        }
        PageReference pg = new PageReference('/ChangeCRS');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        //throw new Form_CustomException('PG' + pg);
        return pg;
    }
    public PageReference changePage() {
        PageReference pg = new PageReference('/ChangeCRS');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        //throw new Form_CustomException('PG' + pg);
        return pg;
    }
    public PageReference addStatementofCapital() {
        // validate before pushing to qa
        //if (currentShares.isEmpty()) {
        //    hasPageErrors = true;
        //    currentErrorMessage = 'Cannot add a statement of capital without the notice';
        //    return null;
        //}
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