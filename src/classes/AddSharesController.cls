/*
Name:  Shares.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------
Controller Class for Shares Page
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-05-19  Initial development.
*/
public with sharing class AddSharesController extends TransactionStepControllerBase {

    // MetaData
    public String displayText1 {
        get;
        set;
    }
    public String displayText2 {
        get;
        set;
    }
    public String displayText3 {
        get;
        set;
    }
    public String headerText1 {
        get;
        set;
    }

    // dynamic set data
    public String directorName {
        get;
        set;
    }
    public String companyName {
        get;
        set;
    }
    public String companyNumber {
        get;
        set;
    }
    public String presenterEmail {
        get;
        set;
    }
    public String presenterName {
        get;
        set;
    }
    public String presenterPhone {
        get;
        set;
    }

    public List < Shares__c > sharecapital {
        get;
        set;
    }

    public Transaction__c transactionrecords {
        get;
        set;
    }
    public boolean showtable {
        get;
        set;
    }

    // Public properties.



    public AddSharesController() {

        // super();
        //put back later
        //if (isPageInitialised)
        initialiseStep();
    }

    public void initialiseStep() {
        showtable = true;

        headerText1 = 'Share Capital'; //transactionMgr.currentStep.Header_Text_1__c;

        displayText1 = 'Add Shares'; //transactionMgr.currentStep.Display_Text_1__c;
        //sharecapital = submissionMgr.submission.Shares__r;



        String transactionID = 'a0N4E000000mJn9';

        List < Transaction__c > recs = [select Id, Form_Name__c, Presenter__c, ExpiryDate__c, Presenter__r.Name, isMajorityRequired__c, Expiry_Date_Length__c,
            PresenterName__c, PresenterPhoneNumber__c, RequiredOfficerSign__c, ContactEmail__c,
            MultipleDirectors__c, Name, Historical_Valid_Step_Ids__c, CompanyNumber__c,
            Status__c, CompanyName__c, SubmissionId__c, Valid_Step_Ids__c, Warning_Confirmation_Flag__c, Amount__c, isLLP__c,
            (SELECT Id, BodyLength, Name FROM Attachments), (SELECT ActiveData__c, Aggregate_nominal_value__c, Class_of_Shares__c, Company_Name__c, CreatedById, CreatedDate, Currency__c, IsDeleted, Number_of_Shares__c, Prescribed_Particulars__c, Id, Name, Total_aggregate_amount_unpaid__c, Transaction__c FROM Shares__r),
            (Select Id, Name, Email__c, isPresenter__c, isSignatory__c, RecipientId__c,
                AuthorizedSigner__c, isDeceased__c, isPowerOfAttorney__c, isCorporateDirector__c From Officers__r), (SELECT Name, dsfs__DocuSign_Envelope_ID__c, dsfs__Envelope_Link__c, dsfs__Envelope_Status__c, dsfs__Sender__c, dsfs__Sender_Email__c, dsfs__Subject__c FROM DocuSign_Status__r)
            from Transaction__c where Id = : transactionID
        ];

        transactionrecords = recs[0];
        // if (recs.size() == 1) { transactionrecords = recs[0]; }

        sharecapital = transactionrecords.Shares__r;




        return;
    }

    // boolean needed to show table or hide table if no table data is shown

    public PageReference AddShare() {
        String transactionrecordid = 'a0N4E000000mJn9'; // submissionMgr.submission.Id;
        String transactioncompanynumber = '01946167'; // submissionMgr.submission.CompanyNumber__c;
        String transactioncompanyname = 'VIRGIN LIMITED'; // submissionMgr.submission.CompanyName__c;

        String redirection = '/ShareBuilder';
        PageReference pr = new PageReference(redirection);
        //pr.getParameters().put('c', addSharesparameter);
        pr.getParameters().put('c', SecurityManager.encryptText(transactionrecordid + AppConstants.ID_DELIM_CHAR + transactioncompanynumber + AppConstants.ID_DELIM_CHAR + transactioncompanyname));
        pr.setRedirect(true);
        return pr;
    }

    private void persistStep() {
            submissionMgr.persist();
        }
        // End Instance methods.    

    // Action methods.     
    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;

        persistStep();

        return nextStep();
    }

    public PageReference previousAction() {
            if (!validatePageState()) return Page.TransactionException;

            return previousStep();
        }
        // End Action methods.    

}
