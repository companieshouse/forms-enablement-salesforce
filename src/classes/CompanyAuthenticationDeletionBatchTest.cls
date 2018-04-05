@isTest
private class CompanyAuthenticationDeletionBatchTest {
    @isTest static void batchTest() {
        Company_Authorisation__c testRecord = new Company_Authorisation__c();
        testRecord.CreatedDateUnitTest__c = system.today().addDays(-10);
        testRecord.Nonce__c = 'NonceTest';
        testRecord.Transaction_Type__c = 'DS91';
        testRecord.Company_Number__c = '19191919';
        insert testRecord;

        Company_Authorisation__c testRecord2 = new Company_Authorisation__c();
        testRecord2.CreatedDateUnitTest__c = system.today().addDays(-3);
        testRecord2.Company_Number__c = '191919192';
        testRecord2.Transaction_Type__c = 'DS91';
        testRecord2.Nonce__c = 'NonceTest2';
        insert testRecord2;

        Decimal count = (Decimal)[Select count(Id) total From Company_Authorisation__c ][0].get('total');

        system.assertEquals(2, count);

        Test.startTest();

        Database.executeBatch(new CompanyAuthenticationDeletionBatch());

        Test.stopTest();

        count = (Decimal)[Select count(Id) total From Company_Authorisation__c ][0].get('total');

        system.assertEquals(1, count);
    }

}
