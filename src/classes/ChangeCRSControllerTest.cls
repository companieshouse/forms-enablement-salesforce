@isTest
private class ChangeCRSControllerTest {
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
		transac.finishedPart1__c = false;
		transac.SoleDirectorPresenter__c = false;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.isBehalfSignatoryEnable__c = true;
		transac.OfficerCount__c = 1;
		transac.shareChangeSelection__c = 'RECONVERSION';
		insert transac;

		Attachment testAttachment = new Attachment();
		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		testAttachment.parentId = transac.id;
		testAttachment.description = 'testDescription';
		testAttachment.Name = 'TestBlob';
		testAttachment.body = testpdfBlob;
		insert testAttachment;

		Shares__c testShare1 = new Shares__c();
		testshare1.transaction__c = transac.id;
		testshare1.sharetype__c = 'testshare';
		testshare1.ActiveData__c = true;
		insert testShare1;

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

		PageReference changeCRSTestPage = Page.ChangeCRS;
		changeCRSTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(changeCRSTestPage);
		ChangeCRSController test1controller = new ChangeCRSController();
		test1controller.classofshares = null;

		test1controller.goForward();

		test1controller.valOfStock = null;
		test1controller.addReconversion();
		test1controller.valOfStock = 10;
		test1controller.oldIssuedShares = null;
		test1controller.addReconversion();
		test1controller.oldIssuedShares = 10;
		test1controller.oldNomVal = null;
		test1controller.addReconversion();
		test1controller.oldNomVal = 10;
		test1controller.addReconversion();
		test1controller.addShare();
		test1controller.previousAction();
	}

	@isTest static void test_method_two() {

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
		transac.finishedPart1__c = true;
		transac.shareChangeSelection__c = 'SUBDIVISION';


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
		testAttachment.Name = 'TestBlob';
		testAttachment.body = testpdfBlob;
		insert testAttachment;

		Shares__c testShare1 = new Shares__c();
		testshare1.transaction__c = transac.id;
		testshare1.sharetype__c = 'testshare';
		testshare1.ActiveData__c = true;
		insert testShare1;

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

		PageReference changeCRSTestPage = Page.ChangeCRS;
		changeCRSTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(changeCRSTestPage);
		ChangeCRSController test1controller = new ChangeCRSController();
		test1controller.classofshares = null;

		test1controller.goForward();

		test1controller.oldIssuedShares = null;
		test1controller.addSubdivision();
		test1controller.oldIssuedShares = 10;
		test1controller.oldNomVal = null;
		test1controller.addSubdivision();
		test1controller.oldNomVal = 10;
		test1controller.newIssuedShares = null;
		test1controller.addSubdivision();
		test1controller.newIssuedShares = 10;
		test1controller.newNomVal = null;
		test1controller.addSubdivision();
		test1controller.newNomVal = 10;
		test1controller.addSubdivision();
		test1controller.addShare();
		test1controller.previousAction();
	}

	@isTest static void test_method_three() {

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
		transac.finishedPart1__c = false;
		transac.SoleDirectorPresenter__c = false;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.isBehalfSignatoryEnable__c = true;
		transac.OfficerCount__c = 1;
		transac.shareChangeSelection__c = 'CONSOLIDATION';

		insert transac;

		Attachment testAttachment = new Attachment();
		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		testAttachment.parentId = transac.id;
		testAttachment.description = 'testDescription';
		testAttachment.Name = 'TestBlob';
		testAttachment.body = testpdfBlob;
		insert testAttachment;

		Shares__c testShare1 = new Shares__c();
		testshare1.transaction__c = transac.id;
		testshare1.sharetype__c = 'testshare';
		testshare1.ActiveData__c = true;
		insert testShare1;

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

		PageReference changeCRSTestPage = Page.ChangeCRS;
		changeCRSTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(changeCRSTestPage);
		ChangeCRSController test1controller = new ChangeCRSController();
		test1controller.classofshares = null;

		test1controller.goForward();
		test1controller.oldIssuedShares = null;
		test1controller.addConsolidation();
		test1controller.oldIssuedShares = 10;
		test1controller.oldNomVal = null;
		test1controller.addConsolidation();
		test1controller.oldNomVal = 10;
		test1controller.newIssuedShares = null;
		test1controller.addConsolidation();
		test1controller.newIssuedShares = 10;
		test1controller.newNomVal = null;
		test1controller.addConsolidation();
		test1controller.newNomVal = 10;
		test1controller.addConsolidation();
		test1controller.addShare();
		test1controller.previousAction();


	}
	@isTest static void test_method_four() {

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
		transac.finishedPart1__c = false;
		transac.SoleDirectorPresenter__c = false;
		transac.isMajorityRequired__c = true;
		transac.isPresenterMultipleDirectors__c = true;
		transac.isBehalfSignatoryEnable__c = true;
		transac.OfficerCount__c = 1;
		transac.shareChangeSelection__c = 'REDEMPTION';

		insert transac;

		Attachment testAttachment = new Attachment();
		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		testAttachment.parentId = transac.id;
		testAttachment.description = 'testDescription';
		testAttachment.Name = 'TestBlob';
		testAttachment.body = testpdfBlob;
		insert testAttachment;

		Shares__c testShare1 = new Shares__c();
		testshare1.transaction__c = transac.id;
		testshare1.sharetype__c = 'testshare';
		testshare1.ActiveData__c = true;
		insert testShare1;

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

		PageReference changeCRSTestPage = Page.ChangeCRS;
		changeCRSTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		Test.setCurrentPage(changeCRSTestPage);
		ChangeCRSController test1controller = new ChangeCRSController();
		test1controller.classofshares = null;

		test1controller.goForward();
		test1controller.oldIssuedShares = null;
		test1controller.addRedemption();
		test1controller.oldIssuedShares = 10;
		test1controller.oldNomVal = null;
		test1controller.addRedemption();
		test1controller.oldNomVal = 10;
		test1controller.addRedemption();
		test1controller.addShare();
		test1controller.previousAction();
	}

}