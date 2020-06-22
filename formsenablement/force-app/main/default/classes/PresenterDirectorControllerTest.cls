@isTest
private class PresenterDirectorControllerTest {

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
		transac.Form_Name__c = 'TestForm';
		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.officerTerminology__c = 'test';
		transac.isDigitalSignatureNeeded__c = true;
		transac.PresenterName__c = 'Short Presenter Name';
		transac.Historical_Valid_Step_Ids__c = testStep1.Id + AppConstants.DELIM_HISTORICAL_STEP + 1 + AppConstants.DELIM_HISTORICAL_STEP;
		insert transac;
		con1.Account = testCompany;
		con2.Account = testCompany;

		insert con1;
		insert con2;

		testOff2.Transaction__c = transac.id;
		testOff2.Contact__c = con1.Id;

		testoff1.transaction__c = transac.id;
		testOff1.Contact__c = con2.Id;
		insert testOff1;
		insert testOff2;


		PageReference presenterDirectorTest = Page.PresenterDirector;
		presenterDirectorTest.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(presenterDirectorTest);

		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('test@test.com'+AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	presenterDirectorTest.setCookies(new Cookie[]{sessionValidity});

		PresenterDirectorController controller = new PresenterDirectorController();
		controller.populateDirectorList();

		String c = EncodingUtil.urlEncode(SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), 'UTF-8');
		PresenterDirectorController.refreshBoolean(c);

		transac.Historical_Valid_Step_Ids__c = testStep1.Id + AppConstants.DELIM_HISTORICAL_STEP + 0 + AppConstants.DELIM_HISTORICAL_STEP;

		update transac;
		controller.getListOfficer();
		controller.redirectUser();
		controller.nextAction();
		controller.directorPresenter = false;
		controller.persistStep();
		controller.previousAction();
		controller.updatePresenter();

		controller.nextAction();

		controller.directorPresenter = true;
		controller.persistStep();
		controller.nextAction();
		controller.updatePresenter();

		controller.redirectUser();

	}

}