@isTest
private class CRSControllerTest {
	@isTest static void test_method_one() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testDS01 = CompaniesHouseTestData.getInstance().testDS01;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;
		insert testPresenter;


		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.Transaction_Type__c = 'SH13';
		transac.Form_Name__c = 'SH13';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = false;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.isBehalfSignatoryEnable__c = true;
		transac.OfficerCount__c = 1;
		insert transac;

		Shares__c testShare = new Shares__c();
		testshare.transaction__c = transac.Id;
		testshare.shareType__c = 'SH13';
		testshare.Class_of_Shares__c = 'testclass';
		insert testShare;


		Attachment testAttachment = new Attachment();
		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		testAttachment.parentId = transac.id;
		testAttachment.description = 'testDescription';
		testAttachment.Name = 'SH13';
		testAttachment.body = testpdfBlob;
		insert testAttachment;

		testContact.Transaction__c = transac.id;
		insert testContact;
		Officer__c testoff = new Officer__c();
		testoff.name = 'testfirstname';
		testoff.Surname__c = 'testsurname';
		testoff.Forename__c = 'testforename';
		testoff.Middlenames__c = 'testmiddlename';
		testoff.Email__c = 'testEmail@testemail.com';
		testoff.IsPresenter__c = false;
		testoff.Transaction__c = transac.Id;
		testoff.Contact__c = testContact.id;
		testoff.isSignatoryBehalf__c = true;
		testoff.isSignatory__c = true;
		insert testoff;

		PageReference crscontrollerTestPage = Page.CRS;
		crscontrollerTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(crscontrollerTestPage);
		crscontroller test1controller = new crscontroller();
		test1controller.goForward();
		test1controller.setSelectedClass();
		test1controller.setSelectedShareChange();
		test1controller.nextAction();
		test1controller.selectedShareClass = null;
		test1controller.nextAction();
		test1controller.selectedShareClass = '';
		test1controller.nextAction();
		test1controller.selectedShareClass = 'test share class';
		test1controller.nextAction();
		test1controller.selectedShareChange = null;
		test1controller.nextAction();
		test1controller.selectedShareChange = 'test share change';
		test1controller.nextAction();
		test1controller.previousAction();
	}

	@isTest static void test_method_two() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testDS01 = CompaniesHouseTestData.getInstance().testDS01;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;
		insert testPresenter;


		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.Transaction_Type__c = 'SH13';
		transac.Form_Name__c = 'SH13';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.finishedpart1__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = false;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.isBehalfSignatoryEnable__c = true;
		transac.OfficerCount__c = 1;
		insert transac;

		Shares__c testShare = new Shares__c();
		testshare.transaction__c = transac.Id;
		testshare.shareType__c = 'SH13';
		testshare.Class_of_Shares__c = 'testclass';
		insert testShare;


		Attachment testAttachment = new Attachment();
		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		testAttachment.parentId = transac.id;
		testAttachment.description = 'testDescription';
		testAttachment.Name = 'SH13';
		testAttachment.body = testpdfBlob;
		insert testAttachment;

		testContact.Transaction__c = transac.id;
		insert testContact;
		Officer__c testoff = new Officer__c();
		testoff.name = 'testfirstname';
		testoff.Surname__c = 'testsurname';
		testoff.Forename__c = 'testforename';
		testoff.Middlenames__c = 'testmiddlename';
		testoff.Email__c = 'testEmail@testemail.com';
		testoff.IsPresenter__c = false;
		testoff.Transaction__c = transac.Id;
		testoff.Contact__c = testContact.id;
		testoff.isSignatoryBehalf__c = true;
		testoff.isSignatory__c = true;
		insert testoff;

		PageReference crsTestPage = Page.CRS;
		crsTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(crsTestPage);
		crscontroller test1controller = new crscontroller();
		test1controller.goForward();

	}
}