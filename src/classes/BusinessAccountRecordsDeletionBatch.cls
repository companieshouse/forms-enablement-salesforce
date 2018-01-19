public with sharing class BusinessAccountRecordsDeletionBatch implements Database.Batchable<sObject> {
	public BusinessAccountRecordsDeletionBatch() {
		
	}

    String query;
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
               
        query = 'SELECT Id, isPersonAccount from Account where isPersonAccount = false And Id Not IN (Select Company__c from Transaction__c) And';

        String whereCondition = ' CreatedDate != TODAY';

        if(Test.isRunningTest())
        {
            whereCondition = ' CreatedDateUnitTest__c != TODAY';
        }

        query += whereCondition;

        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope) {
        //delete the scope result

        if(!scope.isEmpty())
            delete scope;
    }
    
    public void finish(Database.BatchableContext BC) {
        //Run other batch in the finish
    }
}