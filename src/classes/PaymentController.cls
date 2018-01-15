/**
 * Controller for the redirection to the payment page at SmartPay. Also handles the
 * redirect back to us following payment.
 * Version adapted to Framework
 * Author: eliot.stock@methods.co.uk
 */
public with sharing class PaymentController extends TransactionStepControllerBase {
    //Payment properties
    @TestVisible
    private static final String QUERY_STRING_PARAM_MERCHANT_REFERENCE = 'merchantReference';
    @TestVisible
    private static final String QUERY_STRING_PARAM_MERCHANT_SIG = 'merchantSig';
    @TestVisible
    private static final String QUERY_STRING_PARAM_AUTH_RESULT = 'authResult';
    @TestVisible
    private static final String QUERY_STRING_PARAM_PSP_REFERENCE = 'pspReference';
    @TestVisible
    private static final String QUERY_STRING_PARAM_SKIN_CODE = 'skinCode';
    @TestVisible
    private static final String QUERY_STRING_PARAM_PAYMENT_METHOD = 'paymentMethod';
    @TestVisible
    private static final String QUERY_STRING_PARAM_SHOPPER_LOCAL = 'shopperLocale';
    // AUTHORISED: Authorisation was successfully completed.
    @TestVisible
    private static final String AUTH_RESULT_AUTHORISED = 'AUTHORISED';
    // REFUSED: Authorisation was unsuccessful, Declined by issuer.
    @TestVisible
    private static final String AUTH_RESULT_REFUSED = 'REFUSED';
    // CANCELLED: Shopper cancelled payment or used back button on initial page to
    // return to merchants website.
    @TestVisible
    private static final String AUTH_RESULT_CANCELLED = 'CANCELLED';
    // PENDING: Final status of the payment could not be established at the time,
    // this can be due to the payment method (e.g PayPal) or requiring the shopper
    // to take further action.
    @TestVisible
    private static final String AUTH_RESULT_PENDING = 'PENDING';
    // ERROR: An error occurred during the payment process.
    @TestVisible
    private static final String AUTH_RESULT_ERROR = 'ERROR';
    @TestVisible
    private String merchantReference;
    public Boolean hasBeenRedirected {get; set;}
    @TestVisible
    private String merchantSig;
    @TestVisible
    private String authResult;
    // Public properties.
    public String externalURL {
        get;
        set;
    }
    public Boolean hasPaid {
        get;
        set;
    }
    public Boolean hasPaymentSuccess {
        get;
        set;
    }
    public Boolean hasPaymentRejected {
        get;
        set;
    }
    public Boolean hasPaymentError {
        get;
        set;
    }
    public Boolean hasPaymentPending {
        get;
        set;
    }
    public Boolean previousClicked {
        get;
        set;
    }
    public Boolean isCardPayment {
        get;
        set;
    }
    public Boolean isPaypalPayment {
        get;
        set;
    }
    public Boolean isAccountPayment {
        get;
        set;
    }
    public Boolean isSameDayPayment {
        get;
        set;
    }
    public Boolean isCardSelected {
        get;
        set;
    }
    public Boolean isPaypalSelected {
        get;
        set;
    }
    public Boolean isAccountSelected {
        get;
        set;
    }
    public Boolean isSameDaySelected {
        get;
        set;
    }
    public Integer valuePaymentUI {
        get;
        set;
    }
    public String headerBox1 {
        get;
        set;
    }
    public String textBox1NormalFee {
        get;
        set;
    }
    public String textBox1FastTrackFee {
        get;
        set;
    }
    public Decimal fastTrackFee {
        get;
        set;
    }
    public Decimal normalFee {
        get;
        set;
    }
    public String paymentReference {
        get;
        set;
    }
    public String accountNumber {
        get;
        set;
    }
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String currentErrorMessage {
        get;
        set;
    }
    public String samedayError {get; set;}
    public String sameDayErrorMessage {get; set;}
    public String accountcurrentErrorMessage {get; set;}
    public String errorVal {
        get;
        set;
    }

    public String pageLog {get; set;}

    public String accountAuthCode {get; set;}
    public Boolean accountFailure {get; set;}
    public Boolean accountSuccess {get; set;}

    public String accountSuccessMsg {get; set;}
    public String accountFailureMsg {get; set;}

    public String accounterrorVal {get; set;}
    public Boolean hasBeenHacked {get; set;}
    public PaymentController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public Boolean hasPaid() {
        if (submissionMgr.submission.hasPaid__c) {
            return true;
        }
        return false;
    }
    public void initialiseStep() {

        pageLog = '';
        hasPaid = false;
        hasBeenRedirected = false;
        hasPaymentSuccess = false;
        hasPaymentRejected = false;
        hasBeenHacked = false;
        hasPaymentError = false;
        hasPaymentPending = false;
        previousClicked = false;
        accountSuccess = false;
        accountFailure = false;
        accountSuccessMsg = 'Your account payment has been validated, it will be processed when you submit the '+ submissionMgr.submission.Form_Name__c +'.' ;
        accountFailureMsg = 'Your account payment has not been validated, please use the previous button to correct the presenter id or presenter authentication code or Start again.';
        paymentReference = '';
        accountAuthCode = '';
        isCardPayment = (transactionMgr.td.isCardAllowed__c == null ? false : transactionMgr.td.isCardAllowed__c);
        isPaypalPayment = (transactionMgr.td.isPaypalAllowed__c == null ? false : transactionMgr.td.isPaypalAllowed__c);
        isAccountPayment = (transactionMgr.td.isAccountPayment__c == null ? false : transactionMgr.td.isAccountPayment__c);
        isSameDayPayment = (transactionMgr.td.isSameDayPayment__c == null ? false : transactionMgr.td.isSameDayPayment__c);
        normalFee = (transactionMgr.td.Fee__c == null ? 0 : transactionMgr.td.Fee__c);
        fastTrackFee = (transactionMgr.td.FeeFastTrack__c == null ? 0 : transactionMgr.td.FeeFastTrack__c);
        textBox1NormalFee = (transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c);
        headerBox1 = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        textBox1FastTrackFee = textBox1NormalFee.replace('FEE', fastTrackFee + '');
        textBox1NormalFee = textBox1NormalFee.replace('FEE', normalFee + '');
        isCardSelected = false;
        isPaypalSelected = false;
        isAccountSelected = false;
        // isSameDaySelected = false;
    }

    

    public PageReference checkPaymentResult() {
        parseQueryString();        

        if(hasBeenRedirected)
            SecurityManager.createSessionValidityCookie(submissionMgr.submission.ContactEmail__c, submissionMgr.submission, transactionMgr, 'CheckPaymentResult Method (Return from Payment)');
        
        PageReference res = initialiseAction();

        pageLog += LogSessionManager.log;

        if(res != null)
        {
            return res;
        }

        if(hasBeenHacked)
        {
            PageReference pg = new PageReference('/InMaintenance');
            pg.setRedirect(true);
            return pg;
        }

        //If there is no payment associated we need to protect the page to be displayed
        if (!submissionMgr.submission.isPaymentRequired__c) {
            hasPaid = true;
            PageReference nextPage = nextStep();
            nextPage.setRedirect(true);
            return nextPage;
        }
        if (hasPaid() && !hasPaymentSuccess) {
            hasPaid = true;
            return null;
        }

        

        // Transaction context.
        if (!ApexPages.currentPage().getParameters().containsKey('c') || String.isBlank(ApexPages.currentPage().getParameters().get('c'))) return null;
        String paramInput = ApexPages.currentPage().getParameters().get('c');
        if (paramInput.contains(' ')) {
            paramInput = paramInput.replace(' ', '+');
            ApexPages.currentPage().getParameters().put('c', paramInput);
            ApexPages.currentPage().setRedirect(true);
            return ApexPages.currentPage();
        }
        //if (previousClicked) {
        //    return previousAction();
        //}
        //if(hasPaymentRejected || hasPaymentError || hasPaymentPending)
        return null;
    }
    public PageReference updateLink() {
        submit();
        PageReference pg = new PageReference(externalURL);
        pg.setRedirect(true);
        return pg;
    }
    @TestVisible
    private void persistStep() {
        if (previousClicked) {
            submissionMgr.submission.Status__c = 'Signed';
            submissionMgr.submission.hasPaid__c = false;
            submissionMgr.submission.isPaymentAccount__c = false;
            submissionMgr.submission.isPaymentPaypal__c = false;
            submissionMgr.submission.isPaymentCard__c = false;
        }
        if (hasPaymentSuccess || hasPaid) {
            submissionMgr.submission.Status__c = 'Paid';
            submissionMgr.submission.hasPaid__c = true;
        }
        if (String.isBlank(paymentReference) && !hasPaid ) {
            paymentReference = submissionMgr.submission.Id;
        }
        if (isAccountSelected) {
            submissionMgr.submission.isPaymentAccount__c = true;
            submissionMgr.submission.AccountNumber__c = accountNumber;
            paymentReference = accountNumber;
            submissionMgr.submission.isPaymentPaypal__c = false;
            submissionMgr.submission.isPaymentCard__c = false;
            submissionMgr.submission.AccountAuthorisationCode__c = accountAuthCode.toUpperCase();
        }
        if (isPaypalSelected ) {
            submissionMgr.submission.isPaymentPaypal__c = true;
            submissionMgr.submission.AccountNumber__c = '';
            submissionMgr.submission.AccountAuthorisationCode__c = '';
            submissionMgr.submission.isPaymentAccount__c = false;
            submissionMgr.submission.isPaymentCard__c = false;
        }
        if (isCardSelected) {
            submissionMgr.submission.AccountNumber__c = '';
            submissionMgr.submission.AccountAuthorisationCode__c = '';
            submissionMgr.submission.isPaymentCard__c = true;
            submissionMgr.submission.isPaymentPaypal__c = false;
            submissionMgr.submission.isPaymentAccount__c = false;
        }
        if (transactionMgr.td.isSameDayPayment__c == true)
            if(isSameDaySelected) {
                submissionMgr.submission.isSameDayProcessing__c = true;
            }
        if (submissionMgr.submission.Amount__c == null) submissionMgr.submission.Amount__c = (isSameDaySelected == true ? fastTrackFee : normalFee);

        if(!hasPaid)
        {
            submissionMgr.submission.paymentReference__c = paymentReference;
            submissionMgr.submission.paymentDate__c = String.valueOf(system.today().format());
        }

        submissionMgr.persist();
    }
    // End Instance methods.
    // Action methods.
    public PageReference nextAction() {
        LogSessionManager.initLog();
        LogSessionManager.log = pageLog;
        if (!hasPaid() && valuePaymentUI == null && accountSuccess == false) {
            hasPageErrors = true;
            currentErrorMessage = 'Please provide a method of payment';
            errorVal = 'error';
            return null;
        }
        if (!hasPaid() && valuePaymentUI == 2 && accountSuccess == false) {
            if (accountNumber.length() == 0) {
                hasPageErrors = true;
                accountcurrentErrorMessage = 'Please provide an account number or select another method of payment';
                accounterrorVal = 'error';
                return null;
            }
            if (!accountNumber.isNumeric()) {
                hasPageErrors = true;
                accountcurrentErrorMessage = 'Please provide an account number containing only numbers';
                accounterrorVal = 'error';
                return null;
            }
            if (String.isEmpty(accountAuthCode)) {
                hasPageErrors = true;
                accountcurrentErrorMessage = 'Please provide an authentication code if you want to pay using your account';
                accounterrorVal = 'error';
                return null;
            }
        }
        if (transactionMgr.td.isSameDayPayment__c == true) {

            if (isSameDaySelected == null) {
                hasPageErrors = true;
                sameDayErrorMessage = 'Please choose application processing time (Same Day or Normal)';
                accountcurrentErrorMessage = '';
                currentErrorMessage = '';
                errorVal = '';
                accounterrorVal = '';
                samedayError = 'error';
                return null;
            }
        }


        if (!validatePageState()) return Page.TransactionException;


        if(isAccountSelected)
        {
            if(!(submissionMgr.submission.Status__c == 'Approved' || submissionMgr.submission.Status__c == 'Rejected' || submissionMgr.submission.Status__c == 'Submitted'))
                persistStep();
            PageReference pg = new PageReference('/Payment');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
            

               
        }
        if(!(submissionMgr.submission.Status__c == 'Approved' || submissionMgr.submission.Status__c == 'Rejected' || submissionMgr.submission.Status__c == 'Submitted'))
            persistStep();

        if (isCardSelected || isPaypalSelected) {
            submit();
            PageReference pg = new PageReference(externalURL);
            pg.setRedirect(true);
            return pg;
        }
        if (!hasPaid()) return null;
        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;

        Boolean isAccount = submissionMgr.submission.isPaymentAccount__c;
        
        previousClicked = true;

        persistStep();

        if(isAccount)
        {
            PageReference pg = new PageReference('/Payment');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }


        
        return previousStep();
    }
    // End Action methods.
    public void updatePayment() {
        if (valuePaymentUI == null) return;
        if (valuePaymentUI == 1) {
            isCardSelected = true;
            isAccountSelected = false;
            isPaypalSelected = false;
        } else if (valuePaymentUI == 2) {
            isCardSelected = false;
            isPaypalSelected = false;
            isAccountSelected = true;
        } else if (valuePaymentUI == 3) {
            isCardSelected = false;
            isAccountSelected = false;
            isPaypalSelected = true;
        }
    }
    public void updateSameDay() {}
    /**
     * Off we go to a SmartPay URL.
     */
    public void submit() {
        // Let's use a transaction ID as the merchant reference on the payment. It's then
        // guaranteed to be unique.
        // Get a URL for SmartPay, the payment processor. Whether this is on TEST or LIVE is
        // driven by the active custom setting record.
        //CODE FOR PRODUCTION WHEN Submission manager will be in sync with Transaction Object
        SmartPayUrl url = new SmartPayUrl.Builder().merchantReference(submissionMgr.submission.Id).paymentAmount(isSameDaySelected == true ? fastTrackFee : normalFee).customerEmail(submissionMgr.submission.ContactEmail__c).customerMethodsPayment(isPaypalSelected).build();
        String redirectUrl = url.toString();
        externalURL = redirectUrl;
        //CSBeginMod: Sylvain Picory 14 April 2016: We don't want to redirect to the payement page anymore
        //PageReference pageReference = new PageReference(redirectUrl);
        //pageReference.setRedirect(true);
        //return pageReference;
        //CSEndMod: Sylvain Picory 14 April 2016
    }
    public PageReference resetTransaction(){
        //The framework has been decomissioned to now redirect to the company details page once you click the link start again

            if(submissionMgr.submission.Id != null)
            {   
                //update the transaction first
                submissionMgr.submission.Status__c = 'deleteContact';
                //Save the transaction type
                String transactionType = submissionMgr.submission.Transaction_Type__c;
                Id presenterID = submissionMgr.submission.Presenter__c;
                String presenterEmail = submissionMgr.submission.ContactEmail__c;
                Account companyId = submissionMgr.submission.Company__r;
                update submissionMgr.submission;
                delete submissionMgr.submission;
                TransactionManager tr = new TransactionManager(transactionType);
                Id submissionId = submissionMgr.initialise(transactionType, presenterID, presenterEmail, companyId, tr.td);
                return tr == null ? null : tr.firstStep(submissionId);

            }

            return null;
    }
    /**
     * Figure out, based on query string params, whether we've paid already or not. If we have, the
     * URL will look like:
     *
     * https://c.cs83.visual.force.com/apex/payment
     *   ?merchantReference=a034E000000qrsCQAQ
     *   &skinCode=rDzAns5W
     *   &shopperLocale=en_GB
     *   &paymentMethod=visa
     *   &authResult=AUTHORISED
     *   &pspReference=7914593350745514
     *   &merchantSig=c96mrZtROXInJlVRWfzMGvRx6vY%3D
     *
     * TODO: (BETA) Validate the merchantSig passed over. If it's invalid, that could mean a
     * malicious user has simply hacked the URL together in order to avoid paying.
     *
     * TODO: (BETA) Store the pspReference on the Transaction record. Admin bods would need this if
     * they ever needed to query a transation with Barclays.
     */
    public void parseQueryString() {
        //QUERY_STRING_PARAM_PAYMENT_METHOD
        merchantReference = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_MERCHANT_REFERENCE);
        merchantSig = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_MERCHANT_SIG);
        authResult = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_AUTH_RESULT);

        String pspRef = '';
        if(ApexPages.currentPage().getParameters().containsKey(QUERY_STRING_PARAM_PSP_REFERENCE))
            pspRef = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_PSP_REFERENCE);

        String skinC = '';
        if(ApexPages.currentPage().getParameters().containsKey(QUERY_STRING_PARAM_SKIN_CODE))
            skinC = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_SKIN_CODE);

        String paymentMeth = '';
        if(ApexPages.currentPage().getParameters().containsKey(QUERY_STRING_PARAM_PAYMENT_METHOD))
            paymentMeth = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_PAYMENT_METHOD);

        String shopperLoc = '';
        if(ApexPages.currentPage().getParameters().containsKey(QUERY_STRING_PARAM_SHOPPER_LOCAL))
            shopperLoc = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_SHOPPER_LOCAL);
        
        if(submissionMgr.submission.isPaymentAccount__c)
        {
            //Make the API Call
            FormsApiClient client = new FormsApiClient();
            HTTPResponse response = client.requestPresenterAPI(submissionMgr.submission.AccountNumber__c, submissionMgr.submission.AccountAuthorisationCode__c.toUpperCase()); 
            if(response != null)
            {
                if(response.getStatusCode() == 200)
                {
                    hasPaid = true;
                    hasPaymentSuccess = true;
                    paymentReference = submissionMgr.submission.AccountNumber__c;
                    accountSuccess = true;
                    accountFailure = false;
                    hasPaymentRejected = false;
                    hasPaymentPending = false;
                    previousClicked = false;
                    hasPaymentError = false;
                    hasBeenRedirected = true;
                    return;
                }
                else{
                    hasPaid = false;
                    hasPaymentSuccess = false;
                    accountSuccess = false;
                    accountFailure = true;
                    hasPaymentRejected = false;
                    hasPaymentPending = false;
                    previousClicked = false;
                    hasPaymentError = true;
                    hasBeenRedirected = true;
                    return;
                }
            }
        }
        if (merchantReference != null && merchantReference.length() > 0) {
            // Valid params for the result URL back to us after payment. Now check authResult.
            SmartPayUrl smp = new SmartPayUrl();

            if(smp.checkSigningString(authResult, pspRef, merchantReference, skinC,paymentMeth,shopperLoc, merchantSig) == false)
            {
                hasPaymentSuccess = false;
                hasPaid = false;
                hasPaymentRejected = false;
                hasPaymentPending = false;
                previousClicked = false;
                hasPaymentError = false;
                hasBeenHacked = true;
                hasBeenRedirected = true;
                return;
            }
            else if (authResult == AUTH_RESULT_AUTHORISED) {
                //change the status of the payment page
                paymentReference = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_PSP_REFERENCE);
                hasPaid = false;
                hasPaymentSuccess = true;
                hasPaymentRejected = false;
                hasPaymentPending = false;
                previousClicked = false;
                hasPaymentError = false;
                hasBeenRedirected = true;
                persistStep();
            } else if (authResult == AUTH_RESULT_REFUSED) {
                //Go To refused Payment page ?
                hasPaymentSuccess = false;
                hasPaid = false;
                hasPaymentRejected = true;
                hasPaymentPending = false;
                previousClicked = false;
                hasPaymentError = false;
                hasBeenRedirected = true;
            } else if (authResult == AUTH_RESULT_PENDING) {
                //Nothing to do?
                hasPaymentSuccess = false;
                hasPaid = false;
                hasPaymentRejected = false;
                hasPaymentPending = true;
                previousClicked = false;
                hasPaymentError = false;
                hasBeenRedirected = true;
            } else if (authResult == AUTH_RESULT_CANCELLED) {
                hasPaymentSuccess = false;
                hasPaid = false;
                hasPaymentRejected = false;
                hasPaymentPending = false;
                previousClicked = true;
                hasPaymentError = false;
                hasBeenRedirected = true;
            } else if (authResult == AUTH_RESULT_ERROR) {
                hasPaymentSuccess = false;
                hasPaid = false;
                hasPaymentRejected = false;
                hasPaymentPending = false;
                previousClicked = false;
                hasPaymentError = true;
                hasBeenRedirected = true;
            }
        } else {
            hasPaymentSuccess = false;
            hasPaid = false;
            hasPaymentRejected = false;
            hasPaymentPending = false;
            previousClicked = false;
            hasPaymentError = false;
        }
    }
}