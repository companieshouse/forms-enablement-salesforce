/*
Name:  DirectorDetails.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Director Details Page
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-06-16  Initial development.
*/
public class DirectorDetails extends TransactionStepControllerBase {
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String companyName {
        get;
        set;
    }
    public List < Officer__c > companyDirectors {
        get;
        set;
    }
    public List < Officer__c > builtDirectors {
        get;
        set;
    }
    public List < DirectorWrapper > directorWrapper {
        get;
        set;
    }
    public String emailErrors {
        get;
        set;
    }
    public Boolean showErrors {
        get;
        set;
    }
    public String errorVal {
        get;
        set;
    }

    public String pageTitle {get; set;}
    public String pageBody {get; set;}
    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}
    public Boolean signingFinished {get; set;}
    public DirectorDetails() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void initialiseStep() {
        stepValidator = isPageAlreadyValidStep;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        builtDirectors = new List < Officer__c > ();
        pageTitle = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;

        pageTitle = pageTitle.replace('director', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        buildDirectorsList();
        return;
    }
    public PageReference checkDirectorStatus() {
        if (submissionMgr.submission.Officers__r.size() >= 1) {
            Integer baseline = 0;
            Integer myinteger = 0;
            for (Officer__c officerstoCount : submissionMgr.submission.Officers__r) {
                if (officerstoCount.isSignatory__c == true) {
                    baseline++;
                    if (officerstoCount.Email__c != null) {
                        myinteger++;
                    }
                }
            }
            if (baseline == myinteger) {
                return nextAction();
            }
        }
        return null;
    }
    public void buildDirectorsList() {
        for (Officer__c chosenOfficer : companyDirectors) {
            if (chosenOfficer.isSignatory__c && !chosenOfficer.hasInputBehalfDetails__c && !chosenOfficer.IsPresenter__c) {
                builtDirectors.add(chosenOfficer);
            }
        }
    }
    private void persistStep() {
        submissionMgr.persist();
    }
    public PageReference nextAction() {
        // skip if officer is presenter
        if (!validatePageState()) return Page.TransactionException;
        if (submissionMgr.submission.Officers__r.size() == 1) {
            if (submissionMgr.submission.Officers__r[0].IsPresenter__c) return nextStep();
        }

        for (Officer__c off : submissionMgr.submission.Officers__r) {
            for (directorWrapper directorstoUPDATE : getWrappedDirectors()) {
                if (off.Id == directorstoUPDATE.off.Id) {
                    if (!emailValidation(directorstoUPDATE.email, directorstoUPDATE.off.Name)) {
                        directorstoUPDATE.validationErrors = emailErrors;
                        errorVal = 'error';
                        return null;
                    }
                    if (!emailValidation(directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name)) {
                        directorstoUPDATE.confirmationErrors = emailErrors;
                        directorstoUPDATE.validationErrors = ' ';
                        errorVal = 'error';
                        return null;
                    }
                    if (!emailComparison(directorstoUPDATE.email, directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name)) {
                        directorstoUPDATE.validationErrors = emailErrors;
                        directorstoUPDATE.confirmationErrors = emailErrors;
                        errorVal = 'error';
                        return null;
                    }
                    directorstoUPDATE.validationErrors = '';
                    directorstoUPDATE.confirmationErrors = '';
                    off.Email__c = directorstoUPDATE.email;
                }
            }
        }
        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
    public with sharing class directorWrapper {
        public Officer__c off {
            get;
            set;
        }
        public String email {
            get;
            set;
        }
        public String confirmationemail {
            get;
            set;
        }
        public String validationErrors {
            get;
            set;
        }

        public String confirmationErrors {
            get;
            set;
        }
        public directorWrapper(Officer__c wrappedofficer) {

            validationErrors = '';
            off = wrappedofficer;
            if (Test.isRunningTest()) {
                confirmationemail = wrappedofficer.Email__c;
                email = wrappedofficer.Email__c;
            } else {
                email = '';

                confirmationemail = '';
            }
        }
    }
    public Boolean emailValidation(String emailAddress, String username) {
        // remove whitespaces
        String email = emailAddress;
        String[] whitespaceFinder = email.split(' ');
        for (String afterstringString : whitespaceFinder) {
            email = email + afterstringString;
        }
        if (String.isBlank(email)) {
            //throw new Form_CustomException(' email is blank  for ' + ' ' + username);
            emailErrors = 'Email Address for' + ' ' + username + ' ' + 'must not be blank';
            hasPageErrors = true;
            showErrors = true;
            return false;
        }
        // check for @
        if (email.contains('@')) {
            // check for "."
            if (!email.contains('.')) {
                //throw new Form_CustomException(' email error for' + ' ' + username + ' '+  'not containing dot ' + email);
                emailErrors = 'Email Address for' + ' ' + username + ' ' + 'must be valid and contain a proper address (e.g. .com .net .edu .co.uk )';
                hasPageErrors = true;
                showErrors = true;
                return false;
            }
        } else {
            // throw new Form_CustomException(' email not valid needs @ ' + email);
            emailErrors = 'Email Address for' + ' ' + username + ' ' + ' must be valid and contain an @';
            hasPageErrors = true;
            showErrors = true;
            return false;
        }
        return true;
    }
    public Boolean emailComparison(String email1, String email2, String username) {
        // check to make sure the emails are the same  after validation has occurred then call next();
        if (email1 != email2) {
            //throw new Form_CustomException(' emails do not match' + email1 + email2 + ' for Member/Director' + username);
            emailErrors = 'Email Addresses' + ' ' + email1 + ' ' + 'does not match' + ' ' + email2 + ' ' + 'for' + ' ' + username;
            hasPageErrors = true;
            showErrors = true;
            return false;
        }
        return true;
    }
    public List < directorWrapper > getWrappedDirectors() {
        if (directorWrapper == null) {
            directorWrapper = new List < directorWrapper > ();
            for (Officer__c loopedOfficers : builtDirectors) {
                directorWrapper happyDirectors = new directorWrapper(loopedOfficers);
                directorWrapper.add(happyDirectors);
            }
        }
        return directorWrapper;
    }
    public Void saveWrappedDirectorsSelection() {
        for (Officer__c off : submissionMgr.submission.Officers__r) {
            for (directorWrapper directorstoUPDATE : getWrappedDirectors()) {
                if (off.Id == directorstoUPDATE.off.Id) {
                    emailValidation(directorstoUPDATE.email, directorstoUPDATE.off.Name);
                    emailValidation(directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name);
                    emailComparison(directorstoUPDATE.email, directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name);
                    off.Email__c = directorstoUPDATE.email;
                }
            }
        }
    }
    public PageReference redirectUser() {
        //The framework has been decomissioned to now redirect to the company details page once you click the link start again
        if (isPageAlreadyValidStep)
            if (submissionMgr.submission.isDigitalSignatureNeeded__c && !submissionMgr.submission.isSigningFinished__c) {
                if (submissionMgr.submission.Id != null) {
                    //update the transaction first
                    submissionMgr.submission.Status__c = 'deleteContact';
                    //Save the transaction type
                    String transactionType = submissionMgr.submission.Transaction_Type__c;
                    Id presenterID = submissionMgr.submission.Presenter__c;
                    String presenterEmail = submissionMgr.submission.ContactEmail__c;
                    Account companyId = submissionMgr.submission.Company__r;
                    update submissionMgr.submission;
                    delete submissionMgr.submission;
                    if (Test.isRunningTest()) {
                        System.debug('test is running');
                        return null;
                    }
                    Id submissionId = submissionMgr.initialise(transactionType, presenterID, presenterEmail, companyId, transactionMgr.td);
                    PageReference pg = transactionMgr == null ? null : transactionMgr.firstStep(submissionId);

                    pg.setRedirect(true);
                    return pg;
                }
            }
        return null;
    }
}