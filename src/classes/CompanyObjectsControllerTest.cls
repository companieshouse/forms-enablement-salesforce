@isTest
private class CompanyObjectsControllerTest {

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
		transac.selectShareType__c = 'testclass';
		transac.Form_Name__c = 'SH19';
		insert transac;

		Shares__c testShare = new Shares__c();
		testshare.transaction__c = transac.Id;
		testshare.shareType__c = 'STATEMENTOFCAPITAL';
		testshare.Class_of_Shares__c = 'testclass';
		insert testShare;

		PageReference companyObjectsTestPage = Page.ObjectsCompany;
		companyObjectsTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(companyObjectsTestPage);

		CompanyObjectsController test1controller = new CompanyObjectsController();
		test1controller.previousAction();
		test1controller.alterObjects = null;
		test1controller.removeObjects = null;
		test1controller.addObjects = null;
		test1controller.nextAction();
		test1controller.alterObjects = true;
		test1controller.removeObjects = true;
		test1controller.addObjects = true;
		test1controller.confirmObjects = false;
		test1controller.nextAction();
		test1controller.confirmObjects = true;
		test1controller.nextAction();
		test1controller.saveAddValue();
		test1controller.saveAlterValue();
		test1controller.saveConfirmValue();
		test1controller.saveRemoveValue();

	}

}