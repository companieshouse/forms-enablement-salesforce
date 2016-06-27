/**
 * Attachements Trigger Handler
 *
 * Update Attachement Parent Id when Parent is a DocuSign Status
 *
 * Author: antonio.bravo@golligo.co.uk
 * Edited: sylvain.picory@methodsdigital.co.uk (READ COMMENTS)
 * ab
 **/
 public class AttachmentTriggerHandler {

 	//Static Prefix name for Attachement created from DocuSign
 	//public static final String ATTPREFIXNAME = 'Transaction'; Not Needed anymore as per CSBeginMod Sylvain Picory 07 April 2016 


    //Method used to get the transaction from the DocuSignStatus from the attachment List
    public static void beforeInsert(List<Attachment> newList){
    	Set<Id> uniqueDocuSignIds = new Set<Id>();

    	String recordIdPrefix = getDocuSignSettings().RecordIdPrefix__c;

    	List<Attachment> attToUpdate = new List<Attachment>(); //This list contains form document and other docs sent back by docusign
    	
    	for(Attachment att : newList)
    	{
    		if(((String)att.ParentId).startsWith(recordIdPrefix))
    		{
    			uniqueDocuSignIds.add(att.ParentId);
    			attToUpdate.add(att);
    		}
    	}

    	Map<Id, dsfs__DocuSign_Status__c> dsStatusMap = new Map<Id, dsfs__DocuSign_Status__c> ([Select Id, Transaction__c, Transaction__r.Form_Name__c from dsfs__DocuSign_Status__c where Id IN :uniqueDocuSignIds]);

    	for(Attachment att:attToUpdate)
    	{
    		//Get the corresponding DocuSignStatus starting with Transaction Form Name
    		dsfs__DocuSign_Status__c dss = dsStatusMap.get(att.ParentId);

    		if(att.Name.startsWith(dss.Transaction__r.Form_Name__c))
    		{
    			if(dss.Transaction__c != null)
    			{
					att.ParentId = dss.Transaction__c; 
    			}
    		}
    	}
    }


 //CSBeginMod Sylvain Picory 07 April 2016: This version of the class use the static 
 //ATTPREFIXNAME Where we need to get this from the transanction before moving the attachment
 //	public static void beforeInsert(List<Attachment> newList){
 		
 //		String parentIdString;
 //		dsfs__DocuSign_Status__c dss; 
 //		Set<Id> dsStatusIds = new Set<Id>();
 //		List<Attachment> attToUpdate = new List<Attachment>();
 //		Map<Id, dsfs__DocuSign_Status__c> dsStatusMap;

 //		String recordIdPrefix = dsSetting.RecordIdPrefix__c;


 //		//Get Parent Ids from attachements that:
 //		// - represent a Transaction (in pdf)
 //		// - are linked with DocuSignStatus record, prefix  
 //		for(Attachment att : newList) {
 //			parentIdString = (String)att.ParentId;
 //			if(att.Name.startsWith(ATTPREFIXNAME) && parentIdString.startsWith(recordIdPrefix)){
 //				dsStatusIds.add(att.ParentId);
 //				attToUpdate.add(att);
 //			}
 //		}

 //		// DocuSign is only adding one Transaction attachement when completed.
 //		// If this change query need to change 
 //		dsStatusMap = new Map<Id, dsfs__DocuSign_Status__c> ([Select Id, Transaction__c 
 //																from dsfs__DocuSign_Status__c 
 //																where Id IN :dsStatusIds]);


 //		//Update Attachment ParentId when DocuSign Status record is linked with a Transacation record
 //		for(Attachment att : attToUpdate) {
 //			dss = dsStatusMap.get(att.ParentId);

 //			if(dss.Transaction__c != null)
 //				att.ParentId = dss.Transaction__c; 
 //		}
 //}
 //CSEndMod Sylvain Picory 07 April 2016
 
 	// Look for a custom setting record with the URL, username and password for the DocuSign server.
	public static DocuSignSetting__c getDocuSignSettings() {
		List<DocuSignSetting__c> dsSettingsList = DocuSignSetting__c.getAll().values();
		
        // Return the first active one found.
		for (DocuSignSetting__c dsSett : dsSettingsList) {
			if (dsSett.Active__c) {
				return dsSett;
			}
		}
		
		// Unit tests should not rely on custom settings records.
		if (Test.isRunningTest()) {
			String dsPrefix = dsfs__DocuSign_Status__c.sobjecttype.getDescribe().getKeyPrefix();

			DocuSignSetting__c dsSettTest = new DocuSignSetting__c(Name = 'DocuSign Test Settings',
													Username__c 		= 'unitTestUsername', 
													Password__c 		= 'unitTestPassword',
													AccountId__c 		= 'unitTestAccountId',
													IntegratorKey__c 	= 'unitTestIntegratorKey',
													URL__c 				= 'unitTestURL',
													RecordIdPrefix__c 	= dsPrefix,
													Active__c 			= true);
			return dsSettTest;
		}
		
		System.debug(LoggingLevel.ERROR, 'No active DocuSignSetting records exist under Custom'
                     + ' Settings. Can\'t connect to DocuSign.');
		return null;
	}
}