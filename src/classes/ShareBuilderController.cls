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


    SecurityManager securityMgr;
    SubmissionManager submissionMgr;

    public ShareBuilderController() {
    	initialize();
    }

    private void initialize() {

		headerText1 = 'Add a Share Capital'; 
        displayText1 = 'Add Shares'; 
        securityMgr = new SecurityManager();
        submissionMgr = new SubmissionManager();

        try {
            if (!ApexPages.currentPage().getParameters().containsKey('c') ||
                String.isBlank(ApexPages.currentPage().getParameters().get('c'))) {
                return;
            }

        } catch (Exception e) {
            return;
        }

        // ShareBuilder state.
        String paramInput = ApexPages.currentPage().getParameters().get('c');
        String paramValue = SecurityManager.decryptText(paramInput);
        transactionSFID = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];
        if (!SubmissionManager.isValidSubmissionId(transactionSFID)){ return;}

        companyName = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];

        companyNumber = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[2];


        return;
    }

    public PageReference viewnewShares() {

        addShare(transactionSFID, numberofshares, sharecurrency, classofshares, totalvalueofshares);

        String redirection = '/Shares';
        PageReference pr = new PageReference(redirection);
        String storedCValue = 'thisisthestoredcvaluewhichwillbecorrupted';
        //get stored c value in cookie and redirect back to Shares View State
        pr.getParameters().put('c', storedCValue);
        pr.setRedirect(true);
        return pr;
    }

    private void addShare(String transactionid, Decimal numberofshares, String sharecurrency, String classofshares, Decimal totalvalueofshares) {
        try {

            upsert new Shares__c(Transaction__c = transactionid, Number_of_Shares__c = numberofshares, Currency__c = sharecurrency, Class_of_Shares__c = classofshares, Total_aggregate_amount_unpaid__c = totalvalueofshares);
        } catch (DmlException e) {

        	ApexPages.Message error = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid Input.' + e);
            ApexPages.addMessage(error);
        }

    }
}
