@isTest
private class UserAuthenticationDeletionBatchTest {
    @isTest static void batchTest() {
        User_Authorisation__c testRecord = new User_Authorisation__c();
        testRecord.CreatedDateUnitTest__c = system.today().addDays(-10);
        testRecord.Nonce__c = 'NonceTest';
        insert testRecord;

        User_Authorisation__c testRecord2 = new User_Authorisation__c();
        testRecord2.CreatedDateUnitTest__c = system.today().addDays(-3);
        testRecord2.Nonce__c = 'NonceTest2';
        insert testRecord2;

        Decimal count = (Decimal)[Select count(Id) total From User_Authorisation__c ][0].get('total');

        system.assertEquals(2, count);

        Test.startTest();

        Database.executeBatch(new UserAuthenticationDeletionBatch());

        Test.stopTest();

        count = (Decimal)[Select count(Id) total From User_Authorisation__c ][0].get('total');

        system.assertEquals(1, count);
    }
  
}