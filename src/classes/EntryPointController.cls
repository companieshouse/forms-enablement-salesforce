public with sharing class EntryPointController {
	public EntryPointController() {

	}

	public void cleanTransactions() {

		Delete[Select ID from Transaction__c];

	}
}