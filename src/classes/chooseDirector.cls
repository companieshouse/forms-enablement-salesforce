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
public class chooseDirector extends TransactionStepControllerBase
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

    public List < Officer__c > builtDirectors
    {
        get;
        set;
    }
    public Boolean isLLPCompany
    {
        get;
        set;
    }
    public Integer majoritytosign
    {
        get;
        set;
    }

    public List < DirectorWrapper > directorWrapper
    {
        get;
        set;
    }
    public String majoritySignError
    {
        get;
        set;
    }


    public chooseDirector()
    {
        super();
        if (isPageInitialised) initialiseStep();

    }


    public void initialiseStep()
    {

        if (submissionMgr.submission.SoleDirectorPresenter__c == true)
        {
            nextAction();
        }
        majoritytosign = Integer.valueOf(submissionMgr.submission.RequiredOfficerSign__c);
        companyName = submissionMgr.submission.CompanyName__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        builtDirectors = new List < Officer__c > ();
        isLLPCompany = submissionMgr.submission.isLLP__c;
        majoritySignError = 'form-label-bold';

        buildDirectorsList();
        return;
    }

    public void buildDirectorsList()
    {
        for (Officer__c chosenOfficer: companyDirectors)
        {
            if (chosenOfficer.isPresenter__c == False)
            {
                builtDirectors.add(chosenOfficer);
            }
            else if (chosenOfficer.IsPresenter__c == true)
            {
                if (chosenOfficer.isSignatory__c == true)
                {
                    majoritytosign = majoritytosign - 1;
                }
            }
        }
    }



    private void persistStep()
    {

        saveWrappedDirectorsSelection();
        submissionMgr.persist();

    }

    public PageReference nextAction()
    {
        if (!validatePageState()) return Page.TransactionException;

        if (submissionMgr.submission.isMajorityRequired__c)
        {
            if (isSignatureNumberOK())
            {
                majoritySignError = 'form-label-bold';
            }
            else if (!isSignatureNumberOK())
            {
                majoritySignError = 'error-message';

                return null;
            }
        }
        persistStep();

        return nextStep();
    }

    public PageReference previousAction()
    {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }

    public Boolean isSignatureNumberOK()
    {
        Integer i = 0;

        for (Officer__c off: submissionMgr.submission.Officers__r)
        {
            if (off.isPresenter__c)
            {
                if (off.isSignatory__c)
                {
                    i++;
                }
            }
        }


        for (DirectorWrapper directorstoAddtoSignatoryChecklist: getWrappedDirectors())
        {
            if (directorstoAddtoSignatoryChecklist.selected)
                i++;
        }

        if (Integer.valueOf(submissionMgr.submission.RequiredOfficerSign__c) > i)
        {
            return false;
        }
        return true;
    }

    public with sharing class directorWrapper
    {
        public Officer__c off
        {
            get;
            set;
        }
        public boolean selected
        {
            get;
            set;
        }

        public directorWrapper(Officer__c wrappedofficer)
        {

            off = wrappedofficer;
            selected = false;

        }
    }

    public List < directorWrapper > getWrappedDirectors()
    {
        if (directorWrapper == null)
        {
            directorWrapper = new List < directorWrapper > ();

            for (Officer__c loopedOfficers: builtDirectors)
            {

                directorWrapper happyDirectors = new directorWrapper(loopedOfficers);
                directorWrapper.add(happyDirectors);
            }
        }

        return directorWrapper;
    }

    public Void saveWrappedDirectorsSelection()
    {
        for (Officer__c off: submissionMgr.submission.Officers__r)
        {
            for (directorWrapper directorstoUPDATE: getWrappedDirectors())
            {
                if (off.Id == directorstoUPDATE.off.Id)
                {
                    off.isSignatory__c = directorstoUPDATE.selected;

                }
            }
        }
    }
}