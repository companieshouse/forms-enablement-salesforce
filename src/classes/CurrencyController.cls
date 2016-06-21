/*
Name:  CurrencyController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: CurrencyController

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-06  Initial development.
*/
public with sharing class CurrencyController extends TransactionStepControllerBase
{
    public String totalnumberofShares
    {
        get;
        set;
    }
    public String totalnumberAggregate
    {
        get;
        set;
    }
    public Decimal numberofshares
    {
        get;
        set;
    }
    public String sharecurrency
    {
        get;
        set;
    }
    public String classofshares
    {
        get;
        set;
    }
    public Decimal totalvalueofshares
    {
        get;
        set;
    }

    public String selectedCurrency
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

    public List < Shares__c > currentShares
    {
        get;
        set;
    }

    public Shares__c shareCapital
    {
        get;
        set;
    }
    public Boolean showautocomplete
    {
        get;
        set;
    }

    public Boolean previousSharesBoolean
    {
        get;
        set;
    }

    public String statusvalue
    {
        get;
        set;
    }

    public String searchCurrencyError
    {
        get;
        set;
    }

    public String valueTestdata
    {
        get;
        set;
    }

    public CurrencyController()
    {
        super();
        if (isPageInitialised) initialiseStep();

    }


    public void initialiseStep()
    {
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        currentShares = new List < Shares__c > ();
        autoCompleteState();
    }

    public void autoCompleteState()
    {

        if (submissionMgr.submission.Shares__r.size() > 0)
        {
            valueTestdata = String.valueOf(submissionMgr.submission.Shares__r.size());
            previousSharesBoolean = true;
            // loop through the current shares and assign them to the buttons
            // build a wrapper class

            for (Shares__c foundShares: submissionMgr.submission.Shares__r)
            {

                currentShares.add(foundShares);
            }
        }
        else if (submissionMgr.submission.Shares__r.size() == 0)
        {
            valueTestdata = String.valueOf(submissionMgr.submission.Shares__r.size());

            previousSharesBoolean = false;
        }
    }

    public void checkCurrencyTable(string currencyToCheckAgainst)
    {
        //throw new Form_CustomException('finally working and currency to check against is   ' + submissionMgr.submission.Shares__r.size());

        if (submissionMgr.submission.Shares__r.size() > 0)
        {
            for (Shares__c previousShares: submissionMgr.submission.Shares__r)
            {
                if (previousShares.Currency__c == currencyToCheckAgainst)
                {
                    searchCurrencyError = 'It looks like you have shares in this currency already';
                    throw new Form_CustomException('found a previous currency selection for  ' + currencyToCheckAgainst);

                }
                else if (previousShares.Currency__c != currencyToCheckAgainst)
                {
                    throw new Form_CustomException('found not previous currency selection for  this should never be hit.  ' + currencyToCheckAgainst);
                }
            }
        }
        else if (submissionMgr.submission.Shares__r.size() == 0)
        {

            throw new Form_CustomException('there is nothing to test against so your statement works but there is no reason to have this else statement');

        }
    }

    public PageReference finishedAddingShares()
    {


        submissionMgr.submission.finishedAddingShares__c = true;
        // may just need next step and no persist and nextAction

        submissionMgr.persist();

        return nextStep();
    }

    public PageReference setSelectedCurrency()
    {

        // throw new Form_CustomException('currency after persist' + submissionMgr.submission.sharecurrencyselection__c);

        checkCurrencyTable(selectedCurrency);

        submissionMgr.submission.sharecurrencyselection__c = selectedCurrency;

        System.debug('Currency Changed to   ' + selectedCurrency);


        persistStep();
        return nextAction();
    }


    private void persistStep()
    {
        //throw new Form_CustomException('this is the selected currency' + selectedCurrency);
        submissionMgr.submission.sharecurrencyselection__c = selectedCurrency;

        // persist stuff here
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
