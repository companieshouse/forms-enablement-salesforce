@isTest
private class DigitalSignatureControllerTest {
	
	@isTest static void test_method_one() {
		// Implement test code
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;
		insert testPresenter;

		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.Transaction_Type__c = 'TestForm';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = true;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.OfficerCount__c = 1;
		insert transac;

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

		PageReference digitalSignature = Page.DigitalSignature;
		digitalSignature.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(digitalSignature);
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('true' + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	digitalSignature.setCookies(new Cookie[]{sessionValidity});
		DigitalSignatureController test1controller = new DigitalSignatureController();
		test1controller.initSignature();
		test1controller.restartPresenterSigning();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();

		testContact.DateSigned__c = System.today();
		update testContact;
		transac.Status__c = AppConstants.REQUEST_STATUS_SIGNED;
		update transac;
		test1controller.pollMethods();
		test1controller.initSignature();

		transac.isDigitalSignatureNeeded__c = false;
		update transac;

		test1controller.initSignature();

		test1controller.signoutAction();
		test1controller.previousAction();


	}
	
	@isTest static void test_method_two() {
		// Implement test code
				CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;
		insert testPresenter;

		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.Transaction_Type__c = 'TestForm';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = true;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.OfficerCount__c = 1;
		insert transac;

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

		PageReference digitalSignature = Page.DigitalSignature;
		digitalSignature.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(digitalSignature);
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('true' + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	digitalSignature.setCookies(new Cookie[]{sessionValidity});
		DigitalSignatureController test1controller = new DigitalSignatureController();
		test1controller.initSignature();
		test1controller.restartPresenterSigning();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.resetTransaction();
	}

		@isTest static void test_method_three() {
		// Implement test code
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;
		insert testPresenter;

		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.Transaction_Type__c = 'TestForm';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = true;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.OfficerCount__c = 1;
		insert transac;

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

		PageReference digitalSignature = Page.DigitalSignature;
		digitalSignature.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(digitalSignature);
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('true' + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	digitalSignature.setCookies(new Cookie[]{sessionValidity});
		DigitalSignatureController test1controller = new DigitalSignatureController();
		test1controller.initSignature();
		test1controller.restartPresenterSigning();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();

		testContact.RecipientStatus__c = 'AutoResponded';
		update testContact;
		transac.Status__c = 'Contact email Error';
		update transac;
		test1controller.pollMethods();
		test1controller.initSignature();

	}

		@isTest static void test_method_four() {
		// Implement test code
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;
		insert testPresenter;

		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.Transaction_Type__c = 'TestForm';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = true;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.OfficerCount__c = 1;
		insert transac;

		testContact.Transaction__c = transac.id;
		insert testContact;
		Officer__c testoff = new Officer__c();
		testoff.Surname__c = 'testsurname';
		testoff.Forename__c = 'testforename';
		testoff.Middlenames__c = 'testmiddlename';
		testoff.Email__c = 'testEmail@testemail.com';
		testoff.IsPresenter__c = false;
		testoff.Transaction__c = transac.Id;
		testoff.Contact__c = testContact.id;
		testoff.isSignatory__c = true;
		insert testoff;

		PageReference digitalSignature = Page.DigitalSignature;
		digitalSignature.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(digitalSignature);
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('true' + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	digitalSignature.setCookies(new Cookie[]{sessionValidity});
		DigitalSignatureController test1controller = new DigitalSignatureController();
		test1controller.initSignature();
		test1controller.restartPresenterSigning();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();
		test1controller.pollMethods();

		testContact.DateSigned__c = System.today();
		update testContact;
		transac.Status__c = AppConstants.DOCUSIGN_STATUS_REJECTED;
		update transac;
		test1controller.pollMethods();
		test1controller.initSignature();

		transac.isDigitalSignatureNeeded__c = false;
		update transac;

		test1controller.initSignature();

		test1controller.signoutAction();
		test1controller.previousAction();


	}
	
	
}