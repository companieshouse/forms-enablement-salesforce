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
public class whichDirector extends TransactionStepControllerBase
{

    public Boolean hasPageErrors
    {
        get;
        set;
    }

    public String companyName
    {
        get;
        set;
    }

    public List < Officer__c > companyDirectors
    {
        get;
        set;
    }
    public Boolean isLLPCompany
    {
        get;
        set;
    }
    public Id selectedId
    {
        get;
        set;
    }

    public List < Officer__c > officerUpdater
    {
        get;
        set;
    }
    public Map < String, Officer__c > officerUpdaterMap
    {
        get;
        set;
    }
    public whichDirector()
    {
        super();
        if (isPageInitialised) initialiseStep();


    }
    private String convertName(String name)
    {
        String firstName;
        String lastName;

        firstName = name.substringAfter(',') + ' ';

        lastName = name.substringBefore(',');
        lastName = lastName.toLowerCase();
        lastName = lastName.capitalize();

        return firstName + lastName;
    }

    public void initialiseStep()
    {

        officerUpdater = new List < Officer__c > ();
        officerUpdaterMap = new Map < String, Officer__c > ();
        companyName = submissionMgr.submission.CompanyName__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        isLLPCompany = submissionMgr.submission.isLLP__c;
        return;
    }
    public PageReference checkDirectorStatus()
    {

        if (submissionMgr.submission.Officers__r.size() == 1)
        {
            if (submissionMgr.submission.Officers__r[0].isSignatory__c)
                return nextAction();
        }
        return null;
    }

    public void selectPresenter()
    {

        officerUpdater.clear();

        for (Officer__c selectingOfficer: companyDirectors)
        {
            if (selectingOfficer.Id == selectedId)
            {
                selectingOfficer.IsPresenter__c = true;
                selectingOfficer.isSignatory__c = true;
                officerUpdaterMap.put(selectingOfficer.Name, selectingOfficer);
            }
            else if (selectingOfficer.Id != selectedId)
            {
                selectingOfficer.IsPresenter__c = false;
                selectingOfficer.isSignatory__c = false;
                officerUpdaterMap.put(selectingOfficer.Name, selectingOfficer);
            }

        }
        officerUpdater.addAll(officerUpdaterMap.values());

        update officerUpdater;
    }


    private void persistStep()
    {
        submissionMgr.persist();
    }

    public PageReference nextAction()
    {
        if (!validatePageState()) return Page.TransactionException;

        persistStep();

        return nextStep();
    }

    public PageReference previousAction()
    {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }

}
