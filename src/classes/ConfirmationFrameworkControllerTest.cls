@isTest
private class ConfirmationFrameworkControllerTest {

	@isTest static void test_method_one() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
		Contact testContact = CompaniesHouseTestData.getInstance().contact1;

		Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
		insert testPresenter;

		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.OfficerCount__c = 2;
		transac.Transaction_Type__c = 'DS01';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		insert transac;
		testContact2.Transaction__c = transac.id;
		insert testContact2;
		testContact.Transaction__c = transac.id;
		insert testContact;
		Officer__c testoff = new Officer__c();
		testoff.Surname__c = 'testsurname';
		testoff.Forename__c = 'testforename';
		testoff.Middlenames__c = 'testmiddlename';
		testoff.Email__c = 'testEmail@testemail.com';
		testoff.IsPresenter__c = true;
		testoff.Transaction__c = transac.Id;
		testoff.Contact__c = testContact.id;
		testoff.isSignatory__c = true;

		insert testoff;

		Officer__c testoff2 = new Officer__c();
		testoff2.Surname__c = 'testsurname2';
		testoff2.Forename__c = 'testforename2';
		testoff2.Middlenames__c = 'testmiddlename2';
		testoff2.Email__c = 'testEmail2@testemail2.com';
		testoff2.IsPresenter__c = false;
		testoff2.Transaction__c = transac.Id;
		testoff2.Contact__c = testContact2.id;
		testoff2.isSignatory__c = true;

		insert testoff2;


		PageReference confirmationFrameworkPage = Page.ConfirmationFramework;
		confirmationFrameworkPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(confirmationFrameworkPage);
		ConfirmationFrameworkController test1controller = new ConfirmationFrameworkController();

		test1controller.standardView = false;
		test1controller.customView = true;
		test1controller.initialiseStep();
		test1controller.redirectDS02();
		test1controller.saveTransaction();
		test1controller.persistStep();
		test1controller.previousAction();
		test1controller.standardView = true;
		test1controller.customView = false;
		test1controller.initialiseStep();
	}

	@isTest static void test_method_two() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
		Contact testContact = CompaniesHouseTestData.getInstance().contact1;

		Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
		insert testPresenter;

		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.OfficerCount__c = 2;
		transac.Transaction_Type__c = 'SH05_6_7';
		transac.Form_Name__c = 'SH05_6_7';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		insert transac;

		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment = new Attachment();
		testAttachment.ParentId = transac.Id;
		testAttachment.Description = 'testdescription';
		testAttachment.Name = 'Resolution';
		testAttachment.Body = testpdfBlob;

		testContact2.Transaction__c = transac.id;
		insert testContact2;

		testContact.Transaction__c = transac.id;
		insert testContact;

		Officer__c testoff = new Officer__c();
		testoff.Surname__c = 'testsurname';
		testoff.Forename__c = 'testforename';
		testoff.Middlenames__c = 'testmiddlename';
		testoff.Email__c = 'testEmail@testemail.com';
		testoff.IsPresenter__c = true;
		testoff.Transaction__c = transac.Id;
		testoff.Contact__c = testContact.id;
		testoff.isSignatory__c = true;

		insert testoff;

		Officer__c testoff2 = new Officer__c();
		testoff2.Surname__c = 'testsurname2';
		testoff2.Forename__c = 'testforename2';
		testoff2.Middlenames__c = 'testmiddlename2';
		testoff2.Email__c = 'testEmail2@testemail2.com';
		testoff2.IsPresenter__c = false;
		testoff2.Transaction__c = transac.Id;
		testoff2.Contact__c = testContact2.id;
		testoff2.isSignatory__c = true;

		insert testoff2;


		PageReference confirmationFrameworkPage = Page.ConfirmationFramework;
		confirmationFrameworkPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(confirmationFrameworkPage);
		ConfirmationFrameworkController test1controller = new ConfirmationFrameworkController();

		test1controller.standardView = false;
		test1controller.customView = true;
		test1controller.initialiseStep();
		test1controller.redirectDS02();
		test1controller.saveTransaction();
		test1controller.persistStep();
		test1controller.previousAction();
		test1controller.standardView = true;
		test1controller.customView = false;
		test1controller.initialiseStep();
	}

	@isTest static void test_method_three() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
		Contact testContact = CompaniesHouseTestData.getInstance().contact1;

		Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
		insert testPresenter;

		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.OfficerCount__c = 2;
		transac.Transaction_Type__c = 'DS02';
		transac.Form_Name__c = 'DS02';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		insert transac;



		testContact2.Transaction__c = transac.id;
		insert testContact2;

		testContact.Transaction__c = transac.id;
		insert testContact;

		Officer__c testoff = new Officer__c();
		testoff.Surname__c = 'testsurname';
		testoff.Forename__c = 'testforename';
		testoff.Middlenames__c = 'testmiddlename';
		testoff.Email__c = 'testEmail@testemail.com';
		testoff.IsPresenter__c = true;
		testoff.Transaction__c = transac.Id;
		testoff.Contact__c = testContact.id;
		testoff.isSignatory__c = true;

		insert testoff;

		Officer__c testoff2 = new Officer__c();
		testoff2.Surname__c = 'testsurname2';
		testoff2.Forename__c = 'testforename2';
		testoff2.Middlenames__c = 'testmiddlename2';
		testoff2.Email__c = 'testEmail2@testemail2.com';
		testoff2.IsPresenter__c = false;
		testoff2.Transaction__c = transac.Id;
		testoff2.Contact__c = testContact2.id;
		testoff2.isSignatory__c = true;

		insert testoff2;

		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');

		Attachment testAttachment2 = new Attachment();
		testAttachment2.ParentId = transac.Id;
		testAttachment2.Description = 'testdescription';
		testAttachment2.Name = 'SH06';
		testAttachment2.Body = testpdfBlob;
		insert testAttachment2;

		Attachment testAttachment = new Attachment();
		testAttachment.ParentId = transac.Id;
		testAttachment.Description = 'testdescription';
		testAttachment.Name = 'STATEMENTOFCAPITAL';
		testAttachment.Body = testpdfBlob;
		insert testAttachment;

		PageReference confirmationFrameworkPage = Page.ConfirmationFramework;
		confirmationFrameworkPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(confirmationFrameworkPage);

		ConfirmationFrameworkController test1controller = new ConfirmationFrameworkController();

		test1controller.standardView = true;
		test1controller.customView = false;
		test1controller.initialiseStep();
		test1controller.redirectDS02();
		test1controller.saveTransaction();
		test1controller.persistStep();
		test1controller.previousAction();
		test1controller.standardView = false;
		test1controller.customView = true;
		test1controller.initialiseStep();
	}
}