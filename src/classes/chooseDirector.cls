/*
Name:  chooseDirector.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Choose Director  Page
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-06-16  Initial development.
*/
public class chooseDirector extends TransactionStepControllerBase {
    public Boolean hasPageErrors {
        get;
        set;
    }
    
    public String errorVal {get; set;}
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
    public Integer majoritytosign {
        get;
        set;
    }

    public List < DirectorWrapper > directorWrapper {
        get;
        set;
    }

    public String errorMsg1 {get; set;}

    public String pageTitle {get; set;}

    public String pageBody {get; set;}
    public Boolean stepValidator {get; set;}
    public Boolean sigNeeded {get; set;}
    public Boolean signingFinished {get; set;}

    public chooseDirector() {
        super();
        if (isPageInitialised) initialiseStep();

    }

    public void initialiseStep() {
        stepValidator = isPageAlreadyValidStep;
        sigNeeded = submissionMgr.submission.isDigitalSignatureNeeded__c;
        signingFinished = submissionMgr.submission.isSigningFinished__c;
        majoritytosign = Integer.valueOf(submissionMgr.submission.RequiredOfficerSign__c);
        //We need to minus if we have already select one of the director because we don't print it !
        for (Officer__c off : submissionMgr.submission.Officers__r) {
            if (off.IsPresenter__c && off.isSignatory__c) {
                majoritytosign = majoritytosign - 1;
            }
        }
        companyName = submissionMgr.submission.CompanyName__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        builtDirectors = new List < Officer__c > ();
        pageTitle = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        String pageBodyTemp = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        errorMsg1 = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;
        buildDirectorsList();
        pageBodyTemp = pageBodyTemp.replace('X', String.valueOf(majoritytosign));
        errorMsg1 = errorMsg1.replace('X', String.valueOf(majoritytosign));

        if(builtDirectors.size() == 1){
            pageBodyTemp = pageBodyTemp.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c.replace('s', '')));
            errorMsg1 = errorMsg1.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c.replace('s', '')));
        }
        else{
            pageBodyTemp = pageBodyTemp.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
            errorMsg1 = errorMsg1.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        }

        pageTitle = pageTitle.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        pageBody = pageBody.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        pageBody += pageBodyTemp;
        return;
    }

    public PageReference checkDirectorStatus() {
        PageReference res = initialiseAction();

        if(res != null)
            return res;

        Boolean skip = false;
        if(submissionMgr.submission.RequiredOfficerSign__c == 1)
        {
            for(Officer__c off :submissionMgr.submission.Officers__r)
            {
                if(off.isSignatory__c)
                {
                    skip = true;
                }
            }
        }
        
        if(skip)
            return nextAction();
        
        return null;
    }


    public void buildDirectorsList() {
        for (Officer__c chosenOfficer : companyDirectors) {
            if (chosenOfficer.isPresenter__c == False) {
                builtDirectors.add(chosenOfficer);
            } 
        }
    }



    private void persistStep() {

        saveWrappedDirectorsSelection();
        submissionMgr.persist();
    }

    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;

        //if (submissionMgr.submission.isMajorityRequired__c) {
            if (isSignatureNumberOK()) {
                hasPageErrors = false;
                errorVal = '';

            } else if (!isSignatureNumberOK()) {
                hasPageErrors = true;
                errorVal = 'error';
                return null;
            }
       // }
        persistStep();

        return nextStep();
    }

    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }

    public Boolean isSignatureNumberOK() {
        Integer i = 0;

        for (Officer__c off : submissionMgr.submission.Officers__r) {
            if (off.isPresenter__c) {
                if (off.isSignatory__c) {
                    i++;
                }
            }
        }


        for (DirectorWrapper directorstoAddtoSignatoryChecklist : getWrappedDirectors()) {
            if (directorstoAddtoSignatoryChecklist.selected)
                i++;
        }

        if (Integer.valueOf(submissionMgr.submission.RequiredOfficerSign__c) > i) {
            return false;
        }
        return true;
    }

    public with sharing class directorWrapper {
        public Officer__c off {
            get;
            set;
        }
        public boolean selected {
            get;
            set;
        }

        public directorWrapper(Officer__c wrappedofficer) {

            off = wrappedofficer;
            selected = false;

        }
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
                    off.isSignatory__c = directorstoUPDATE.selected;

                }
            }
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