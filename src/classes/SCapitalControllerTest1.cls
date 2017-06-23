@IsTest
public with sharing class SCapitalControllerTest1 {
	public SCapitalControllerTest1() {
		test_method_one();
		test_method_two();
	}

	@isTest static void test_method_one() {
		// go forward
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		// needs mock web callout information here for initialize step test
		insert testPresenter;

		insert testCompany;

		Transaction__c transac = testData.tx;

		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = false;
		transac.finishedAddingShares__c = false;
		transac.finishedPart1__c = false;

		insert transac;

		PageReference scapital1TestPage = Page.SCapital1;
		scapital1TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(scapital1TestPage);

		SCapitalController1 scap1controller = new SCapitalController1();
		scap1controller.grabPrescribedParticular();
		scap1controller.grabShareType();
		scap1controller.checkstatus();
		scap1controller.AddtocurrentShare();
		scap1controller.previousAction();
		scap1controller.nextAction();
		scap1controller.shareClassType = 'ordinary';
		scap1controller.nextAction();
		scap1controller.prescribedParticular = 'test text';
		scap1controller.nextAction();
		scap1controller.checkstatus();
		scap1controller.nextStep();
	}

	@isTest static void test_method_two() {
		// go forward
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		// needs mock web callout information here for initialize step test
		insert testPresenter;

		insert testCompany;

		Transaction__c transac = testData.tx;

		transac.Company__c = testCompany.Id;
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = true;
		transac.finishedAddingShares__c = false;
		transac.finishedPart1__c = false;

		insert transac;

		PageReference scapital1TestPage = Page.SCapital1;
		scapital1TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(scapital1TestPage);

		SCapitalController1 scap1controller = new SCapitalController1();
		scap1controller.grabPrescribedParticular();
		scap1controller.grabShareType();
		scap1controller.checkstatus();
		scap1controller.AddtocurrentShare();
		scap1controller.previousAction();
		scap1controller.nextAction();
		scap1controller.shareClassType = 'ordinary';
		scap1controller.nextAction();
		scap1controller.prescribedParticular = 'test text';
		scap1controller.nextAction();
		scap1controller.checkstatus();
		scap1controller.nextStep();
	}
}