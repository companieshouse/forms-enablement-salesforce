/**
 * Test Class for FormAPISubmissionManager
 *
 * Unit Test:
 * - sendForm
 *
 * To Do: 
 * - Improve mock response
 * - asserts
 *
 * Author: antonio.bravo@gollico.co.uk 
 **/
@isTest
public with sharing class FormAPISubmissionManagerTest {
    //Create Data
    //Create Transaction
    static Transaction__c createTransaction() {
        Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
        tx.Status__c = AppConstants.REQUEST_STATUS_PENDING_SUBMISSION;
        insert tx;
        
        return tx;
    }

    //Create Attachment
    static Attachment createAttachment(Id parentId){
        Attachment att = CompaniesHouseTestData.getInstance().pdf;
        att.Name = ' DS01 Test';
        att.ParentId = parentId;
        insert att;

        return att;
    }


    @isTest(seeAllData=false)
    public static void sendFormTest() {
        
        //Create Transaction
        Transaction__c tx = createTransaction();

        //Create Attachment
        Attachment att = createAttachment(tx.Id);


        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMock());
        
        // Going for coverage only at this stage. No assertions.
        FormAPISubmissionManager formApiSM = new FormAPISubmissionManager();
        Transaction__c txResponse = formApiSM.sendForm(tx);
        
        Test.stopTest();

        // To do update mock to return 200 or 202 depending on the endpoint
        //System.assertEquals(AppConstants.REQUEST_STATUS_SUBMITTED, txResponse.Status__c);
    }

    @isTest(seeAllData=false)
    public static void sendPaymentTest() {
        
        //Create Transaction
        Transaction__c tx = createTransaction();

        //Create Attachment
        Attachment att = createAttachment(tx.Id);


        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccess());
        
        // Going for coverage only at this stage. No assertions.
        FormAPISubmissionManager formApiSM = new FormAPISubmissionManager();
        Transaction__c txResponse = formApiSM.updatePayment(tx);
        
        Test.stopTest();

        // To do update mock to return 200 or 202 depending on the endpoint
        //System.assertEquals(AppConstants.REQUEST_STATUS_SUBMITTED, txResponse.Status__c);
    }

    @isTest(seeAllData=false)
    public static void sendFormTest4() {
        
        //Create Transaction
        Transaction__c tx = createTransaction();

        //Create Attachment
        Attachment att = createAttachment(tx.Id);


        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mock202());
        
        // Going for coverage only at this stage. No assertions.
        FormAPISubmissionManager formApiSM = new FormAPISubmissionManager();
        Transaction__c txResponse = formApiSM.sendForm(tx);
        
        Test.stopTest();

        // To do update mock to return 200 or 202 depending on the endpoint
        //System.assertEquals(AppConstants.REQUEST_STATUS_SUBMITTED, txResponse.Status__c);
    }

    @isTest(seeAllData=false)
    public static void sendFormTest2() {
        
        //Create Transaction
        Transaction__c tx = createTransaction();
        tx.Barcode__c = null;
        update tx;
        //Create Attachment
        Attachment att = createAttachment(tx.Id);


        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccess());
        
        // Going for coverage only at this stage. No assertions.
        FormAPISubmissionManager formApiSM = new FormAPISubmissionManager();
        Transaction__c txResponse = formApiSM.sendForm(tx);
        
        Test.stopTest();

        // To do update mock to return 200 or 202 depending on the endpoint
        //System.assertEquals(AppConstants.REQUEST_STATUS_SUBMITTED, txResponse.Status__c);
    }

    @isTest(seeAllData=false)
    public static void sendFormTest3() {
        
        //Create Transaction
        Transaction__c tx = createTransaction();
        tx.Barcode__c = null;
        update tx;
        //Create Attachment
        Attachment att = createAttachment(tx.Id);


        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockError());
        
        // Going for coverage only at this stage. No assertions.
        FormAPISubmissionManager formApiSM = new FormAPISubmissionManager();
        Transaction__c txResponse = formApiSM.sendForm(tx);
        
        Test.stopTest();

        // To do update mock to return 200 or 202 depending on the endpoint
        //System.assertEquals(AppConstants.REQUEST_STATUS_SUBMITTED, txResponse.Status__c);
    }

    @isTest(seeAllData=false)
    public static void sendPaymentErrorTest() {
        
        //Create Transaction
        Transaction__c tx = createTransaction();

        //Create Attachment
        Attachment att = createAttachment(tx.Id);


        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockError());
        
        // Going for coverage only at this stage. No assertions.
        FormAPISubmissionManager formApiSM = new FormAPISubmissionManager();
        Transaction__c txResponse = formApiSM.updatePayment(tx);
        
        Test.stopTest();

        // To do update mock to return 200 or 202 depending on the endpoint
        //System.assertEquals(AppConstants.REQUEST_STATUS_SUBMITTED, txResponse.Status__c);
    }

    @isTest static void addIntegrationLogTest()
    {
        Transaction__c tx = createTransaction();
        tx.AmendmentHistory__c = '';
        update tx;
        
        FormAPISubmissionManager sub = new FormAPISubmissionManager();
        Test.startTest();
        system.assertEquals(false, tx.AmendmentHistory__c.contains('Failed'));

        tx = sub.addIntegrationLog('Failed', tx);

        update tx;

        system.assertEquals(true, tx.AmendmentHistory__c.contains('Failed'));
        system.assertEquals(false, tx.AmendmentHistory__c.contains('Success'));

        tx = sub.addIntegrationLog('Success', tx); 

        update tx;

        system.assertEquals(true, tx.AmendmentHistory__c.contains('Success'));
    }
}