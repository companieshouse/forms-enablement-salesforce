public with sharing class ShareBuilderController {


    public String transactionSFID {
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

    public Decimal numberofshares {
        get;
        set;
    }
    public String sharecurrency {
        get;
        set;
    }
    public String classofshares {
        get;
        set;
    }
    public Decimal totalvalueofshares {
        get;
        set;
    }
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
    public String totalnumberofShares {
        get;
        set;
    }
    public String totalnumberAggregate {
        get;
        set;
    }

    public Boolean addsharedisabled {
        get;
        set;
    }
    public List < Shares__c > shareCapital { get;
        set; }
    public Transaction__c transactionrecords {get; set;}


    SecurityManager securityMgr;
    SubmissionManager submissionMgr;

    public ShareBuilderController() {
        initialize();
    }

    private void initialize() {

        headerText1 = 'Add a Share Capital';
        displayText1 = 'Add Shares';
        //securityMgr = new SecurityManager();
        //submissionMgr = new SubmissionManager();

        String transactionID = 'a0N4E000000mLw8';

        List < Transaction__c > recs = [select Id, Form_Name__c, Presenter__c, ExpiryDate__c, Presenter__r.Name, isMajorityRequired__c, Expiry_Date_Length__c,
            PresenterName__c, PresenterPhoneNumber__c, RequiredOfficerSign__c, ContactEmail__c,
            MultipleDirectors__c, Name, Historical_Valid_Step_Ids__c, CompanyNumber__c,
            Status__c, CompanyName__c, SubmissionId__c, Valid_Step_Ids__c, Warning_Confirmation_Flag__c, Amount__c, isLLP__c,sharecurrencyselection__c,
            (SELECT Id, BodyLength, Name FROM Attachments), (SELECT ActiveData__c, Aggregate_nominal_value__c, Class_of_Shares__c, Company_Name__c, CreatedById, CreatedDate, Currency__c, IsDeleted, Number_of_Shares__c, Prescribed_Particulars__c, Id, Name, Total_aggregate_amount_unpaid__c, Transaction__c FROM Shares__r),
            (Select Id, Name, Email__c, isPresenter__c, isSignatory__c, RecipientId__c,
                AuthorizedSigner__c, isDeceased__c, isPowerOfAttorney__c, isCorporateDirector__c From Officers__r), (SELECT Name, dsfs__DocuSign_Envelope_ID__c, dsfs__Envelope_Link__c, dsfs__Envelope_Status__c, dsfs__Sender__c, dsfs__Sender_Email__c, dsfs__Subject__c FROM DocuSign_Status__r)
            from Transaction__c where Id = : transactionID
        ];

         transactionrecords = recs[0];
        // if (recs.size() == 1) { transactionrecords = recs[0]; }

        shareCapital = transactionrecords.Shares__r;
        transactionSFID = transactionrecords.Id;
        sharecurrency = transactionrecords.sharecurrencyselection__c;
      
        //transactionSFID = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];
        //if (!SubmissionManager.isValidSubmissionId(transactionSFID)) {
        //    return;
        //}
        //        shareCapital = submissionMgr.submission.Shares__r;

        //companyName = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];

        //companyNumber = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[2];

        return;
    }

    public PageReference viewnewShares() {
        addShare();
        //classofshares, transactionSFID, numberofshares, sharecurrency, classofshares, totalvalueofshares
        return null;
    }

    private void addShare() {
        try {
            //String name, String transactionid, Decimal numberofshares, String sharecurrency, String classofshares, Decimal totalvalueofshares
            insert new Shares__c(Name = classofshares, Transaction__c = transactionrecords.Id, Number_of_Shares__c = numberofshares, Currency__c = sharecurrency, Class_of_Shares__c = classofshares, Total_aggregate_amount_unpaid__c = totalvalueofshares, ActiveData__c = true);

        } catch (DmlException e) {

            ApexPages.Message error = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Invalid Input.' + e);
            ApexPages.addMessage(error);
            //return;
        } catch (Exception e) {
            ApexPages.Message error = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Invalid Input.' + e);
            ApexPages.addMessage(error);
            //return;

        }

    }
}