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
    public String currentErrorMessage {
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


    public chooseDirector() {
        super();
        if (isPageInitialised) initialiseStep();

    }

    public void initialiseStep() {
        majoritytosign = Integer.valueOf(submissionMgr.submission.RequiredOfficerSign__c);
        companyName = submissionMgr.submission.CompanyName__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        builtDirectors = new List < Officer__c > ();
        pageTitle = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        pageBody += transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        errorMsg1 = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;

        pageBody = pageBody.replace('X', String.valueOf(majoritytosign));
        errorMsg1 = errorMsg1.replace('X', String.valueOf(majoritytosign));
        buildDirectorsList();
        return;
    }

    public PageReference checkDirectorStatus() {

        if (submissionMgr.submission.Officers__r.size() == 1) {
            if (submissionMgr.submission.Officers__r[0].isSignatory__c)
                return nextAction();
        }
        return null;
    }


    public void buildDirectorsList() {
        for (Officer__c chosenOfficer : companyDirectors) {
            if (chosenOfficer.isPresenter__c == False) {
                builtDirectors.add(chosenOfficer);
            } else if (chosenOfficer.IsPresenter__c == true) {
                if (chosenOfficer.isSignatory__c == true) {
                    majoritytosign = majoritytosign - 1;
                }
            }
        }
    }



    private void persistStep() {

        saveWrappedDirectorsSelection();
        submissionMgr.persist();
    }

    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;

        if (submissionMgr.submission.isMajorityRequired__c) {
            if (isSignatureNumberOK()) {
                hasPageErrors = false;
                currentErrorMessage = '';
                errorVal = '';

            } else if (!isSignatureNumberOK()) {
                currentErrorMessage = '';
                hasPageErrors = true;
                errorVal = 'error';
                return null;
            }
        }
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
}