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
    public String companyNumber {get;set;}
    public Boolean hasPageErrors {get;set;}
    public String transactionType {get;set;}
    public String currentError {get;set;}
    public String currentErrorMessage {get;set;}
    public String companySearchHeader {get; set;}

    public String pageTitle {get; set;}
    public String pageBody {get; set;}
    public String pageBody2 {get; set;}


    // Private class members.
    Boolean isPageInitialised = false;
    Boolean isUserAuthenticated = false;
    SecurityManager securityMgr;
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
            pageTitle = transactionMgr.td.Company_Page_Title__c == null ? '' : transactionMgr.td.Company_Page_Title__c;
            pageBody = transactionMgr.td.Company_Page_Body_1__c == null ? '' : transactionMgr.td.Company_Page_Body_1__c;
            pageBody += transactionMgr.td.Company_Page_Body_2__c == null ? '' : transactionMgr.td.Company_Page_Body_2__c;

            pageBody2 = transactionMgr.td.Company_Page_HiddenT1__c == null ? '' : transactionMgr.td.Company_Page_HiddenT1__c;
            pageBody2 += transactionMgr.td.Company_Page_HiddenT2__c == null ? '' : transactionMgr.td.Company_Page_HiddenT2__c;
            pageBody2 += transactionMgr.td.Company_Page_HiddenT3__c == null ? '' : transactionMgr.td.Company_Page_HiddenT3__c;


        } catch (Exception e) {
            return;
        }
        return;
    }

    @TestVisible
    private Boolean validateStep() {
        if (String.isBlank(companyNumber)) {
            currentErrorMessage = 'You must enter the company number';
            hasPageErrors = true;
            currentError = 'govuk-form-group--error';
            return false;
        }
        

        companyNumber = companyNumber.deleteWhitespace();

        if (companyNumber.length() > 8) {
            currentErrorMessage = 'Please enter only 8 alphanumeric characters';
            hasPageErrors = true;
            currentError = 'govuk-form-group--error';
            return false;
        }

        String prefix = '';

        //Extract the prefix
        if(companyNumber.length() >= 2)
            if(companyNumber.substring(0,2).isAlpha())
            {
                prefix = companyNumber.substring(0,2);
            }
        
        Integer size = (String.isBlank(prefix) ? companyNumber.length() : companyNumber.substring(2).length());
        String postfix = (String.isBlank(prefix) ? companyNumber : companyNumber.substringAfter(prefix));

        while(size < (String.isBlank(prefix) ? 8 : 6 ))
        {
            postfix = '0' + postfix;
            size++;
        }

        prefix = prefix.toUpperCase();
        companyNumber = prefix + postfix;
        CompaniesHouse.CompanyProfile compProf = new CompaniesHouse.CompanyProfile();

        try{
            
            compProf = CompanyQueryAction.getCompanyInfo(companyNumber);

            System.debug('STATUS OF CompanyQueryAction:' + CompanyQueryAction.isSuccess );
            if(!CompanyQueryAction.isSuccess)
            {
                currentErrorMessage = 'Company data currently unavailable. Try again.';
                hasPageErrors = true;
                currentError = 'govuk-form-group--error';
                return false;
            }
            
        }catch(Exception e)
        {
            currentErrorMessage = 'Company number does not exist or incorrect.';
            hasPageErrors = true;
            currentError = 'govuk-form-group--error';
            return false;
        }    

        if (compProf.company_name == null) {
            currentErrorMessage = 'Company number does not exist or incorrect.';
            hasPageErrors = true;
            currentError = 'govuk-form-group--error';

            //CSBEGINMOD: Carl 10/08/2016 : we were returning null instead of Boolean
            return false;
            //CSENDMOD: Carl 10/08/2016 : End mod
        }

        String companyTypeText = AppConstants.validCompanyType.get(compProf.type);

        if(companyTypeText == 'ERROR')
        {
            currentErrorMessage = 'This company type is not accepted by the system.';
            hasPageErrors = true;
            currentError = 'govuk-form-group--error';
            return false;
        }

        if(transactionType.contains('DS01') || transactionType.contains('DS02'))
        {
            if(transactionType.contains('LL'))
            {
                if(!companyTypeText.equals('LLP'))
                {
                    currentErrorMessage = 'You cannot close this company type using this service.';
                    hasPageErrors = true;
                    currentError = 'govuk-form-group--error';

                    return false;
                }
            }
            else
            {
                if(companyTypeText.equals('LLP'))
                {
                    currentErrorMessage = 'You cannot close this company type using this service.';
                    hasPageErrors = true;
                    currentError = 'govuk-form-group--error';

                    return false;
                }
            }
        }

        return true;
    }

    public PageReference initialiseAction() {
        if (!isUserAuthenticated) return Page.StartFramework;
        if (!isPageInitialised) return Page.TransactionException;

        //Get if the user is auth
        Cookie userEmail = ApexPages.currentPage().getCookies().get('user_Email');

        //return SecurityManager.checkSessionValidityCookie();
        return SecurityManager.checkSessionValidityCookie(SecurityManager.decryptText(userEmail.getValue()), null, null, 'Company Controller' );
    }

    public PageReference nextAction() {
        hasPageErrors = !validateStep();
        if (hasPageErrors) {
            currentError = 'govuk-form-group--error';
            return null;
        }       

        trackuser = new TrackUserClass();

        //Merged From Leo 03 May 2016
        trackuser.getSearchedCompany(companyNumber);
        //return securityMgr.getCompanyAuthRedirect(companyNumber, transactionType);
        PageReference pg = new PageReference('/CompanySearched');
        pg.setRedirect(true);
        pg.getParameters().put('t', transactionType);

        return pg;
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