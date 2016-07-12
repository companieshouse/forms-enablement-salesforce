/**
 * DocuSign Status Trigger
 *
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/
trigger DocuSignStatusTrigger on dsfs__DocuSign_Status__c (before insert, before update) {

	if (trigger.isUpdate) {

		if (trigger.isBefore)
			DocuSignStatusTriggerHandler.beforeUpdate(trigger.new);
	}
	if (trigger.isInsert) {

		if (trigger.isBefore)
			DocuSignStatusTriggerHandler.beforeUpdate(trigger.new);
	}

}