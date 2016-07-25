/*
Name:  FormsAPIServiceTest.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Test for FormsAPIService

Unit tests:
- updateTransactionApprovedTest - when a transaction
is approved

- updateTransactionRejectedTest - when a transaction
is rejected

- updateTransactionExceptionTest - when there is an 
exception updating the transaction record

======================================================
======================================================
History
------- 
Ver. Author         Date        Detail
1.0  Antonio Bravo  2016-01-02  Initial development.
*/

@isTest
public class FormsAPIServiceTest {

    //private static String CHIPS_APPROVED = AppConstants.CHIPS_APPROVED;
    //private static String CHIPS_REJECTED = AppConstants.CHIPS_REJECTED;
    //private static String SUCCESS_STATUS = AppConstants.SUCCESS_STATUS;
    //private static String ERROR_STATUS = AppConstants.ERROR_STATUS;
    //private static String TX_DRAFT = AppConstants.REQUEST_STATUS_DRAFT;
    //private static String TX_APPROVED = AppConstants.REQUEST_STATUS_APPROVED;
    //private static String TX_REJECTED = AppConstants.REQUEST_STATUS_REJECTED;

    //private static String BARCODE = 'X100';

    ////Create Data
    ////Create Transaction
    //static Transaction__c createTransaction() {
    //    Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
    //    tx.Status__c = 'Draft';
    //    tx.Barcode__c = BARCODE;
    //    insert tx;
        
    //    return tx;
    //}

    ////Create Reason
    //static FormsAPIService.Reason createReason() {
    //    FormsAPIService.Reason r = new FormsAPIService.Reason();
    //    r.textEnglish = 'You have not shown the existing class of share(s).';
    //    return r;
    //} 
    

    //static Transaction__c queryTransaction(String txId){
    //    return [Select Id, Status__c
    //            from Transaction__c where Id=:txId];
    //}


    //@isTest(seeAllData=false)
    //static void updateTransactionApprovedTest() {
        
    //    //Create Transaction
    //    Transaction__c tx = createTransaction();

    //    test.startTest();

    //    //To do: Do we need to declare RestRequest and RestResponse?

    //    //RestRequest req = new RestRequest(); 
    //    //RestResponse res = new RestResponse();

    //    //req.requestURI = 'https://test.salesforce.com/services/apexrest/FormsAPIService';
    //    //req.httpMethod = 'POST';
    //    ////req.addHeader('firstname','Wain','lastname','Rolen');
        
    //    //RestContext.request = req;
    //    //RestContext.response = res;
        
    //    FormsAPIService.StatusReply results = FormsAPIService.updateTransaction(BARCODE, '', CHIPS_APPROVED, null);
 
    //    test.stopTest();

    //    //Validate
    //    //check if webservice returns Success
    //    System.assertEquals(SUCCESS_STATUS, results.status);
    //    //check if transaction was updated with Success
    //    Transaction__c txTemp = queryTransaction(tx.Id);
    //    System.assertEquals(TX_APPROVED, txTemp.Status__c);


    //}

    //@isTest(seeAllData=false)
    //static void updateTransactionRejectedTest() {
    //    List<FormsAPIService.Reason> rejectReasons = new List<FormsAPIService.Reason>();
        
    //    //Create Transaction
    //    Transaction__c tx = createTransaction();

    //    //Create Reason
    //    rejectReasons.add(createReason());


    //    test.startTest();
    
    //    FormsAPIService.StatusReply results = FormsAPIService.updateTransaction(BARCODE, '', CHIPS_REJECTED, rejectReasons);
 
    //    test.stopTest();

    //    //Validate
    //    //check if webservice returns Success
    //    System.assertEquals(SUCCESS_STATUS, results.status);
    //    //check if transaction was updated with Rejected
    //    Transaction__c txTemp = queryTransaction(tx.Id);
    //    System.assertEquals(TX_REJECTED, txTemp.Status__c);

    //}

    //@isTest(seeAllData=false)
    //static void updateTransactionNotFoundTest() {
    //    string wrongbarcode = 'WrongBarcode';
        
    //    //Create Transaction
    //    Transaction__c tx = createTransaction();


    //    test.startTest();
 
    //    FormsAPIService.StatusReply results = FormsAPIService.updateTransaction(wrongbarcode, '', CHIPS_APPROVED, null);
 
    //    test.stopTest();

    //    //Validate
    //    //check if webservice returns Success
    //    System.assertEquals(ERROR_STATUS, results.status);
    //    //check if transaction was updated with Rejected
    //    Transaction__c txTemp = queryTransaction(tx.Id);
    //    System.assertEquals(TX_DRAFT, txTemp.Status__c);

    //}

    //@isTest(seeAllData=false)
    //static void updateTransactionUnknownStatusTest() {
    //    String unknownStatus = '2';
        
    //    //Create Transaction
    //    Transaction__c tx = createTransaction();


    //    test.startTest();
 
    //    FormsAPIService.StatusReply results = FormsAPIService.updateTransaction(BARCODE, '', unknownStatus, null);
 
    //    test.stopTest();

    //    //Validate
    //    //check if webservice returns Success
    //    System.assertEquals(ERROR_STATUS, results.status);
    //    //check if transaction was updated with Rejected
    //    Transaction__c txTemp = queryTransaction(tx.Id);
    //    System.assertEquals(TX_DRAFT, txTemp.Status__c);

    //}

    //@isTest(seeAllData=false)
    //static void updateTransactionExceptionTest() {
    //    List<FormsAPIService.Reason> rejectReasons = new List<FormsAPIService.Reason>();
        
    //    //Create Transaction
    //    Transaction__c tx = createTransaction();

    //    //Create Reason
    //    //This contains more than 255 characters
    //    for(Integer i=0; i < 6; i++){
    //        rejectReasons.add(createReason());
    //    }
        

    //    test.startTest();

    //    FormsAPIService.StatusReply results = FormsAPIService.updateTransaction(BARCODE, '', CHIPS_REJECTED, rejectReasons);
 
    //    test.stopTest();

    //    //Validate
    //    //check if webservice returns Error
    //    System.assertEquals(ERROR_STATUS, results.status);
    //    //check if transaction was not updated
    //    Transaction__c txTemp = queryTransaction(tx.Id);
    //    System.assertEquals(TX_DRAFT, txTemp.Status__c);
        

    //}

}