@isTest(seealldata = false)
private class DirectorsListControllerTest {

	@isTest static void test_method_one() {
		//officers loaded
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
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
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.Historical_Valid_Step_Ids__c = testStep1.Id + AppConstants.DELIM_HISTORICAL_STEP + 1 + AppConstants.DELIM_HISTORICAL_STEP;
		transac.officerTerminology__c = 'test';

		transac.isDigitalSignatureNeeded__c = true;
		insert transac;

		con1.Account = testCompany;
		con2.Account = testCompany;

		insert con1;
		insert con2;

		testOff2.Transaction__c = transac.id;
		testOff2.Name = 'test 2Name';
		testOff2.Contact__c = con1.Id;

		testoff1.Name = 'test 1Name';
		testoff1.transaction__c = transac.id;
		testOff1.Contact__c = con2.Id;
		insert testOff1;
		insert testOff2;


		PageReference directorsListPage = Page.DirectorsList;
		directorsListPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(directorsListPage);
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('true' + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	directorsListPage.setCookies(new Cookie[]{sessionValidity});
		DirectorsListController controller = new DirectorsListController();

		controller.populateDirectorList();

		String c = EncodingUtil.urlEncode(SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), 'UTF-8');
		DirectorsListController.refreshBoolean(c);

		transac.Historical_Valid_Step_Ids__c = testStep1.Id + AppConstants.DELIM_HISTORICAL_STEP + 0 + AppConstants.DELIM_HISTORICAL_STEP;

		update transac;

		controller = new DirectorsListController();

		controller.populateDirectorList();

		controller.extractOfficerName(0, 'name, name');
		controller.extractOfficerName(1, 'name, name');
		controller.extractOfficerName(2, 'name, name');
		controller.extractOfficerName(0, 'name');
		controller.hasAlreadyLoadedOfficers = false;
		controller.validationDirector = false;
		controller.updateDirectorList();
		controller.redirectUser();
		controller.nextAction();
		controller.previousAction();

		controller.validationDirector = null;
		controller.nextAction();

		controller.validationDirector = true;
		controller.nextAction();
		controller.validationDirector = null;
		controller.validateStep();
		controller.validationDirector = false;
		controller.validateStep();
		controller.validationDirector = true;
		controller.validateStep();


		controller.nextAction();
		controller.companyNumber = '05448736';
		controller.populateDirectorList();
		controller.companyNumber = 'null';
		controller.hasAlreadyLoadedOfficers = false;
		controller.populateDirectorList();

		controller.redirectUser();

	}
}