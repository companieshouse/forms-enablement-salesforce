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

    public String classofshares
    {
        get;
        set;
    }
    public Decimal aggregateNominalValue

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

    public Boolean showTable
    {
        get;
        set;

    }

    public String statusvalue
    {
        get;
        set;
    }

    public Boolean sharesAvailable
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

    public Map < Id, Shares__c > shareUpdaterMap
    {
        get;
        set;
    }
    public Id selectedId
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
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        selectedCurrency = submissionMgr.submission.sharecurrencyselection__c;
        currentShares = new List < Shares__c > ();
        checkFinishedAddingShares();
    }

    public PageReference checkFinishedAddingShares()
    {

        if (submissionMgr.submission.finishedAddingShares__c)
        {
            return nextAction();
        }
        else
        {
            statusvalue = 'No Shares here yet and not finsished';
            selectCurrentCurrencyTable();
            return null;
        }
    }


    public void selectCurrentCurrencyTable()
    {
        //currentShares.clear();
        if (submissionMgr.submission.Shares__r.size() > 0)
        {
            for (Shares__c previousShares: submissionMgr.submission.Shares__r)
            {
                if (previousShares.Currency__c == selectedCurrency)
                {
                    // throw new Form_CustomException(' current shares are ' + previousShares);

                    currentShares.add(previousShares);
                }
            }

            if (currentShares.size() == 0)
            {

                showTable = false;
                statusvalue = 'No Shares here that match current currency selection';


            }
            else if (currentshares.size() > 0)
            {
                showTable = true;
                statusvalue = 'Shares here';
            }

        }
        else if (submissionMgr.submission.Shares__r.size() == 0)
        {
            showTable = false;
            statusvalue = 'No Shares here';
        }


    }

    private void persistStep()
    {

        // persist stuff here
        submissionMgr.persist();
    }
    public void resetAddShare()
    {

        classofshares = '';
        numberofshares = null;
        aggregateNominalValue = null;
    }

    public PageReference addtoPreviousShare()
    {

        if (!validatePageState()) return Page.TransactionException;

        return previousStep();

        //PageReference pg = new PageReference('/AddSharesBase');
        //pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        //pg.setRedirect(true);

        //return pg;
    }

    public PageReference addShare()
    {
        List < Shares__c > previousSharesList = submissionMgr.submission.Shares__r;


        List < Shares__c > sharesToAdd = new List < Shares__c > ();

        if (classofshares.length() == 0)
        {
            hasPageErrors = true;
            currentErrorMessage = 'Must add a class of shares';
            return null;
        }

        if (numberofshares.toPlainString() == '0')
        {
            hasPageErrors = true;
            currentErrorMessage = 'Must add the number of shares';
            return null;
        }

        if (aggregateNominalValue.toPlainString() == '0')
        {
            hasPageErrors = true;
            currentErrorMessage = 'Must add a class of shares';
            return null;
        }

        sharesToAdd.add(new Shares__c(Name = classofshares, Transaction__c = submissionMgr.submission.Id, Number_of_Shares__c = numberofshares, Currency__c = selectedCurrency, Class_of_Shares__c = classofshares, Aggregate_nominal_value__c = aggregateNominalValue, ActiveData__c = true));
        insert sharesToAdd;

        PageReference pg = new PageReference('/TabularData');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);

        return pg;
        //resetAddShare();
        //selectCurrentCurrencyTable();

    }

    public void updateShares()
    {
        List < Shares__c > sharestoUpdate = new List < Shares__c > ();


        for (Shares__c sharesUPDATED: submissionMgr.submission.Shares__r)
        {
            if (sharesUPDATED.Id == selectedId)
            {
                sharesUPDATED.Name = classofshares;
                sharesUPDATED.Number_of_Shares__c = numberofshares;
                sharesUPDATED.Class_of_Shares__c = classofshares;
                sharesUpdated.Aggregate_nominal_value__c = aggregateNominalValue;
                shareUpdaterMap.put(sharesUPDATED.Id, sharesUPDATED);
            }

        }
        sharestoUpdate.addAll(shareUpdaterMap.values());

        update sharestoUpdate;
    }



    public PageReference finishAddingShares()
    {
        if (!validatePageState()) return Page.TransactionException;
        submissionMgr.submission.finishedAddingShares__c = true;

        persistStep();

        return nextStep();
    }

    public PageReference addPreparticularRights()
    {

        if (submissionMgr.submission.Shares__r.size() == 0)
        {
            hasPageErrors = true;
            currentErrorMessage = 'Cannot add preparticular rights without shares';
            return null;
        }
        return nextAction();
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