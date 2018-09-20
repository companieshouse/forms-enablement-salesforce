/*
Name:  BehalfDecisionController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: BehalfDecision

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  SylvainP      2016-06-16  Initial development.
*/
public with sharing class BehalfDecisionController extends TransactionStepControllerBase {

    public Boolean hasPageErrors { get; set; }
    public Boolean showNoError {get; set;}

    public Boolean behalfValidation {get; set;}

    public Boolean singleDirectorNotPresentorWaitingSigning {get; set;}
    public Boolean multipleDirectorWaitingSigning {get; set;}
    
    public List<Officer__c> displayedListOfDirector {get; set;}

    public String textBox1 {get; set;}
    public String textBox2 {get; set;}
    public String headerBox1 {get; set;}
    public String currentErrorMessage {get; set;}
    public String errorVal {get; set;}
    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}
    public Boolean signingFinished {get; set;}
    public BehalfDecisionController() {
        super();
        if (isPageInitialised) initialiseStep();

    }

    public void initialiseStep() {
        stepValidator = isPageAlreadyValidStep;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;
        showNoError = false;
        singleDirectorNotPresentorWaitingSigning = false;
        multipleDirectorWaitingSigning = false;
        displayedListOfDirector = new List<Officer__c>();
        String offName = '';
        textBox2 = (transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c);

        //Header
        
        //2 or more director without presenter => multiple screen
        if(!submissionMgr.submission.SoleDirectorPresenter__c && submissionMgr.submission.Contacts__r.size() > 3)
        {
            List<Officer__c> tempListToCheckFinalNumber = new List<Officer__c>();
            for(Officer__c off :submissionMgr.submission.Officers__r)
            {
                if(!off.isCorporateDirector__c && off.isSignatory__c && !off.IsPresenter__c)
                { 
                    tempListToCheckFinalNumber.add(off);
                }
            }

            if(tempListToCheckFinalNumber.size() == 1)
            {
                singleDirectorNotPresentorWaitingSigning = true;
            }
            else{
                multipleDirectorWaitingSigning = true;
            }
        }
        else
        {
            //If there are 2 directors we go on single not presenter
            if(submissionMgr.submission.Contacts__r.size() == 2 && submissionMgr.submission.MultipleDirectors__c)
            {
                singleDirectorNotPresentorWaitingSigning = true;
                if(submissionMgr.submission.Officers__r[0].isPresenter__c)
                {
                    offName = submissionMgr.submission.Officers__r[1].Name;
                }
                else{
                    offName = submissionMgr.submission.Officers__r[0].Name;
                }
            }
            else if(submissionMgr.submission.Contacts__r.size() == 2 && !submissionMgr.submission.MultipleDirectors__c)
            {
                List<Officer__c> tempListToCheckFinalNumber = new List<Officer__c>();
                for(Officer__c off :submissionMgr.submission.Officers__r)
                {
                    if(!off.isCorporateDirector__c && off.isSignatory__c && !off.IsPresenter__c)
                    { 
                        tempListToCheckFinalNumber.add(off);
                    }
                }

                if(tempListToCheckFinalNumber.size() == 1)
                {
                    offName = tempListToCheckFinalNumber[0].Name;
                    singleDirectorNotPresentorWaitingSigning = true;
                }
                else{
                    multipleDirectorWaitingSigning = true;
                }
            }
            else if(submissionMgr.submission.Contacts__r.size() == 3 && submissionMgr.submission.isPresenterMultipleDirectors__c)
            {
                Integer indexCounter = 0;

                for(Officer__c ct :submissionMgr.submission.Officers__r)
                {
                    if(!ct.isCorporateDirector__c && ct.isSignatory__c && !ct.IsPresenter__c)
                    {
                        indexCounter++;
                        offName = ct.Name;
                    }
                }

                if(indexCounter == 1)
                {
                    singleDirectorNotPresentorWaitingSigning = true;
                }
                else{
                    multipleDirectorWaitingSigning = true;
                }

            }
            else if(submissionMgr.submission.Contacts__r.size() == 1)
            {
                singleDirectorNotPresentorWaitingSigning = true;
                offName = submissionMgr.submission.Officers__r[0].Name;
            }
            else{
                multipleDirectorWaitingSigning = true;
            }
        }
        

        if(singleDirectorNotPresentorWaitingSigning)
        {
            headerBox1 = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c );
            headerBox1 = headerBox1.replace('NAME', offName);
            textBox2 = (transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c);
        }
        else if(multipleDirectorWaitingSigning)
        {
            headerBox1 = (transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c );
            textBox1 = (transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c);
            textBox2 = (transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c);
            for(Officer__c off :submissionMgr.submission.Officers__r)
            {
                if(!off.isCorporateDirector__c && off.isSignatory__c && !off.IsPresenter__c)
                { 
                    displayedListOfDirector.add(off);
                }
            }
        }
        textBox2 = textBox2.replace('WARNING', 'Only someone who has power of attorney can approve this application');

        return;
    }

    @TestVisible private void persistStep() {
        if (behalfValidation != null)
            submissionMgr.submission.isBehalfSignatoryEnable__c = behalfValidation;
        submissionMgr.persist();
    }

    public PageReference nextAction() {
        if (behalfValidation == null) {
            hasPageErrors = true;
            currentErrorMessage = 'Select yes or no';
            errorVal = 'govuk-form-group--error';
            return null;
        }

        Integer corpDirectors = 0;

        //Test No more needed as Corporate are part of officer detail page
        // if(behalfValidation == false)
        // {
        //     //Iterate officers
        //     for (Officer__c off : submissionMgr.submission.Officers__r) {
        //         if (off.isSignatory__c && !off.IsPresenter__c && (off.Name.containsIgnoreCase('ltd') || off.Name.containsIgnoreCase('plc') || off.Name.containsIgnoreCase('llp') || off.Name.containsIgnoreCase('limited'))) {
        //             corpDirectors++; 
        //         }
        //     }

        //     if(corpDirectors > 0)
        //     {
        //         hasPageErrors = true;
        //         currentErrorMessage = 'You must select Yes as you have selected Corporate Officers';
        //         errorVal = 'govuk-form-group--error';
        //         return null;
        //     }
        // }

        
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

        if (submissionMgr.submission.SoleDirectorPresenter__c) {
            return nextStep();
        }

        Boolean isOtherDirectorThanCorporate = false;

        for(Officer__c off : submissionMgr.submission.Officers__r)
        {
            if(!off.isCorporateDirector__c && off.isSignatory__c && !off.isPresenter__c)
            {
                isOtherDirectorThanCorporate = true;
            }
        }

        if(!isOtherDirectorThanCorporate)
        {
            return nextStep();
        }

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