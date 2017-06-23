@isTest
private class DocStatusControllerTest {

	@isTest static void test_method_one() {

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
		transac.Form_Name__c = 'SH19';

		insert transac;


		Blob test2pdfBlob;
		test2pdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment2 = new Attachment();
		testAttachment2.ParentId = transac.Id;
		testAttachment2.Description = 'Solvency statement';
		testAttachment2.Name = 'Solvency statement' + '.pdf';
		testAttachment2.Body = test2pdfBlob;
		insert testAttachment2;



		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment = new Attachment();
		testAttachment.ParentId = transac.Id;
		testAttachment.Description = 'Resolution';
		testAttachment.Name = 'Resolution' + '.pdf';
		testAttachment.Body = testpdfBlob;
		insert testAttachment;
		PageReference documentStatusPage2 = Page.Status;
		documentStatusPage2.getParameters().put('state', 'testNonce2');
		Test.setCurrentPage(documentStatusPage2);
		SecurityManager.createSessionValidityCookie('test@test.com');
		DocStatusController test2controller = new DocStatusController();
		Company_Authorisation__c testAuth = new Company_Authorisation__c();
		testAuth.Company_Access_Token__c = 'test';
		testAuth.Company_Number__c = '9872734234';
		testAuth.userEmail__c = 'test@test.com';
		testAuth.User_Id__c = 'testuserId';
		testAuth.Nonce__c = 'testNonce2';
		testAuth.Transaction_Type__c = 'DS01';
		insert testAuth;

		test2controller.parseQueryString();
		test2controller.findCompanyAuthByNonce();
	}

