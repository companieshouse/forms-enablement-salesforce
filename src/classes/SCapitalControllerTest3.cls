@IsTest
public with sharing class SCapitalControllerTest3 {
	public SCapitalControllerTest3() {
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
		transac.selectShareType__c = 'testclass';
		transac.Form_Name__c = 'SH19';
		insert transac;

		Shares__c testShare = new Shares__c();
		testshare.transaction__c = transac.Id;
		testshare.shareType__c = 'STATEMENTOFCAPITAL';
		testshare.Class_of_Shares__c = 'testclass';
		insert testShare;

		PageReference scapital3TestPage = Page.Attachments;
		scapital3TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(scapital3TestPage);

		SCapitalController3 scap3controller = new SCapitalController3();
		scap3controller.confirmShares();
		scap3controller.addsameShare();
		scap3controller.choosePath();
		scap3controller.previousAction();
		scap3controller.shareStatus = false;

		scap3controller.nextAction();
		scap3controller.AddtocurrentShare();
		scap3controller.checkstatus();
		scap3controller.restartJourney();

		scap3controller.shareStatus = true;
		scap3controller.choosePath();
		scap3controller.shareID = testshare.Id;
		scap3controller.deleteShare();
		scap3controller.nextAction();

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
		transac.finishedAttachments__c = false;
		transac.finishedAddingShares__c = true;
		transac.finishedPart1__c = false;
		transac.selectShareType__c = 'testclass';
		//transac.Form_Name__c = 'SH19';
		insert transac;

		Shares__c testShare = new Shares__c();
		testshare.transaction__c = transac.Id;
		testshare.shareType__c = 'STATEMENTOFCAPITAL';
		testshare.Class_of_Shares__c = 'testclass';
		insert testShare;

		PageReference scapital3TestPage = Page.SCapital3;
		scapital3TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(scapital3TestPage);

		SCapitalController3 scap3controller = new SCapitalController3();
		scap3controller.checkstatus();
		scap3controller.confirmShares();
		scap3controller.addsameShare();
		scap3controller.choosePath();
		scap3controller.previousAction();
		scap3controller.shareStatus = false;

		scap3controller.nextAction();
		scap3controller.AddtocurrentShare();
		scap3controller.restartJourney();
		scap3controller.hasPageErrors = true;
		scap3controller.hasPageErrors = false;
		scap3controller.currentErrorMessage = 'testmessage';
		scap3controller.currentErrorMessage = '';

		scap3controller.shareStatus = true;
		scap3controller.choosePath();
		scap3controller.shareID = testshare.Id;
		scap3controller.deleteShare();
		scap3controller.nextAction();

	}


	@isTest static void test_method_three() {
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
		transac.finishedAddingShares__c = true;
		transac.finishedPart1__c = false;
		transac.selectShareType__c = 'testclass';
		//transac.Form_Name__c = 'SH19';
		insert transac;

		//Shares__c testShare = new Shares__c();
		//testshare.transaction__c = transac.Id;
		//testshare.shareType__c = 'STATEMENTOFCAPITAL';
		//testshare.Class_of_Shares__c = 'testclass';
		//insert testShare;

		PageReference scapital3TestPage = Page.SCapital3;
		scapital3TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(scapital3TestPage);

		SCapitalController3 scap3controller = new SCapitalController3();
		scap3controller.checkstatus();
		scap3controller.confirmShares();
		scap3controller.addsameShare();
		scap3controller.choosePath();
		scap3controller.previousAction();
		scap3controller.shareStatus = false;

		scap3controller.nextAction();
		scap3controller.AddtocurrentShare();
		scap3controller.restartJourney();
		scap3controller.hasPageErrors = true;
		scap3controller.hasPageErrors = false;
		scap3controller.currentErrorMessage = 'testmessage';
		scap3controller.currentErrorMessage = '';

		scap3controller.shareStatus = true;
		scap3controller.choosePath();
		scap3controller.nextAction();

	}
}