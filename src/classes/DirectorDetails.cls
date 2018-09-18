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
public with sharing class DirectorDetails extends TransactionStepControllerBase {
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String companyName {
        get;
        set;
    }
    public String divForErrorLink {get; set;}
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

    public String errorVal2 {
        get;
        set;
    }

    public String pageTitle {get; set;}
    public String pageBody {get; set;}
    public String emailMessage {get; set;}
    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}
    public Boolean signingFinished {get; set;}
    public Boolean isSingleDirectorOnScreen {get; set;}
    public DirectorDetails() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void initialiseStep() {
        stepValidator = isPageAlreadyValidStep;
        isSingleDirectorOnScreen = false;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        builtDirectors = new List < Officer__c > ();
        buildDirectorsList();
        if(builtDirectors.size() == 1)
        {
            pageTitle = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
            pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
            pageTitle = pageTitle.replace('NAME', builtDirectors[0].Name);
            pageBody = pageBody.replace('NAME', builtDirectors[0].Name);
            isSingleDirectorOnScreen = true;
         }
        else{
            pageTitle = (transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c);
            pageBody = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        }
        emailMessage = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;

        if(builtDirectors.size() == 1)
        {
            pageTitle = pageTitle.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c.replace('s','')));
        }
        else{
            pageTitle = pageTitle.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        }

        return;
    }
    public PageReference checkDirectorStatus() {
        PageReference res = initialiseAction();

        if(res != null)
            return res;
            
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
        
        for (Officer__c off : submissionMgr.submission.Officers__r) 
        {
            Integer k = 0;
            for (directorWrapper directorstoUPDATE : getWrappedDirectors()) 
            {
                if (off.Id == directorstoUPDATE.off.Id) 
                {
                    if (!emailValidation(directorstoUPDATE.email, directorstoUPDATE.off.Name)) {
                        directorstoUPDATE.validationErrors = emailErrors;
                        errorVal = 'govuk-form-group--error';
                        errorVal2 = '';
                        divForErrorLink = '#OfficerDetailsPage:TempPage:mainForm:theRepeat:'+ k + ':email';
                        return null;
                    }
                    if(String.isBlank(directorstoUPDATE.nameCorpo) && directorstoUPDATE.isCorporate)
                    {
                        divForErrorLink = '#OfficerDetailsPage:TempPage:mainForm:theRepeat:' + k + ':nameCorpo';
                        emailErrors = 'The name is required for Corporate Officer: ' + directorstoUPDATE.off.Name;
                        directorstoUPDATE.validationErrors2 = emailErrors;
                        hasPageErrors = true;
                        showErrors = true;
                        errorVal = 'govuk-form-group--error';
                        errorVal2 = '';
                        return null;
                    }
                    // if (!emailValidation(directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name)) {
                    //     directorstoUPDATE.confirmationErrors = emailErrors;
                    //     directorstoUPDATE.validationErrors = ' ';
                    //     errorVal2 = 'govuk-form-group--error';
                    //     errorVal = '';
                    //     return null;
                    // }
                    // if (!emailComparison(directorstoUPDATE.email, directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name)) {
                    //     directorstoUPDATE.validationErrors = emailErrors;
                    //     directorstoUPDATE.confirmationErrors = emailErrors;
                    //     errorVal = 'govuk-form-group--error';
                    //     errorVal2 = 'govuk-form-group--error';
                    //     return null;
                    // }
                    errorVal2 = '';
                    errorVal = '';
                    divForErrorLink = '';
                    directorstoUPDATE.validationErrors2 = '';
                    directorstoUPDATE.validationErrors = '';
                    directorstoUPDATE.confirmationErrors = '';
                    off.Email__c = directorstoUPDATE.email;
                    if(directorstoUPDATE.isCorporate)
                        off.AuthorizedSigner__c = directorstoUPDATE.nameCorpo;
                    
                }
              k++;  
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
        public Boolean isCorporate {get; set;}
        public String email {
            get;
            set;
        }
        public String nameCorpo {get; set;}
        public String confirmationemail {
            get;
            set;
        }
        public String validationErrors {
            get;
            set;
        }
        public String validationErrors2 {
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
            isCorporate = wrappedofficer.isCorporateDirector__c;
            nameCorpo = '';
            if (Test.isRunningTest()) {
                confirmationemail = wrappedofficer.Email__c;
                email = wrappedofficer.Email__c;
            } else {
                email = wrappedofficer.Email__c;

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

        try{
            submissionMgr.submission.validateEmailFormat__c = emailAddress;
            update submissionMgr.submission;
        }
        catch(DMLException e)
        {
            emailErrors = 'Email Address for' + ' ' + username + ' ' + 'must be valid.';
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

            System.debug('TESTD' + isPageAlreadyValidStep);
            return isPageAlreadyValidStep;
    }
    
    public PageReference redirectUser() {
        //The framework has been decomissioned to now redirect to the company details page once you click the link start again
        String paramInput = ApexPages.currentPage().getParameters().get('c');
        String paramValue = SecurityManager.decryptText(paramInput);                    

        // Submission state.
        String submissionId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];
        Id stepId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];
        List<Transaction__c> transac = [Select Id,Transaction_Type__c,Presenter__c,ContactEmail__c,Company__r.Id,Company__r.Name,Company__r.CompanyNumber__c, Status__c,Historical_Valid_Step_Ids__c,isDigitalSignatureNeeded__c,isSigningFinished__c From Transaction__c Where Id = :submissionId Limit 1];
        if(transac.size() == 0)
            return null;

        if (transac[0].isDigitalSignatureNeeded__c && !transac[0].isSigningFinished__c) {
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