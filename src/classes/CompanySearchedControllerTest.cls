@isTest
private class CompanySearchedControllerTest {
	
	@isTest static void test_method_one() {
		// Implement test code
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;



		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.CompanyName__c = 'TEST';
		transac.CompanyNumber__c = 'TEST';
		transac.DownloadLink__c = 'TEST';
		transac.Transaction_Type__c = 'TestForm';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.Presenter__c = testPresenter.Id;
		transac.PresenterName__c = 'TEST';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = true;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.OfficerCount__c = 1;
		insert transac;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;
		testContact.LastName = 'TEST';
		testContact.Email = 'test@test.com';
		testContact.Transaction__c = transac.Id;
		insert testPresenter;

		transac.Presenter__c = testPresenter.Id;
		update transac;

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

		PageReference digitalSignature = Page.CompanySearched;
		digitalSignature.getParameters().put('t', 'TestForm');
		digitalSignature.getParameters().put('id', String.valueOf(transac.Id));
		Test.setCurrentPage(digitalSignature);
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessTokenAuth());
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('test@test.com' + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 120, true);
		Cookie compS = new Cookie('searched_company', SecurityManager.encryptText('05448736'), '', 120, true);

    	digitalSignature.setCookies(new Cookie[]{sessionValidity, compS});
		CompanySearchedController test1controller = new CompanySearchedController();
		test1controller.initialiseAction();
		test1controller.nextAction();
		test1controller.previousAction();
		Test.stopTest();
	}
	
		@isTest static void test2() {
		// Implement test code
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;



		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.CompanyName__c = 'TEST';
		transac.CompanyNumber__c = 'TEST';
		transac.DownloadLink__c = 'TEST';
		transac.Transaction_Type__c = 'TestForm';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.Presenter__c = testPresenter.Id;
		transac.PresenterName__c = 'TEST';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.SoleDirectorPresenter__c = true;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.OfficerCount__c = 1;
		insert transac;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;
		testContact.LastName = 'TEST';
		testContact.Email = 'test@test.com';
		testContact.Transaction__c = transac.Id;
		insert testPresenter;

		transac.Presenter__c = testPresenter.Id;
		update transac;

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

		PageReference digitalSignature = Page.CompanySearched;
		digitalSignature.getParameters().put('t', 'TestForm');
		digitalSignature.getParameters().put('id', String.valueOf(transac.Id));
		Test.setCurrentPage(digitalSignature);
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessTokenAuth());
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('test@test.com' + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	digitalSignature.setCookies(new Cookie[]{sessionValidity});
		CompanySearchedController test1controller = new CompanySearchedController();
		test1controller.initialiseAction();
		
		Test.stopTest();
	}
	
}