/**
 * Review Redirect URL for multiple Directors
 *
 * Author: leo.bitoy@methods.digital.co.uk
 * 
 **/
// updates transaction with ReviewNotiicationTriggerHandler
// Builds the Review URL field when the multi-director signing process has been successful
// After this trigger a workflow is fired off with an email allowing the user to review their status
// and continue the process.
trigger ReviewStatusTrigger on Transaction__c (after insert, after update) {

if(trigger.isUpdate){

        if(trigger.isAfter)
            ReviewNotificationTriggerHandler.afterUpdateandafterInsert(trigger.new);
    }
    
if(trigger.isInsert){

        if(trigger.isAfter)
            ReviewNotificationTriggerHandler.afterUpdateandafterInsert(trigger.new);
    }
}