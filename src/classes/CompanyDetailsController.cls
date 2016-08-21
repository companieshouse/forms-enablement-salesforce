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
public class CompanyDetailsController extends TransactionStepControllerBase {

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

    public Map<String, String> companyType {get; set;}

    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}

    public String previousButtonText {get; set;}
    public Boolean signingFinished {get; set;}

    public CompanyDetailsController() {
        super();

        if (isPageInitialised) initialiseStep();

    }

    public void initialiseStep() {
        displayText1 = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c;
        previousButtonText = transactionMgr.currentStep.previousButtonText__c == null ? '' : transactionMgr.currentStep.previousButtonText__c;

        companyNumber = submissionMgr.submission.CompanyNumber__c;
        companyType = new Map<String, String>();

        stepValidator = isPageAlreadyValidStep;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;
        companyType.put('private-unlimited', 'Private unlimited Company');
        companyType.put('ltd', 'Private limited Company');
        companyType.put('plc', 'Public limited Company');
        companyType.put('old-public-company', 'Old public Company');
        companyType.put('private-limited-guarant-nsc-limited-exemption', 'Private Limited Company by guarantee without share capital, use of \'Limited\'exemption');
        companyType.put('limited-partnership', 'Limited partnership');
        companyType.put('private-limited-guarant-nsc', 'Private limited by guarantee without share capital');
        companyType.put('converted-or-closed', 'Converted / closed');
        companyType.put('private-unlimited-nsc', 'Private unlimited Company without share capital');
        companyType.put('private-limited-shares-section-30-exemption', 'Private Limited Company, use of \'Limited\'exemption');
        companyType.put('assurance-company', 'Assurance Company');
        companyType.put('oversea-company', 'Overseas Company');
        companyType.put('eeig', 'European economic interest grouping (EEIG)');
        companyType.put('icvc-securities', 'Investment Company with variable capital');
        companyType.put('icvc-warrant', 'Investment Company with variable capital');
        companyType.put('icvc-umbrella', 'Investment Company with variable capital');
        companyType.put('industrial-and-provident-society', 'Industrial and provident society');
        companyType.put('northern-ireland', 'Northern Ireland Company');
        companyType.put('northern-ireland-other', 'Credit union (Northern Ireland)');
        companyType.put('llp', 'Limited liability partnership');
        companyType.put('royal-charter', 'Royal charter Company');
        companyType.put('investment-company-with-variable-capital', 'Investment Company with variable capital');
        companyType.put('unregistered-company', 'Unregistered Company');
        companyType.put('other', 'Other Company type');
        companyType.put('european-public-limited-liability-company-se', 'European public limited liability Company (SE)');
        companyType.put('uk-establishment', 'UK establishment Company');

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
            companyTypeText = companyType.get(compProf.type);
        }
        showprevious = true;

        companyAddress = (companyAddress1 ==  null ? '' : companyAddress1 + '<br/>')  + (companyAddress2 ==  null ? '' : companyAddress2 + '<br/>')  + (companyLocality ==  null ? '' : companyLocality + '<br/>')  + (companyregion ==  null ? '' : companyregion + '<br/>') + (companypostcode ==  null ? '' : companypostcode + '<br/>')  + (companyCountry ==  null ? '' : companyCountry);

        return;
    }

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
        delete submissionMgr.submission;
        return pg;
        //return previousStep();
    }


}