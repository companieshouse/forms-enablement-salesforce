@isTest
private class DocumentControllerTest {

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
		PageReference documentsTestPage2 = Page.Documents;
		documentsTestPage2.getParameters().put('state', 'testNonce2');
		Test.setCurrentPage(documentsTestPage2);
		SecurityManager.createSessionValidityCookie('test@test.com');
		DocumentController test2controller = new DocumentController();
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
		PageReference documentsTestPage = Page.Documents;
		documentsTestPage.getParameters().put('documentdownload', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'));
		Test.setCurrentPage(documentsTestPage);
		SecurityManager.createSessionValidityCookie('test@test.com');
		DocumentController test2controller = new DocumentController();
		Company_Authorisation__c testAuth = new Company_Authorisation__c();
		testAuth.Company_Access_Token__c = 'test';
		testAuth.Company_Number__c = '9872734234';
		testAuth.userEmail__c = 'test@test.com';
		testAuth.User_Id__c = 'testuserId';
		testAuth.Nonce__c = 'testNonce';
		testAuth.Transaction_Type__c = 'DS01';
		insert testAuth;

		test2controller.initialiseController();
		//test2controller.getDocumentDownloadTransaction();

		//test2controller.DestroyCookies();


	}

}