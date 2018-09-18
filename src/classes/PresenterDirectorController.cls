/*
Name:  PresenterDirectorController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: DirectorsInputList

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-02-04  Initial development.
*/
public with sharing class PresenterDirectorController extends TransactionStepControllerBase {

    public String companyAddress {get; set;}
    public String companyAddress1 {get; set;}
    public String companyAddress2 {get; set;}
    public String companyregion {get; set;}
    public String companypostcode {get; set;}
    public String companyCountry {get; set;}
    public String companyLocality {get; set;}
    public String companyStatus {get; set;}
    public String companyDateOfCreation {get; set;}
    public String companyTypeText {get; set;}
    public Integer nbOfOfficers {get; set;}
    public Boolean isLLPCompany {get; set;}
    public Boolean isPLCLTDCompany {get; set;}
    public Boolean isLPCompany {get; set;}
    public String officerTerm {get; set;}
    public Boolean noOfficers {get; set;}
    public List<String> listOfDirectorsAPI {get; set;}
    public Boolean hasAlreadyLoadedOfficers {get; set;}
    public Integer totalOfficers {get; set;}
    public Boolean singleOfficer {get; set;}
    public String divForErrorLink {get; set;}
    
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String currentPageError {
        get;
        set;
    }
    public String currentPageErrorTop {
        get;
        set;
    }
    public String currentPageErrorBot {
        get;
        set;
    }
    public String errorVal {
        get;
        set;
    }
    public String errorValBottom {
        get;
        set;
    }

    public String errorValBottom2 {
        get;
        set;
    }
    public String companyName {
        get;
        set;
    }
    public String companyNumber {
        get;
        set;
    }
    public List < officerContainer > listOfDirectors {
        get;
        set;
    }
    public Boolean directorPresenter {
        get;
        set;
    }

    public String presenterName {
        get;
        set;
    }
    public String phoneNumber {
        get;
        set;
    }

    public String pageTitle {get; set;}
    public String pageBody {get; set;}
    public String pageBody2 {get; set;}
    public String pageHiddenText {get; set;}
    public Boolean showMorePresenterInfo {get; set;}
    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}
    public Boolean signingFinished {get; set;}

    public PresenterDirectorController() {
        super();
        if (isPageInitialised) initialiseStep();
    }

    public void initCompInfo(Transaction__c sub){
        listOfDirectorsAPI = new List<String>();
        if (Test.isRunningTest()) {
            system.debug('test is running now');
        } else {
            CompaniesHouse.CompanyProfile compProf = CompanyQueryAction.getCompanyInfo(sub.CompanyNumber__c);
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

        if (isPageAlreadyValidStep) {
            hasAlreadyLoadedOfficers = true;
        }
        //Get the list officer already created
        if (submissionMgr.submission.Officers__r != null) {
            if (submissionMgr.submission.Officers__r.size() == 0) {
                hasAlreadyLoadedOfficers = false;
            } else {
                hasAlreadyLoadedOfficers = true;
            }
        }
    }

    public void initialiseStep() {

        initCompInfo(submissionMgr.submission);

        submissionMgr.submission.CompanyStatus__c = companyStatus;
        submissionMgr.submission.CompanyIncorporationDate__c = companyDateOfCreation;
        submissionMgr.submission.CompanyType__c = companyTypeText;
        submissionMgr.submission.CompanyAddress1__c = companyAddress1;
        submissionMgr.submission.CompanyAddress2__c = companyAddress2;
        submissionMgr.submission.CompanyCountry__c = companyCountry;
        submissionMgr.submission.CompanyLocality__c = companyLocality;
        submissionMgr.submission.CompanyPostCode__c = companypostcode;
        submissionMgr.submission.CompanyRegion__c = companyregion;
        submissionMgr.submission.CompanyName__c = companyName;

        stepValidator = isPageAlreadyValidStep;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;
        //Set up the company name
        showMorePresenterInfo = false;
        //directorPresenter = true;
        phoneNumber = '';
        presenterName = '';
        errorValBottom2 = '';
        errorValBottom = '';
        currentPageErrorTop = '';
        currentPageErrorBot = '';
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        listOfDirectors = new List < officerContainer > ();
        pageTitle = transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c;
        pageBody = '';

        pageHiddenText = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;
        pageBody2 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;

        pageTitle = pageTitle.replace('director', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c.replace('s', '')));
        pageHiddenText = pageHiddenText.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));

        return;
    }
    public void persistStep() {
        if (directorPresenter) {
            if (submissionMgr.submission.Officers__r.size() == 1) {
                submissionMgr.submission.SoleDirectorPresenter__c = true;
                submissionMgr.submission.Officers__r[0].isSignatory__c = true;
                submissionMgr.submission.Officers__r[0].isPresenter__c = true;
            } else {
                submissionMgr.submission.isPresenterMultipleDirectors__c = true;
            }
        } else {
            submissionMgr.submission.PresenterPhoneNumber__c = phoneNumber;
            submissionMgr.submission.PresenterName__c = presenterName;
            submissionMgr.submission.SoleDirectorPresenter__c = false;
            //TODO: remove existing flag in case of previous from officer
        }
        submissionMgr.submission.CompanyStatus__c = companyStatus;
        submissionMgr.submission.CompanyIncorporationDate__c = companyDateOfCreation;
        submissionMgr.submission.CompanyType__c = companyTypeText;
        submissionMgr.submission.CompanyAddress1__c = companyAddress1;
        submissionMgr.submission.CompanyAddress2__c = companyAddress2;
        submissionMgr.submission.CompanyCountry__c = companyCountry;
        submissionMgr.submission.CompanyLocality__c = companyLocality;
        submissionMgr.submission.CompanyPostCode__c = companypostcode;
        submissionMgr.submission.CompanyRegion__c = companyregion;
        submissionMgr.submission.CompanyName__c = companyName;
        submissionMgr.submission.OfficerCount__c = nbOfOfficers;
        submissionMgr.persist();
    }
    public PageReference nextAction() {
        if (directorPresenter == null) {
            hasPageErrors = true;
            errorVal = 'govuk-form-group--error';
            currentPageError = 'Please make a selection to continue';
            divForErrorLink = '#radio-indent-1';
            return null;
        }

        if(!directorPresenter)
        {
            Boolean hasError = false;
            if(presenterName != null)
                if(presenterName.length() > 255)
                {
                    hasError = true;
                    hasPageErrors = true;
                    errorValBottom = 'govuk-form-group--error';
                    currentPageErrorTop = 'The name is too long (maximum number of characters allowed is 255).';
                    divForErrorLink = '#presentorPage:TempPage:form:directors-name';
                }
                else{
                    errorValBottom = '';
                    currentPageErrorTop = '';
                }
            else{
                errorValBottom = '';
                currentPageErrorTop = '';
            }

            if(phoneNumber != null)
                if(phoneNumber.length() > 255)
                {
                    hasError = true;
                    hasPageErrors = true;
                    errorValBottom2 = 'govuk-form-group--error';
                    currentPageErrorBot = 'The phone number is too long (maximum number of characters allowed is 255).';
                    divForErrorLink = '#presentorPage:TempPage:form:directors-confirm-phone';
                }else{
                    errorValBottom2 = '';
                    currentPageErrorBot = '';
                }
            else{
                errorValBottom2 = '';
                currentPageErrorBot = '';
            }

            if(hasError){
                return null;
            }
            
        }

        if (!validatePageState()) return Page.TransactionException;
        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
        if (Test.isRunningTest()) {
            system.debug('test is running now');
        } else {
            if (!validatePageState()) return Page.TransactionException;

            PageReference pg = new PageReference('/Company');

            pg.getParameters().put('t', submissionMgr.submission.Form_Name__c);
            pg.setRedirect(true);
            if(submissionMgr.submission.Contacts__r != null && !submissionMgr.submission.Contacts__r.isEmpty())
                delete submissionMgr.submission.Contacts__r;
            delete submissionMgr.submission;
            return pg;
        }
        return null;
    }

    public void getListOfficer(){
        List<CompaniesHouse.OfficerDetails> directorDetailsList = new List<CompaniesHouse.OfficerDetails>();
        if (Test.isRunningTest()) {
            Boolean addOff = true;
            system.debug('test is running now');

            CompaniesHouse.OfficerDetails addedOfficer = new CompaniesHouse.OfficerDetails();
            CompaniesHouse.OfficerDetails addedOfficer1 = new CompaniesHouse.OfficerDetails();
            CompaniesHouse.OfficerDetails addedOfficer2 = new CompaniesHouse.OfficerDetails();
            CompaniesHouse.RegisteredOfficeAddress testaddress = new CompaniesHouse.RegisteredOfficeAddress();
            CompaniesHouse.Links testLinks = new CompaniesHouse.Links();
            CompaniesHouse.DateOfBirth testdateofbirth = new Companieshouse.DateOfBirth();
            CompaniesHouse.Officers testOfficers = new companieshouse.Officers();
            CompaniesHouse.Officers testOfficers2 = new companieshouse.Officers();
            CompaniesHouse.Officers testOfficers3 = new companieshouse.Officers();

            testdateofbirth.Day = 1;
            testdateofbirth.Month = 1;
            testdateofbirth.Year = 1990;

            testOfficers.officer_role = 'director';
            testOfficers.name  = 'testname';
            testOfficers.appointed_on = 'testappointedon';
            testOfficers.appointments = 'testappointments';
            testOfficers.date_of_birth = testdateofbirth;

            testOfficers2.officer_role = 'llp-designated-member';
            testOfficers2.name  = 'testname';
            testOfficers2.appointed_on = 'testappointedon';
            testOfficers2.appointments = 'testappointments';
            testOfficers2.date_of_birth = testdateofbirth;

            testOfficers3.officer_role = 'general-partner-in-a-limited-partnership';
            testOfficers3.name  = 'testname';
            testOfficers3.appointed_on = 'testappointedon';
            testOfficers3.appointments = 'testappointments';
            testOfficers3.date_of_birth = testdateofbirth;

            testlinks.officer = testOfficers;
            testlinks.self = 'testlinkSelf';
            testlinks.document_metadata = 'testmetadata';
            testlinks.charge = 'testCharge';
            testlinks.chcase = 'testCHCase';
            testlinks.filing = 'testFiling';
            testlinks.insolvency_case = 'testinsolvency Case';

            testaddress.region = 'test Region';
            testaddress.postal_code = '12345677';
            testaddress.locality = 'test locality';
            testaddress.address_line_1 = 'testaddress line1';
            testaddress.address_line_2 = 'testaddress line2';
            testaddress.country = 'testaddressCountry';
            testaddress.etag = 'testaddressEtag';
            testaddress.care_of = 'testaddressCareof';
            testaddress.po_box = 'testaddress POBox 123123';
            testaddress.premises = 'testaddress Premises';

            addedOfficer.resigned_on = System.today();
            addedOfficer.links = testLinks;
            addedOfficer.appointed_on = 'testappointedOn';
            addedOfficer.address = testaddress;
            addedOfficer.name = 'testfirstname testlastname';
            addedOfficer.country_of_residence = 'testcountry';
            addedOfficer.date_of_birth = testdateofbirth;
            addedOfficer.nationality = 'testnationality';
            addedOfficer.occupation = 'testoccupation';
            addedOfficer.officer_role = 'director';


            addedOfficer1.resigned_on = System.today();
            addedOfficer1.links = testLinks;
            addedOfficer1.appointed_on = 'testappointedOn';
            addedOfficer1.address = testaddress;
            addedOfficer1.name = 'testfirstname testlastname';
            addedOfficer1.country_of_residence = 'testcountry';
            addedOfficer1.date_of_birth = testdateofbirth;
            addedOfficer1.nationality = 'testnationality';
            addedOfficer1.occupation = 'testoccupation';
            addedOfficer1.officer_role = 'llp-designated-member';


            addedOfficer2.resigned_on = System.today();
            addedOfficer2.links = testLinks;
            addedOfficer2.appointed_on = 'testappointedOn';
            addedOfficer2.address = testaddress;
            addedOfficer2.name = 'testfirstname testlastname';
            addedOfficer2.country_of_residence = 'testcountry';
            addedOfficer2.date_of_birth = testdateofbirth;
            addedOfficer2.nationality = 'testnationality';
            addedOfficer2.occupation = 'testoccupation';
            addedOfficer2.officer_role = 'general-partner-in-a-limited-partnership';

            directorDetailsList.add(addedOfficer);
            directorDetailsList.add(addedOfficer1);
            directorDetailsList.add(addedOfficer2);
        }else{
            directorDetailsList = OfficersQueryAction.getOfficers(companyNumber);
        }

        List<Officer__c> officerList = new List<Officer__c>();
        List<Contact> contactList = new List<Contact>();
        Integer countOfficer = 0;
        if(directorDetailsList != null)
            for (CompaniesHouse.OfficerDetails officer : directorDetailsList) 
            {
                Boolean isCorporate = false;

                countOfficer++;
                if(officerList.size() >= 51)
                    continue;

                Boolean addOff = false;
                if ( (officer.officer_role == 'director' || officer.officer_role == 'corporate-director' || officer.officer_role == 'corporate-nominee-director' || officer.officer_role == 'judicial-factor' ) && (officer.resigned_on == null || officer.resigned_on > date.today())) {
                    addOff = true;
                    isLLPCompany = false;
                    isLPCompany = false;
                    isPLCLTDCompany = true;
                    officerTerm = 'director';
                    isCorporate = officer.officer_role == 'corporate-director' || officer.officer_role == 'corporate-nominee-director' ? true : false; 

                } else if ( (officer.officer_role == 'llp-designated-member' || officer.officer_role == 'corporate-llp-designated-member' || officer.officer_role == 'corporate-llp-member' || officer.officer_role == 'llp-member') && (officer.resigned_on == null || officer.resigned_on > date.today())) {
                    addOff = true;
                    isLLPCompany = true;
                    isPLCLTDCompany = false;
                    isLPCompany = false;
                    officerTerm = 'member';
                    isCorporate = officer.officer_role == 'corporate-llp-designated-member' || officer.officer_role == 'corporate-llp-member' ? true : false; 

                } else if ( (officer.officer_role == 'general-partner-in-a-limited-partnership' ||  officer.officer_role == 'limited-partner-in-a-limited-partnership') && (officer.resigned_on == null || officer.resigned_on > date.today())) {
                    addOff = true;
                    isLLPCompany = false;
                    isPLCLTDCompany = false;
                    isLPCompany = true;
                    officerTerm = 'partner';
                }


                if (addOff) {
                    if (Test.isRunningTest()) {
                        contactList.add(new Contact(Transaction__c = submissionMgr.submission.Id, AccountId = submissionMgr.submission.Company__c, LastName = 'testLastname'));

                    } else {
                        contactList.add(new Contact(isCorporateDirectorTEXT__c = (isCorporate? 'true' : 'false') ,Transaction__c = submissionMgr.submission.Id, AccountId = submissionMgr.submission.Company__c, LastName = officer.name));
                    }
                    String offFirstName = (extractOfficerName(1, officer.name) != null ? (extractOfficerName(1, officer.name).substringAfter(' ').substringBefore(' ')) : '');
                    String offLastName = (extractOfficerName(0, officer.name) == null ? officer.name : extractOfficerName(0, officer.name));
                    String offTitle = (extractOfficerName(2, officer.name) == null ? '' : extractOfficerName(2, officer.name));
                    String offMiddleName = (extractOfficerName(1, officer.name) != null ? (extractOfficerName(1, officer.name).substringAfter(' ').substringAfter(' ')) : '');
                    String offName = offTitle + (offTitle == '' ? '' : ' ') + offFirstName + (offFirstName == '' ? '' : ' ' ) + offLastName;
                    listOfDirectorsAPI.add(offName);
                    officerList.add(new Officer__c(isCorporateDirector__c = isCorporate ,Name = offName, Title__c = offTitle,
                                                    Forename__c  = offFirstName,
                                                    Middlenames__c = offMiddleName,
                                                    Surname__c =  offLastName, Transaction__c = submissionMgr.submission.Id ));
                }


            }
        system.debug('ELIST' + officerList.size());
        nbOfOfficers = officerList.size();

        if(nbOfOfficers > 1)
        {
            singleOfficer = false;
            officerTerm += 's';
        }
        //Insert the contact
        insert contactList;

        //Update the Officer List with contact ID list
        for (Integer i = 0; i < contactList.size(); i++) {
            officerList[i].Contact__c = contactList[i].Id;
        }
        //Insert the officer
        insert officerList;
        if (contactList.size() == 0) {
            noOfficers = true;
            return;
        } 
        else if (contactList.size() > 0) {
            noOfficers = false;
        }

        submissionMgr.submission.officerTerminology__c = officerTerm;
        submissionMgr.submission.isLLP__c = isLLPCompany;
        submissionMgr.submission.isLP__c = isLPCompany;
        submissionMgr.submission.isLtdPlc__c = isPLCLTDCompany;
        submissionMgr.submission.OfficerCount__c = nbOfOfficers;

        if(nbOfOfficers == 1)
        {
            singleOfficer = true;

        }
        else{
            singleOfficer = false;

        }
        update submissionMgr.submission;
    }

    public String extractOfficerName(Integer module, String name) {
        if (name.contains(',')) {
            String[] extract = name.split(',');
            if (extract.size() - 1 >= module)
                if (!String.isBlank(extract[module])) {
                    return extract[module];
                }
        }

        return null;
    }

    public PageReference populateDirectorList() {
        if(!hasAlreadyLoadedOfficers) getListOfficer();

        loadStepSubmissionState();

        if(submissionMgr.submission.Officers__r.size() == 1)
        {
            pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
            pageBody = pageBody.replace('NAME', submissionMgr.submission.Officers__r[0].Name);
        }
        else{
            pageBody = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
            pageBody = pageBody.replace('COMPANYNAME', (String.isBlank(companyName)? '' : companyName));
        }
        
        PageReference res = initialiseAction();
        
        if(res != null)
            return res;
        //Get the list officer already created
        if (submissionMgr.submission.Officers__r != null) {
            if (submissionMgr.submission.Officers__r.size() > 0) {
                for (Officer__c off : submissionMgr.submission.Officers__r) {
                    if(!off.Name.containsIgnoreCase('ltd') && !off.Name.containsIgnoreCase('plc') && !off.Name.containsIgnoreCase('llp') && !off.Name.containsIgnoreCase('limited'))
                    {
                        listOfDirectors.add(new officerContainer(off));
                    }
                }
            }
        }

        if (listOfDirectors.isEmpty()){
            //Simulate a no with empty details
            directorPresenter = false;
            return nextAction();
        }
        return null;
    }
    public PageReference updatePresenter() {
        if (directorPresenter) {
            showMorePresenterInfo = false;
            hasPageErrors = false;
            errorVal = '';
            errorValBottom = '';
            errorValBottom2 = '';
        }
        
        if (!directorPresenter) {
            showMorePresenterInfo = true;
        }
        return null;
    }
    public with sharing class officerContainer {
        public Officer__c officer {
            get;
            set;
        }
        public String officerTXT {
            get;
            set;
        }
        public Boolean isPresenter {
            get;
            set;
        }
        public officerContainer(Officer__c off) {
            officer = off;
            officerTXT = off.Name;
            isPresenter = (off.isPresenter__c == null ? false : off.isPresenter__c);
        }
    }

    @RemoteAction
    public static Boolean refreshBoolean(String paramfunction){
        String paramInput = paramfunction;

        String paramValue = SecurityManager.decryptText(EncodingUtil.urlDecode(paramInput, 'UTF-8'));                    

        // Submission state.
        String submissionId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];
        String stepId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];
        
        List<Transaction__c> transac = [Select Id, Historical_Valid_Step_Ids__c From Transaction__c Where Id = :submissionId Limit 1];
        if( transac.size() == 0)
            return false;
        //We need to detect if the page has been loaded more than 1 time
        String historicalValidStepId = transac[0].Historical_Valid_Step_Ids__c;
        String stepIdTXT = stepId;
        Boolean isPageAlreadyValidStep = false;
        if(historicalValidStepId != null)
            if(historicalValidStepId.contains(stepIdTXT))
            {
                //We need to check if the value associated is 0 if not 0 then it is true
                List<String> histStep = historicalValidStepId.split(AppConstants.DELIM_HISTORICAL_STEP);
                for(Integer i = 0; i <= histStep.size()-1; i++)
                {
                    if(histStep[i] == stepIdTXT)
                    {
                        if(Integer.valueOf(histStep[i+1]) == 0)
                        {
                            isPageAlreadyValidStep = false;
                            break;
                        }
                        else
                        {
                            isPageAlreadyValidStep = true;
                            break;
                        }
                    }
                }
            }
            else
                isPageAlreadyValidStep = false;

            return isPageAlreadyValidStep;
    }

    

