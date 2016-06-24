/*
Name:  SigningController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: SigningController

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-06  Initial development.
*/

public with sharing class SigningController extends TransactionStepControllerBase
{
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

    public String signingOptions
    {
        get;
        set;
    }

    public Boolean signingchoice
    {
        get;
        set;
    }
    public Boolean hasPageErrors
    {
        get;
        set;
    }

    public String currentErrorMessage
    {
        get;
        set;
    }

    public SigningController()
    {
        super();
        if (isPageInitialised) initialiseStep();

    }



    public void initialiseStep()
    {
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
    }

    public List < SelectOption > getItems()
    {
        List < SelectOption > options = new List < SelectOption > ();
        options.add(new SelectOption('True', 'Yes'));
        options.add(new SelectOption('False', 'No'));
        return options;
    }



    public PageReference setSigningvalue()
    {

        return nextAction();
    }

    private void persistStep()
    {
        if (signingchoice)
        {
            submissionMgr.submission.Status__c = 'Signed';
        }
        // persist stuff here
        submissionMgr.persist();
    }


    public PageReference nextAction()
    {
        if (!validatePageState()) return Page.TransactionException;


        if (!signingchoice)
        {
            currentErrorMessage = '<span class="error-message">You must select Yes to Proceed</span>';
            hasPageErrors = true;
            return null;
        }
        else if (signingchoice)
        {
            currentErrorMessage = '';
            hasPageErrors = false;
        }
        else if (signingchoice == null)
        {
            currentErrorMessage = '<span class="error-message">You must select Yes to Proceed</span>';
            hasPageErrors = true;
            return null;

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
