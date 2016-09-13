/*
Name:  BehalfWhichSignatoryController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: BehalfWhichSignatory

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  SylvainP      2016-06-17  Initial development.
*/
public with sharing class BehalfWhichSignatoryController extends TransactionStepControllerBase {

    public Boolean hasPageErrors { get; set; }
    public Boolean showNoError {get; set;}
    public String currentErrorMessage {get; set;}
    public String errorVal {get; set;}
    public Boolean behalfValidation {get; set;}

    public String textBox1 {get; set;}
    public String headerBox1 {get; set;}

    public String selectedId {get; set;}
    public List<officerContainer> listOfDirectors {get; set;}
    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}
    public Boolean signingFinished {get; set;}
    public String valueRadio {get; set;}

    public BehalfWhichSignatoryController() {
        super();
        if (isPageInitialised) initialiseStep();
    }



    public void initialiseStep() {
        stepValidator = isPageAlreadyValidStep;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;
        showNoError = false;
        valueRadio = '';

        return;
    }

    @testvisible private void persistStep() {
        if (listOfDirectors == null)
            return;

        for (Officer__c off : submissionMgr.submission.Officers__r) {
            for (officerContainer offCont : listOfDirectors) {
                if (off.Id == offCont.officer.Id) {
                    if (offCont.isSignatoryBehalf) {
                        off.isSignatoryBehalf__c = offCont.isSignatoryBehalf;
                    }
                }
            }
        }

        submissionMgr.persist();
    }
    // End Instance methods.

    // Action methods.
    public PageReference nextAction() {
        if (selectedId == 'null' || selectedId == null) {
            hasPageErrors = true;
            currentErrorMessage = 'Please select the officer(s) that someone will be approving on their behalf.';
            errorVal = 'error';
            return null;
        }
        //throw new Form_CustomException('the selectedID is ' + selectedId);
        if (!validatePageState()) return Page.TransactionException;
        persistStep();
        return nextStep();
    }

    public void updateDirectorList() {
    }

    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }

    public PageReference initPage() {
        PageReference res = initialiseAction();

        if(res != null)
            return res;

        if (submissionMgr.submission.SoleDirectorPresenter__c || !submissionMgr.submission.isBehalfSignatoryEnable__c) {
            persistStep();

            return nextStep();
        }

        listOfDirectors = new List<officerContainer>();
        //Initialise the list of directors
        for (Officer__c off : submissionMgr.submission.Officers__r) {
            if (off.isSignatory__c && !off.IsPresenter__c) {
                listOfDirectors.add(new officerContainer(off));
            }
        }
        textBox1 = (transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c);
        if(listOfDirectors.size() == 1)
        {
            headerBox1 = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c );
            headerBox1 = headerBox1.replace('director', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c.replace('s','')));
        }
        else{
            headerBox1 = (transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c );
            headerBox1 = headerBox1.replace('director', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        }
                
        return null;
    }

    public PageReference updateSelectedPresenter() {
        if (selectedId != null) {
            for (officerContainer off : listOfDirectors) {
                if ( String.valueOf(off.officer.Id) == selectedId) {
                    if(valueRadio == 'true')
                        off.isSignatoryBehalf = true;
                    if(valueRadio == 'false')
                        off.isSignatoryBehalf = false;
                }
            }
        }
        return null;
    }

    public with sharing class officerContainer {

        public Officer__c officer {get; set;}
        public String officerTXT {get; set;}
        public Boolean isPresenter {get; set;}
        public String email {get; set;}
        public Boolean isSignatory {get; set;}
        public Boolean isSignatoryBehalf {get; set;}

        public officerContainer(Officer__c off) {
            officer = off;
            officerTXT = off.Name;
            email = off.Email__c;
            isPresenter = (off.isPresenter__c == null ? false : off.isPresenter__c);
            isSignatory = (off.isSignatory__c == null ? false : off.isSignatory__c);
            isSignatoryBehalf = (off.isSignatoryBehalf__c == null ? false : off.isSignatoryBehalf__c);
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