	@isTest static void test_method_two() {

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
		transac.Form_Name__c = 'SH19';

		insert transac;


		Blob test2pdfBlob;
		test2pdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment2 = new Attachment();
		testAttachment2.ParentId = transac.Id;
		testAttachment2.Description = 'Solvency statement';
		testAttachment2.Name = 'Solvency statement' + '.pdf';
		testAttachment2.Body = test2pdfBlob;
		insert testAttachment2;



		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment = new Attachment();
		testAttachment.ParentId = transac.Id;
		testAttachment.Description = 'Resolution';
		testAttachment.Name = 'Resolution' + '.pdf';
		testAttachment.Body = testpdfBlob;
		insert testAttachment;
		PageReference documentStatusPage = Page.Status;
		documentStatusPage.getParameters().put('documentsigningstatus', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'));
		Test.setCurrentPage(documentStatusPage);
		SecurityManager.createSessionValidityCookie('test@test.com');
		DocStatusController test2controller = new DocStatusController();
		Company_Authorisation__c testAuth = new Company_Authorisation__c();
		testAuth.Company_Access_Token__c = 'test';
		testAuth.Company_Number__c = '9872734234';
		testAuth.userEmail__c = 'test@test.com';
		testAuth.User_Id__c = 'testuserId';
		testAuth.Nonce__c = 'testNonce';
		testAuth.Transaction_Type__c = 'DS01';
		insert testAuth;

		test2controller.initialiseController();
		test2controller.directorName = 'testdirector';
		test2controller.directorSigningStatus = 'signingfinished';
		test2controller.directorDateofBirth = 'Yesterday';
		test2controller.docusignobjectsname = 'docusignObject';
		test2controller.title = 'testtitle';
		test2controller.attachmentId = testAttachment.id;
		test2controller.size = 'testsize';
		test2controller.companytypetext = 'test text';
		test2controller.companyStatus = 'test company status';
		test2controller.companyDateOfCreation = 'companycreationdate yesterday';
		test2controller.showprevious = true;
		test2controller.informationstuff = 'testinformationstuff';

		//test2controller.DestroyCookies();


	}

	@isTest static void testauthCode() {

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
		transac.Form_Name__c = 'SH19';

		insert transac;


		Blob test2pdfBlob;
		test2pdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment2 = new Attachment();
		testAttachment2.ParentId = transac.Id;
		testAttachment2.Description = 'Solvency statement';
		testAttachment2.Name = 'Solvency statement' + '.pdf';
		testAttachment2.Body = test2pdfBlob;
		insert testAttachment2;

		Company_Authorisation__c cp = new Company_Authorisation__c();
		cp.Nonce__c = 'nonce';
		cp.Company_Number__c = '9872734234';
		cp.Transaction_Type__c = 'DS01';
		insert cp;

		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment = new Attachment();
		testAttachment.ParentId = transac.Id;
		testAttachment.Description = 'Resolution';
		testAttachment.Name = 'Resolution' + '.pdf';
		testAttachment.Body = testpdfBlob;
		insert testAttachment;
		PageReference documentStatusPage = Page.Status;

		documentStatusPage.getParameters().put('nonce', 'dwojdwoj');
		documentStatusPage.getParameters().put('code', 'dwojdwoj');
		documentStatusPage.getParameters().put('documentsigningstatus', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'));
		Test.setCurrentPage(documentStatusPage);
		SecurityManager.createSessionValidityCookie('test@test.com');
		DocStatusController test2controller = new DocStatusController();
		Company_Authorisation__c testAuth = new Company_Authorisation__c();
		testAuth.Company_Access_Token__c = 'test';
		testAuth.Company_Number__c = '9872734234';
		testAuth.userEmail__c = 'test@test.com';
		testAuth.User_Id__c = 'testuserId';
		testAuth.Nonce__c = 'testNonce';
		testAuth.Transaction_Type__c = 'DS01';
		insert testAuth;
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessTokenAuth());
		test2controller.initialiseController();

		Test.stopTest();


	}

		@isTest static void testauthCode2() {

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
		transac.Form_Name__c = 'SH19';

		insert transac;


		Blob test2pdfBlob;
		test2pdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment2 = new Attachment();
		testAttachment2.ParentId = transac.Id;
		testAttachment2.Description = 'Solvency statement';
		testAttachment2.Name = 'Solvency statement' + '.pdf';
		testAttachment2.Body = test2pdfBlob;
		insert testAttachment2;



		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment = new Attachment();
		testAttachment.ParentId = transac.Id;
		testAttachment.Description = 'Resolution';
		testAttachment.Name = 'Resolution' + '.pdf';
		testAttachment.Body = testpdfBlob;
		insert testAttachment;
		PageReference documentStatusPage = Page.Status;
		documentStatusPage.getParameters().put('code', 'dwojdwoj');
		documentStatusPage.getParameters().put('documentsigningstatus', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'));
		Test.setCurrentPage(documentStatusPage);
		SecurityManager.createSessionValidityCookie('test@test.com');
		DocStatusController test2controller = new DocStatusController();
		Company_Authorisation__c testAuth = new Company_Authorisation__c();
		testAuth.Company_Access_Token__c = 'test';
		testAuth.Company_Number__c = '9872734234';
		testAuth.userEmail__c = 'test@test.com';
		testAuth.User_Id__c = 'testuserId';
		testAuth.Nonce__c = 'testNonce';
		testAuth.Transaction_Type__c = 'DS01';
		insert testAuth;
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessTokenAuth());

		Cookie d_valueTType = new Cookie('documentsigningstatus', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'), null, -1, true);
		ApexPages.currentPage().setCookies(new Cookie[] {
                                               d_valueTType
                                           });
		 		test2controller.initialiseController();

		Test.stopTest();


	}
		@isTest static void testauthCode3() {

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
		transac.Form_Name__c = 'SH19';

		insert transac;


		Blob test2pdfBlob;
		test2pdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment2 = new Attachment();
		testAttachment2.ParentId = transac.Id;
		testAttachment2.Description = 'Solvency statement';
		testAttachment2.Name = 'Solvency statement' + '.pdf';
		testAttachment2.Body = test2pdfBlob;
		insert testAttachment2;

		Company_Authorisation__c cp = new Company_Authorisation__c();
		cp.Nonce__c = 'nonce';
		cp.Company_Number__c = '05448736';
		cp.Transaction_Type__c = 'DS01';
		insert cp;

		Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment = new Attachment();
		testAttachment.ParentId = transac.Id;
		testAttachment.Description = 'Resolution';
		testAttachment.Name = 'Resolution' + '.pdf';
		testAttachment.Body = testpdfBlob;
		insert testAttachment;
		PageReference documentStatusPage = Page.Status;

		documentStatusPage.getParameters().put('state', 'nonce');
		documentStatusPage.getParameters().put('code', 'dwojdwoj');

		documentStatusPage.getParameters().put('documentsigningstatus', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'));
		Test.setCurrentPage(documentStatusPage);
		SecurityManager.createSessionValidityCookie('test@test.com');
		DocStatusController test2controller = new DocStatusController();
		Cookie d_valueTType = new Cookie('d_valueTType', SecurityManager.encryptText('DS01'), null, -1, true);

        Cookie d_valueEmail = new Cookie('d_valueEmail', SecurityManager.encryptText('test@email.com'), null, -1, true);

        Cookie d_valueId = new Cookie('d_valueId', SecurityManager.encryptText(transac.Id), null, -1, true);

        Cookie d_valueCookieStatus = new Cookie('d_valueCookieStatus', SecurityManager.encryptText('setauth'), null, -1, true);

        //Cookie d_valueEnvelopeId = new Cookie('d_valueEnvelopeId', SecurityManager.encryptText(envelopeID), null, -1, true);

        ApexPages.currentPage().setCookies(new Cookie[] {
                                               d_valueTType,
                                               d_valueEmail,
                                               d_valueId,
                                               d_valueCookieStatus
                                           });

		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessTokenAuth());
		test2controller.initialiseController();

		Test.stopTest();


	}

}