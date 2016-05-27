/*
Name:  DocStatusController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Authenticated Document Statuses 
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-05-27  Initial development.
*/
public with sharing class DocStatusController {

    public String cookiestatus {
        get;
        set;
    }
    public String transactionType {
        get;
        set;
    }
    public String contactemail {
        get;
        set;
    }
    public String transactionID {
        get;
        set;
    }
    public String companyNumber {
        get;
        set;
    }
    public Transaction__c currenttransaction {
        get;
        set;
    }

    public Transaction__c tx {
        get;
        set;
    }
    public String title {
        get;
        private set;
    }
    public Id attachmentId {
        get;
        private set;
    }
    public String size {
        get;
        private set;
    }

	private String nonce;
    private Company_Authorisation__c companyAuth;
    private static final String QUERY_STRING_PARAM_NONCE = 'state';

    SecurityManager securityMgr;

    public class DocStatusControllerCallbackException extends Exception {}

    public DocStatusController() {

    }
    public PageReference initialiseController() {

        parseQueryString();

        findCompanyAuthByNonce();

        // parse the query string and search for the company auth by the noncevalue 
        // if null redirect to company search page for auth 
        if (companyAuth != null) {

            // get transaction and attachment and set vforcepage
            getDocumentDownloadTransaction();

            tx = currenttransaction;

            DestroyCookies();

            return null;

        } else {
            // set the cookiestatus and then redirect to companypage and call SecurityManager.getDownloadAuthRedirect();
            // to be sent back and captured in the above
            securityMgr = new SecurityManager();

            CreateDocumentStatusCookies();
            system.debug('transactiontype= ' + transactionType + 'company number=' + companyNumber);
            // need to check for company number/ parameters and if they don't exist then throw an error to show up on the docstatus page in apex messages
            
            return securityMgr.getDocumentStatusAuthRedirect(companyNumber, transactionType);

            // company page search redirect
            /*
            PageReference pr = new PageReference('/Company');
            pr.getParameters().put('t', transactionType);
            return pr;
            */
        }

    }

    Public String CreateDocumentStatusCookies() {

        String dvalueparameter = ApexPages.currentPage().getParameters().get('documentstatus');

        transactionType = dvalueparameter.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];

        contactemail = dvalueparameter.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];

        transactionID = dvalueparameter.split(AppConstants.ID_DELIM_SPLIT_CHAR)[2];

        companyNumber = dvalueparameter.split(AppConstants.ID_DELIM_SPLIT_CHAR)[3];

        cookiestatus = 'setauth';

        Cookie d_valuetType = new Cookie('d_valueTType', SecurityManager.encryptText(transactionType), null, -1, true);

        Cookie d_valueEmail = new Cookie('d_valueEmail', SecurityManager.encryptText(contactemail), null, -1, true);

        Cookie d_valueId = new Cookie('d_valueId', SecurityManager.encryptText(transactionID), null, -1, true);

        Cookie d_valueCookieStatus = new Cookie('d_valueCookieStatus', SecurityManager.encryptText(cookiestatus), null, -1, true);

        ApexPages.currentPage().setCookies(new Cookie[] { d_valuetType, d_valueEmail, d_valueId, d_valueCookieStatus });

        return null;
    }

    Public sObject getDocumentDownloadTransaction() {

        Cookie a = ApexPages.currentPage().getCookies().get('d_valueTType');

        Cookie b = ApexPages.currentPage().getCookies().get('d_valueEmail');

        Cookie c = ApexPages.currentPage().getCookies().get('d_valueId');

        transactiontype = SecurityManager.decryptText(a.getValue());

        contactemail = SecurityManager.decryptText(b.getValue());

        transactionID = SecurityManager.decryptText(c.getValue());

        List < Transaction__c > recs = [select Id, Form_Name__c, Presenter__c, Presenter__r.Name, isMajorityRequired__c, PresenterName__c, PresenterPhoneNumber__c, RequiredOfficerSign__c, ContactEmail__c, MultipleDirectors__c, Name, Historical_Valid_Step_Ids__c, CompanyNumber__c, Status__c, CompanyName__c, SubmissionId__c, Warning_Confirmation_Flag__c, Amount__c, (SELECT Id, BodyLength, Name FROM Attachments), (Select Id, Name, Email__c, isPresenter__c, isSignatory__c From Officers__r) from Transaction__c where Id = : transactionID];
        if (recs.size() == 1) currenttransaction = recs[0];


        return currenttransaction;
    }

    Public String DestroyCookies() {

        Cookie d_valuetType = new Cookie('d_valueTType', 'empty', null, 0, true);

        Cookie d_valueEmail = new Cookie('d_valueEmail', 'empty', null, 0, true);

        Cookie d_valueId = new Cookie('d_valueId', 'empty', null, 0, true);

        return null;
    }

    private void parseQueryString() {
        // Expect a nonce on the query string under the param "state".
        nonce = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_NONCE);
        if (String.isBlank(nonce)) {

            // not authenticated so call authentication

        }
        //throw new DocumentControllerCallbackException('A ' + QUERY_STRING_PARAM_NONCE + ' parameter is required.'); }
    }

    private void findCompanyAuthByNonce() {
        try {

            List < Company_Authorisation__c > companyAuthorisations = [select Id from Company_Authorisation__c where Nonce__c = : nonce];
            if (companyAuthorisations.size() == 1) {
                companyAuth = companyAuthorisations[0];
                return;
            }
        } catch (QueryException e) {
            throw new DocStatusControllerCallbackException('Invalid state ' + nonce);
        }
    }
}