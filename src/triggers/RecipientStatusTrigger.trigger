trigger RecipientStatusTrigger on dsfs__DocuSign_Recipient_Status__c (after update, after insert) {

    if(trigger.isUpdate)
        if(trigger.isAfter)
            RecipientStatusDocusignTriggerHandler.dateSigned(trigger.new);
    
    if(trigger.isInsert)
        if(trigger.isAfter)
            RecipientStatusDocusignTriggerHandler.dateSigned(trigger.new);
    
}