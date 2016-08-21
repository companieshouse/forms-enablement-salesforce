@isTest
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
		transac.officerTerminology__c = 'test';
		transac.isDigitalSignatureNeeded__c = true;
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


		PageReference directorsList = Page.DirectorsList;
		directorsList.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(directorsList);

		DirectorsListController controller = new DirectorsListController();
		controller.extractOfficerName(0, 'name, name');
		controller.extractOfficerName(1, 'name, name');
		controller.extractOfficerName(2, 'name, name');
		controller.extractOfficerName(0, 'name');
		controller.hasAlreadyLoadedOfficers = false;
		controller.initialiseStep();
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
		controller.companyNumber = null;
		controller.populateDirectorList();

		controller.companyNumber = '05448736';
		controller.populateDirectorList();

	}

}