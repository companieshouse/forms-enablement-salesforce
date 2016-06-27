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
    public Boolean showCurrentShares
    {
        get;
        set;
    }
    public List < Shares__c > currentShares
    {
        get;
        set;
    }
    public List < String > displayresult
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

    public String currencyperSelection
    {
        get;
        set;
    }
    public Map < String, Shares__c > mapShares
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
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        displayresult = new List < String > ();

        checkShares();

    }

    public void checkShares()
    {


        if (submissionMgr.submission.Shares__r.size() >= 1)
        {
            showCurrentShares = true;
            currentShares = submissionMgr.submission.Shares__r;

            Map < String, Shares__c > mapShares = new Map < String, Shares__c > ();

            for (Shares__c sortedshares: currentShares)
            {

                mapShares.put(sortedshares.Currency__c, sortedshares);

            }
            displayresult.addAll(mapShares.keySet());
            //throw new Form_CustomException('here is the error' + displayresult);

        }
        else if (submissionMgr.submission.Shares__r.size() < 1)
        {
            showCurrentShares = false;
        }

    }


    public PageReference AddtocurrentShare()
    {
        submissionMgr.submission.sharecurrencyselection__c = currencyperSelection;
        submissionMgr.persist();
        //throw new Form_CustomException(' your currency per selection is?' + submissionMgr.submission.sharecurrencyselection__c);

        //PageReference pg = new PageReference('/TabularData');
        //pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        //pg.setRedirect(true);

        //return pg;

        return nextStep();
    }

    public PageReference finishedAddingShares()
    {

        submissionMgr.submission.finishedAddingShares__c = true;
        submissionMgr.persist();
        return nextStep();
    }

    public PageReference setSelectedCurrency()
    {

        System.debug('Currency Changed to   ' + selectedCurrency);

        return nextAction();
    }


    private void persistStep()
    {
        submissionMgr.submission.sharecurrencyselection__c = selectedCurrency;

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