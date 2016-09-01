@isTest
private class BehalfInputDetailsControllerTest {
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
		transac.Transaction_Type__c = 'DS01';
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
		testoff.hasInputBehalfDetails__c = false;
		testoff.IsPresenter__c = false;
		insert testoff;

		PageReference behalfInputPage = Page.BehalfInputDetails;
		behalfInputPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(behalfInputPage);
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('true' + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	behalfInputPage.setCookies(new Cookie[]{sessionValidity});
		BehalfInputDetailsController test1controller = new BehalfInputDetailsController();
		test1controller.currentOfficer = testoff;
		test1controller.initPage();
		test1controller.previousAction();
		test1controller.nameAuthorized = '';
		test1controller.nextAction();
		test1controller.nameAuthorized = 'test name';
		test1controller.nextAction();
		test1controller.emailDirector = null;
		test1controller.nextAction();
		test1controller.emailDirector = 'testemail';
		test1controller.nextAction();
		test1controller.emailDirector = 'test@emailcom';
		test1controller.nextAction();
		test1controller.emailDirector = 'test@email.com';
		test1controller.nextAction();
		test1controller.emailConfirmDirector = null;
		test1controller.nextAction();
		test1controller.emailConfirmDirector = 'testemail';
		test1controller.nextAction();
		test1controller.emailConfirmDirector = 'test@emailcom';
		test1controller.nextAction();
		test1controller.emailConfirmDirector = 'nonmatching@gmail.com';
		test1controller.nextAction();
		test1controller.emailConfirmDirector = 'test@email.com';
		//test1controller.nextAction();
		//test1controller.behalfSelection = null;
		//test1controller.nextAction();
		test1controller.behalfSelection = 1;
		test1controller.nextAction();
		test1controller.behalfValidation = true;
		test1controller.updateSelectedBehalf();
		test1controller.redirectUser();
		test1controller.currentOfficer = null;
		test1controller.persistStep();

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
		transac.Transaction_Type__c = 'DS01';
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

		testContact.Transaction__c = transac.id;
		insert testContact;

		Officer__c testoff = new Officer__c();
		testoff.name = 'test2firstname';
		testoff.Surname__c = 'test2surname';
		testoff.Forename__c = 'test2forename';
		testoff.Middlenames__c = 'test2middlename';
		testoff.Email__c = 'testEmail2@testemail.com';
		testoff.IsPresenter__c = false;
		testoff.Transaction__c = transac.Id;
		testoff.Contact__c = testContact.id;
		testoff.isSignatoryBehalf__c = true;
		testoff.isSignatory__c = true;
		testoff.hasInputBehalfDetails__c = false;
		testoff.IsPresenter__c = false;
		insert testoff;

		PageReference behalfInputPage = Page.BehalfInputDetails;
		behalfInputPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(behalfInputPage);
		BehalfInputDetailsController test1controller = new BehalfInputDetailsController();
		test1controller.currentOfficer = testoff;
		test1controller.initPage();
		test1controller.previousAction();
		test1controller.nameAuthorized = '';
		test1controller.nextAction();
		test1controller.nameAuthorized = 'test name';
		test1controller.nextAction();
		test1controller.emailDirector = null;
		test1controller.nextAction();
		test1controller.emailDirector = 'test2email';
		test1controller.nextAction();
		test1controller.emailDirector = 'test2@emailcom';
		test1controller.nextAction();
		test1controller.emailDirector = 'test2@email.com';
		test1controller.nextAction();
		test1controller.emailConfirmDirector = null;
		test1controller.nextAction();
		test1controller.emailConfirmDirector = 'test2email';
		test1controller.nextAction();
		test1controller.emailConfirmDirector = 'test2@emailcom';
		test1controller.nextAction();
		test1controller.emailConfirmDirector = 'nonmatching@gmail.com';
		test1controller.nextAction();
		test1controller.emailConfirmDirector = 'test2@email.com';
		test1controller.behalfSelection = null;
		test1controller.nextAction();

		test1controller.updateSelectedBehalf();
		test1controller.redirectUser();

	}

}