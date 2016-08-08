/*
Name:  GuidanceController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:


Controller which is link to the guidance page
======================================================
======================================================
History

Ver. Author             Date        Detail
1.0  Sylvain Picory     2016-05-28  Initial development.
*/
public with sharing class GuidanceController {
    public TrackUserClass userTracker;
    public String displayText0 {
        get;
        set;
    }
    public String checkboxText0 {
        get;
        set;
    }
    public Boolean agreeBoxChoice {
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
    public String transactionType {
        get;
        set;
    }
    public Boolean warningAgreeBox {
        get;
        set;
    }
    public String guidanceTitle {get; set;}
    public String guidanceText1 {get; set;}
    public String guidanceText2 {get; set;}
    public String guidanceText3 {get; set;}
    public String guidanceText4 {get; set;}
    public String guidanceText5 {get; set;}

    public Boolean standardGuidanceView {get; set;}
    public Boolean customGuidanceView {get; set;}
    Boolean isPageInitialised = false;
    SecurityManager securityMgr;
    TransactionManager transactionMgr;


    public GuidanceController() {
        initialiseStep();
    }
    public void initialiseStep() {
        securityMgr = new SecurityManager();
        userTracker = new TrackUserClass();
        // userTracker.getUserDocument();
        try {
            if (!ApexPages.currentPage().getParameters().containsKey('t') || String.isBlank(ApexPages.currentPage().getParameters().get('t')) || !TransactionManager.isValidTransactionType(ApexPages.currentPage().getParameters().get('t'))) return;
            transactionType = ApexPages.currentPage().getParameters().get('t');
            transactionMgr = new TransactionManager(transactionType);
            // this is not efficient unless start pages follow this format consistently
            warningAgreeBox = false;
            customGuidanceView = transactionMgr.td.customGuidanceView__c;
            standardGuidanceView = transactionMgr.td.standardGuidanceView__c;
            // display text
            if (standardGuidanceView) {
                displayText0 = '';
                displayText0 += (transactionMgr.td.Guidance_Text_1__c == null ? '' : transactionMgr.td.Guidance_Text_1__c);
                displayText0 += (transactionMgr.td.Guidance_Text_2__c == null ? '' : transactionMgr.td.Guidance_Text_2__c);
                displayText0 += (transactionMgr.td.Guidance_Text_3__c == null ? '' : transactionMgr.td.Guidance_Text_3__c);
                displayText0 += (transactionMgr.td.Guidance_Text_4__c == null ? '' : transactionMgr.td.Guidance_Text_4__c);
                displayText0 += (transactionMgr.td.Guidance_Text_5__c == null ? '' : transactionMgr.td.Guidance_Text_5__c);
                displayText0 += (transactionMgr.td.Guidance_Text_6__c == null ? '' : transactionMgr.td.Guidance_Text_6__c);
            } else if (customGuidanceView) {
                guidanceTitle = (transactionMgr.td.Guidance_Text_1__c == null ? '' : transactionMgr.td.Guidance_Text_1__c);
                guidanceText1 = (transactionMgr.td.Guidance_Text_2__c == null ? '' : transactionMgr.td.Guidance_Text_2__c);
                guidanceText2 = (transactionMgr.td.Guidance_Text_3__c == null ? '' : transactionMgr.td.Guidance_Text_3__c);
                guidanceText3 = (transactionMgr.td.Guidance_Text_4__c == null ? '' : transactionMgr.td.Guidance_Text_4__c);
                guidanceText4 = (transactionMgr.td.Guidance_Text_5__c == null ? '' : transactionMgr.td.Guidance_Text_5__c);
                guidanceText5 = (transactionMgr.td.Guidance_Text_6__c == null ? '' : transactionMgr.td.Guidance_Text_6__c);
            }
            // checkbox text
            checkboxText0 = transactionMgr.td.GuidanceWarningText__c;
            // System.debug('while in initialize' + warningAgreeBox);
            if (String.isEmpty(displayText0)) displayText0 = null;
            isPageInitialised = true;
        } catch (Exception e) {
            return;
        }
        return;
    }

    public PageReference setAgreeValue() {
        if (!agreeBoxChoice) {
            currentErrorMessage = '<span class="error-message">You must agree to Proceed</span>';
            hasPageErrors = true;
            return null;
        } else if (agreeBoxChoice) {
            currentErrorMessage = '';
            hasPageErrors = false;
        } else if (String.valueOf(agreeBoxChoice) == 'undefined') {
            currentErrorMessage = '<span class="error-message">You must agree to Proceed</span>';
            hasPageErrors = true;
            return null;
        }
        return nextAction();
    }
// End Instance methods.
// Action methods.
    public PageReference nextAction() {
        //We don't redirect to the next step but to the auth
        userTracker = new TrackUserClass();
        //userTracker.setBooleanGuidanceAgreeBox(warningAgreeBox);
        // persist  warning box in cookie here
        // todo - the code below forces reauthentication.
        // todo - code should check for non-expired User_Authorisation__c record (record Id stored in user_auth cookie).
        userTracker.saveUserDocumentInfo();
        //userTracker.getUserDocument();
        // todo - reinstate user authentication by returning the pagereference below instead of logging it out.
        return securityMgr.getUserAuthRedirect();
    }
    public PageReference previousAction() {
        userTracker = new TrackUserClass();
        userTracker.saveUserDocumentInfo();
        return new PageReference('/?t=' + transactionType);
    }
// End Action methods.
}