public PageReference redirectUser() {
        //The framework has been decomissioned to now redirect to the company details page once you click the link start again
        String paramInput = ApexPages.currentPage().getParameters().get('c');
        String paramValue = SecurityManager.decryptText(paramInput);                    

        // Submission state.
        String submissionId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];
        Id stepId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];
        List<Transaction__c> transac = [Select Id,Transaction_Type__c,Presenter__c,ContactEmail__c,Company__r.Id,Form_Name__c,Company__r.Name,Company__r.CompanyNumber__c, Status__c,Historical_Valid_Step_Ids__c,isDigitalSignatureNeeded__c,isSigningFinished__c From Transaction__c Where Id = :submissionId Limit 1];
        if(transac.size() == 0)
            return null;

        if ((transac[0].isDigitalSignatureNeeded__c && !transac[0].isSigningFinished__c) || (!transac[0].Form_Name__c.contains('DS01'))) {
            if (transac[0].Id != null) {
                //update the transaction first
                transac[0].Status__c = 'deleteContact';
                //Save the transaction type
                String transactionType = transac[0].Transaction_Type__c;
                Id presenterID = transac[0].Presenter__c;
                String presenterEmail = transac[0].ContactEmail__c;
                Account companyId = transac[0].Company__r;
                update transac[0];
                delete transac[0];
                TransactionManager transactionMgr2 = new TransactionManager(transactionType);
                Id submissionId2 = submissionMgr.initialise(transactionType, presenterID, presenterEmail, companyId, transactionMgr2.td);
                PageReference pg = transactionMgr2 == null ? null : transactionMgr2.firstStep(submissionId2);

                pg.setRedirect(true);
                return pg;
            }
        }
        return null;
    }
}