@isTest
public with sharing class DirectorDetailsTest {

	@isTest static void test_method_one() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
		Contact testContact = CompaniesHouseTestData.getInstance().contact1;

		Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
		insert testPresenter;

		insert testCompany;
		Transaction__c transac = testData.tx;
		transac.OfficerCount__c = 2;
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
		testContact2.Transaction__c = transac.id;
		insert testContact2;
		testContact.Transaction__c = transac.id;
		insert testContact;

		Officer__c testoff = new Officer__c();
		testoff.Surname__c = 'testsurname';
		testoff.Forename__c = 'testforename';
		testoff.Middlenames__c = 'testmiddlename';
		testoff.Email__c = 'testEmail@testemail.com';
		testoff.Name = 'testname1';
		testoff.IsPresenter__c = true;
		testoff.Transaction__c = transac.Id;
		testoff.Contact__c = testContact.id;
		testoff.isSignatory__c = true;

		insert testoff;

		Officer__c testoff2 = new Officer__c();
		testoff2.Surname__c = 'testsurname2';
		testoff2.Forename__c = 'testforename2';
		testoff2.Name = 'testname';
		testoff2.Middlenames__c = 'testmiddlename2';
		testoff2.Email__c = 'testEmail2@testemail2.com';
		testoff2.IsPresenter__c = false;
		testoff2.Transaction__c = transac.Id;
		testoff2.Contact__c = testContact2.id;
		testoff2.isSignatory__c = true;

		insert testoff2;


		PageReference officerDetailsTestPage = Page.OfficerDetails;
		officerDetailsTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(officerDetailsTestPage);
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('true' + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	officerDetailsTestPage.setCookies(new Cookie[]{sessionValidity});
		DirectorDetails test1controller = new DirectorDetails();

		test1controller.checkDirectorStatus();
		test1controller.nextAction();
		test1controller.previousAction();
		test1controller.emailValidation('testemailemail.com', 'testusernameString');
		test1controller.emailValidation('testemail@emailcom', 'testusernameString');
		test1controller.emailValidation('testemail@email.com', 'testusernameString');

		test1controller.emailComparison('testemail@email.com', 'testErroremail@email.com', 'testpersonusername');
		test1controller.emailComparison('testemail@email.com', 'testemail@email.com', 'testpersonusername');
		test1controller.saveWrappedDirectorsSelection();
		test1controller.isPageAlreadyValidStep = true;
		test1controller.redirectUser();

	}

}