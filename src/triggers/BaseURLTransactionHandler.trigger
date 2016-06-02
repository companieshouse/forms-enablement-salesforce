trigger BaseURLTransactionHandler on Transaction__c (before update) {


if(trigger.isUpdate){

        if(trigger.isBefore)
            BaseURLHandler.beforeUpdate(trigger.new);
    }
}