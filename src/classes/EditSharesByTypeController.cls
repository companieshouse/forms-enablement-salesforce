/*
Name:  EditSharesByTypeController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: EditSharesByType

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-05-07  Initial development.
*/
public with sharing class EditSharesByTypeController extends TransactionStepControllerBase {
    public Decimal numberofshares {
        get;
        set;
    }
    public Decimal newnumberofshares {
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
    public Decimal newaggregateNominalValue {
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
    public String continueButtonText {
        get;
        set;
    }
    public List < Shares__c > allShares {
        get;
        set;
    }
    public String selectedType {
        get;
        set;
    }
    public String oldclassofshares {
        get;
        set;
    }
    public String newclassofshares {
        get;
        set;
    }
    public Boolean isSH13 {
        get;
        set;
    }
    public Boolean isSH14 {
        get;
        set;
    }
    public String shareType {
        get;
        set;
    }
    public Decimal nominalValue {
        get;
        set;
    }
    public Decimal newnominalValue {
        get;
        set;
    }
    public EditSharesByTypeController() {
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
        previousButton = transactionMgr.currentStep.previousButtonText__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        currentShares = new List < Shares__c > ();
        allShares = submissionMgr.submission.Shares__r;
        checkForm();
        checkShares();
    }
    public void checkShares() {
        if (submissionMgr.submission.Shares__r.size() > 0) {
            for (Shares__c sh1314Shares: submissionMgr.submission.Shares__r) {
                if (submissionMgr.submission.Form_Name__c == 'SH13') {
                    currentShares.add(sh1314Shares);
                } else if (submissionMgr.submission.Form_Name__c == 'SH14') {
                    currentShares.add(sh1314Shares);
                }
            }
            if (currentShares.size() > 0) {
                showTable = true;
            }
        }
    }
    public void checkForm() {
        if (submissionMgr.submission.Form_Name__c == 'SH13') {
            isSH13 = true;
            shareType = 'SH13';
        } else if (submissionMgr.submission.Form_Name__c == 'SH14') {
            isSH14 = true;
            shareType = 'SH14';
        }
    }
    public void setOldSelectedShare() {
        //throw new Form_CustomException(' here is your  selected class of  shares' + oldclassofshares + ' ' + sharetype + ' ' );
    }
    public void setNewSelectedShare() {
        //throw new Form_CustomException(' here is your  selected class of  shares' + newclassofshares);
    }
    private void persistStep() {
        //// persist stuff here
        submissionMgr.persist();
    }
    public PageReference addShare() {
        List < Shares__c > sharesToAdd = new List < Shares__c > ();
        //if (classofshares == null || classofshares.length() == 0) {
        //    hasPageErrors = true;
        //    currentErrorMessage = 'Must add a class of shares';
        //    return null;
        //}
        //if (numberofshares.toPlainString() == '0') {
        //    hasPageErrors = true;
        //    currentErrorMessage = 'Must add the number of shares';
        //    return null;
        //}
        //if (aggregateNominalValue.toPlainString() == '0') {
        //    hasPageErrors = true;
        //    currentErrorMessage = 'Aggregate nominal value must be greater than 0';
        //    return null;
        //}
        //if (aggregateunpaidAmount.toPlainString() == '0') {
        //    hasPageErrors = true;
        //    currentErrorMessage = 'Must add the  total amount unpaid on each share (if any)';
        //    return null;
        //}
        if (submissionMgr.submission.Form_Name__c == 'SH13') {
            sharesToAdd.add(new Shares__c(ShareType__c = shareType, Name = shareType, Transaction__c = submissionMgr.submission.Id, Class_of_Share_new__c = newclassofshares, Class_of_Shares__c = oldclassofshares, ActiveData__c = true));
        } else if (submissionMgr.submission.Form_Name__c == 'SH14') {
            sharesToAdd.add(new Shares__c(ShareType__c = shareType, Name = sharetype, Transaction__c = submissionMgr.submission.Id, Number_of_Shares__c = numberofshares, Aggregate_nominal_value__c = nominalValue, Aggregate_nominal_value_New__c = newnominalValue, Class_of_Shares__c = oldclassofshares, ActiveData__c = true));
        }
        try {
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
        PageReference pg = new PageReference('/EditSharesByType');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
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
