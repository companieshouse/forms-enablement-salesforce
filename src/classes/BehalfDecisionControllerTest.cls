@isTest
private class BehalfDecisionControllerTest {

	@isTest static void test_method_one() {

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
		transac.Historical_Valid_Step_Ids__c = testStep1.Id + AppConstants.DELIM_HISTORICAL_STEP + 0;
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

		BehalfDecisionController.refreshBoolean(EncodingUtil.urlEncode(SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR),'UTF-8'));

		PageReference behalfDecisionPage = Page.BehalfDecision;

		behalfDecisionPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(behalfDecisionPage);
				SecurityManager.createSessionValidityCookie('test@test.com');

		BehalfDecisionController test1controller = new BehalfDecisionController();
		test1controller.updateDirectorList();
		test1controller.nextAction();
		test1controller.previousAction();
		test1controller.behalfValidation = true;
		test1controller.nextAction();
		test1controller.initPage();
		//test1controller.isPageAlreadyValidStep = true;
		//test1controller.redirectUser();
		test1controller.persistStep();
		test1controller.redirectUser();
	}

		@isTest static void test2() {

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
		transac.Historical_Valid_Step_Ids__c = testStep1.Id + AppConstants.DELIM_HISTORICAL_STEP + 0;
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

		BehalfDecisionController.refreshBoolean(EncodingUtil.urlEncode(SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR),'UTF-8'));

		PageReference behalfDecisionPage = Page.BehalfDecision;

		behalfDecisionPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(behalfDecisionPage);
				SecurityManager.createSessionValidityCookie('test@test.com');

		BehalfDecisionController test1controller = new BehalfDecisionController();
		test1controller.redirectUser();
	}
}