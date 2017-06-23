/*
Name:  EmailHelper.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Class that provides methods to send email externaly from SF
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-09-12  Initial development.
*/
public with sharing class EmailHelper {

	public static Messaging.SendEmailResult[] sendSingleEmail(Id contactId, Id templateEmailId){

		if(contactId == null)
		{
			throw new Form_CustomException('You need to specify a contact Id.');
		}
		if(templateEmailId == null)
		{
			throw new Form_CustomException('You need to specify a template Id.');
		}

		// First, reserve email capacity for the current Apex transaction to ensure
		// that we won't exceed our daily email limits when sending email after
		// the current transaction is committed.
		Messaging.reserveSingleEmailCapacity(1);

		// Processes and actions involved in the Apex transaction occur next,
		// which conclude with sending a single email.

		// Now create a new single email message object
		// that will send out a single email to the addresses in the To, CC & BCC list.
		//Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

		mail.setTargetObjectId(contactId);
		mail.setTemplateId(templateEmailId);

		// Send the email you have created.
		return Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}	
}