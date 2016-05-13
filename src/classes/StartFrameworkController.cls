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

    // Public properties.
        public Cookie t_value {get; set;}

    public String pageTitle {
        get;
        private set;
    }
    public String pageText {
        get;
        private set;
    }
    public String pageText2 {
        get;
        private set;
    }
    public String pageText3 {
        get;
        private set;
    }
    public String pageText4 {
        get;
        private set;
    }
    public String pageText5 {
        get;
        private set;
    }
    public String pageText6 {
        get;
        private set;
    }
    public String abovebuttontext {
        get;
        private set;
    }
    public String belowbuttontitle {
        get;
        private set;
    }
    public String belowbuttontext {
        get;
        private set;
    }
    public String belowbuttontext2 {
        get;
        private set;
    }
    public String belowbuttontext3 {
        get;
        private set;
    }
    public String transactionType {get; set;}


    // Private class members.
    Boolean isPageInitialised = false;
    SecurityManager securityMgr;
    TransactionManager transactionMgr;
    TrackUserClass userTracker;

    //String transactionType;

    // Constructors.
    public StartFrameworkController() {
        initialise();
    }

    private void initialise() {
        
            securityMgr = new SecurityManager();


            try {
                
                if (!ApexPages.currentPage().getParameters().containsKey('t') ||
                    String.isBlank(ApexPages.currentPage().getParameters().get('t')) ||
                    !TransactionManager.isValidTransactionType(ApexPages.currentPage().getParameters().get('t'))) return;
                    
                transactionType = ApexPages.currentPage().getParameters().get('t');
                transactionMgr = new TransactionManager(transactionType);

                // this is not efficient unless start pages follow this format consistently
                pageTitle = transactionMgr.td.Landing_Page_Title__c;
                pageText = transactionMgr.td.Landing_Page_Text__c;
                pageText2 = transactionMgr.td.Landing_Page_Text2__c;
                pageText3 = transactionMgr.td.Landing_Page_Text3__c;
                pageText4 = transactionMgr.td.Landing_Page_Text4__c;
                pageText5 = transactionMgr.td.Landing_Page_Text5__c;
                pageText6 = transactionMgr.td.Landing_Page_Text6__c;
                abovebuttontext = transactionMgr.td.above_button_text__c;
                belowbuttontitle = transactionMgr.td.Below_Button_Title__c;
                belowbuttontext = transactionMgr.td.Below_Button_Text__c;
                belowbuttontext2 = transactionMgr.td.Below_Button_Text2__c;
                belowbuttontext3 = transactionMgr.td.Below_Button_Text3__c;

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
        return null;
    }

    public PageReference startAction() {

           userTracker = new TrackUserClass();

            // todo - the code below forces reauthentication.
            // todo - code should check for non-expired User_Authorisation__c record (record Id stored in user_auth cookie).        
            userTracker.saveUserDocumentInfo();

            
           // userTracker.getUserDocument();

            // todo - reinstate user authentication by returning the pagereference below instead of logging it out.
            return securityMgr.getUserAuthRedirect();
            
        }
        // End Instance methods.
}