/**
 * Controller for the redirection to the payment page at SmartPay. Also handles the
 * redirect back to us following payment.
 * 
 * Author: eliot.stock@methods.co.uk
 */
public class PaymentController {

    private static final String QUERY_STRING_PARAM_TX_ID = 'txId'; 
    
    private String txId;
    
    private Transaction__c tx;

    public String externalURL {get; set;}
    
    // Required, since Apex code can't throw the standard Exception class.
    public class PaymentException extends Exception {
        
    }

    public PaymentController() {
        init();
    }
    
    public void init() {
        txId = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_TX_ID);


        if (txId != null && txId.length() > 0) {
            // New payment for this transaction.

            try {
	            tx = [SELECT Amount__c FROM Transaction__c WHERE Id =:txId];
                
                // Stay here and present a button that goes off to our SmartPay URL.
                //return null;
                submit(); //ab change
            }
            catch (QueryException e) {
                throw new PaymentException('No such transaction: ' + txId);
            }           
        }
        else {
            // No params. Wrong.
			throw new PaymentException('Malformed request. We expect either a transaction ID, or some payment parameters.');
        }
    }
    
    
    
    /**
     * Off we go to a SmartPay URL.
     */
    public void submit() {
        // Let's use a transaction ID as the merchant reference on the payment. It's then
        // guaranteed to be unique.
        
        // Get a URL for SmartPay, the payment processor. Whether this is on TEST or LIVE is
        // driven by the active custom setting record.
		SmartPayUrl url = new SmartPayUrl.Builder()
            	.merchantReference(tx.Id)
            	.paymentAmount(tx.Amount__c)
            	.build();
        String redirectUrl = url.toString();
        externalURL = redirectUrl;
        //CSBeginMod: Sylvain Picory 14 April 2016: We don't want to redirect to the payement page anymore
        //PageReference pageReference = new PageReference(redirectUrl);
        //pageReference.setRedirect(true);
        //return pageReference;
        //CSEndMod: Sylvain Picory 14 April 2016
    }
    
}