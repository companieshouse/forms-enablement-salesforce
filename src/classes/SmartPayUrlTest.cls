/**
 * Author: eliot.stock@methods.digital.co.uk.
 */
@isTest
public with sharing class SmartPayUrlTest {
    
    @isTest
    public static void testGetSettings(){
        Test.startTest();

            SmartPay_Settings__c settings = SmartPayUrl.getSettings();

            system.assertNotEquals(null, settings);
            system.assertEquals('TEST', settings.Environment__c);
            system.assertEquals('F753AB5DF230962A00919ECE6458489E43FF867F6D613A7BDC80B42BCCF4EDC4', settings.HMAC_key__c);
            system.assertEquals('unitTestMerchantAccount', settings.Merchant_account__c);

        Test.stopTest();
    }


    @isTest
    public static void testGetResultUrl(){

        PageReference pg = Page.Payment;
        pg.getParameters().put('c', EncodingUtil.urlDecode('DMFqXZ1DKpZWfHg%2B%2F32FnufP%2BYlEoZ2WrKsL1cEunogIXH4ovhXFbmyg%2BvFpcw054xWEJS5oPbvIXepJZ6x4rlicOUpOsZJjfnmZBVUQMmc%3D', 'UTF-8'));
        Test.setCurrentPage(pg);

        SmartPayUrl smt = new SmartPayUrl();

        Test.startTest();

            String result = smt.getResultUrl();
            system.assertEquals(true, result.contains('?c=DMFqXZ1DKpZWfHg%2B%2F32FnufP%2BYlEoZ2WrKsL1cEunogIXH4ovhXFbmyg%2BvFpcw054xWEJS5oPbvIXepJZ6x4rlicOUpOsZJjfnmZBVUQMmc%3D'));

            system.assertEquals(true, result.contains('/payment?'));

        Test.stopTest();
    }

    @isTest
    public static void testToString()
    {
        PageReference pg = Page.Payment;
        pg.getParameters().put('c', EncodingUtil.urlDecode('DMFqXZ1DKpZWfHg%2B%2F32FnufP%2BYlEoZ2WrKsL1cEunogIXH4ovhXFbmyg%2BvFpcw054xWEJS5oPbvIXepJZ6x4rlicOUpOsZJjfnmZBVUQMmc%3D', 'UTF-8'));
        Test.setCurrentPage(pg);

        SmartPayUrl smt = new SmartPayUrl();

        smt.merchantAccount = 'TestMerchantAccount';
        smt.paymentAmount = '10000';
        smt.customerEmail = 'test@testemail.com';

        Test.startTest();

        String result = smt.toString();

        Test.stopTest();

    }

    @isTest
    public static void testBuilderSmartPayURL()
    {
        SmartPayUrl url = new SmartPayUrl.Builder()
                .merchantReference('WDIHAWIDHAIH')
                .paymentAmount(50)
                .customerEmail('myEmail@jddmdm.com')
                .customerMethodsPayment(false)
                .build();
    }
}