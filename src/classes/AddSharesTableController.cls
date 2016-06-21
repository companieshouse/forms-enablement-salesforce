/*
Name:  AddSharesTableController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: AddShares

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-06  Initial development.
*/
public with sharing class AddSharesTableController extends TransactionStepControllerBase
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

    public AddSharesTableController()
    {
        super();
        if (isPageInitialised) initialiseStep();

    }



    public void initialiseStep()
    {
    	checkFinishedAddingShares();
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        currentShares = new List < Shares__c > ();
        selectedCurrency = submissionMgr.submission.sharecurrencyselection__c;
    }
    public PageReference checkFinishedAddingShares(){

    	if(submissionMgr.submission.finishedAddingShares__c == true)

    	{ return nextAction();
    	}
    	else { return null;}
    }


    public void selectCurrentCurrencyTable()
    {

        if (submissionMgr.submission.Shares__r.size() > 0)
        {
            for (Shares__c previousShares: submissionMgr.submission.Shares__r)
            {
                if (previousShares.Currency__c == selectedCurrency)
                {
                    currentShares.add(previousShares);

                }
            }
                    	statusvalue = 'Shares here';

        }
        else {
        	statusvalue = 'No Shares here';
            //throw new Form_CustomException('you have no shares to view again - this page should not show up');
        }
    }

    private void persistStep()
    {

        // persist stuff here
        submissionMgr.persist();
    }

    public String addShare()
    {
        try
        {
            //String name, String transactionid, Decimal numberofshares, String sharecurrency, String classofshares, Decimal totalvalueofshares
            insert new Shares__c(Name = classofshares, Transaction__c = submissionMgr.submission.Id, Number_of_Shares__c = numberofshares, Currency__c = sharecurrency, Class_of_Shares__c = classofshares, Total_aggregate_amount_unpaid__c = totalvalueofshares, ActiveData__c = true);
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