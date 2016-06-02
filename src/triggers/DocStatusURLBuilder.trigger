/**
 * Status URL builder for multiple Directors flow
 *
 * Author: leo.bitoy@methods.digital.co.uk
 * 
 **/
// updates transaction with DocStatusUrlTriggerHandler
// Builds the status URL field when the multi-director signing process has started
// After this trigger fires a workflow is fired with an email allowing the presenter review the 
// signing status ceremony

trigger DocStatusURLBuilder on Transaction__c (before update) {

	if(trigger.isUpdate){

        if(trigger.isBefore)
            DocStatusUrlTriggerHandler.afterUpdate(trigger.new);
    }
   
}