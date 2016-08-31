/*
Name:  StartController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Start

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-02  Initial development.
*/
public with sharing class StartFrameworkController {
    public String pageTitle {
        get;
        set;
    }
    public String pageText {
        get;
        set;
    }
    public String pageTextAfterButton {
        get;
        set;
    }
    public String pageTextAfterButton2 {
        get;
        set;
    }
    public String transactionType {
        get;
        set;
    }
    // Private class members.
    Boolean isPageInitialised = false;
    SecurityManager securityMgr;
    TransactionManager transactionMgr;
    TrackUserClass userTracker;
    public Boolean hasGuidancePage {get; set;}
    //String transactionType;
    // Constructors.
    public StartFrameworkController() {
        initialise();
    }
    private void initialise() {
        securityMgr = new SecurityManager();
        //  userTracker = new TrackUserClass();
        // userTracker.getUserDocument();
        SecurityManager.createSessionValidityCookie();
        try {
            if (!ApexPages.currentPage().getParameters().containsKey('t') || String.isBlank(ApexPages.currentPage().getParameters().get('t')) || !TransactionManager.isValidTransactionType(ApexPages.currentPage().getParameters().get('t'))) return;
            transactionType = ApexPages.currentPage().getParameters().get('t');
            transactionMgr = new TransactionManager(transactionType);
            // this is not efficient unless start pages follow this format consistently
            pageTitle = (transactionMgr.td.Landing_Page_Title__c == null ? '' : transactionMgr.td.Landing_Page_Title__c);
            //pageTitle = (transactionMgr.td.Landing_Page_Title2__c == null ? '' : transactionMgr.td.Landing_Page_Title2__c);
            //pageTitle = (transactionMgr.td.Landing_Page_Title3__c == null ? '' : transactionMgr.td.Landing_Page_Title3__c);
            pageText = transactionMgr.td.Landing_Page_Text__c == null ? '' : transactionMgr.td.Landing_Page_Text__c;
            pageText += transactionMgr.td.Landing_Page_Text2__c == null ? '' : transactionMgr.td.Landing_Page_Text2__c;
            pageText += transactionMgr.td.Landing_Page_Text3__c == null ? '' : transactionMgr.td.Landing_Page_Text3__c;
            pageText += transactionMgr.td.Landing_Page_Text4__c == null ? '' : transactionMgr.td.Landing_Page_Text4__c;
            pageText += transactionMgr.td.Landing_Page_Text5__c == null ? '' : transactionMgr.td.Landing_Page_Text5__c;
            pageText += transactionMgr.td.Landing_Page_Text6__c == null ? '' : transactionMgr.td.Landing_Page_Text6__c;
            //pageText = transactionMgr.td.Landing_Page_Text7__c == null ? '' : transactionMgr.td.Landing_Page_Text7__c;
            //pageText = transactionMgr.td.Landing_Page_Text8__c == null ? '' : transactionMgr.td.Landing_Page_Text8__c;
            //pageText = transactionMgr.td.Landing_Page_Text9__c == null ? '' : transactionMgr.td.Landing_Page_Text9__c;
            //pageText = transactionMgr.td.Landing_Page_Text10__c == null ? '' : transactionMgr.td.Landing_Page_Text10__c;
            //pageText = transactionMgr.td.Landing_Page_Text11__c == null ? '' : transactionMgr.td.Landing_Page_Text11__c;
            pageTextAfterButton = transactionMgr.td.Below_Button_Text__c == null ? '' : transactionMgr.td.Below_Button_Text__c;
            pageTextAfterButton2 = transactionMgr.td.Below_Button_Text2__c == null ? '' : transactionMgr.td.Below_Button_Text2__c;

            hasGuidancePage = transactionMgr.td.hasGuidancePage__c;
            isPageInitialised = true;
        } catch (Exception e) {
            return;
        }
        return;
    }
    // End Constructors.
    // Instance methods.
    public PageReference initialiseAction() {
        if (!isPageInitialised) return Page.TransactionException;
        return SecurityManager.checkSessionValidityCookie();
    }
    public PageReference startAction() {
        //Static step we need to check the boolean if there is a guidance page in the form
        if (hasGuidancePage) {
            userTracker = new TrackUserClass();
            PageReference pr = new PageReference('/Guidance');
            pr.getParameters().put('t', transactionType);
            pr.setRedirect(true);
            return pr;
        } else {
            //We don't redirect to the next step but to the auth
            userTracker = new TrackUserClass();
            // todo - the code below forces reauthentication.
            // todo - code should check for non-expired User_Authorisation__c record (record Id stored in user_auth cookie).
            userTracker.saveUserDocumentInfo();
            //userTracker.getUserDocument();
            // todo - reinstate user authentication by returning the pagereference below instead of logging it out.
            return securityMgr.getUserAuthRedirect(null);
        }
    }
    // End Instance methods.
}