/**
 * Controller for the confirmation page - the very last page in the process. Shows
 * a submission ID and allows the user to download a PDF.
 * 
 * Author: eliot.stock@methods.co.uk
 */
public class ConfirmationController {

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
    
    public Transaction__c tx {get; private set;}

    public Id attachmentId {get; private set;}

    public String title {get; private set;}

    public String size {get; private set;}

    public String todayThreeMonths {get; set;}

    public ConfirmationController(ApexPages.StandardController stdController) {
        parseQueryString();

    	String txId = ApexPages.currentPage().getParameters().get('txId');

        if (merchantReference != null && merchantReference.length() > 0) {
            // Valid params for the result URL back to us after payment. Now check authResult.
            if (authResult == AUTH_RESULT_AUTHORISED) {
                // The user has paid already. We're done. Move on.
                txId = merchantReference;
                //PageReference pageReference = new PageReference('/apex/confirmation?txId=' + merchantReference); // ab added tx Id
                //pageReference.setRedirect(true);
            }
            else {
                // TODO: Do we need to handle authResult values other than AUTHORISED? If the
                // payment failed !!!!!, would the user ever make it back here at all?
                //throw new PaymentException('Payment not authorised.');
            }
        }
        
        
        if (txId == null || txId.length() == 0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
					'No transaction ID on query string.'));
            return;
        }
       	
        // Binary fields cannot be selected in join queries, so we need two queries here.
        try {
    	    tx = [SELECT Id, (SELECT Id,BodyLength, Name FROM Attachments),CompanyName__c,Status__c,SubmissionId__c FROM Transaction__c WHERE Id = :txId];

    	}
        catch (QueryException qe) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
					'No such transaction:' + txId));
            return;
        }

        Transaction__c myTrans = (Transaction__c) stdController.getRecord();
        myTrans = tx;
        
        if (tx.attachments.size() != 1) {
            // This should never happen.
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
					'Transaction should have one and only one attachment. This one ('
					+ txId + ') has ' + tx.attachments.size()));
            return;
        }
        else
        {
        	attachmentId = tx.attachments[0].Id;
        	title = tx.attachments[0].Name;
        	Integer sizeInt = tx.attachments[0].BodyLength;
        	String tempSize = String.valueOf(sizeInt);
            size = tempSize.left(3);
        	//MB
        	if(tempSize.length() >= 9)
        	{	
        		size += 'M';
        	}
        	//KB
        	else if(tempSize.length() >= 6 && tempSize.length() < 9)
        	{	
        		size += 'K';
        	}
        	

        }

        todayThreeMonths = system.today().day() + '-' + system.today().addMonths(3).month() + '-' +  system.today().year();

    }

    public void initTransaction()
    {
        parseQueryString();

        String txId = ApexPages.currentPage().getParameters().get('txId');


        if (merchantReference != null && merchantReference.length() > 0) {
            // Valid params for the result URL back to us after payment. Now check authResult.
            if (authResult == AUTH_RESULT_AUTHORISED) {
                // The user has paid already. We're done. Move on.
                txId = merchantReference;
                //PageReference pageReference = new PageReference('/apex/confirmation?txId=' + merchantReference); // ab added tx Id
                //pageReference.setRedirect(true);
            }
            else {
                // TODO: Do we need to handle authResult values other than AUTHORISED? If the
                // payment failed !!!!!, would the user ever make it back here at all?
                //throw new PaymentException('Payment not authorised.');
            }
        }

        if (txId == null || txId.length() == 0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
                    'No transaction ID on query string.'));
            return;
        }
        
        // Binary fields cannot be selected in join queries, so we need two queries here.
        try {
            tx = [SELECT Id, (SELECT Id,BodyLength, Name FROM Attachments),Status__c,SubmissionId__c,CompanyName__c FROM Transaction__c WHERE Id = :txId];
            if(tx.SubmissionId__c == null)
            {
                Blob b = Crypto.GenerateAESKey(128);
                String h = EncodingUtil.ConvertTohex(b);
                String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
                tx.SubmissionId__c =  guid;
                tx.Status__c = 'Awaiting Submission';
                update tx;
            }
        }
        catch (QueryException qe) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
                    'No such transaction:' + txId));
            return;
        }
        
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