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
    public String previousButtonText {
        get;
        set;
    }
    public String continueButtonText {
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
    public List<Shares__c> sharesToAdd {get; set;}
    public String error1 {get; set;}
    public String error2 {get; set;}
    public String error3 {get; set;}
    public String error4 {get; set;}

    public Boolean ifReconversion {get; set;}
    public Boolean ifSubdivision {get; set;}
    public Boolean ifConsolidation {get; set;}
    public Boolean ifRedemption {get; set;}

    public ChangeCRSController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void initialiseStep() {
        displayText = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;
        displayText4 = transactionMgr.currentStep.Display_Text_4__c == null ? '' : transactionMgr.currentStep.Display_Text_4__c;
        displayText5 = transactionMgr.currentStep.Display_Text_5__c == null ? '' : transactionMgr.currentStep.Display_Text_5__c;
        displayText6 = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;
        headerText2 = transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c;
        headerText3 = transactionMgr.currentStep.Header_Text_3__c == null ? '' : transactionMgr.currentStep.Header_Text_3__c;
        companyName = submissionMgr.submission.CompanyName__c == null ? '' : submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c == null ? '' : submissionMgr.submission.CompanyNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c == null ? '' : transactionMgr.currentStep.ContinueButtonText__c;
        previousButtonText = transactionMgr.currentStep.PreviousButtonText__c == null ? '' : transactionMgr.currentStep.PreviousButtonText__c;
        selectedNotice = submissionMgr.submission.shareChangeSelection__c == null ? '' : submissionMgr.submission.shareChangeSelection__c;
        classofshares = submissionMgr.submission.shareClassSelection__c == null ? '' : submissionMgr.submission.shareClassSelection__c;
        sharesToAdd = new List<Shares__c>();
        buildViewState();
    }
    public PageReference goForward() {
        if (submissionMgr.submission.finishedpart1__c == true) {
            return nextStep();
        }
        return null;
    }
    public void buildViewState () {
        if (selectedNotice == 'RECONVERSION') {
            ifReconversion = true;
        } else if (selectedNotice == 'SUBDIVISION') {
            ifSubdivision = true;
        } else if (selectedNotice == 'CONSOLIDATION') {
            ifConsolidation = true;
        } else if (selectedNotice == 'REDEMPTION') {
            ifRedemption = true;
        }
    }
    private void persistStep() {
        // persist stuff here
        submissionMgr.persist();
    }

    public PageReference addReconversion() {

        if ( valOfStock == null || valOfStock == 0 ) {
            error1 = 'error';
            error2 = '';
            error3 = '';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add the value of the stock which has been re-converted';
            return null;
        }
        if (oldIssuedShares == null || oldIssuedShares == 0 ) {
            error1 = '';
            error2 = 'error';
            error3 = '';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add the number of' + ' ' + classofshares + ' ' + 'shares that have been re-converted';
            return null;
        }
        if (oldNomVal == null || oldNomVal == 0 ) {
            error1 = '';
            error2 = '';
            error3 = 'error';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add the value of the stock which has been re-converted';
            return null;
        }
        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            sharesToAdd.add(new Shares__c(SHARETYPE__c = 'RECONVERSION', Name = classofshares, Transaction__c = submissionMgr.submission.Id, oldNumSharesIssued__c = oldIssuedShares, valOfStock__c = valOfStock, Class_of_Shares__c = classofshares, OldNominalValue__c = oldNomVal, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
        return  nextAction();
    }
    public PageReference addRedemption() {

        if ( oldIssuedShares == null || oldIssuedShares == 0 ) {
            error1 = 'error';
            error2 = '';
            error3 = '';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add the number of' + ' ' + classofshares + ' ' + 'shares that have been redeemed';
            return null;
        }
        if (oldNomVal == null || oldNomVal == 0 ) {
            error1 = '';
            error2 = 'error';
            error3 = '';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add the nominal value of each share';
            return null;
        }
        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            sharesToAdd.add(new Shares__c(SHARETYPE__c = 'REDEMPTION', Name = classofshares, Transaction__c = submissionMgr.submission.Id, oldNumSharesIssued__c = oldIssuedShares, OldNominalValue__c = oldNomVal, Class_of_Shares__c = classofshares, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
        return  nextAction();

    }
    public PageReference addConsolidation() {
        if ( oldIssuedShares != null && oldIssuedShares != 0 && oldNomVal != null && oldNomVal != 0  && newIssuedShares != null && newIssuedShares != 0 && newNomVal != null && newNomVal != 0 ) {
            error1 = '';
            error2 = '';
            error3 = '';
            error4 = '';
            currentErrorMessage = '';
            hasPageErrors = false;
        }
        if ( oldIssuedShares == null || oldIssuedShares == 0 ) {
            error1 = 'error';
            error2 = '';
            error3 = '';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add how many' + ' ' + classofshares + ' ' + 'shares that were previously issued';
            return null;
        }
        if (oldNomVal == null || oldNomVal == 0 ) {
            error1 = '';
            error2 = 'error';
            error3 = '';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add the nominal value of each previously issued' + ' ' + classofshares + ' ' + 'share';
            return null;
        }
        if (newIssuedShares == null || newIssuedShares == 0 ) {
            error1 = '';
            error2 = '';
            error3 = 'error';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add how many' + ' ' + classofshares + ' ' + 'share(s) that are currently in issue';
            return null;
        }
        if (newNomVal == null || newNomVal == 0 ) {
            error1 = '';
            error2 = '';
            error3 = '';
            error4 = 'error';
            hasPageErrors = true;
            currentErrorMessage = 'You must add the nominal value of each currently issued' + ' ' + classofshares + ' ' + 'share';
            return null;
        }

        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            sharesToAdd.add(new Shares__c(SHARETYPE__c = 'CONSOLIDATION', newNumSharesIssued__c = newIssuedShares, OldNominalValue__c = oldNomVal, NewNominalValu__c = newNomVal, Name = classofshares, Transaction__c = submissionMgr.submission.Id, oldNumSharesIssued__c = oldIssuedShares, Class_of_Shares__c = classofshares, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {
        } catch (Exception e) {}
        return  nextAction();
    }
    public PageReference addSubdivision() {

        if ( oldIssuedShares == null || oldIssuedShares == 0 ) {
            error1 = 'error';
            error2 = '';
            error3 = '';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add how many' + ' ' + classofshares + ' ' + 'share(s) were previously issued';
            return null;
        }
        if (oldNomVal == null || oldNomVal == 0 ) {
            error1 = '';
            error2 = 'error';
            error3 = '';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add the nominal value of each previously issued' + ' ' + classofshares + ' ' + 'share';
            return null;
        }
        if (newIssuedShares == null || newIssuedShares == 0 ) {
            error1 = '';
            error2 = '';
            error3 = 'error';
            error4 = '';
            hasPageErrors = true;
            currentErrorMessage = 'You must add how many' + ' ' + classofshares + ' ' + 'share(s) that are currently in issue';
            return null;
        }
        if (newNomVal == null || newNomVal == 0 ) {
            error1 = '';
            error2 = '';
            error3 = '';
            error4 = 'error';
            hasPageErrors = true;
            currentErrorMessage = 'You must add the nominal value of each currently issued' + ' ' + classofshares + ' ' + 'share';
            return null;
        }
        try {
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            sharesToAdd.add(new Shares__c(SHARETYPE__c = 'SUBDIVISION', newNumSharesIssued__c = newIssuedShares, OldNominalValue__c = oldNomVal, NewNominalValu__c = newNomVal, Name = classofshares, Transaction__c = submissionMgr.submission.Id, oldNumSharesIssued__c = oldIssuedShares, Class_of_Shares__c = classofshares, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
        return  nextAction();

    }
    public PageReference addShare() {
        if (selectedNotice == 'CONSOLIDATION') {
            return addConsolidation();
        } else if (selectedNotice == 'SUBDIVISION') {
            return addSubdivision();
        } else if (selectedNotice == 'REDEMPTION') {
            return addRedemption();
        } else if (selectedNotice == 'RECONVERSION') {
            return addReconversion();
        }
        return null;
    }

    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;
        persistStep();
        PageReference pg = new PageReference('/YourReviewChanges');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        PageReference pg = new PageReference('/CRS');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
    }
}