/**
 * Encapsulates a URL for Barclays SmartPay, our credit card payment provider, to
 * which we forward the user.
 * 
 * To configure SmartPay, use the backend at https://ca-test.barclaycardsmartpay.com. You'll need a
 * username and password from Carl Allen.
 * 
 * Author: eliot.stock@methods.co.uk
 */
public class SmartPayUrl {
    
    @TestVisible
    private static final String ENV_TEST = 'TEST';
    
    @TestVisible
    private static final String ENV_LIVE = 'LIVE';
    
    @TestVisible    
    private static final String URL_TEST = 'https://test.barclaycardsmartpay.com/hpp/pay.shtml';
    
    @TestVisible
    private static final String URL_LIVE = 'https://live.barclaycardsmartpay.com/hpp/pay.shtml';
        
    @TestVisible
    private static final String CURRENCY_CODE = 'GBP';
    
    @TestVisible
    private static final  String COUNTRY_CODE = 'GB';
    

    public String allowedMethods = '';
    
    @TestVisible
    private static final String SHOPPER_LOCALE = 'en_GB';
    
    @TestVisible
    public static final String SKIP_SELECTION = 'true';

    public String merchantReference;
    
    public String paymentAmount;
    
    public String skinCode;
    
    public String merchantAccount;
    
    public String merchantSig;
    
    public String shopperReference;
    
    public String merchantReturnData;
    
    public String resURL;

    public String customerEmail;
    
    public override String toString() {

        // Get this each and every time in case it's changed under us.
        SmartPay_Settings__c settings = getSettings();
        
        Datetime now = Datetime.now();
        Datetime oneDayFromNow = now.addHours(24);
        Datetime oneMonthFromNow = now.addMonths(1);
        
        String url = '';
        
        if (ENV_LIVE.equals(settings.Environment__c)) {
            url += URL_LIVE;
        }
        else if (ENV_TEST.equals(settings.Environment__c)) {
            url += URL_TEST;
        }
        else {
            throw new Form_CustomException('Environment on custom settings record must be LIVE or TEST.');
        }
        
        url += '?';
        url += 'merchantReference=' + merchantReference;
        
        url += '&';
        url += 'paymentAmount=' + paymentAmount;
        
        url += '&';
        url += 'currencyCode=' + CURRENCY_CODE;
        
        url += '&';
        url += 'countryCode=' + COUNTRY_CODE;
        
        url += '&';
        url += 'shopperLocale=' + SHOPPER_LOCALE;
        
        url += '&';
        url += 'allowedMethods=' + allowedMethods;
        
        url += '&';
        url += 'skipSelection=' + SKIP_SELECTION;
        
        // The date by which the goods or services specified in the order must be shipped
	    // or rendered. YYYY-MM-DD format. This can always be a day or so from now.
	    String shipBeforeDate = oneDayFromNow.format('yyyy-MM-dd');
        url += '&';
        url += 'shipBeforeDate=' + shipBeforeDate;
        
		// Skins are collections of configuration in the SmartPay backend.
        skinCode = settings.Skin_Code__c;
        url += '&';
        url += 'skinCode=' + skinCode;
        
        // Companies House has multiple merchant accounts with SmartPay, all under the one
        // company account.
        merchantAccount = settings.Merchant_account__c;
        url += '&';
        url += 'merchantAccount=' + merchantAccount;

        url += '&';
        url += 'merchantReturnData=' + merchantReference;

        url += '&';
        url += 'shopperEmail=' + customerEmail;
        
        // The final time by which a payment needs to have been made. This is especially
        // useful for tickets/reservations, where you want to “lock” the item for sale for
        // only a short time and payments made after this time would lead to extra costs
        // and administrative hassle. YYYY-MM-DDThh:mm:ssTZD format.
        String sessionValidity = oneMonthFromNow.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
        url += '&';
        url += 'sessionValidity=' + sessionValidity;

        // It would be nice to specify the result URL dynamically, so that it's driven by us
        // and not by the skin config in the SmartPay backend, but this doesn't work. SmartPay
        // never sends us here.
        url += '&';     
        url += 'resURL=' + getResultUrl().replace('%', AppConstants.PERCENTAGE_REPLACEMENT);
        
        // We use this to sign the query string parameter values we're sending over.
        String hmacKey = settings.HMAC_key__c;
        
        String signingString = 'allowedMethods:countryCode:currencyCode:merchantAccount:merchantReference:merchantReturnData:paymentAmount:resURL:sessionValidity:shipBeforeDate:shopperEmail:shopperLocale:skinCode:skipSelection:';
        signingString += allowedMethods + ':' + COUNTRY_CODE + ':' + CURRENCY_CODE + ':' + merchantAccount + ':' + merchantReference + ':' + merchantReference + ':' + paymentAmount + ':'  + getResultUrl().replace('\\', '\\\\').replace(':', '\\:').replace('%', AppConstants.PERCENTAGE_REPLACEMENT)  +':' + sessionValidity.replace('\\', '\\\\').replace(':', '\\:') + ':' + shipBeforeDate.replace('\\', '\\\\').replace(':', '\\:') + ':' + customerEmail + ':' + SHOPPER_LOCALE + ':' + skinCode + ':' + SKIP_SELECTION;

        Blob sig = Crypto.generateMac('HmacSHA256', Blob.valueOf(signingString),EncodingUtil.convertFromHex(hmacKey));

        String sigEncoded = EncodingUtil.base64Encode(sig);
        
        
        url += '&';
        url += 'merchantSig=' + sigEncoded.replace('+','%2B');

        return url;
    }
    
