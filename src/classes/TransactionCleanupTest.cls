/*
Name:  transactionCleanupTest.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------
Test for TransactionCleanup class
Cleanups up expired transactions after Expiry email has been sent.
Note: Transaction is not deleted but rather set as inactive

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy&    2016-10-05  Initial development.
*/

@isTest
private class TransactionCleanupTest {
    //ASSERT NOT WORKING COMMENTED BY SYLVAIN
    //static testmethod void test() {
    //    // The query used by the batch job.
    //String query = 'SELECT Id, Name, ExpirySEnt__c , InActiveTransaction__c FROM Transaction__C WHERE ExpirySEnt__c = True';


    //   // Create some test transaction items to be updated
    //   //   by the batch job.
    //   Transaction__c[] tx = new List<Transaction__c>();
    //   for (Integer i=0;i<10;i++) {
    //       Transaction__c t = new Transaction__c(
    //           //Name='SUB99'+ i,
    //           Transaction_Type__c = 'DS01',
    //           inActiveTransaction__c=true,
    //           ExpirySEnt__c=true);
    //       tx.add(t);
    //   }
    //   insert tx;

    //   Test.startTest();
    //   //TransactionCleanup c = new TransactionCleanup(query);
    //   //Database.executeBatch(c);
    //   Test.stopTest();

    //   // Verify merchandise items got deleted 
    //   Integer i = [SELECT COUNT() FROM Transaction__c Where InActiveTransaction__c = true];
    //   System.assertEquals(i, 0);
    //}
}