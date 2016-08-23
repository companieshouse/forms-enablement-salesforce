@isTest
private class whichDirectorTest {


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
		transac.isPresenterMultipleDirectors__c = true;
		insert transac;

		testContact.Transaction__c = transac.id;
		insert testContact;
		Officer__c testoff = new Officer__c();
		testoff.Surname__c = 'testsurname';
		testoff.Forename__c = 'testforename';
		testoff.Middlenames__c = 'testmiddlename';
		testoff.Email__c = 'testEmail@testemail.com';
		testoff.IsPresenter__c = true;
		testoff.Transaction__c = transac.Id;
		testoff.Contact__c = testContact.id;
		insert testoff;

		PageReference whichDirector1testpage = Page.whichDirector;
		whichDirector1testpage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(whichDirector1testpage);
		whichDirector test1controller = new whichDirector();

		test1controller.checkDirectorStatus();
		test1controller.selectPresenter();
		test1controller.nextAction();
		test1controller.selectedid = testoff.id;
		test1controller.selectPresenter();
		test1controller.nextAction();
		test1controller.previousAction();
		test1controller.isPageAlreadyValidStep = true;
		system.debug('your transaction manager' + test1controller.transactionMgr);
		test1controller.isPageAlreadyValidStep = true;

		//test1controller.transactionMgr = new TransactionManager('DS01');
		test1controller.redirectUser();
		//test1controller.checkDirectorStatus();

	}

	@isTest static void test_method_two() {
		//multiple test
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
		transac.isPresenterMultipleDirectors__c = true;
		transac.Presenter__c = testPresenter.Id;
		transac.company__r = testcompany;
		transac.SoleDirectorPresenter__c = true;
		insert transac;

		testContact.Transaction__c = transac.id;
		insert testContact;
		Officer__c testoff = new Officer__c();
		testoff.Surname__c = 'testsurname';
		testoff.Forename__c = 'testforename';
		testoff.Middlenames__c = 'testmiddlename';
		testoff.Email__c = 'testEmail@testemail.com';
		testoff.IsPresenter__c = true;
		testoff.Transaction__c = transac.Id;
		testoff.Contact__c = testContact.id;
		insert testoff;

		PageReference whichDirector1testpage = Page.whichDirector;
		whichDirector1testpage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(whichDirector1testpage);
		whichDirector test1controller = new whichDirector();
		test1controller.checkDirectorStatus();
		test1controller.currentError = '';
		test1controller.selectPresenter();
		test1controller.nextAction();
		test1controller.selectedid = testoff.id;
		test1controller.selectPresenter();
		test1controller.nextAction();
		test1controller.previousAction();
		test1controller.isPageAlreadyValidStep = false;
		system.debug('your transaction manager' + test1controller.transactionMgr.td);

		//test1controller.transactionMgr = new TransactionManager('DS01');
		test1controller.redirectUser();
		//test1controller.checkDirectorStatus();


	}

}