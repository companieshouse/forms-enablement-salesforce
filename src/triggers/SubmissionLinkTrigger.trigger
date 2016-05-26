/**
 * Review Redirect URL for Download Links after submission 
 *
 * Author: leo.bitoy@methods.digital.co.uk
 * 
 **/
trigger SubmissionLinkTrigger on Transaction__c ( before update) {

	if(trigger.isUpdate){

        if(trigger.isBefore)
            SubmissionURLTriggerHandler.afterUpdateandafterInsert(trigger.new);
    }
}