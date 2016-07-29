/*
Name:  DirectorsListController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: DirectorsList

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class DirectorsListController extends TransactionStepControllerBase {

    public Boolean hasPageErrors { get; set; }
    public Boolean showNoError {get; set;}
    public Boolean hasAlreadyLoadedOfficers {get; set;}
    public String currentErrorMessage {get; set;}
    public String errorVal {get; set;}
    public String companyName {get; set;}
    public String companyNumber {get; set;}
    public Boolean validationDirector {get; set;}
    public List<String> listOfDirectors {get; set;}
    public Integer nbOfOfficers {get; set;}
	public Boolean isLLPCompany {get; set;}
    public Boolean isPLCLTDCompany {get; set;}
    public Boolean isLPCompany {get; set;}
    public String officerTerm {get; set;}
    public Boolean noOfficers {get; set;}
    public String pageTitle {get; set;}
    public String pageText {get; set;}

    public DirectorsListController() {
        super();
        System.debug(LoggingLevel.ERROR, 'After Super Call:' + isPageInitialised);
        hasAlreadyLoadedOfficers = false;
        if (isPageInitialised) initialiseStep();

    }



    public void initialiseStep() {
        System.debug(LoggingLevel.ERROR, 'Start of Initialise Step');
        //Set up the company name
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        listOfDirectors = new List<String>();
        showNoError = false;
		isLLPCompany = submissionMgr.submission.isLLP__c;
        isPLCLTDCompany = false;
        isLPCompany = false;
        officerTerm = '';
        pageTitle = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        pageText = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;


        if(isPageAlreadyValidStep)
        {
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

        nbOfOfficers = 0;
        System.debug(LoggingLevel.ERROR, 'End of Initialise Step');
        return;

    }

    private void persistStep() {
        System.debug(LoggingLevel.ERROR, 'Start of Persist Step');

        submissionMgr.submission.CompanyName__c = companyName;
        submissionMgr.submission.OfficerCount__c = nbOfOfficers;
        submissionMgr.persist();    
        System.debug(LoggingLevel.ERROR,'End of Persist Step');

    }
    // End Instance methods.

    // Action methods.
    public PageReference nextAction() {

        if (validationDirector == null) {
            hasPageErrors = true;
            currentErrorMessage = 'Please select one of the options below';
            errorVal = 'error';
            return null;
        }
        if (!validatePageState()) return Page.TransactionException;

        if (validationDirector == false) {
            PageReference pg = new PageReference('/UpdateCompanyDirectors');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }

        persistStep();

        System.debug(LoggingLevel.ERROR, 'Before return of NextStep');
        return nextStep();
    }

    private Boolean validateStep() {
        System.debug(LoggingLevel.ERROR, 'Start of Validate Step:' + validationDirector);
        if (validationDirector == null)
            return false;

        return true;
    }

    public void updateDirectorList() {
        System.debug(LoggingLevel.ERROR, 'Clicked yes or no:' + validationDirector);
        if (validationDirector == false)
            showNoError = true;
        else
            showNoError = false;
        hasPageErrors = false;
        System.debug(LoggingLevel.ERROR, 'End of Click yes or no:' + validationDirector);

    }

    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }

    //Method used to extract the title from the name of an officer, return null if no title found
    // 0 = surname 1= forename and middlename 2 = title null incorrect module value or corporate name -_-
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

    public void populateDirectorList() {
        System.debug(LoggingLevel.ERROR, 'Start of Populating Directors');

        initialiseAction();
        if (companyNumber == null) {
            listOfDirectors.add('No Officers found.');
            return;
        }


        if (hasAlreadyLoadedOfficers) {
            System.debug(LoggingLevel.ERROR, 'Already Loaded officer');
            isLLPCompany = submissionMgr.submission.isLLP__c;
            //Get the list officer already created
            if (submissionMgr.submission.Officers__r != null) {
                if (submissionMgr.submission.Officers__r.size() > 0) {
                    for (Officer__c off : submissionMgr.submission.Officers__r) {
                        listOfDirectors.add(off.Name);
                    }
                }
            }
        } else {
            System.debug(LoggingLevel.ERROR, 'Get the director list from API');
            //Make the call to the list of directors
            List<CompaniesHouse.OfficerDetails> directorDetailsList = OfficersQueryAction.getOfficers(companyNumber);

            List<Officer__c> officerList = new List<Officer__c>();
            List<Contact> contactList = new List<Contact>();

            for(CompaniesHouse.OfficerDetails officer : directorDetailsList){
                Boolean addOff = false;
                if( (officer.officer_role == 'director' || officer.officer_role == 'corporate-director' || officer.officer_role == 'corporate-nominee-director' || officer.officer_role == 'judicial-factor' ) && (officer.resigned_on == null || officer.resigned_on > date.today()))
                {   
                    addOff = true;
					isLLPCompany = false; 
                    isLPCompany = false;
                    isPLCLTDCompany = true;
                    officerTerm = 'Director(s)';

                }else if ( (officer.officer_role == 'llp-designated-member' || officer.officer_role == 'corporate-llp-designated-member' || officer.officer_role == 'llp-designated-member') && (officer.resigned_on == null || officer.resigned_on > date.today())) {
                    addOff = true;
                    isLLPCompany = true;
                    isPLCLTDCompany = false;
                    isLPCompany = false;
                    officerTerm = 'Member(s)';
                   
                }else if ( (officer.officer_role == 'general-partner-in-a-limited-partnership' ||  officer.officer_role == 'limited-partner-in-a-limited-partnership') && (officer.resigned_on == null || officer.resigned_on > date.today())) {
                    isLLPCompany = false;
                    isPLCLTDCompany = false;
                    isLPCompany = true;
                    officerTerm = 'Partner(s)';
                }   


                if(addOff)
                {
                    contactList.add(new Contact(Transaction__c =submissionMgr.submission.Id, AccountId = submissionMgr.submission.Company__c, LastName = officer.name));    
                    listOfDirectors.add(officer.name);
                    officerList.add(new Officer__c(Name = officer.name, Title__c = extractOfficerName(2, officer.name),
                    Forename__c  = (extractOfficerName(1, officer.name) != null ? (extractOfficerName(1, officer.name).substringAfter(' ').substringBefore(' ')) : null),
                    Middlenames__c = (extractOfficerName(1, officer.name) != null ? (extractOfficerName(1, officer.name).substringAfter(' ').substringAfter(' ')): null),
                      Surname__c = (extractOfficerName(0, officer.name) == null ? officer.name : extractOfficerName(0, officer.name)), Transaction__c =submissionMgr.submission.Id ));
                }
                

            }

            nbOfOfficers = listOfDirectors.size();
            //Insert the contact
            insert contactList;

            //Update the Officer List with contact ID list
            for (Integer i = 0; i < contactList.size(); i++) {
                officerList[i].Contact__c = contactList[i].Id;
            }
            //Insert the officer
            insert officerList;
            if (contactList.size() == 0) {noOfficers = true;} else if (contactList.size() > 0) {noOfficers = false;}

            submissionMgr.submission.officerTerminology__c = officerTerm;
            submissionMgr.submission.isLLP__c = isLLPCompany;
            submissionMgr.submission.isLP__c = isLPCompany;
            submissionMgr.submission.isLtdPlc__c = isPLCLTDCompany;

            update submissionMgr.submission;

        }
        System.debug(LoggingLevel.ERROR, 'end of List of directors');

    }
}