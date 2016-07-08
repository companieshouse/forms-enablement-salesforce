/*
Name:  PromoterController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: PromoterTable

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-06-05  Initial development.
*/
public with sharing class PromoterController extends TransactionStepControllerBase {
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
    public String previousButton {
        get;
        set;
    }
    public String continueButtonText {
        get;
        set;
    }
    public Decimal considerationGiven {
        get;
        set;
    }
    public Decimal amountPaidUp {
        get;
        set;
    }
    public Decimal benefitGiven {
        get;
        set;
    }
    public List < Shares__c > allShares {
        get;
        set;
    }
    public Boolean showTable {
        get;
        set;
    }
    public PromoterController() {
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
        checkStepDependency();
        checkShares();
    }
    public void checkShares() {
        allShares = new List < Shares__c > ();
        for (Shares__c currentShares: submissionMgr.submission.Shares__r) {
            if (currentShares.SHARETYPE__c == 'promoter') {
                allShares.add(currentShares);
            }
        }
        if (allShares.size() > 0) {
            showTable = true;
        }
    }
    public PageReference checkStepDependency() {
        if (submissionMgr.submission.hasPromoter__c == false) {
            return nextStep();
        }
        return null;
    }
    public PageReference addShare() {
        if (submissionMgr.submission.hasPromoter__c == true) {
            try {
                List < Shares__c > sharesToAdd = new List < Shares__c > ();
                //validation below commented out
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
                sharesToAdd.add(new Shares__c(SHARETYPE__c = 'PROMOTER', considerationGiven__c = considerationGiven, Transaction__c = submissionMgr.submission.Id, benefitGiven__c = benefitGiven, amountPaidUp__c = amountPaidUp, ActiveData__c = true));
                insert sharesToAdd;
            } catch (DmlException e) {} catch (Exception e) {} finally {
                PageReference pg = new PageReference('/PromotersTable');
                pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
                pg.setRedirect(true);
                return pg;
            }
        }
        return null;
    }
    private void persistStep() {
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