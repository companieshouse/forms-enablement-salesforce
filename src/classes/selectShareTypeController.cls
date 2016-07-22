
/*
Name:  selectShareTypeController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: selectShareType

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-07  Initial development.
*/
public with sharing class selectShareTypeController extends TransactionStepControllerBase {
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
    public String continueButtonText {
        get;
        set;
    }
    public String previousButtonText {
        get;
        set;
    }
    public String prescribedParticular {
        get;
        set;
    }
    public String shareClassType {
        get;
        set;
    }
    public Boolean rightsErrors {
        get;
        set;
    }
    public Boolean shareClassErrors {
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
    public String errorsClass {
        get;
        set;
    }
    public Decimal numberofshares {get; set;}
    public Decimal nominalvalue {get; set;}
    public selectShareTypeController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void grabShareType() {
        if (shareClassType != null) {
            System.debug('sharetype == ' + ' ' + shareClassType);
            //throw new Form_CustomException('share class type is ' +shareClassType);
        }
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
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        previousButtonText = transactionMgr.currentStep.PreviousButtonText__c;
    }
    public PageReference checkstatus() {
        if (submissionMgr.submission.finishedAddingShares__c == true) {
            return nextStep();
        }
        return null;
    }
    public PageReference AddtocurrentShare() {
        submissionMgr.persist();
        return nextStep();
    }
    private void persistStep() {

        submissionMgr.persist();
    }

    public PageReference addnewShares() {
        if (numberofshares == 0 || numberofshares == null) {
            hasPageErrors = true;
            currentErrorMessage = 'Must add the number of shares';
            return null;
        }
        if (nominalvalue == 0 || nominalvalue == null) {
            hasPageErrors = true;
            currentErrorMessage = 'Aggregate nominal value must be greater than 0';
            return null;
        }
        if (shareClassType.length() < 1) {
            hasPageErrors = true;
            currentErrorMessage = 'You are missing the Share Class Type';
            return null;
        }

        List < Shares__c > sharesToAdd = new List < Shares__c > ();
        try {
            sharesToAdd.add(new Shares__c( Aggregate_nominal_value__c = nominalvalue, Number_of_Shares__c = numberofshares, SHARETYPE__c = 'SH06', Name = shareClassType, Transaction__c = submissionMgr.submission.Id, Class_of_Shares__c = shareClassType, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {System.debug('DML error =' + ' ' + e.getMessage());} catch (Exception e) {System.debug('Exception =' + ' ' + e.getMessage());}

        PageReference pg = new PageReference('/CancelledShares');
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