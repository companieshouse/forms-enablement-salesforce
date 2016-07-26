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
    public Date variationDate {
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
    public String button1 {
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
    public List < Shares__c > allShares {
        get;
        set;
    }
    public String formName {
        get;
        set;
    }
    public String variationInfo {
        get;
        set;
    }
    public String realTransactionName {
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
    public String variationTextHint {
        get;
        set;
    }
    public String dateQuestionTextHint {
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
        formName = submissionMgr.submission.Form_Name__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        currentShares = submissionMgr.submission.Shares__r;
        buildLABELS();
    }
    public void setSelectedForm() {}
    private void persistStep() {
        submissionMgr.persist();
    }
    public void buildLABELS() {
        if (submissionMgr.submission.Form_Name__c.contains('SH10')) {
            labelText = '';// 'Notice of particulars of variation of rights attached to shares';
            dateQuestionText = 'Date of variation of rights';
            dateQuestionTextHint = 'This is the date on which the company\'s Board of Directors approved the variation. This must not be a future date.';
            variationText = 'Details of variation of rights';
            variationTextHint = 'Please give details of the variation of rights attached to shares.';
        } else if (submissionMgr.submission.Form_Name__c.contains('SH11')) {
            labelText = 'Notice of new class of members';
            dateQuestionText = 'Date of creation of new class of members';
            dateQuestionTextHint = 'Please insert the date on which the new class was created.';
            variationText = 'Rights attached to class of members';
            variationTextHint = 'Please provide details of the rights attached to the new class of members.';
        } else if (submissionMgr.submission.Form_Name__c.contains('SH12')) {
            labelText = 'Notice of particulars of variation of class rights';
            dateQuestionText = 'Date of variation of class rights';
            dateQuestionTextHint = 'Please insert date on which the rights were varied';
            variationText = 'Variation in the rights of the class of members';
            variationTextHint = 'Please give details of the variation in the rights of the class of members';
        }
        //throw new Form_CustomException('continueButtonText'+ continueButtonText);
        if (submissionMgr.submission.Shares__r.size() > 0) {
            showTable = true;
        } else if (submissionMgr.submission.Shares__r.size() == 0) {
            showTable = false;
        }
    }
    public PageReference addShare() {
        try {
            submissionMgr.submission.trueTransactionName__c = realTransactionName;
            List < Shares__c > sharesToAdd = new List < Shares__c > ();
            sharesToAdd.add(new Shares__c(ShareType__c = 'VARIATIONS', varationField__c = variationInfo, Date__c = variationDate, Transaction__c = submissionMgr.submission.Id, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {} catch (Exception e) {}
        PageReference pg = new PageReference('/VariationOfRights');
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