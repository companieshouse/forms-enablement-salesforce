/*
Name:  SendSFEmailToPresenterController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller for the page SendSFEmailToPresenter
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-09-12  Initial development.
*/
public with sharing class SendSFEmailToPresenterController {
	
	public List<SelectOption> templateList {get; set;}
	public Id selectedTemplate {get; set;}
	public String htmlTemplate {get; set;}
	public Account presenter {get; set;}
	public Boolean errors {get; set;}
	public String transactionId {get; set;}
	public Transaction__c clickTransaction {get; set;}
	public Boolean resultTab {get; set;}
	public Boolean success {get; set;}
	public String reasonErrors {get; set;}
	public Boolean errorsPreview {get; set;}
	public transient Messaging.SingleEmailMessage email {get; set;}
	public Contact ct {get; set;}

	public SendSFEmailToPresenterController() {
		errors = false;
		resultTab = false;
		success = false;
		errorsPreview = false;
		reasonErrors = '';

		//Get the transaction id
		if(!ApexPages.currentPage().getParameters().containsKey('id'))
		{
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: You must call this page within the transaction using the button please.');
            ApexPages.addMessage(myMsg);
            errors = true;
            return;
		}

		//Extract the id and get the presenter inside the transaction if no presenter = error
		transactionId = ApexPages.currentPage().getParameters().get('id');

		//Query
		List<Transaction__c> clickTransactionList = [Select Id,Company__c, CompanyName__c, PresenterName__c, Presenter__c, Presenter__r.PersonEmail, Presenter__r.Name from Transaction__c where Id = :transactionId];

		if(clickTransactionList == null || clickTransactionList.size() == 0)
		{
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: The parameter is wrong.');
            ApexPages.addMessage(myMsg);
            errors = true;
            return;
		}

		clickTransaction = clickTransactionList[0];

		if(clickTransaction.Presenter__c == null)
		{
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: The transaction do not have any presenter associated, you cannot send emails.');
            ApexPages.addMessage(myMsg);
            errors = true;
            return;
		}

		presenter = clickTransaction.Presenter__r;

		//Init the list
		templateList = new List<SelectOption>();

		htmlTemplate = '';

		//Get the list of template
		List<EmailTemplate> templateCHS = new List<EmailTemplate>();

		templateCHS = [Select Name, Subject,Body, HtmlValue, Id, TemplateType, Description From EmailTemplate];

		//Add it to the picklist on the page
		for(EmailTemplate emTemp :templateCHS)
		{
			templateList.add(new SelectOption(emTemp.Id, emTemp.Name));
			//Select the first template
			if(selectedTemplate == null)
				selectedTemplate = emTemp.Id;
		}

	}

	public PageReference initPreview()
	{
		return refreshTemplate();
	}

	public PageReference refreshTemplate()
	{
		errorsPreview = false;

		if(selectedTemplate == null)
			return null;

		//We need to convert the presenter from PersonAccount to Contact !!!	
		ct = convertPersonAccountToContact(presenter);

		htmlTemplate = [Select Body, HtmlValue From EmailTemplate Where ID = :selectedTemplate].HtmlValue;

		List<String> emailsTemplate = new List<String>();
		emailsTemplate.add(htmlTemplate);

		List<Messaging.RenderEmailTemplateBodyResult> result = Messaging.renderEmailTemplate(ct.Id, clickTransaction.Id, emailsTemplate);

		for(Messaging.RenderEmailTemplateBodyResult bodyRes :result)
		{
			if(bodyRes.getSuccess())
			{
				htmlTemplate = bodyRes.getMergedBody();
				return null;
			}
			else{
				ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: There has been an error while generating the preview. You are trying to send an email that has not yet been issued by the system.');
	            ApexPages.addMessage(myMsg);
	            errorsPreview = true;
	            return null;
			}
		}

		return null;

	}

	public PageReference sendEmail(){

		if(email == null)
		{
			email = new Messaging.SingleEmailMessage();
		}

		email.setTemplateId(selectedTemplate);

		system.debug('ID' + ct);

		email.setTargetObjectId(ct.Id);

		email.setWhatId(clickTransaction.Id);

		//Display the result tab
		resultTab = true;

		List<Messaging.SingleEmailMessage>  emails = new List<Messaging.SingleEmailMessage>();

		emails.add(email);

		Messaging.SendEmailResult[] result = Messaging.sendEmail(emails);

		for(Messaging.SendEmailResult res :result)
		{
			if(res.isSuccess())
			{
				success = true;
				return null;
			}
			else{
				Messaging.SendEmailError[] errors = res.getErrors();

				for(Messaging.SendEmailError error:errors)
				{
					reasonErrors = 'The reason of the error is: ' + error.getMessage() + ' might be affected by the following fields: ' + error.getFields() + ' and the final status code is: ' + error.getStatusCode();
					success = false;
					return null;
				}
			}
		}

		return null;
	}

	public Contact convertPersonAccountToContact(Account account)
	{
		if(account == null) return null;

		List<Contact> contactList = new List<Contact>();

		//Check if a contact with the email and name exist (if name is not null)
		if(clickTransaction.PresenterName__c == null)
		{
			contactList = [Select Id, Email, Name From Contact Where Email = :account.PersonEmail and Transaction__c = :clickTransaction.Id];
		}
		else{
			contactList = [Select Id, Email, Name From Contact Where Email = :account.PersonEmail And Name = :clickTransaction.PresenterName__c and Transaction__c = :clickTransaction.Id];			
		}

		if(contactList.size() == 0)
		{
			ct = new Contact();
			ct.AccountId = clickTransaction.Company__c;
			ct.LastName = clickTransaction.PresenterName__c == null ? account.Name : clickTransaction.PresenterName__c;
			ct.Email = account.PersonEmail;
			ct.Transaction__c = clickTransaction.Id;
			insert ct;
		}
		else{
			//we take the first one... should be only one officer..
			ct = contactList[0];
		}
		

		return ct;
	}
}