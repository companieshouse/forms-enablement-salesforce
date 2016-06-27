/*
Name:  Review.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Transaction Review Page
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-05-19  Initial development.
*/
public class ReviewController extends TransactionStepControllerBase
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
    public List < Shares__c > reviewShares
    {
        get;
        set;
    }

    // company address information
    public String companyAddress
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
    public String reviewpagebutton
    {
        get;
        set;
    }
    public Boolean custompanelView
    {
        get;
        set;
    }
    public String customPanelHTML
    {
        get;
        set;
    }

    public Boolean standardPanelView
    {
        get;
        set;
    }
    public Map < String, Shares__c > shareCurrencyMap
    {
        get;
        set;
    }
    public List < Shares__c > shareReviewer
    {
        get;
        set;
    }

    public Map < Id, List < Shares__c >> viewlist
    {
        get;
        set;
    }
    public List < Attachment > reviewAttachments
    {
        get;
        set;
    }
    
    public ReviewController()
    {
        super();
        if (isPageInitialised) initialiseStep();

    }

    public void initialiseStep()
    {
        shareReviewer = new List < Shares__c > ();

        displayText1 = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        standardPanelView = transactionMgr.currentstep.StandardView__c;
        custompanelView = transactionMgr.currentstep.CustomView__c;
        customPanelHTML = CustomViews.SH19_REVIEW_PAGE;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.Name;
        presenterName = submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c;
        reviewpagebutton = transactionMgr.currentStep.ContinueButtonText__c;
        companyDirectors = submissionMgr.submission.Officers__r;

        //CSBEGINMOD SP 01/06/2016: Code changed because we don't need to do an API call
        //CompaniesHouse.CompanyProfile compProf = CompanyQueryAction.getCompanyInfo(companyNumber);
        //companyAddress1 = compProf.registered_office_address.address_line_1;
        //companyAddress2 = compProf.registered_office_address.address_line_2;
        //companyregion = compProf.registered_office_address.region;
        //companypostcode = compProf.registered_office_address.postal_code;
        //companyCountry = compProf.registered_office_address.country;
        //companyLocality = compProf.registered_office_address.locality;
        //CSENDMOD SP 01/06/2016

        companyAddress1 = submissionMgr.submission.CompanyAddress1__c;
        companyAddress2 = submissionMgr.submission.CompanyAddress2__c;
        companyregion = submissionMgr.submission.CompanyRegion__c;
        companypostcode = submissionMgr.submission.CompanyPostCode__c;
        companyCountry = submissionMgr.submission.CompanyCountry__c;
        companyLocality = submissionMgr.submission.CompanyLocality__c;
        companyAddress = (companyAddress1 == null ? '' : companyAddress1 + '<br/>') + (companyAddress2 == null ? '' : companyAddress2 + '<br/>') + (companyregion == null ? '' : companyregion + '<br/>') + (companyLocality == null ? '' : companyLocality + '<br/>') + (companypostcode == null ? '' : companypostcode + '<br/>') + (companyCountry == null ? '' : companyCountry);
        showprevious = true;
        if (submissionMgr.submission.Officers__r.size() > 1)
        {
            showprevious = false;
        }
        //buildReviewShares();
        if (submissionMgr.submission.Shares__r.size() > 0)
        {
            reviewShares = submissionMgr.submission.Shares__r;
            // note need to loop through by currency and build it dynamically
        }

        if (submissionMgr.submission.Attachments.size() > 0)
        {
            reviewAttachments = submissionMgr.submission.Attachments;
            // note need to loop through by currency and build it dynamically
        }

        return;
    }


    public void buildReviewShares()
    {
        //if (!submissionMgr.submission.Shares__r == 0)
        //{
        //    // should create a map of keys that contain the currencies for all tables
        //    for (Shares__c sharecurrencylimiter: submissionMgr.submission.Shares__r)
        //    {
        //        shareCurrencyMap.put(sharecurrencylimiter.Currency__c, sharecurrencylimiter);

        //    }

        //    for (Integer i = 0; i < shareCurrencyMap.size(); i++)
        //    {
        //        Map < Id, List < Shares__c >> viewmap = new Map < Id, List < Shares__c >> ();
        //        for (Shares__c buildShares: submissionMgr.submission.Shares__r)
        //        {
        //            for (Id key: shareCurrencyMap.keySet())
        //            {
        //                if (buildShares.Currency__c == key)
        //                {
        //                    viewmap.add(i, buildShares);

        //                }
        //            }
        //        }
        //    }

        //    reviewShares.add(viewmap.values());
        //}
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