    /**
     * Generate the URL to which SmartPay will pass the user back after they've paid. Should be
     * on the same hostname as we are now. No need to URL encode it.
     */
    @TestVisible
    private String getResultUrl() {
        String hostname = ApexPages.currentPage().getHeaders().get('Host');
        String pageUrl = ApexPages.currentPage().getUrl();
        //Here page URL contains Apex/Payment
        pageUrl = pageUrl.substringAfter('/apex');

        pageUrl = pageUrl.substringBefore('?') + '?c=' + EncodingUtil.urlEncode(ApexPages.currentPage().getParameters().get('c'), 'UTF-8') ;

        String url = 'https://' + hostname + pageUrl;
        return url;
    }
    
    // Look for a custom setting record with the details for the SmartPay environment.
	public static SmartPay_Settings__c  getSettings() {
		List<SmartPay_Settings__c > settings = SmartPay_Settings__c.getAll().values();
		
        SmartPay_Settings__c result;

        // Return the first active one found. 
		for (SmartPay_Settings__c s : settings) {
			if (s.Active__c) {
                result = s;
                break;
			}
		}

        return (result == null ? (Test.isRunningTest() ? new SmartPay_Settings__c (Environment__c  = 'TEST',
                    HMAC_key__c  = 'unitTestHmacKey', Merchant_account__c  = 'unitTestMerchantAccount',
                    Active__c = true) : null ) : result);
		
	}
    
    public class Builder {
        
        private SmartPayUrl url;
        
        public Builder() {
            url = new SmartPayUrl();
        }
        
        public Builder merchantReference(String value) {
            url.merchantReference = value;
            return this;
        }
        
        public Builder paymentAmount(Decimal valueInPounds) {
            // We cast this to an Integer number of pence, then store it as a String.
            // Awful but necessary. See:
			//   http://boards.developerforce.com/t5/Apex-Code-Development/Converting-number-fields-to-Integer/td-p/58518

			//Integer valueInPence = Integer.valueOf(String.valueOf(Math.roundToLong(valueInPounds))) * 100;
            Decimal valueInPence =  valueInPounds * 100;
            url.paymentAmount = String.valueOf(valueInPence).substringBefore('.');
            return this;
        }

        public Builder customerEmail(String email)
        {
            url.customerEmail = email;
            return this;
        }

        public Builder customerMethodsPayment(Boolean isPaypal)
        {
            url.allowedMethods = ( isPaypal == true ? 'paypal' : 'card');
            return this;
        }
        
        public SmartPayUrl build() {
            return url;
        }

        
        
    }
    
}