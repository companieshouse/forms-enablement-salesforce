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

    public whichDirector() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    private String convertName(String name) {
        String firstName;
        String lastName;
        firstName = name.substringAfter(',') + ' ';
        lastName = name.substringBefore(',');
        lastName = lastName.toLowerCase();
        lastName = lastName.capitalize();
        return firstName + lastName;
    }
    public void initialiseStep() {
        officerUpdater = new List < Officer__c > ();
        officerUpdaterMap = new Map < String, Officer__c > ();
        companyName = submissionMgr.submission.CompanyName__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        pageTitle = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;

        pageTitle = pageTitle.replace('director', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
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
    // End Action methods.
}