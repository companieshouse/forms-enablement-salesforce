@isTest
private class TrackUserClassTest {

	@isTest static void test_method_one() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Contact testContact = CompaniesHouseTestData.getInstance().contact1;



		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = true;
		transac.isDigitalSignatureNeeded__c = true;
		transac.isSigningFinished__c = false;
		transac.officerTerminology__c = 'testterminology';
		insert transac;

		testPresenter.PersonEmail = transac.ContactEmail__c;
		insert testPresenter;

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
		insert testoff;

		Company_Authorisation__c testAuth = new Company_Authorisation__c();
		testAuth.Company_Access_Token__c = 'test';
		testAuth.Company_Number__c = '12345678';
		testAuth.userEmail__c = 'test@test.com';
		testAuth.User_Id__c = 'testuserId';
		testAuth.Nonce__c = 'testNonce2';
		testAuth.Transaction_Type__c = 'DS01';
		insert testAuth;

		PageReference cookieTester = Page.StartFramework;
		cookieTester.getParameters().put('t', 'DS01');
		Test.setCurrentPage(cookieTester);

		TrackUserClass test1controller = new TrackUserClass();
		test1controller.saveUserDocumentInfo();
		test1controller.setBooleanGuidanceAgreeBox(True);
		test1controller.setStringGuidanceAgreeBox('SampleText');
		test1controller.GuidanceAgreeBox();
		test1controller.getUserDocument();
		test1controller.getSearchedCompany(transac.CompanyNumber__c);
		//// mock
		//cookie searched_company = new Cookie('searched_company', SecurityManager.encryptText(transac.CompanyNumber__c), null, -1, true);
		//ApexPages.currentPage().setCookies(new Cookie[] { searched_company });
		test1controller.setStringGuidanceAgreeBox('true');
		test1controller.setBooleanGuidanceAgreeBox(true);
		test1controller.GuidanceAgreeBox();
		test1controller.saveUserDocumentInfo();
		test1controller.getUserDocument();
		test1controller.returnCurrentCompanyObject();
		test1controller.getCurrentUser(transac.ContactEmail__c);
		test1controller.getSearchedCompany('12345678');
		test1controller.returnCurrentCompanyObject();
		test1controller.returnCurrentUser();
		TrackUserClass.isValidUser('testEmail@testemail.com');
		TrackUserClass.isValidCompanySearched('12345678');
	}

}