/*
Name:  DeleteTransactionButton.cls
Copyright © 2017  Ribbonfish LTD
======================================================
======================================================
Purpose:
-------

This button will be used to delete the transaction with the related officer
======================================================
======================================================
History
------- 
Ver. Author            Date        Detail
1.0  Sylvain Picory    2017-05-26  Initial draft of code.
*/
public with sharing class DeleteTransactionButton {

	private ApexPages.StandardController standardController;

	public DeleteTransactionButton(ApexPages.StandardController stdController) {
		this.standardController = stdController;
	}

	public Pagereference initButton()
	{
		Id profileID = UserInfo.getProfileId();

		Profile prof = [Select Id, Name From Profile where Id = :profileID];
		
		Id transactionID = standardController.getId();

		if(!prof.Name.equals('System Administrator'))
			return new Pagereference('/' );		

		Transaction__c tTemp = new Transaction__c();
		tTemp.Id = transactionID;
		tTemp.Status__c = 'deleteContact';

		update tTemp;

		delete tTemp;

		return new Pagereference('/' );		
	}	
}