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
    public String currentErrorMessage {
        get;
        set;
    }
    public String selectedShareChange {
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
    public Map < String, Shares__c > mapShares {
        get;
        set;
    }
    public Boolean showCurrentShares {
        get;
        set;
    }
    public List < Shares__c > currentShares {
        get;
        set;
    }
    public List < String > displayresult {
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
        currentShares = new List < Shares__c > ();
        displayresult = new List < String > ();
        checkShares();
    }
    public void checkShares() {
        for (Shares__c sharestoUse: submissionMgr.submission.Shares__r) {
            if (sharestoUse.cancelled_shares__c == false) {
                if (sharestoUse.SHARETYPE__c != 'STATEMENTOFCAPITAL') {
                    currentShares.add(sharestoUse);
                }
            }
        }
        if (currentShares.size() >= 1) {
            showCurrentShares = true;
            //currentShares = submissionMgr.submission.Shares__r;
            Map < String, Shares__c > mapShares = new Map < String, Shares__c > ();
            for (Shares__c sortedshares: currentShares) {
                mapShares.put(sortedshares.SHARETYPE__c, sortedshares);
            }
            displayresult.addAll(mapShares.keySet());
            //throw new Form_CustomException('here is the error' + displayresult);
        } else if (currentShares.size() < 1) {
            showCurrentShares = false;
        }
    }
    public PageReference AddtocurrentShare() {
        submissionMgr.submission.shareChangeSelection__c = selectedShareChange;
        submissionMgr.persist();
        return nextStep();
    }
    public PageReference setSelectedShareType() {
        System.debug('Currency Changed to   ' + selectedShareChange);
        return nextAction();
    }
    private void persistStep() {
        submissionMgr.submission.shareChangeSelection__c = selectedShareChange;
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
