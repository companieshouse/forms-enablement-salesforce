/*
Name:  transactionCleanup.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Cleanups up expired transactions after Expiry email has been sent.
Note: Transaction is not deleted but rather set as inactive

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy&    2016-10-05  Initial development.
*/

global class TransactionCleanup implements Database.Batchable < sObject > {

    String query = 'SELECT Id,Name, ExpirySEnt__c, InActiveTransaction__c FROM Transaction__C WHERE ExpirySEnt__c = True';


    global TransactionCleanup() {

    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List < Transaction__c > scope) {
        for (Transaction__c a: scope) {
            a.InActiveTransaction__c = true;
        }
        update scope;
    }

    global void finish(Database.BatchableContext BC) {}


}