@isTest(seealldata = false)
private class DocusignStatusDeletionBatchTest {

	@isTest static void testBatch() {
		dsfs__DocuSign_Status__c testData3 = new dsfs__DocuSign_Status__c();

		insert testData3;

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();		

		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Officer__c testOff1 = CompaniesHouseTestData.getInstance().off;

		Officer__c testOff2 = CompaniesHouseTestData.getInstance().off2;

		Contact con1 = CompaniesHouseTestData.getInstance().contact1;
		Contact con2 = CompaniesHouseTestData.getInstance().contact2;

		// needs mock web callout information here for initialize step test
		insert testPresenter;

		insert testCompany;

		Transaction__c transac = testData.tx;
		transac.Form_Name__c = 'DS01';
		transac.Transaction_Type__c = 'DS01';
		transac.Company__c = testCompany.Id;
		transac.CompanyNumber__c = '05448736';
		transac.officerTerminology__c = 'test';

		transac.isDigitalSignatureNeeded__c = true;
		insert transac;

		dsfs__DocuSign_Status__c testData2 = new dsfs__DocuSign_Status__c();
		testData2.Transaction__c = transac.Id;

		insert testData2;

		Attachment testAttachment = new Attachment();
		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		testAttachment.parentId = testData3.id;
		testAttachment.description = 'testDescription';
		testAttachment.Name = 'TestBlob';
		testAttachment.body = testpdfBlob;
		insert testAttachment;

		System.assertEquals(2, [Select Id From dsfs__DocuSign_Status__c].size());

		Test.startTest();

		Database.executeBatch(new DocusignStatusDeletionBatch());

		Test.stopTest();

		System.assertEquals(1, [Select Id From dsfs__DocuSign_Status__c].size());
		System.assertEquals(0, [Select Id From Attachment].size());
	}

}