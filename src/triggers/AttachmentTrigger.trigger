/**
 * Attachment Trigger
 *
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/
trigger AttachmentTrigger on Attachment (before insert) {
	
	if(trigger.isInsert){

		if(trigger.isBefore)
			AttachmentTriggerHandler.beforeInsert(trigger.new);
	}
	
}