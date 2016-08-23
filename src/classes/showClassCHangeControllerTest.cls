@isTest
private class showClassCHangeControllerTest {

	@isTest static void test_method_one() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testDS01 = CompaniesHouseTestData.getInstance().testDS01;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;
		Shares__c testShare1 = new Shares__c();

		insert testPresenter;

		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.Transaction_Type__c = 'SH08';
		transac.Form_Name__c = 'SH08';
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

		testShare1.Transaction__c = transac.id;
		testShare1.SHARETYPE__c = 'SH08';
		testshare1.ActiveData__c = true;
		insert testshare1;

		Attachment testAttachment = new Attachment();
		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		testAttachment.parentId = transac.id;
		testAttachment.description = 'testDescription';
		testAttachment.Name = 'SH08';
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

		PageReference showClassChangesTestPage = Page.ShowClassChanges;
		showClassChangesTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(showClassChangesTestPage);
		showClassChangeController test1controller = new showClassChangeController();
		test1controller.showShares();
		test1controller.nextAction();
		test1controller.varDay = 12;
		test1controller.nextAction();
		test1controller.varMonth = 11;
		test1controller.nextAction();
		test1controller.varYear = 1500;
		test1controller.nextAction();
		test1controller.varYear = 2050;
		test1controller.nextAction();
		test1controller.varYear = 1981;
		test1controller.nextAction();
		test1controller.previousAction();
		test1controller.shareID = testshare1.Id;
		test1controller.deleteShare();
	}
	@isTest static void test_method_two() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testDS01 = CompaniesHouseTestData.getInstance().testDS01;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;
		Shares__c testShare1 = new Shares__c();

		insert testPresenter;

		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.Transaction_Type__c = 'SH08';
		transac.Form_Name__c = 'SH08';
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

		//testShare1.Transaction__c = transac.id;
		//testShare1.SHARETYPE__c = 'SH08';
		//testshare1.ActiveData__c = true;
		//insert testshare1;

		Attachment testAttachment = new Attachment();
		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		testAttachment.parentId = transac.id;
		testAttachment.description = 'testDescription';
		testAttachment.Name = 'SH08';
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

		PageReference showClassChangesTestPage = Page.ShowClassChanges;
		showClassChangesTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(showClassChangesTestPage);
		showClassChangeController test1controller = new showClassChangeController();
		test1controller.showShares();

	}

}