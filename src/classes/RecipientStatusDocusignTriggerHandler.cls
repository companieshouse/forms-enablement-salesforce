public with sharing class RecipientStatusDocusignTriggerHandler {
	
	public static void dateSigned(List<dsfs__DocuSign_Recipient_Status__c> lObjectsNew, Map<Id,dsfs__DocuSign_Recipient_Status__c> lObjectsOld ){
		List<Officer__c> lOff = new List<Officer__c>();

		if(lObjectsNew != null)
		{
			//Get the status associated with the recipient
			List<dsfs__DocuSign_Status__c> lStatus = [Select Transaction__c,Id From dsfs__DocuSign_Status__c Where Id = :lObjectsNew[0].dsfs__Parent_Status_Record__c limit 1];
			List<Officer__c> lOfficer = [Select Id, Name From Officer__c Where Transaction__c = :lStatus[0].Transaction__c];
			
			for(Officer__c off: lOfficer)
			{
				for(dsfs__DocuSign_Recipient_Status__c status :lObjectsNew)
				{
					String[] nameSplit = status.Name.split(' ');

					if(off.Name.contains(nameSplit[0]))
						if(status.dsfs__Date_Signed__c != null)
						{
							lOff.add(new Officer__c(Id=off.Id, DateSigned__c = status.dsfs__Date_Signed__c));
						}
				}

			}

			
			update lOff;
		}

	}
}