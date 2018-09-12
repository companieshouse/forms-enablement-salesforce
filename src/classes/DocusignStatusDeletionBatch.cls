public with sharing class DocusignStatusDeletionBatch implements Database.Batchable<sObject> {
	public DocusignStatusDeletionBatch() {
		
	}

    String query;
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
               
        //We want to query all the record at once then 
        query = 'SELECT Id, (SELECT Id FROM Attachments) from dsfs__DocuSign_Status__c where Transaction__c = null';
        
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope) {
        //delete the scope result

		//List of the Attachments to be deleted
        List<Attachment> attachmentsToBeDeleted = new List<Attachment>();

        for(sObject scopeRecord : scope)
        {
            //Cast the record into transaction record
            dsfs__DocuSign_Status__c statusRecord = (dsfs__DocuSign_Status__c) scopeRecord;

            if(statusRecord.Attachments != null && statusRecord.Attachments.size() > 0)
            {
                attachmentsToBeDeleted.addAll(statusRecord.Attachments);
            }
        }

        if(!attachmentsToBeDeleted.isEmpty())
            delete attachmentsToBeDeleted;

        if(!scope.isEmpty())
            delete scope;
    }
    
    public void finish(Database.BatchableContext BC) {
        //Run other batch in the finish
    }
}