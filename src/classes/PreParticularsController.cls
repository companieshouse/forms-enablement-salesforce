/*
Name:  PreParticularsController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Tabular Input PreParticulars Page
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-06-15  Initial development.
*/
public class PreParticularsController extends TransactionStepControllerBase
{
    public Boolean hasPageErrors
    {
        get;
        set;
    }

    public String displayText1
    {
        get;
        set;
    }
    public String displayText2
    {
        get;
        set;
    }
    public String displayText3
    {
        get;
        set;
    }
    public String headerText1
    {
        get;
        set;
    }

    public String directorName
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
    public String presenterEmail
    {
        get;
        set;
    }
    public String presenterName
    {
        get;
        set;
    }
    public String presenterPhone
    {
        get;
        set;
    }

    public List < Officer__c > companyDirectors
    {
        get;
        set;
    }
    public List < Shares__c > currentshares
    {
        get;
        set;
    }

    public String companyAddress1
    {
        get;
        set;
    }
    public String companyAddress2
    {
        get;
        set;
    }
    public String companyregion
    {
        get;
        set;
    }
    public String companypostcode
    {
        get;
        set;
    }
    public String companyCountry
    {
        get;
        set;
    }
    public String companyLocality
    {
        get;
        set;
    }
    public Boolean showprevious
    {
        get;
        set;
    }
    public List < Shares__c > displayresult
    {
        get;
        set;
    }
    public PreParticularsController()
    {
        super();
        if (isPageInitialised) initialiseStep();

    }

    public void initialiseStep()
    {

        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        currentshares = submissionMgr.submission.Shares__r;
        displayresult = new List < Shares__c > ();

        createPreParticularInputs();

        return;
    }

    public void createPreParticularInputs()
    {

        Map < String, Shares__c > mapShares = new Map < String, Shares__c > ();

        for (Shares__c sortedshares: currentShares)
        {
            mapShares.put(sortedshares.Class_of_Shares__c, sortedshares);
        }
        displayresult.addAll(mapShares.values());
    }

    private void persistStep()
    {
        if (displayresult == null)
            return;

        for (Shares__c sharestoUpdate: submissionMgr.submission.Shares__r)
        {
            for (Shares__c preParticulars: displayresult)
            {
                if (preParticulars.Class_of_Shares__c == sharestoUpdate.Class_of_Shares__c)
                {
                    if (preParticulars.Prescribed_Particulars__c.length() > 0)
                    {
                        sharestoUpdate.Prescribed_Particulars__c = preParticulars.Prescribed_Particulars__c;
                    }
                }
            }
        }

        submissionMgr.persist();
    }

    public PageReference nextAction()
    {
        if (!validatePageState())
        {
            return Page.TransactionException;
        }


        persistStep();

        return nextStep();
    }

    public PageReference previousAction()
    {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }
}