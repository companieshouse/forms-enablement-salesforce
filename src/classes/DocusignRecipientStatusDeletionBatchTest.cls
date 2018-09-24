@isTest(seealldata = false)
private class DocusignRecipientStatusDeletionBatchTest {

	@isTest static void testBatch() {
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();		
		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		insert testCompany;

		Transaction__c transac = testData.tx;
		transac.Form_Name__c = 'DS01';
		transac.Transaction_Type__c = 'DS01';
		transac.Company__c = testCompany.Id;
		transac.CompanyNumber__c = '05448736';
		transac.officerTerminology__c = 'test';

		transac.isDigitalSignatureNeeded__c = true;
		insert transac;

		dsfs__DocuSign_Status__c testData3 = new dsfs__DocuSign_Status__c();
		testData3.Transaction__c = transac.Id;
		insert testData3;

		dsfs__DocuSign_Recipient_Status__c testData33 = new dsfs__DocuSign_Recipient_Status__c();
		testData33.dsfs__DocuSign_Recipient_Id__c = 'doawjdoawj';
		testData33.dsfs__Parent_Status_Record__c = testData3.Id;
		insert testData33;


		Contact con1 = CompaniesHouseTestData.getInstance().contact1;

		insert con1;

		dsfs__DocuSign_Recipient_Status__c testData2 = new dsfs__DocuSign_Recipient_Status__c();
		testData2.dsfs__Contact__c = con1.Id;
		testData2.dsfs__Parent_Status_Record__c = testData3.Id;
		testData2.dsfs__DocuSign_Recipient_Id__c = 'ojdojodjdojdoj';
		insert testData2;

		System.assertEquals(2, [Select Id From dsfs__DocuSign_Recipient_Status__c].size());

		Test.startTest();

		Database.executeBatch(new DocusignRecipientStatusDeletionBatch());

		Test.stopTest();

		System.assertEquals(1, [Select Id From dsfs__DocuSign_Recipient_Status__c].size());
	}

}