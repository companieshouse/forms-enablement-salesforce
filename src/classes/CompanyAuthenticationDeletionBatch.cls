/*
Name:  CompanyAuthenticationDeletionBatch.cls
Copyright © 2017  Ribbonfish LTD
======================================================
======================================================
Purpose:
-------

This batch will delete any Company_Authorisation__c records older than 7 days

======================================================
======================================================
History
-------
Ver. Author            Date        Detail
1.0  Sylvain Picory    2017-05-26  Initial draft of code.
*/
public with sharing class CompanyAuthenticationDeletionBatch implements Database.Batchable<sObject> {
    public CompanyAuthenticationDeletionBatch() {

    }

    String query;

    public Database.QueryLocator start(Database.BatchableContext BC) {

        //Default value hardcoded
        Integer period = 7;

        Datetime targetDate = System.today().addDays(-period);

        String whereCondition = ' CreatedDate <= :targetDate';
        //We want to query all the record at once then
        query = 'SELECT Id FROM Company_Authorisation__c Where ';

        if(Test.isRunningTest())
        {
            whereCondition = ' CreatedDateUnitTest__c <= :targetDate';
        }

        query = query + whereCondition;

        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope) {
        //delete the scope result

        if(!scope.isEmpty())
            delete scope;
    }

    public void finish(Database.BatchableContext BC) {
    }
}
