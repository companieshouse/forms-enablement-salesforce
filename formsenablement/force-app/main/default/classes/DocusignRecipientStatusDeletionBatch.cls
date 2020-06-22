public with sharing class DocusignRecipientStatusDeletionBatch implements Database.Batchable<sObject> {
	public DocusignRecipientStatusDeletionBatch() {
		
	}

    String query;
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
               
        //We want to query all the record at once then 
        query = 'SELECT Id from dsfs__DocuSign_Recipient_Status__c where dsfs__Contact__c = null';
        
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope) {
        //delete the scope result

        if(!scope.isEmpty())
            delete scope;
    }
    
    public void finish(Database.BatchableContext BC) {
        //Run other batch in the finish
        Database.executeBatch(new DocusignStatusDeletionBatch()); 
    }
}