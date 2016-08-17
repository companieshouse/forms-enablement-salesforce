/*
Name:  whichDirector.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Which Director  Page
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-06-16  Initial development.
*/
public class whichDirector extends TransactionStepControllerBase {
    // Public properties.
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
    public Id selectedId {
        get;
        set;
    }
    public List < Officer__c > officerUpdater {
        get;
        set;
    }
    public Map < String, Officer__c > officerUpdaterMap {
        get;
        set;
    }
    public String currentError {
        get;
        set;
    }
    public String currentErrorMessage {
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
    public whichDirector() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    //private String convertName(String name) {
    //    String firstName;
    //    String lastName;
    //    firstName = name.substringAfter(',') + ' ';
    //    lastName = name.substringBefore(',');
    //    lastName = lastName.toLowerCase();
    //    lastName = lastName.capitalize();
    //    return firstName + lastName;
    //}
    public void initialiseStep() {
        stepValidator = isPageAlreadyValidStep;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;
        officerUpdater = new List < Officer__c > ();
        officerUpdaterMap = new Map < String, Officer__c > ();
        companyName = submissionMgr.submission.CompanyName__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        pageTitle = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;

        pageTitle = pageTitle.replace('director', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c.replace('s', '')));
        return;
    }
    public void selectPresenter() {
        officerUpdater.clear();
        for (Officer__c selectingOfficer : companyDirectors) {
            if (selectingOfficer.Id == selectedId) {
                selectingOfficer.IsPresenter__c = true;
                selectingOfficer.isSignatory__c = true;
                selectingOfficer.Email__c = submissionMgr.submission.Presenter__r.PersonEmail;
                officerUpdaterMap.put(selectingOfficer.Name, selectingOfficer);
            } else if (selectingOfficer.Id != selectedId) {
                selectingOfficer.IsPresenter__c = false;
                selectingOfficer.isSignatory__c = false;
                selectingOfficer.Email__c = null;
                officerUpdaterMap.put(selectingOfficer.Name, selectingOfficer);
            }
        }
        officerUpdater.addAll(officerUpdaterMap.values());
        update officerUpdater;
    }
    public PageReference checkDirectorStatus() {
        Boolean isSolePresenterDetected = submissionMgr.submission.SoleDirectorPresenter__c == null ? false : submissionMgr.submission.SoleDirectorPresenter__c;
        Boolean isPresenterDetected = SubmissionMgr.submission.isPresenterMultipleDirectors__c == null ? false : submissionMgr.submission.isPresenterMultipleDirectors__c;
        if (isPresenterDetected || isSolePresenterDetected) {
            return null;
        }
        return nextStep();
    }
    private void persistStep() {
        submissionMgr.persist();
    }
    // End Instance methods.
    // Action methods.
    public PageReference nextAction() {

        if (selectedid == null) {
            hasPageErrors = true;
            currentErrorMessage = 'You must select an officer';
            errorVal = 'error';
            return null;
        }
        if (!validatePageState()) return Page.TransactionException;
        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
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
    // End Action methods.
}