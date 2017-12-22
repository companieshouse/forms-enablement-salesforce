/*
Name:  CompanySearchedController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Searched Company Page
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  S PIcory    2016-09-08  Initial development.
*/
public with sharing class CompanySearchedController {

// Public properties.

    // MetaData
    public String displayText1 {get; set;}
    public String headerText1 {get; set;}

    // dynamic set data
    public String companyName {get; set;}
    public String companyNumber {get; set;}
    public String companyTypeText {get; set;}
    public String companyStatus {get; set;}
    public String companyDateOfCreation {get; set;}


    // company address information
    public String companyAddress {get; set;}
    public String companyAddress1 {get; set;}
    public String companyAddress2 {get; set;}
    public String companyregion {get; set;}
    public String companypostcode {get; set;}
    public String companyCountry {get; set;}
    public String companyLocality {get; set;}

    public String previousButtonText {get; set;}

    public SecurityManager securityMgr {get; set;}
    public TransactionManager transactionMgr {get; set;}

    public String transactionType {
        get;
        set;
    }

    public CompanySearchedController() {

    	initialiseStep();

    }

    public void initialiseStep() {
    	securityMgr = new SecurityManager();

		if (!ApexPages.currentPage().getParameters().containsKey('t') ||
                String.isBlank(ApexPages.currentPage().getParameters().get('t')) ||
                !TransactionManager.isValidTransactionType(ApexPages.currentPage().getParameters().get('t'))) return;

        transactionType = ApexPages.currentPage().getParameters().get('t');
        transactionMgr = new TransactionManager(transactionType);

        displayText1 = transactionMgr.td.CompanySearchedBody1__c == null ? '' : transactionMgr.td.CompanySearchedBody1__c;
        headerText1 = transactionMgr.td.CompanySearchedHeader1__c == null ? '' : transactionMgr.td.CompanySearchedHeader1__c;
        previousButtonText = transactionMgr.td.CompanySearchedPreviousButton__c == null ? '' : transactionMgr.td.CompanySearchedPreviousButton__c;
        if(!ApexPages.currentPage().getCookies().containsKey('searched_company'))
        	return;
        companyNumber = SecurityManager.decryptText(ApexPages.currentPage().getCookies().get('searched_company').getValue());
    
        
        CompaniesHouse.CompanyProfile compProf = CompanyQueryAction.getCompanyInfo(companyNumber);
        companyAddress1 = compProf.registered_office_address.address_line_1;
        companyAddress2 = compProf.registered_office_address.address_line_2;
        companyregion = compProf.registered_office_address.region;
        companypostcode = compProf.registered_office_address.postal_code ;
        companyCountry = compProf.registered_office_address.country;
        companyLocality = compProf.registered_office_address.locality;
        companyStatus = compProf.company_status.capitalize();
        String[] split = compProf.date_of_creation.split('-');
        Datetime tempDate = Datetime.newInstance(Integer.valueOf(split[0]), Integer.valueOf(split[1]), Integer.valueOf(split[2]));
        companyDateOfCreation = tempDate.format('dd MMMMM yyyy');

        companyName = compProf.company_name;
        companyTypeText = AppConstants.formatedCompanyType.get(compProf.type);
        

        companyAddress = (companyAddress1 ==  null ? '' : companyAddress1 + '<br/>')  + (companyAddress2 ==  null ? '' : companyAddress2 + '<br/>')  + (companyLocality ==  null ? '' : companyLocality + '<br/>')  + (companyregion ==  null ? '' : companyregion + '<br/>') + (companypostcode ==  null ? '' : companypostcode + '<br/>')  + (companyCountry ==  null ? '' : companyCountry);

        return;
    }

    public PageReference initialiseAction() {
        //Get if the user is auth
        Cookie userEmail = ApexPages.currentPage().getCookies().get('user_Email');

        String emailD = ApexPages.currentPage().getCookies().containsKey('user_Email') ? SecurityManager.decryptText(userEmail.getValue()) : '';
        //return SecurityManager.checkSessionValidityCookie();
        return SecurityManager.checkSessionValidityCookie(emailD, null, null, 'Company Search Controller');
    }


    // Action methods.
    public PageReference nextAction() {
        return securityMgr.getCompanyAuthRedirect(companyNumber, transactionType);
    }

    public PageReference previousAction() {

        PageReference pg = new PageReference('/Company');

        pg.getParameters().put('t', transactionType);
        pg.setRedirect(true);
        return pg;
        //return previousStep();
    }


}