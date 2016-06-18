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

    // Public properties.
    public Boolean hasPageErrors
    {
        get;
        set;
    }

    // MetaData
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

    // dynamic set data
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

    // company address information
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
            submissionMgr.persist();
        }
        // End Instance methods.    

    // Action methods.     
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
        // End Action methods.    

}