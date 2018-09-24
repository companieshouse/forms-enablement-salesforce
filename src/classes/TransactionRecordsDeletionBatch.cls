/*
Name:  TransactionRecordsDeletionBatch.cls
Copyright © 2017  Ribbonfish LTD
======================================================
======================================================
Purpose:
-------

This batch will delete any old transaction and all associated records
It will use the custom setting RetentionSettings__c, if the custom settings do not exist then the default value of 12 months will be applied

======================================================
======================================================
History
------- 
Ver. Author            Date        Detail
1.0  Sylvain Picory    2017-05-26  Initial draft of code.
*/
public with sharing class TransactionRecordsDeletionBatch implements Database.Batchable<sObject> {
	
    public TransactionRecordsDeletionBatch() {
		
	}

    String query;
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
               
        //Default value hardcoded
        Integer period = 12;

        RetentionSettings__c basePeriod = RetentionSettings__c.getOrgDefaults();

        if(basePeriod != null && basePeriod.RetentionPeriodMonths__c != null)
        {
            Integer customSettingPeriod = Integer.valueOf(basePeriod.RetentionPeriodMonths__c);
            period = ((customSettingPeriod >= 1 && customSettingPeriod <= 12) ? customSettingPeriod : period);
        }

        Datetime targetDate = System.today().addMonths(-period);

        String whereCondition = ' CreatedDate <= :targetDate';
        //We want to query all the record at once then 
        query = 'SELECT Id, (SELECT Id FROM DocuSign_Status__r), (SELECT Id FROM Attachments),  (SELECT Id FROM Contacts__r) FROM Transaction__c Where ExpirySEnt__c = true AND ';

        if(Test.isRunningTest())
        {
            whereCondition = ' CreatedDateUnitTest__c <= :targetDate';
        }

        query = query + whereCondition;

        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope) {
        //delete the scope result
        
        //List of the transaction to be deleted
        List<Transaction__c> transactionToBeDeleted = new List<Transaction__c>();

        //List of the Docusign Records to be deleted
        List<dsfs__DocuSign_Status__c> docusignToBeDeleted = new List<dsfs__DocuSign_Status__c>();

        //List of the Attachments to be deleted
        List<Attachment> attachmentsToBeDeleted = new List<Attachment>();

        //List of Contacts to be deleted
        List<Contact> contactsToBeDeleted = new List<Contact>();

        for(sObject scopeRecord : scope)
        {
            //Cast the record into transaction record
            Transaction__c transactionRecord = (Transaction__c) scopeRecord;

            if(transactionRecord.DocuSign_Status__r != null && transactionRecord.DocuSign_Status__r.size() > 0)
            {
                docusignToBeDeleted.addAll(transactionRecord.DocuSign_Status__r);
            }

            if(transactionRecord.Attachments != null && transactionRecord.Attachments.size() > 0)
            {
                attachmentsToBeDeleted.addAll(transactionRecord.Attachments);
            }

            if(transactionRecord.Contacts__r != null && transactionRecord.Contacts__r.size() > 0)
            {
                contactsToBeDeleted.addAll(transactionRecord.Contacts__r);
            }

            transactionToBeDeleted.add(transactionRecord);
        }

        if(!docusignToBeDeleted.isEmpty())
            delete docusignToBeDeleted;

        if(!attachmentsToBeDeleted.isEmpty())
            delete attachmentsToBeDeleted;

        if(!contactsToBeDeleted.isEmpty())
            delete contactsToBeDeleted;

        if(!transactionToBeDeleted.isEmpty())
            delete transactionToBeDeleted;
    }
    
    public void finish(Database.BatchableContext BC) {
        //Run other batch in the finish
        Database.executeBatch(new PersonAccountRecordsDeletionBatch());
    }
}