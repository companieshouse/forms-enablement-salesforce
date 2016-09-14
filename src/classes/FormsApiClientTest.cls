/**
 * Test Class for FormsApiClient
 *
 * Unit Test:
 * - request Barcode
 * - send Package
 *
 * To Do: 
 * - 
 *
 * Author: eliot.stock@methods.digital.co.uk.
 * 
 * Update 11/04/2016 
 * Author: antonio.bravo@gollico.co.uk 
 **/
@isTest
public with sharing class FormsApiClientTest {
    //Create Data
    //Create Transaction
    static Transaction__c createTransaction() {
        Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
        tx.Status__c = 'Draft';
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
    public static void sendPackageTest() {
        
        //Create Transaction
        Transaction__c tx = createTransaction();

        //Create Attachment
        Attachment att = createAttachment(tx.Id);


        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMock());
        
        // Going for coverage only at this stage. No assertions.
        //In the future sendForm() will receive a package
        FormsApiClient client = new FormsApiClient();
        HTTPResponse response = client.sendForm(tx);
        
        Test.stopTest();
    }
    
    @isTest(seeAllData=false)
    public static void requestBarcodeTest() {

        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMock());
        
        // Going for coverage only at this stage. No assertions.
        FormsApiClient client = new FormsApiClient();
        HTTPResponse response = client.requestBarcode();
        
        Test.stopTest();
    }

    @isTest(seeAllData=false)
    public static void getJsonPackageNoPresenterTest() {

        String expectedJson = '{ "packageIdentifier": "12345","count": 1 }';

        Test.startTest();
        
        FormsApiClient client = new FormsApiClient();
        String jsonPackage = client.getJsonPackage('12345', 1, null, null);
        
        System.assertEquals(expectedJson, jsonPackage);

        Test.stopTest();
    } 

    @isTest(seeAllData=false)
    public static void getJsonPackageWithPresenterTest() {

        String expectedJson = '{ "packageIdentifier": "12345","count": 1,"presenterId": "01234567891","presenterAuth": "01234567891x" }';

        Test.startTest();
        
        FormsApiClient client = new FormsApiClient();
        String jsonPackage = client.getJsonPackage('12345', 1, '01234567891', '01234567891x');
        
        System.assertEquals(expectedJson, jsonPackage);

        Test.stopTest();
    }  

}