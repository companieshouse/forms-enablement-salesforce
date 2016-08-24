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
    public void initialiseStep() {
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
        if(submissionMgr.submission.Officers__r.size() == 1)
        {
            pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        }
        else{
            pageBody = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        }
        pageBody = pageBody.replace('COMPANYNAME', companyName);
        pageHiddenText = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;
        pageBody2 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;

        pageTitle = pageTitle.replace('director', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c.replace('s', '')));
        pageBody = pageBody.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        pageHiddenText = pageHiddenText.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));

        return;
    }
    private void persistStep() {
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
        submissionMgr.persist();
    }
    public PageReference nextAction() {
        if (directorPresenter == null) {
            hasPageErrors = true;
            errorVal = 'error';
            currentPageError = 'Please make a selection to continue';
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
                    errorValBottom = 'error';
                    currentPageErrorTop = 'The name is too long (maximum number of characters allowed is 255).';
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
                    errorValBottom2 = 'error';
                    currentPageErrorBot = 'The phone number is too long (maximum number of characters allowed is 255).';
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
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
    public void populateDirectorList() {
        initialiseAction();
        //Get the list officer already created
        if (submissionMgr.submission.Officers__r != null) {
            if (submissionMgr.submission.Officers__r.size() > 0) {
                for (Officer__c off : submissionMgr.submission.Officers__r) {
                    listOfDirectors.add(new officerContainer(off));
                }
            }
        }
    }
    public PageReference updatePresenter() {
        if (directorPresenter) {
            showMorePresenterInfo = false;
            hasPageErrors = false;
            errorVal = '';
            errorValBottom = '';
            errorValBottom2 = '';
        } else if (!directorPresenter) {
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