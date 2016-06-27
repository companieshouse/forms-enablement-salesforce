/**
 * Author: eliot.stock@methods.digital.co.uk.
 */
@isTest
public class SmartPayUrlTest {
    
    @isTest
    public static void testGetSettings(){
        Test.startTest();

            SmartPay_Settings__c settings = SmartPayUrl.getSettings();

            system.assertNotEquals(null, settings);
            system.assertEquals('TEST', settings.Environment__c);
            system.assertEquals('unitTestHmacKey', settings.HMAC_key__c);
            system.assertEquals('unitTestMerchantAccount', settings.Merchant_account__c);

        Test.stopTest();
    }


    @isTest
    public static void testGetResultUrl(){

        PageReference pg = Page.Payment;
        pg.getParameters().put('Test', 'Test');
        Test.setCurrentPage(pg);

        SmartPayUrl smt = new SmartPayUrl();

        Test.startTest();

            String result = smt.getResultUrl();

            system.assertEquals(true, result.contains('?Test=Test'));

            system.assertEquals(true, result.contains('/payment?'));

        Test.stopTest();
    }

    @isTest
    public static void testToString()
    {
        SmartPayUrl smt = new SmartPayUrl();

        smt.merchantAccount = 'TestMerchantAccount';
        smt.paymentAmount = '10000';
        smt.customerEmail = 'test@testemail.com';

        Test.startTest();

        String result = smt.toString();

        Test.stopTest();

    }
}