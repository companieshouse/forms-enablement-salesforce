public with sharing class RecipientStatusDocusignTriggerHandler {
	
	public static void dateSigned(List<dsfs__DocuSign_Recipient_Status__c> lObjectsNew, Map<Id,dsfs__DocuSign_Recipient_Status__c> lObjectsOld ){
		List<Officer__c> lOff = new List<Officer__c>();

		for(dsfs__DocuSign_Recipient_Status__c status :lObjectsNew)
		{
		
			
				if(status.dsfs__Date_Signed__c != null)
				{
					lOff.add(new Officer__c(Id=status.Officer__c, DateSigned__c = status.dsfs__Date_Signed__c));
				}
		}

		update lOff;
	}
}