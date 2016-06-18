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
public with sharing class PresenterDirectorController extends TransactionStepControllerBase
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
    public String companyNumber
    {
        get;
        set;
    }
    public List < officerContainer > listOfDirectors
    {
        get;
        set;
    }
    public Boolean directorPresenter
    {
        get;
        set;
    }
    public Id selectedId
    {
        get;
        set;
    }
    public String presenterName
    {
        get;
        set;
    }
    public String phoneNumber
    {
        get;
        set;
    }
    public Boolean isLLPCompany
    {
        get;
        set;
    }

    public PresenterDirectorController()
    {
        super();
        if (isPageInitialised) initialiseStep();

    }

    public void initialiseStep()
    {

        //Set up the company name
        directorPresenter = true;
        phoneNumber = '';
        presenterName = '';
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        listOfDirectors = new List < officerContainer > ();
        isLLPCompany = submissionMgr.submission.isLLP__c;


        return;

    }

    private void persistStep()
        {
            if (directorPresenter)
            {
                for (Officer__c off: submissionMgr.submission.Officers__r)
                {
                    for (officerContainer offCont: listOfDirectors)
                    {
                        if (off.Id == offCont.officer.Id)
                        {
                            if (offCont.isPresenter)
                            {
                                off.isPresenter__c = offCont.isPresenter;
                                off.isSignatory__c = true;
                                off.Email__c = submissionMgr.submission.Presenter__r.Name;

                                //ab populate Presenter Name field with Director Name
                                submissionMgr.submission.PresenterName__c = convertName(off.Name);
                            }
                        }
                    }
                }
                //TODO: Remove presenter details from trsansaction if the officer is selected.
            }
            else
            {
                submissionMgr.submission.PresenterPhoneNumber__c = phoneNumber;
                submissionMgr.submission.PresenterName__c = presenterName;
                //TODO: remove existing flag in case of previous from officer
            }

            submissionMgr.persist();
        }
        // End Instance methods.    

    public Boolean isPresentorCorrect()
    {
        if (!directorPresenter)
        {
            if (String.isEmpty(phoneNumber) || String.isEmpty(presenterName))
                return false;

        }
        return true;
    }

    // Action methods.     
    public PageReference nextAction()
    {
        if (directorPresenter)
        {
            if (submissionMgr.submission.Officers__r.size() == 1)
            {
                submissionMgr.submission.SoleDirectorPresenter__c = true;
                submissionMgr.submission.Officers__r[0].isSignatory__c = true;
                submissionMgr.submission.Officers__r[0].isPresenter__c = true;
            }
        }
        else if (!directorPresenter)
        {
            {
                submissionMgr.submission.SoleDirectorPresenter__c = false;
            }

        }

        if (!isPresentorCorrect())
        {
            //TODO: ERROR CONTROL 
            return null;
        }

        if (!validatePageState()) return Page.TransactionException;

        persistStep();

        return nextStep();
    }

    public PageReference previousAction()
    {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }

    public void populateDirectorList()
    {
        initialiseAction();

        //Get the list officer already created
        if (submissionMgr.submission.Officers__r != null)
        {
            if (submissionMgr.submission.Officers__r.size() > 0)
            {
                for (Officer__c off: submissionMgr.submission.Officers__r)
                {
                    listOfDirectors.add(new officerContainer(off));
                    if (off.isPresenter__c)
                    {
                        directorPresenter = true;
                        selectedId = off.Id;
                    }
                }
            }
        }

        if (submissionMgr.submission.PresenterPhoneNumber__c != null || submissionMgr.submission.PresenterName__c != null)
        {
            phoneNumber = submissionMgr.submission.PresenterPhoneNumber__c;
            presenterName = submissionMgr.submission.PresenterName__c;
            directorPresenter = false;
        }


    }



    public PageReference updatePresenter()
    {
        return null;
    }

    public PageReference updateSelectedPresenter()
    {
        if (selectedId != null)
        {
            for (officerContainer off: listOfDirectors)
            {
                if (off.officer.Id != selectedId)
                {
                    off.isPresenter = false;
                }
                else
                {
                    off.isPresenter = true;
                }
            }
        }
        return null;
    }



    public with sharing class officerContainer
    {

        public Officer__c officer
        {
            get;
            set;
        }
        public String officerTXT
        {
            get;
            set;
        }
        public Boolean isPresenter
        {
            get;
            set;
        }

        public officerContainer(Officer__c off)
        {
            officer = off;
            officerTXT = off.Name;
            isPresenter = (off.isPresenter__c == null ? false : off.isPresenter__c);
        }
    }

    // API is returning last name + first Name
    // This function set name in the correct order
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
}