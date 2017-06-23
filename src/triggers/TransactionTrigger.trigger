trigger TransactionTrigger on Transaction__c (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {

		if (Trigger.isBefore) {
	    	//call your handler.before method
	    	if(trigger.isUpdate){
	    		TransactionTriggerHandler.beforeUpdate(trigger.new);
	    	}
	    
		} else if (Trigger.isAfter) {
	    	//call handler.after method
	    	if(trigger.isUpdate)
	    	{
	    		TransactionTriggerHandler.afterUpdate(trigger.new);
	    	}
		}
}