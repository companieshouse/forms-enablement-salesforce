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

    //Generic text from the metadata
    //
    public String displayText0 { get;
        set; }

    public String checkboxText0 { get;
        set; }

    //Checkbox in the page
    //
    public Boolean warningAgreeBox { get;
        set; }

    Boolean isPageInitialised = false;
    SecurityManager securityMgr;
    TransactionManager transactionMgr;

    public String transactionType { get;
        set; }


    //Constructor of the controller
    public GuidanceController() {
        initialiseStep();

    }

    public void initialiseStep() {
        securityMgr = new SecurityManager();

        userTracker = new TrackUserClass();

        // userTracker.getUserDocument();

        try {

            if (!ApexPages.currentPage().getParameters().containsKey('t') ||
                String.isBlank(ApexPages.currentPage().getParameters().get('t')) ||
                !TransactionManager.isValidTransactionType(ApexPages.currentPage().getParameters().get('t'))) return;

            transactionType = ApexPages.currentPage().getParameters().get('t');
            transactionMgr = new TransactionManager(transactionType);

            // this is not efficient unless start pages follow this format consistently

            warningAgreeBox = false;
            // display text
            displayText0 = '';
            displayText0 += (transactionMgr.td.Guidance_Text_1__c == null ? '' : transactionMgr.td.Guidance_Text_1__c);
            displayText0 += (transactionMgr.td.Guidance_Text_2__c == null ? '' : transactionMgr.td.Guidance_Text_2__c);
            displayText0 += (transactionMgr.td.Guidance_Text_3__c == null ? '' : transactionMgr.td.Guidance_Text_3__c);
            displayText0 += (transactionMgr.td.Guidance_Text_4__c == null ? '' : transactionMgr.td.Guidance_Text_4__c);
            displayText0 += (transactionMgr.td.Guidance_Text_5__c == null ? '' : transactionMgr.td.Guidance_Text_5__c);
            displayText0 += (transactionMgr.td.Guidance_Text_6__c == null ? '' : transactionMgr.td.Guidance_Text_6__c);
    
            // checkbox text
            checkboxText0 = transactionMgr.td.GuidanceWarningText__c;

            // System.debug('while in initialize' + warningAgreeBox);

            if (String.isEmpty(displayText0))
                displayText0 = null;


            isPageInitialised = true;
        } catch (Exception e) {
            return;
        }
        return;
    }

    public PageReference initializeBox() {
        initialiseStep();
        // warningAgreeBox = userTracker.GuidanceAgreeBox();
        return null;
    }

    public void updateBox() {
        if (warningAgreeBox == true)
            warningAgreeBox = false;
        else
            warningAgreeBox = true;
        return;
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