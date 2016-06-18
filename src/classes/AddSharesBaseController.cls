/*
Name:  AddSharesBaseController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Add Shares Base Page
Controller will capture users logic or current or previous 
share building transactions and guide them to the correct path
e.g. add new shares or update current shares in system.
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  L. Bitoy    2016-06-15  Initial development.
*/
public class AddSharesBaseController extends TransactionStepControllerBase
{
    public String currencyperSelection
    {
        get;
        set;
    }

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
    public String currencyType
    {
        get;
        set;
    }
    public String submissionIdentification
    {
        get;
        set;
    }

    public List < String > displayresult
    {
        get;
        set;
    }

    public List < Shares__c > currentShares
    {
        get;
        set;
    }

    public Map < String, Shares__c > mapShares
    {
        get;
        set;
    }
    public AddSharesBaseController()
    {
        super();
        if (isPageInitialised)
            initialiseStep();
    }

    public void initialiseStep()
    {
        displayText1 = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        companyName = submissionMgr.submission.CompanyName__c;
        displayresult = new List < String > ();
        checkShares();
        return;
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
        }
        else if (submissionMgr.submission.Shares__r.size() < 1)
        {
            showCurrentShares = false;
        }
    }


    public String checkCurrency()
    {
        throw new Form_CustomException('from check currency your current currency is ' + ' ' + currencyperSelection);


        return null;
    }

    private void persistStep()
    {
        submissionMgr.submission.sharecurrencyselection__c = currencyperSelection;

        submissionMgr.persist();
    }
    public PageReference AddtocurrentShare()
    {

        submissionMgr.submission.sharecurrencyselection__c = currencyperSelection;

        return nextAction();
    }

    public PageReference createNewShares()
    {
        currencyperSelection = ' ';

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