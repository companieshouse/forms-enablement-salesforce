public with sharing class PersonAccountRecordsDeletionBatch implements Database.Batchable<sObject> {
	public PersonAccountRecordsDeletionBatch() {
		
	}

    String query;
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
               
        //We want to query all the record at once then 
        query = 'SELECT Id, isPersonAccount from Account where isPersonAccount = true And Id Not IN (Select Presenter__c from Transaction__c) And';

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
        Database.executeBatch(new BusinessAccountRecordsDeletionBatch());
    }
}