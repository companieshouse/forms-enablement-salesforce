public with sharing class EntryPointController {
	public Boolean showTransactionClearer {
		get;
		set;
	}
	public Decimal transactionssize {
		get;
		set;
	}
	public List<Transaction__c> someTransactions {get; set;}
	public String currentError {get; set;}
	public Boolean hasPageErrors {get; set;}
	public EntryPointController() {
		findData();
	}
	public void findData() {
		List < Transaction__c > someTransactions = new List < Transaction__c > ();
		someTransactions = [select Name from Transaction__c];
		if (someTransactions.size() > 0) {
			transactionssize = someTransactions.size();
			showTransactionClearer = true;
		}
	}

	public PageReference cleanTransactions() {
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
		PageReference pg = new PageReference('/EntryPoint');
		pg.setRedirect(true);
		return pg;
	}
}