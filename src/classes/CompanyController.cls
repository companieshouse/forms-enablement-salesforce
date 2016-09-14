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

    private Boolean validateStep() {
        if (String.isBlank(companyNumber)) {
            currentErrorMessage = 'Field is blank. Please enter a company number';
            hasPageErrors = true;
            currentError = 'error';
            return false;
        }
        //if (companyNumber.length() == 7) {
        //    companyNumber = '0' + companyNumber;
        //}

        companyNumber = companyNumber.deleteWhitespace();

        if (companyNumber.length() > 8) {
            currentErrorMessage = 'Please enter only 8 alphanumeric characters';
            hasPageErrors = true;
            currentError = 'error';
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
            if(Test.isRunningTest())
            {
                compProf.type = 'ltd';
                compProf.company_name = 'ltd SP';
            }
            else{
                compProf = CompanyQueryAction.getCompanyInfo(companyNumber);

                System.debug('STATUS OF CompanyQueryAction:' + CompanyQueryAction.isSuccess );
                if(!CompanyQueryAction.isSuccess)
                {
                    currentErrorMessage = 'Company data currently unavailable. Try again.';
                    hasPageErrors = true;
                    currentError = 'error';
                    return false;
                }
            }
        }catch(Exception e)
        {
            currentErrorMessage = 'Company number does not exist or incorrect.';
            hasPageErrors = true;
            currentError = 'error';
            return false;
        }
         

        if (compProf.company_name == null) {
            currentErrorMessage = 'Company number does not exist or incorrect.';
            hasPageErrors = true;
            currentError = 'error';

            //CSBEGINMOD: Carl 10/08/2016 : we were returning null instead of Boolean
            return false;
            //CSENDMOD: Carl 10/08/2016 : End mod
        }

        Map<String, String> companyType = new Map<String, String>();
        companyType.put('private-unlimited', 'Company'); //Company
        companyType.put('ltd', 'Company'); //Company
        companyType.put('plc', 'Company'); //Company
        companyType.put('old-public-company', 'Company');//Company
        companyType.put('private-limited-guarant-nsc-limited-exemption', 'Company');//Company
        companyType.put('limited-partnership', 'ERROR');//member
        companyType.put('private-limited-guarant-nsc', 'Company');//Company
        companyType.put('converted-or-closed', 'ERROR');//Company
        companyType.put('private-unlimited-nsc', 'Company');//Company
        companyType.put('private-limited-shares-section-30-exemption', 'Company');//Company
        companyType.put('assurance-company', 'ERROR');//Company
        companyType.put('oversea-company', 'ERROR');//Company
        companyType.put('eeig', 'ERROR');//Ignore 
        companyType.put('icvc-securities', 'ERROR');//Company
        companyType.put('icvc-warrant', 'ERROR');//Company
        companyType.put('icvc-umbrella', 'ERROR');//Company
        companyType.put('industrial-and-provident-society', 'ERROR');//Company
        companyType.put('northern-ireland', 'Company');//Company
        companyType.put('northern-ireland-other', 'Company');//Company
        companyType.put('llp', 'LLP');//member
        companyType.put('royal-charter', 'ERROR');//Company
        companyType.put('investment-company-with-variable-capital', 'ERROR');//Company
        companyType.put('unregistered-company', 'ERROR');//Company
        companyType.put('other', 'ERROR');//Company
        companyType.put('european-public-limited-liability-company-se', 'ERROR');//member
        companyType.put('uk-establishment', 'ERROR');//Company
        companyType.put('registered-society-non-jurisdictional', 'ERROR');//Company


        String companyTypeText = companyType.get(compProf.type);

        if(companyTypeText == 'ERROR')
        {
            currentErrorMessage = 'This company type is not accepted by the system.';
            hasPageErrors = true;
            currentError = 'error';
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
                    currentError = 'error';

                    return false;
                }
            }
            else
            {
                if(companyTypeText.equals('LLP'))
                {
                    currentErrorMessage = 'You cannot close this company type using this service.';
                    hasPageErrors = true;
                    currentError = 'error';

                    return false;
                }
            }
        }

        

        //    return false;
        //} else if (companyNumber.length() < 8) {
        //    currentErrorMessage = 'Please enter the 8 alphanumeric characters';
        //    return false;
        //}

        //if (!companyNumber.right(6).isNumeric()) {
        //    currentErrorMessage = 'The last 6 characters must be numeric';

        //    return false;
        //}

        //if()

        // todo perform a search on the company API to see if the company is valid and if so return false
        // and add an error to display.
        // note this is 2 api calls - must consult CH to see if this callback can be pulled from the company AUth.
        //

        return true;
    }

    public PageReference initialiseAction() {
        if (!isUserAuthenticated) return Page.StartFramework;
        if (!isPageInitialised) return Page.TransactionException;

        //Get if the user is auth
        Cookie userEmail = ApexPages.currentPage().getCookies().get('user_Email');

        //return SecurityManager.checkSessionValidityCookie();
        return SecurityManager.checkSessionValidityCookie(SecurityManager.decryptText(userEmail.getValue()));
    }

    public PageReference nextAction() {
        hasPageErrors = !validateStep();
        if (hasPageErrors) {
            currentError = 'error';
            return null;
        }

        

        trackuser = new TrackUserClass();
        // todo - the code below forces reauthentication.
        // todo - code should check for non-expired User_Authorisation__c record (record Id stored in user_auth cookie).
        // todo - reinstate company authentication


        //Merged From Leo 03 May 2016
        if (Test.isRunningTest()) {
            system.debug('test is running now');
            return null;
        } else {
			trackuser.getSearchedCompany(companyNumber);
        	//return securityMgr.getCompanyAuthRedirect(companyNumber, transactionType);
            PageReference pg = new PageReference('/CompanySearched');
            pg.setRedirect(true);
            pg.getParameters().put('t', transactionType);

            return pg;
		}
        //Id submissionId = submissionMgr.initialise( transactionType, '0014E000003oEPN', '0014E000003oEPI',transactionMgr.td.Fee__c );
        //return transactionMgr==null ? null : transactionMgr.firstStep(submissionId);
    }

    //private String getNonce() {

    //    final Integer NONCE_LENGTH = 16;

    //    final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';

    //    String nonce = '';

    //    while (nonce.length() < NONCE_LENGTH) {
    //        Integer i = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
    //        nonce += chars.substring(i, i + 1);
    //    }

    //    return nonce;
    //}

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