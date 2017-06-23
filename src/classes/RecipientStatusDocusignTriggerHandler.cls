public with sharing class RecipientStatusDocusignTriggerHandler {
	
	public static void dateSigned(List<dsfs__DocuSign_Recipient_Status__c> lObjectsNew ){
		List<Officer__c> lOff = new List<Officer__c>();

		if(lObjectsNew != null)
		{
			//Get the status associated with the recipient
			List<Contact> lContact = new List<Contact>();

			for(dsfs__DocuSign_Recipient_Status__c status :lObjectsNew)
			{
				if(status.dsfs__Contact__c != null)
				{
					if(status.dsfs__Date_Signed__c != null)
						lContact.add(new Contact(Id=status.dsfs__Contact__c, DateSigned__c = status.dsfs__Date_Signed__c));

					if(status.dsfs__Recipient_Status__c != null)
					{
						if(status.dsfs__Recipient_Status__c == 'AutoResponded')
						{
							lContact.add(new Contact(Id=status.dsfs__Contact__c, RecipientStatus__c = status.dsfs__Recipient_Status__c));
						}
					}
				}
			}

			

			
			update lContact;
		}

	}
}