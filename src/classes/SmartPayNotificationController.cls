/**
 * Handle notifications about changes in state for credit card payments from SmartPay. This
 * should be hosted under a Site, and the URL to this controller under that site configured
 * as the notification URL for the merchant account in the SmartPay backend.
 * 
 * TODO: Question for SmartPay technical support: how do we secure this? You're not passing
 * us a signature, so how do we know it's you calling us?
 * 
 * Example URL under a Site in the Coredev sandbox:
 * 
 * http://coredev-coredev-fe-ch.cs83.force.com/forms/smartpaynotification
 * 
 * Author: eliot.stock@methods.co.uk
 */
public class SmartPayNotificationController {
    
    private static final String DEVELOPER_EMAIL = 'dan.clayton@methodsdigital.co.uk';
    
    // Use this for testing in a browser, or in the unit test.
    public static final String TEST_QUERY_STRING = '?live=false&eventCode=AUTHORISATION&pspReference=foo&originalReference=&merchantReference=a034E000000qs7J&merchantAccountCode=CompaniesHouseECOMM&eventDate=2016-04-01T00:00:00&success=true&paymentMethod=visa&operations=foo&reason=Refused&amount=GBP1000';

	// Notifying if the transaction was put through the Live or Test system.    
    private static final String QUERY_STRING_PARAM_LIVE = 'live';
    private String live;

	// The event type of the notification. For example “AUTHORISATION” for a standard
	// transaction via the HPP.
	private static final String QUERY_STRING_PARAM_EVENT_CODE = 'eventCode';
    private String eventCode;

    // The unique reference created by Barclaycard SmartPay to identify the transaction.
	private static final String QUERY_STRING_PARAM_PSP_REFERENCE = 'pspReference';
    private String pspReference;

	// This is empty unless you are using a modification request to change a previous
	// transaction, where this will contain the reference of the original transaction
	// you have sent the request for.    
	private static final String QUERY_STRING_PARAM_ORIGINAL_REFERENCE = 'originalReference';
    private String originalReference;

	// This reference is assigned by you or your website and passed over with the customer
	// to the payment page and is used to identify the customer and help match the
	// transaction to your order database.
    private static final String QUERY_STRING_PARAM_MERCHANT_REFERENCE = 'merchantReference';
    private String merchantReference;
    
	// The merchant account the payment was processed with.
    private static final String QUERY_STRING_PARAM_MERCHANT_ACCOUNT_CODE = 'merchantAccountCode';
    private String merchantAccountCode;

	// The time the event was generated.    
    private static final String QUERY_STRING_PARAM_EVENT_DATE = 'eventDate';
    private String eventDate;

	// Whether or not the event succeeded (true/false).    
    private static final String QUERY_STRING_PARAM_SUCCESS = 'success';
    private String success;

	// How the transaction was paid for, e.g. Visa.    
    private static final String QUERY_STRING_PARAM_PAYMENT_METHOD = 'paymentMethod';
    private String paymentMethod;
    
	// The operations which can be performed on this transaction.    
    private static final String QUERY_STRING_PARAM_OPERATIONS = 'operations';
    private String operations;

	// Text field which can contain an informational message. Please see below for possible
	// values.
	// - Refused.
	// - FRAUD.
	// - Referral.
	// - 3d-secure: Authentication failed. - REFUSED.
	// - Issuer Unavailable.
	// - Invalid Card Number.
	// - Acquirer Error.
	// - Expired Card.
	// - Transaction not found.
	// - Insufficient balance on payment.
	// - Invalid Amount.
	// - Recurring transaction failed.
	// - Recurring contract already exists.
	// - Blocked Card.
	// - ERROR.
	// - Original transaction no longer open.
	// - Recurring initial payment not available.
	// The format of which is as follows:
	// Reason appears: “97150:1111:12/2012"
	// which is: "AUTH CODE:LAST 4 DIGITS:EXPIRY DATE"   
    private static final String QUERY_STRING_PARAM_REASON = 'reason';
    private String reason;

    // The amount (if relevant) associated with the payment or modification. This consists of
    // a currency and a value which is the amount in minor. In case of HTTP POST notifications
    // you will instead receive currency and value
    private static final String QUERY_STRING_PARAM_AMOUNT = 'amount';
    private String amount;
    
    // Required, since Apex code can't throw the standard Exception class.
    public class SmartPayNotificationException extends Exception {
        
    }
    
    public SmartPayNotificationController() {
        
    }
    
    public PageReference init() {
		parseQueryString();
        
        // Send each and every one of these to a developer in an email until we understand
        // which ones are interesting and deserve status updates on the transaction.
		emailDeveloper();
        
        // We use our own transaction IDs as the merchant reference we pass to SmartPay.
        try {
	        Transaction__c tx = [SELECT Name, Status__c FROM Transaction__c WHERE Id = :merchantReference];
            
            // TODO: Set Approved or Rejected, depending on the value of eventCode and success.
            tx.Status__c = 'Approved';
                
            update tx;
        }
        catch (QueryException e) {
            // TODO: Email an administrator, not the developer.
	        Util.email('SmartPay notification exception',
                       'No such transaction ID: ' + merchantReference + '\n',
                       DEVELOPER_EMAIL);
        }
        
        return null;
    }
    
    private void emailDeveloper() {
        String body = '';
        body += QUERY_STRING_PARAM_LIVE + ': ' + live + '\n';
        body += QUERY_STRING_PARAM_EVENT_CODE + ': ' + eventCode + '\n';
        body += QUERY_STRING_PARAM_PSP_REFERENCE + ': ' + pspReference + '\n';
        body += QUERY_STRING_PARAM_ORIGINAL_REFERENCE + ': ' + originalReference + '\n';
        body += QUERY_STRING_PARAM_MERCHANT_REFERENCE + ': ' + merchantReference + '\n';
        body += QUERY_STRING_PARAM_MERCHANT_ACCOUNT_CODE + ': ' + merchantAccountCode + '\n';
        body += QUERY_STRING_PARAM_EVENT_DATE + ': ' + eventDate + '\n';
        body += QUERY_STRING_PARAM_SUCCESS + ': ' + success + '\n';
        body += QUERY_STRING_PARAM_PAYMENT_METHOD + ': ' + paymentMethod + '\n';
        body += QUERY_STRING_PARAM_OPERATIONS + ': ' + operations + '\n';
        body += QUERY_STRING_PARAM_REASON + ': ' + reason + '\n';
        body += QUERY_STRING_PARAM_AMOUNT + ': ' + amount + '\n';
        
        Util.email('SmartPay notification', body, DEVELOPER_EMAIL);
    }
    
    private void parseQueryString() {
		live = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_LIVE);
		eventCode = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_EVENT_CODE);
		pspReference = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_PSP_REFERENCE);
   		originalReference = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_ORIGINAL_REFERENCE);
   		merchantReference = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_MERCHANT_REFERENCE);
   		merchantAccountCode = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_MERCHANT_ACCOUNT_CODE);
   		eventDate = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_EVENT_DATE);
   		success = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_SUCCESS);
   		paymentMethod = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_PAYMENT_METHOD);
   		operations = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_OPERATIONS);
   		reason = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_REASON);
   		amount = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_AMOUNT);
        
        if (live == null ||
           eventCode == null ||
           pspReference == null ||
           originalReference == null ||
           merchantReference == null ||
           merchantAccountCode == null ||
           eventDate == null ||
           success == null ||
           paymentMethod == null ||
           operations == null ||
           reason == null ||
           amount == null) {
            throw new SmartPayNotificationException('Malformed request. See the code for required query string parameters.');
        }
    }

}