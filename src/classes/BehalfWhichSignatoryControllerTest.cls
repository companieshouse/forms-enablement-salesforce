@isTest
private class BehalfWhichSignatoryControllerTest {


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
		insert testoff;

		PageReference behalfwhichsignatoryPage = Page.BehalfWhichSignatory;
		behalfwhichsignatoryPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(behalfwhichsignatoryPage);
		//Create the cookie
    	Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('true' + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	behalfwhichsignatoryPage.setCookies(new Cookie[]{sessionValidity});
		BehalfWhichSignatoryController test1controller = new BehalfWhichSignatoryController();
		test1controller.initPage();
		test1controller.updateDirectorList();
		test1controller.selectedId = testoff.id;
		test1controller.nextAction();
		test1controller.previousAction();
		test1controller.behalfValidation = true;
		test1controller.nextAction();
		test1controller.persistStep();

		test1controller.updateSelectedPresenter();

		test1controller.selectedId = null;
		test1controller.nextAction();

		test1controller.redirectUser();

	}

}