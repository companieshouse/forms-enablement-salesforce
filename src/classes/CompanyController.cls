/*
Name:  CompanyController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Company

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-09  Initial development.
*/
public with sharing class CompanyController {

    // Public properties.
    public String companyNumber {
        get;
        set;
    }
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String transactionType {
        get;
        set;
    }
    public String currentError {
        get;
        set;
    }
    public String currentErrorMessage {
        get;
        set;
    }
    public String companySearchHeader {get; set;}

    // Private class members.
    Boolean isPageInitialised = false;
    Boolean isUserAuthenticated = false;
    SecurityManager securityMgr;
    SubmissionManager submissionMgr;
    TransactionManager transactionMgr;
    //String transactionType;
    TrackUserClass trackuser;


    // Constructors.
    public CompanyController() {
        trackuser = new TrackUserClass();
        trackuser.saveUserDocumentInfo();
        initialise();
    }
    // End Constructors.

    // Instance methods.
    private void initialise() {
        securityMgr = new SecurityManager();
        submissionMgr = new SubmissionManager();

        try {

            // todo - check for valid user auth cookie.
            isUserAuthenticated = true;

            if (!ApexPages.currentPage().getParameters().containsKey('t') ||
                    String.isBlank(ApexPages.currentPage().getParameters().get('t')) ||
                    !TransactionManager.isValidTransactionType(ApexPages.currentPage().getParameters().get('t'))) return;

            transactionType = ApexPages.currentPage().getParameters().get('t');
            transactionMgr = new TransactionManager(transactionType);
            companySearchHeader = transactionMgr.td.companySearchPageText__c;
            isPageInitialised = true;
        } catch (Exception e) {
            return;
        }
        return;
    }

    private Boolean validateStep() {
        if (String.isBlank(companyNumber)) {
            currentErrorMessage = 'Field is blank. please enter a company number';

            return false;
        }
        if (companyNumber.length() == 7) {
            companyNumber = '0' + companyNumber;
        }

        if (companyNumber.length() > 8) {
            currentErrorMessage = 'Please enter only 8 alphanumeric characters';

            return false;
        } else if (companyNumber.length() < 8) {
            currentErrorMessage = 'Please enter the 8 alphanumeric characters';
            return false;
        }

        if (!companyNumber.right(6).isNumeric()) {
            currentErrorMessage = 'The last 6 characters must be numeric';

            return false;
        }

        // todo perform a search on the company API to see if the company is valid and if so return false
        // and add an error to display.
        // note this is 2 api calls - must consult CH to see if this callback can be pulled from the company AUth.
        //

        return true;
    }

    public PageReference initialiseAction() {
        if (!isUserAuthenticated) return Page.StartFramework;
        if (!isPageInitialised) return Page.TransactionException;
        return null;
    }

    public PageReference nextAction() {
        hasPageErrors = !validateStep();
        if (hasPageErrors) {
            currentError = 'error';
            return null;
        }

        CompaniesHouse.CompanyProfile compProf = CompanyQueryAction.getCompanyInfo(companyNumber);
        if (compProf.company_name == null) {
            currentErrorMessage = 'Company number does not exist';
            hasPageErrors = true;
            currentError = 'error';
            return null;
        }

        trackuser = new TrackUserClass();
        // todo - the code below forces reauthentication.
        // todo - code should check for non-expired User_Authorisation__c record (record Id stored in user_auth cookie).
        // todo - reinstate company authentication


        //Merged From Leo 03 May 2016
        trackuser.getSearchedCompany(companyNumber);
        return securityMgr.getCompanyAuthRedirect(companyNumber, transactionType);
        //Id submissionId = submissionMgr.initialise( transactionType, '0014E000003oEPN', '0014E000003oEPI',transactionMgr.td.Fee__c );
        //return transactionMgr==null ? null : transactionMgr.firstStep(submissionId);
    }

    public PageReference previousAction() {
        trackuser = new TrackUserClass();
        trackuser.saveUserDocumentInfo();
        if (transactionMgr.td.hasGuidancePage__c) {
            return new PageReference('/Guidance?t=' + transactionType);
        }

        return new PageReference('/?t=' + transactionType);
    }
    // End Instance methods.

}