public with sharing class EntryPointController {
	public Boolean showTransactionClearer {
		get;
		set;
	}
	public Boolean showContactClearer {
		get;
		set;
	}
	public Boolean showAccountClearer {
		get;
		set;
	}
	public Decimal transactionssize {
		get;
		set;
	}
	public Decimal accountssize {
		get;
		set;
	}
	public Decimal contactssize {
		get;
		set;
	}
	public String currentError {get; set;}
	public Boolean hasPageErrors {get; set;}
	public EntryPointController() {
	}
	public void findData() {
		List < SObject > someTransactions = new List < SObject > ();
		List < SObject > someContacts = new List < SObject > ();
		List < SObject > someAccounts = new List < SObject > ();
		someAccounts = [select Name from Account];
		someContacts = [select Name from Contact];
		someTransactions = [select Name from Transaction__c];
		if (someTransactions.size() > 0) {
			transactionssize = someTransactions.size();
			showTransactionClearer = true;
		}
		if (someContacts.size() > 0) {
			contactssize = someContacts.size();
			showContactClearer = true;
		}
		if (someAccounts.size() > 0) {
			accountssize = someAccounts.size();
			showAccountClearer = true;
		}
	}
	public PageReference cleanAccounts() {

		try {
			delete[select Name from Contact];
			delete[select Name from Account];
		} catch (DmlException e) {
			currentError = 'DML Error:' + e.getMessage();
			hasPageErrors = true;
			return null;
		} catch (Exception e) {
			currentError = ' Error:' + e.getMessage();
			hasPageErrors = true;
			return null;
		}
		PageReference pg = new PageReference('/entrypoint');
		pg.setRedirect(true);
		return pg;
	}
	public PageReference cleanContacts() {
		try {
			delete[select Name from Contact];
			delete[select Name from Account];
		} catch (DmlException e) {
			currentError = ' DML Error:' + e.getMessage();
			hasPageErrors = true;
			return null;
		} catch (Exception e) {
			currentError = ' Error:' + e.getMessage();
			hasPageErrors = true;
			return null;
		}
		PageReference pg = new PageReference('/entrypoint');
		pg.setRedirect(true);
		return pg;
	}
	public void cleanTransactions() {
		try {
			delete[select Name from Account];
			delete[select Name from Contact];
			delete[select Name from Transaction__c];
		} catch (DmlException e) {
			currentError = ' DML Error:' + e.getMessage();
			hasPageErrors = true;
			//return null;
		} catch (Exception e) {
			currentError = ' Error:' + e.getMessage();
			hasPageErrors = true;
			//return null;
		}
		//PageReference pg = new PageReference('/entrypoint');
		//pg.setRedirect(true);
		//return pg;
	}
}