/*
Name:  CompanyDetailsController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Transaction Review Page
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  S PIcory    2016-05-19  Initial development.
*/
public with sharing class CompanyDetailsController extends TransactionStepControllerBase {

// Public properties.

    // MetaData
    public String displayText1 {get; set;}
    public String displayText2 {get; set;}
    public String displayText3 {get; set;}
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
    public Boolean showprevious {get; set;}

    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}

    public String previousButtonText {get; set;}
    public Boolean signingFinished {get; set;}

    public Boolean buttonDS01 {get; set;}
    public String textButtonDS01 {get; set;}
    public String textButtonOther {get; set;}

    public CompanyDetailsController() {
        super();

        if (isPageInitialised) initialiseStep();

    }

    public void initialiseStep() {

        buttonDS01 = submissionMgr.submission.Form_Name__c.contains('DS01') ? true : false;

        textButtonDS01 = 'Continue';
        if(submissionMgr.submission.Form_Name__c.contains('LL'))
        {
            textButtonDS01 = 'Continue';
        }
        textButtonOther = 'Continue';

        displayText1 = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c;
        previousButtonText = transactionMgr.currentStep.previousButtonText__c == null ? '' : transactionMgr.currentStep.previousButtonText__c;

        companyNumber = submissionMgr.submission.CompanyNumber__c;

        stepValidator = isPageAlreadyValidStep;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;

        if (Test.isRunningTest()) {
            system.debug('test is running now');
        } else {
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
        }
        showprevious = true;

        companyAddress = (companyAddress1 ==  null ? '' : companyAddress1 + '<br/>')  + (companyAddress2 ==  null ? '' : companyAddress2 + '<br/>')  + (companyLocality ==  null ? '' : companyLocality + '<br/>')  + (companyregion ==  null ? '' : companyregion + '<br/>') + (companypostcode ==  null ? '' : companypostcode + '<br/>')  + (companyCountry ==  null ? '' : companyCountry);

        return;
    }

    @TestVisible
    private void persistStep() {

        submissionMgr.submission.CompanyName__c = companyName;
        submissionMgr.submission.CompanyStatus__c = companyStatus;
        submissionMgr.submission.CompanyIncorporationDate__c = companyDateOfCreation;
        submissionMgr.submission.CompanyType__c = companyTypeText;
        submissionMgr.submission.CompanyAddress1__c = companyAddress1;
        submissionMgr.submission.CompanyAddress2__c = companyAddress2;
        submissionMgr.submission.CompanyCountry__c = companyCountry;
        submissionMgr.submission.CompanyLocality__c = companyLocality;
        submissionMgr.submission.CompanyPostCode__c = companypostcode;
        submissionMgr.submission.CompanyRegion__c = companyregion;
        submissionMgr.persist();
    }
    // End Instance methods.

    // Action methods.
    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;

        persistStep();

        return nextStep();
    }

    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;

        PageReference pg = new PageReference('/Company');

        pg.getParameters().put('t', submissionMgr.submission.Form_Name__c);
        pg.setRedirect(true);
        if(submissionMgr.submission.Contacts__r != null && !submissionMgr.submission.Contacts__r.isEmpty())
            delete submissionMgr.submission.Contacts__r;
        delete submissionMgr.submission;
        return pg;
        //return previousStep();
    }


}