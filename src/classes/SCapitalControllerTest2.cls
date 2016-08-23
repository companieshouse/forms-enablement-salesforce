@IsTest
public with sharing class SCapitalControllerTest2 {
	public SCapitalControllerTest2() {
		test_method_one();
		test_method_two();
		test_method_three();
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

		PageReference scapital2TestPage = Page.SCapital2;
		scapital2TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(scapital2TestPage);

		scapitalcontroller2 scap2controller = new scapitalcontroller2();
		scap2controller.addsameShare();

		scap2controller.previousAction();


		scap2controller.nextAction();
		scap2controller.AddtocurrentShare();
		scap2controller.checkstatus();






		scap2controller.nextAction();

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

		PageReference scapital2TestPage = Page.SCapital2;
		scapital2TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(scapital2TestPage);

		scapitalcontroller2 scap2controller = new scapitalcontroller2();
		scap2controller.checkstatus();
		scap2controller.addsameShare();
		scap2controller.getcurrencies();
		scap2controller.previousAction();
		scap2controller.grabAggUnpaidNon0Value();
		scap2controller.grabAggUnpaid();
		scap2controller.grabAggNomValue ();
		scap2controller.grabnumberOfShares ();
		scap2controller.grabCurrencyType();
		scap2controller.showOtherAgg();
		scap2controller.showCurrencyOther();
		scap2controller.nextAction();
		scap2controller.AddtocurrentShare();
		scap2controller.addnewShares();
		scap2controller.currencyType = 'testcurrencytype';
		scap2controller.addnewShares();
		scap2controller.numberofshares = 100;
		scap2controller.addnewShares();
		scap2controller.nominalvalue = 100;
		scap2controller.addnewShares();
		scap2controller.aggUnpaid = 1;
		scap2controller.addnewShares();
		scap2controller.aggUnpaid = 0;
		scap2controller.addnewShares();
		scap2controller.shareClassType = '';
		scap2controller.addnewShares();
		scap2controller.shareClassType = 'testshareclasstype';
		scap2controller.addnewShares();
		scap2controller.grabAggUnpaid();
		scap2controller.aggHidden = '';
		scap2controller.aggHidden = 'test';
		scap2controller.hasPageErrors = true;
		scap2controller.hasPageErrors = false;
		scap2controller.nextAction();
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
		insert transac;

		PageReference scapital2TestPage = Page.SCapital2;
		scapital2TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(scapital2TestPage);

		scapitalcontroller2 scap2controller = new scapitalcontroller2();
		scap2controller.checkstatus();
		scap2controller.addsameShare();

		scap2controller.previousAction();


		scap2controller.nextAction();
		scap2controller.AddtocurrentShare();

		scap2controller.hasPageErrors = true;
		scap2controller.hasPageErrors = false;





		scap2controller.nextAction();

	}
}