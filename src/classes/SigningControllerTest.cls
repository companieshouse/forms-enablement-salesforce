@isTest
private class SigningControllerTest {

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
		transac.Transaction_Type__c = 'SH10';
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

		Attachment testAttachment = new Attachment();
		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		testAttachment.parentId = transac.id;
		testAttachment.description = 'testDescription';
		testAttachment.Name = 'SH10';
		testAttachment.body = testpdfBlob;
		insert testAttachment;

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

		PageReference signingtestPage = Page.SigningPage;
		signingtestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(signingtestPage);
		signingController test1controller = new signingController();
		test1controller.signingchoice = false;
		test1controller.setAuthorizerValue();
		test1controller.signingchoice = true;
		test1controller.setAuthorizerValue();
		test1controller.previousAction();
		test1controller.signingchoice = null;
		test1controller.nextAction();
		test1controller.signingchoice = false;
		test1controller.nextAction();
		test1controller.signingchoice = true;
		test1controller.nextAction();
	}

}