/*
Name:  BehalfInputDetailsController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: BehalfInputDetails

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  SylvainP      2016-06-17  Initial development.
*/
public with sharing class BehalfInputDetailsController extends TransactionStepControllerBase {

    public String divForErrorLink {get; set;}
    public Boolean hasPageErrors { get; set; }
    public Boolean showNoError {get; set;}
    public String currentErrorMessage {get; set;}
    public String nameErrorVal {get; set;}
    public String emailErrorVal {get; set;}
    public String emailErrorValConfirm {get; set;}
    public String behalfSelectionerrorVal {get; set;}
    public Boolean behalfValidation {get; set;}
    public Boolean emailConfirmError {get; set;}

    public String textBox1 {get; set;}
    public String textBox2 {get; set;}
    public String textBox3 {get; set;}
    public String textBox4 {get; set;}

    public String headerBox1 {get; set;}

    public Officer__c currentOfficer {get; set;}

    public String nameAuthorized {get; set;}
    public String emailDirector {get; set;}
    public String emailConfirmDirector {get; set;}
    public Integer behalfSelection {get; set;}
    public Boolean  nameError {get; set;}
    public Boolean emailError {get; set;}
    public Boolean  behalfError {get; set;}
    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}
    public Boolean signingFinished {get; set;}
    public BehalfInputDetailsController() {
        super();
        if (isPageInitialised) initialiseStep();
    }

    public void initialiseStep() {
        stepValidator = isPageAlreadyValidStep;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;
        showNoError = false;
        textBox1 = (transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c);
        textBox2 = (transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c);
        textBox3 = (transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c);
        textBox4 = (transactionMgr.currentStep.Display_Text_4__c == null ? '' : transactionMgr.currentStep.Display_Text_4__c);
        headerBox1 = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c );

        return;
    }
    @testvisible
    private void persistStep() {
        if (currentOfficer == null)
            return;

        for (Officer__c off : submissionMgr.submission.Officers__r) {
            if (off.Id == currentOfficer.Id) {
                off.hasInputBehalfDetails__c = true;
                off.AuthorizedSigner__c = nameAuthorized;
                off.Email__c = emailDirector;

                if (behalfSelection == 1) {
                    off.isPowerOfAttorney__c = true;
                } else if (behalfSelection == 2) {
                    off.isCorporateDirector__c = true;
                }
            }
        }

        submissionMgr.persist();
    }
    // End Instance methods.

    // Action methods.
    public PageReference nextAction() {
        if (nameAuthorized.length() == 0) {
            hasPageErrors = true;
            currentErrorMessage = 'Please provide the name of person approving';
            nameErrorVal = 'govuk-form-group--error';
            divForErrorLink = '#BehalfInputPage:TempPage:mainForm:inputName';
            nameError = true;
            emailError = false;
            behalfError = false;
            behalfSelectionerrorVal = '';
            emailErrorVal = '';
            return null;
        }
        if (String.isBlank(emailDirector)) {
            hasPageErrors = true;
            currentErrorMessage = 'Please provide the email of the person approving';
            emailErrorVal = 'govuk-form-group--error';
            divForErrorLink = '#BehalfInputPage:TempPage:mainForm:inputEmail';
            emailError = true;
            nameError = false;
            behalfError = false;
            nameErrorVal = '';
            behalfSelectionerrorVal = '';
            return null;
        }
       
        try{
            submissionMgr.submission.validateEmailFormat__c = emailDirector;
            update submissionMgr.submission;
        }
        catch(DMLException e)
        {
            hasPageErrors = true;
            currentErrorMessage = 'Email Address for' + ' ' + nameAuthorized + ' ' + ' is not valid';
            emailErrorVal = 'govuk-form-group--error';
            divForErrorLink = '#BehalfInputPage:TempPage:mainForm:inputEmail';
            emailError = true;
            emailConfirmError = false;
            nameError = false;
            behalfError = false;
            nameErrorVal = '';
            behalfSelectionerrorVal = '';
            return null;

        }

        // if (emailConfirmDirector == null) {
        //     hasPageErrors = true;
        //     currentErrorMessage = 'Please provide the email of the person approving';
        //     emailErrorValConfirm = 'govuk-form-group--error';
        //     emailError = false;
        //     emailConfirmError = true;
        //     nameError = false;
        //     behalfError = false;
        //     nameErrorVal = '';
        //     behalfSelectionerrorVal = '';
        //     return null;
        // }
        
        // try{
        //     submissionMgr.submission.validateEmailFormat__c = emailConfirmDirector;
        //     update submissionMgr.submission;
        // }
        // catch(DMLException e)
        // {
        //     hasPageErrors = true;
        //     currentErrorMessage = 'Email Address for' + ' ' + nameAuthorized + ' ' + ' is not valid';
        //     emailErrorValConfirm = 'govuk-form-group--error';
        //     emailError = false;
        //     emailConfirmError = true;
        //     nameError = false;
        //     behalfError = false;
        //     nameErrorVal = '';
        //     behalfSelectionerrorVal = '';
        //     return null;

        // }

        // if(emailDirector != emailConfirmDirector)
        // {
        //     hasPageErrors = true;
        //     currentErrorMessage = 'Email Addresses' + ' ' + emailDirector + ' ' + 'does not match' + ' ' + emailConfirmDirector + ' ' + 'for' + ' ' + currentOfficer.Name;
        //     emailErrorVal = 'govuk-form-group--error';
        //     emailErrorValConfirm = 'govuk-form-group--error';
        //     emailError = true;
        //     emailConfirmError = true;
        //     nameError = false;
        //     behalfError = false;
        //     nameErrorVal = '';
        //     behalfSelectionerrorVal = '';
        //     return null;
        // }
        if (behalfSelection == null) {
            hasPageErrors = true;
            currentErrorMessage = 'Please select how are they acting on behalf of' + ' ' + currentOfficer.Name;
            behalfSelectionerrorVal = 'govuk-form-group--error';
            divForErrorLink = '#radio-1';
            behalfError = true;
            emailConfirmError = false;
            emailError = false;
            nameError = false;
            nameErrorVal = '';
            emailErrorVal = '';
            return null;
        }
        if (Test.isRunningTest()) {
            System.debug('test running');
        } else {
            if (!validatePageState()) return Page.TransactionException;
        }
        persistStep();

        Boolean hasFinishedOfficerList = true;

        for (Officer__c off : submissionMgr.submission.Officers__r) {
            if (!off.hasInputBehalfDetails__c && !off.IsPresenter__c && off.isSignatoryBehalf__c) {
                hasFinishedOfficerList = false;
            }
        }
        if (Test.isRunningTest()) {hasFinishedOfficerList = false;}
        //Refresh the screen to pick the next officer...
        if (!hasFinishedOfficerList) {
            PageReference pg = new PageReference('/BehalfInputDetails');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);

            return pg;
        }

        if (Test.isRunningTest()) {
            System.debug('running test');
            return null;

        } else {
            return nextStep();
        }
    }

    public void updateSelectedBehalf() {
    }

    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }

    public PageReference initPage() {
        PageReference res = initialiseAction();

        if(res != null)
            return res;

        if (submissionMgr.submission.SoleDirectorPresenter__c) {
            return nextStep();
        }


        //Initialise the current directors
        for (Officer__c off : submissionMgr.submission.Officers__r) {
            if (!off.hasInputBehalfDetails__c && !off.IsPresenter__c && off.isSignatoryBehalf__c) {
                currentOfficer = off;
            }
        }

        if (currentOfficer == null)
            return nextStep();

        headerBox1 = headerBox1.replace('DIRECTORNAME', currentOfficer.Name);

        textBox3 = textBox3.replace('DIRECTORNAME', currentOfficer.Name);

        return null;
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