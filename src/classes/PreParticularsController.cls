/*
Name:  PreParticularsController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Tabular Input PreParticulars Page
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-06-15  Initial development.
*/
public class PreParticularsController extends TransactionStepControllerBase {
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String currentErrorMessage {
        get;
        set;
    }
    public String directorName {
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
    public String presenterEmail {
        get;
        set;
    }
    public String presenterName {
        get;
        set;
    }
    public String presenterPhone {
        get;
        set;
    }
    public List < Officer__c > companyDirectors {
        get;
        set;
    }
    public List < Shares__c > currentshares {
        get;
        set;
    }
    public String companyAddress1 {
        get;
        set;
    }
    public String companyAddress2 {
        get;
        set;
    }
    public String companyregion {
        get;
        set;
    }
    public String companypostcode {
        get;
        set;
    }
    public String companyCountry {
        get;
        set;
    }
    public String companyLocality {
        get;
        set;
    }
    public Boolean showprevious {
        get;
        set;
    }
    public List < Shares__c > displayresult {
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
    public String classofshares {
        get;
        set;
    }
    public Boolean preparticulardependency {
        get;
        set;
    }
    public String prescribedParticular {
        get;
        set;
    }
    public Boolean dependencyfulfilled {
        get;
        set;
    }
    public PreParticularsController() {
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
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        currentShares = new List < Shares__c > ();
        displayresult = new List < Shares__c > ();
        preparticulardependency = false;
        createCurrentShares();
        return;
    }
    public void createCurrentShares() {
        if (submissionMgr.submission.Shares__r.size() > 0) {
            for (Shares__c sharestoTest: submissionMgr.submission.Shares__r) {
                if (sharestoTest.cancelled_shares__c == false) {
                    currentShares.add(sharestoTest);
                }
            }
            if (submissionMgr.submission.Form_Name__c == 'SH19') {
                createPreParticularInputs();
            } else {
                // a form that requires preparticulars is found and there are particulars stored
                preparticulardependency = true;
                dependencyfulfilled = true;
            }
        } else if (submissionMgr.submission.Shares__r.size() == 0 && submissionMgr.submission.Form_Name__c != 'SH19') {
            preparticulardependency = true;
        }
    }
    public void createPreParticularInputs() {
        Map < String, Shares__c > mapShares = new Map < String, Shares__c > ();
        for (Shares__c sortedshares: currentShares) {
            mapShares.put(sortedshares.Class_of_Shares__c, sortedshares);
        }
        displayresult.addAll(mapShares.values());
    }
    private void persistStep() {
        if (displayresult == null && preparticulardependency == false) {
            hasPageErrors = true;
            currentErrorMessage = 'Cannot continue without adding prescribed particulars';
            return;
        } else {
            for (Shares__c sharestoUpdate: submissionMgr.submission.Shares__r) {
                for (Shares__c preParticulars: displayresult) {
                    if (preParticulars.Class_of_Shares__c == sharestoUpdate.Class_of_Shares__c) {
                        if (preParticulars.Prescribed_Particulars__c.length() > 0) {
                            sharestoUpdate.Prescribed_Particulars__c = preParticulars.Prescribed_Particulars__c;
                        }
                    }
                }
            }
        }
        submissionMgr.persist();
    }
    public void setSelectedShare() {}
    public PageReference addShare() {
        List < Shares__c > sharesToAdd = new List < Shares__c > ();
        try {
            if (classofshares == null || classofshares.length() == 0) {
                hasPageErrors = true;
                currentErrorMessage = 'You must add the class of shares';
                return null;
            }
            if (prescribedParticular == null || prescribedParticular.length() == 0) {
                hasPageErrors = true;
                currentErrorMessage = 'You must add a Prescribed Particular';
                return null;
            }
            sharesToAdd.add(new Shares__c(Prescribed_Particulars__c = prescribedParticular, Name = classofshares, Transaction__c = submissionMgr.submission.Id, Class_of_Shares__c = classofshares, ActiveData__c = true));
            insert sharesToAdd;
        } catch (DmlException e) {
            hasPageErrors = true;
            currentErrorMessage = 'Sorry we have an Error' + ' ' + e.getMessage();
            return null;
        } catch (Exception e) {
            hasPageErrors = true;
            currentErrorMessage = 'Sorry we have an Error' + ' '+ e.getMessage();
            return null;
        }
        PageReference pg = new PageReference('/PreParticularRights');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
    }
    public PageReference nextAction() {
        if (!validatePageState()) {
            return Page.TransactionException;
        }
        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
}
