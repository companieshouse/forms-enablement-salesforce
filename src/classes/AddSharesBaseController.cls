/*
Name:  AddSharesBaseController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Add Shares Base Page
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  L. Bitoy    2016-06-15  Initial development.
*/
public class AddSharesBaseController extends TransactionStepControllerBase
{

    // Public properties.
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

    // dynamic set data
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

    public AddSharesBaseController()
    {
        super();
        if (isPageInitialised) initialiseStep();

    }


    public void initialiseStep()
    {
        displayText1 = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        companyName = submissionMgr.submission.CompanyName__c;
        currentShares = submissionMgr.submission.Shares__r;
        checkShares();
        return;
    }

    public void checkShares()
    {

        if (submissionMgr.submission.Shares__r.size() > 0)
        {
            showCurrentShares = true;
        }
        else
        {
            showCurrentShares = false;

        }
    }
    public String checkCurrency()
    {
        throw new Form_CustomException('from check currency your current currency is ' + ' ' + currencyperSelection);


        return null;
    }

    public PageReference AddtocurrentShare()
    {

        submissionMgr.submission.sharecurrencyselection__c = currencyperSelection;
        // save the current currency selection to update the table in next step

        return nextAction();
    }

    public PageReference createNewShares()
    {
    	currencyperSelection = ' ';
		//submissionMgr.submission.sharecurrencyselection__c = ' ';

        return nextAction();
    }

    private void persistStep()
        {
            submissionMgr.submission.sharecurrencyselection__c = currencyperSelection;

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
