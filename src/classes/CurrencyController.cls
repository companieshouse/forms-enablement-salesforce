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
    public Boolean showTable
    {
        get
        {
            if (currentShares.size() < 1)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        set;
    }

    public String statusvalue
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

        if (submissionMgr.submission.sharecurrencyselection__c == null)
        {
            showautocomplete = true;
        }
        else
        {
            showautocomplete = false;
            sharecurrency = submissionMgr.submission.sharecurrencyselection__c;
            selectCurrentCurrencyTable(submissionMgr.submission.sharecurrencyselection__c);
        }

    }

    public void selectCurrentCurrencyTable(String currencycomparer)
    {

        if (submissionMgr.submission.Shares__r.size() > 0)
        {
            for (Shares__c previousShares: submissionMgr.submission.Shares__r)
            {
                if (previousShares.Currency__c == currencycomparer)
                {
                    currentShares.add(previousShares);

                }
            }
        }
    }

    public PageReference checkCurrencyTable(string currencyToCheckAgainst)
    {

        if (submissionMgr.submission.Shares__r.size() > 0)
        {  
            showautocomplete = false;
         //throw new Form_CustomException('finally working and currency to check against is   ' + showautocomplete);
            for (Shares__c previousShares: submissionMgr.submission.Shares__r)
            {
                if (previousShares.Currency__c == currencyToCheckAgainst)
                {
                    return null;
                    //showautocomplete = false;
                    //showTable = true;
                    //statusvalue = 'currency is the same';
                    //selectCurrentCurrencyTable(currencyToCheckAgainst);
                    // return true; 

                    // throw new Form_CustomException('it looks like you already have shares in this class' + currencyToCheckAgainst);

                }
                else if (previousShares.Currency__c != currencyToCheckAgainst)
                {
                    showautocomplete = false;
                    statusvalue = 'currency is different';
                                        return null;

                    // throw new Form_CustomException('finally working and currency to check against is   ' + currencyToCheckAgainst);
                }
            }
        }
        else
        {
            throw new Form_CustomException('there is nothing to test against so your statement works');

        }
        return null;
    }

    public PageReference setSelectedCurrency()
    {
        submissionMgr.submission.sharecurrencyselection__c = selectedCurrency;

        // throw new Form_CustomException('currency after persist' + submissionMgr.submission.sharecurrencyselection__c);

        checkCurrencyTable(submissionMgr.submission.sharecurrencyselection__c);

        System.debug('Currency Changed to   ' + selectedCurrency);

        showautocomplete = false;

        persistStep();
        return null;
    }


    private void persistStep()
    {
        //throw new Form_CustomException('this is the selected currency' + selectedCurrency);
        submissionMgr.submission.sharecurrencyselection__c = selectedCurrency;

        // persist stuff here
        submissionMgr.persist();
    }

    public String addShare()
    {
        try
        {
            //String name, String transactionid, Decimal numberofshares, String sharecurrency, String classofshares, Decimal totalvalueofshares
            insert new Shares__c(Name = classofshares, Transaction__c = submissionMgr.submission.Id, Number_of_Shares__c = numberofshares, Currency__c = sharecurrency, Class_of_Shares__c = classofshares, Total_aggregate_amount_unpaid__c = totalvalueofshares, ActiveData__c = true);
            selectCurrentCurrencyTable(submissionMgr.submission.sharecurrencyselection__c);
        }
        catch (DmlException e)
        {

            ApexPages.Message error = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Invalid Input.' + e);
            ApexPages.addMessage(error);
            return null;
        }
        catch (Exception e)
        {
            ApexPages.Message error = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Invalid Input.' + e);
            ApexPages.addMessage(error);
            return null;
        }
        return null;
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