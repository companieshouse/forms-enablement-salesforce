/**
 * Controller for the redirection to the payment page at SmartPay. Also handles the
 * redirect back to us following payment.
 * Version adapted to Framework
 * Author: eliot.stock@methods.co.uk
 */
public class PaymentController extends TransactionStepControllerBase {
    //Payment properties
    private static final String QUERY_STRING_PARAM_MERCHANT_REFERENCE = 'merchantReference';
    
    private static final String QUERY_STRING_PARAM_MERCHANT_SIG = 'merchantSig';
    
    private static final String QUERY_STRING_PARAM_AUTH_RESULT = 'authResult';

    // AUTHORISED: Authorisation was successfully completed.
    private static final String AUTH_RESULT_AUTHORISED = 'AUTHORISED';

    // REFUSED: Authorisation was unsuccessful, Declined by issuer.
    private static final String AUTH_RESULT_REFUSED = 'REFUSED';
    
    // CANCELLED: Shopper cancelled payment or used back button on initial page to
    // return to merchants website.
    private static final String AUTH_RESULT_CANCELLED = 'CANCELLED';

    // PENDING: Final status of the payment could not be established at the time, 
    // this can be due to the payment method (e.g PayPal) or requiring the shopper
    // to take further action.
    private static final String AUTH_RESULT_PENDING = 'PENDING';

    // ERROR: An error occurred during the payment process.
    private static final String AUTH_RESULT_ERROR = 'ERROR';   

    private String merchantReference;
    private String merchantSig;
    private String authResult;


    // Public properties.
    public Boolean hasPageErrors { get; set; }

    public String externalURL {get; set;}

    public Boolean hasPaid {get; set;}
    

    public PaymentController() {
        super();
        if (isPageInitialised) initialiseStep();

    }
    
    public void initialiseStep() {
        hasPaid = false;
        if(true)
        //if(isPageAlreadyValidStep)
        {
            hasPaid = true;
            return;
        }
        else{
            submissionMgr.submission.Status__c = 'Payment pending';
        }


        //If there is no fee associated we need to protect the page to be displayed
        if(transactionMgr.td.Fee__c == null || transactionMgr.td.Fee__c == 00.00) 
        {
            PageReference nextPage = nextAction();
            nextPage.setRedirect(true);
            return;
        }

        submit();
        return;
        
    }

    public PageReference checkPaymentResult(){

        parseQueryString(); 
                  
        if(authResult == null)
        {
            if(submissionMgr.submission.Status__c == 'Payment pending')
            {
                persistStep();
            }
            return null;
        }                         
        // Transaction context.
        if (!ApexPages.currentPage().getParameters().containsKey('c') || 
            String.isBlank(ApexPages.currentPage().getParameters().get('c'))) return null;

        String paramInput = ApexPages.currentPage().getParameters().get('c');

        if(paramInput.contains(' '))
        {
            paramInput = paramInput.replace(' ', '+');

            ApexPages.currentPage().getParameters().put('c',paramInput);

            ApexPages.currentPage().setRedirect(true);

            return ApexPages.currentPage();
        }

        



        if (merchantReference != null && merchantReference.length() > 0) {
            // Valid params for the result URL back to us after payment. Now check authResult.
            if (authResult == AUTH_RESULT_AUTHORISED) {
                // The user has paid already. We're done. Move on.
                //PageReference pageReference = new PageReference('/apex/confirmation?txId=' + merchantReference); // ab added tx Id
                //pageReference.setRedirect(true);
                //return pageReference;
                initialiseAction();
                submissionMgr.submission.Status__c = 'Paid';
                PageReference nextPage = nextAction();
                nextPage.setRedirect(true);
                //We need to update the status to awaiting submission when the payment is success
                return nextPage;
            }
            else if(authResult == AUTH_RESULT_REFUSED) {
                //Go To refused Payment page ?
            }
            else if(authResult == AUTH_RESULT_PENDING) {
                //Nothing to do?
            }
            else if(authResult == AUTH_RESULT_CANCELLED) {
                initialiseAction();
                PageReference nextPage = previousAction();
                nextPage.setRedirect(true);
                return nextPage;
            }
            else if(authResult == AUTH_RESULT_ERROR) {
                //Reload the current page to do the payment again?
            }

        }
        return null;
    }

    private void persistStep(){
        submissionMgr.persist();    
    }
    // End Instance methods.    
    
    // Action methods.     
    public PageReference nextAction(){ 
        if (!validatePageState()) return Page.TransactionException;
        
        persistStep();      

        return nextStep();      
    }
    
    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }
    // End Action methods.    
    
    
    
    /**
     * Off we go to a SmartPay URL.
     */
    public void submit() {
        // Let's use a transaction ID as the merchant reference on the payment. It's then
        // guaranteed to be unique.
        
        // Get a URL for SmartPay, the payment processor. Whether this is on TEST or LIVE is
        // driven by the active custom setting record.

        //CODE FOR PRODUCTION WHEN Submission manager will be in sync with Transaction Object
        SmartPayUrl url = new SmartPayUrl.Builder()
                .merchantReference(submissionMgr.submission.Id)
                .paymentAmount(submissionMgr.submission.Amount__c)
                .build();
        String redirectUrl = url.toString();
        externalURL = redirectUrl;

        //CSBeginMod: Sylvain Picory 14 April 2016: We don't want to redirect to the payement page anymore
        //PageReference pageReference = new PageReference(redirectUrl);
        //pageReference.setRedirect(true);
        //return pageReference;
        //CSEndMod: Sylvain Picory 14 April 2016
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
    private void parseQueryString() {
        merchantReference = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_MERCHANT_REFERENCE);
        merchantSig = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_MERCHANT_SIG);        
        authResult = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_AUTH_RESULT);
        
    }
    
}