@isTest
private class AccountsAuthCallbackControllerTest {
	
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
				transac.Valid_Step_Ids__c = 'odjawojwaojdwojaw';


		insert transac;

		RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
		Account acc = new Account();
		acc.RecordType = personAccountRecordType;
		acc.LastName = 'TestSylvaincutomst';
		acc.PersonEmail = 'test@email.com';
		insert acc;

		Account acc2 = new Account();
		acc2.CompanyNumber__c = '05448736';
		acc2.AccountNumber = 'waddwwa';
		acc2.Name = 'wdaniawidjiawhjih11q3lz!';
		insert acc2;

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

		User_Authorisation__c au = new User_Authorisation__c();
		au.Nonce__c = 'nonce';

		insert au;

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
		documentStatusPage.getParameters().put('nonce', 'dwojdwoj');
		documentStatusPage.getParameters().put('code', 'dwojdwoj');
		documentStatusPage.getParameters().put('documentsigningstatus', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'));
		Test.setCurrentPage(documentStatusPage);
				Cookie t_value = new Cookie('t_value', SecurityManager.encryptText('DS01'), null, 0, true);

    t_value = new Cookie('t_value', SecurityManager.encryptText('DS01'), null, -1, true);
    //user_Email
    Cookie d_valueCookieStatus2 = new Cookie('d_valueCookieStatus', SecurityManager.encryptText('initial'), null, -1, true);
    Cookie user_Email = new Cookie('user_Email', SecurityManager.encryptText('test@email.com'), null, -1, true);
    Cookie searched_company = new Cookie('searched_company', SecurityManager.encryptText('05448736'), null, -1, true);
//05448736
    ApexPages.currentPage().setCookies(new Cookie[] { t_value, d_valueCookieStatus2, user_Email, searched_company });

		SecurityManager.createSessionValidityCookie('test@test.com');
		AccountsAuthCallbackController test2controller = new AccountsAuthCallbackController();
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
		test2controller.initialiseAction();

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
		transac.Valid_Step_Ids__c = 'odjawojwaojdwojaw';

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
		documentStatusPage.getParameters().put('state', 'nonce');
		documentStatusPage.getParameters().put('code', 'dwojdwoj');
		documentStatusPage.getParameters().put('documentsigningstatus', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'));
		Test.setCurrentPage(documentStatusPage);
		SecurityManager.createSessionValidityCookie('test@test.com');
		AccountsAuthCallbackController test2controller = new AccountsAuthCallbackController();
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
		 		test2controller.initialiseAction();

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

		RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
		Account acc = new Account();
		acc.RecordType = personAccountRecordType;
		acc.LastName = 'TestSylvaincutomst';
		acc.PersonEmail = 'test@email.com';
		insert acc;

		Account acc2 = new Account();
		acc2.CompanyNumber__c = '05448736';
		acc2.AccountNumber = 'waddwwa';
		acc2.Name = 'wdaniawidjiawhjih11q3lz!';
		insert acc2;

		Transaction__c transac = testData.tx;
		transac.Company__c = acc2.Id;
		transac.Status__c = 'Draft';
		transac.Presenter__c = acc.Id;
		transac.ContactEmail__c = 'test@email.com';
		transac.Valid_Step_Ids__c = testStep1.Id;
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = false;
		transac.Form_Name__c = 'DS01';
				transac.Valid_Step_Ids__c = testStep1.Id;


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
		documentStatusPage.getParameters().put('nonce', 'dwojdwoj');
		documentStatusPage.getParameters().put('code', 'dwojdwoj');
		documentStatusPage.getParameters().put('documentsigningstatus', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'));
		Test.setCurrentPage(documentStatusPage);
				Cookie t_value = new Cookie('t_value', SecurityManager.encryptText('DS01'), null, 0, true);

    t_value = new Cookie('t_value', SecurityManager.encryptText('DS01'), null, -1, true);
    //user_Email
    Cookie d_valueCookieStatus2 = new Cookie('d_valueCookieStatus', SecurityManager.encryptText('initial'), null, -1, true);
    Cookie user_Email = new Cookie('user_Email', SecurityManager.encryptText('test@email.com'), null, -1, true);
    Cookie searched_company = new Cookie('searched_company', SecurityManager.encryptText('05448736'), null, -1, true);
//05448736
    ApexPages.currentPage().setCookies(new Cookie[] { t_value, d_valueCookieStatus2, user_Email, searched_company });

		SecurityManager.createSessionValidityCookie('test@test.com');
		AccountsAuthCallbackController test2controller = new AccountsAuthCallbackController();
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
		test2controller.initialiseAction();

		Test.stopTest();


	}

	@isTest static void testauthCode4() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		// needs mock web callout information here for initialize step test
		insert testPresenter;

		insert testCompany;

		RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
		Account acc = new Account();
		acc.RecordType = personAccountRecordType;
		acc.LastName = 'TestSylvaincutomst';
		acc.PersonEmail = 'test@email.com';
		insert acc;

		Account acc2 = new Account();
		acc2.CompanyNumber__c = '05448736';
		acc2.AccountNumber = 'waddwwa';
		acc2.Name = 'wdaniawidjiawhjih11q3lz!';
		insert acc2;

		Transaction__c transac = testData.tx;
		transac.Company__c = acc2.Id;
		transac.Status__c = 'Draft';
		transac.ContactEmail__c = 'test@email.com';
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = false;

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
		documentStatusPage.getParameters().put('nonce', 'dwojdwoj');
		documentStatusPage.getParameters().put('code', 'dwojdwoj');
		documentStatusPage.getParameters().put('documentsigningstatus', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'));
		Test.setCurrentPage(documentStatusPage);
				Cookie t_value = new Cookie('t_value', SecurityManager.encryptText('DS01'), null, 0, true);

    t_value = new Cookie('t_value', SecurityManager.encryptText('DS01'), null, -1, true);
    //user_Email
    Cookie d_valueCookieStatus2 = new Cookie('d_valueCookieStatus', SecurityManager.encryptText('initial'), null, -1, true);
    Cookie user_Email = new Cookie('user_Email', SecurityManager.encryptText('test@email.com'), null, -1, true);
    Cookie searched_company = new Cookie('searched_company', SecurityManager.encryptText('05448736'), null, -1, true);
//05448736
    ApexPages.currentPage().setCookies(new Cookie[] { t_value, d_valueCookieStatus2, user_Email, searched_company });

		SecurityManager.createSessionValidityCookie('test@test.com');
		AccountsAuthCallbackController test2controller = new AccountsAuthCallbackController();
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
		test2controller.initialiseAction();

		test2controller.CallPageRedirect();
		try{
			documentStatusPage.getParameters().clear();
			test2controller.parseQueryString();
		}
		catch(Exception e)
		{

		}

		try{
			documentStatusPage.getParameters().put('state', 'nonce');
			test2controller.parseQueryString();
		}
		catch(Exception e)
		{

		}
		Test.stopTest();


	}

	@isTest static void testauthCode5() {

		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		// needs mock web callout information here for initialize step test
		insert testPresenter;

		insert testCompany;

		RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
		Account acc = new Account();
		acc.RecordType = personAccountRecordType;
		acc.LastName = 'TestSylvaincutomst';
		acc.PersonEmail = 'test@email.com';
		insert acc;

		Account acc2 = new Account();
		acc2.CompanyNumber__c = '05448736';
		acc2.AccountNumber = 'waddwwa';
		acc2.Name = 'wdaniawidjiawhjih11q3lz!';
		insert acc2;

		Transaction__c transac = testData.tx;
		transac.Company__c = acc2.Id;
		transac.Status__c = 'Draft';
		transac.ContactEmail__c = 'test@email.com';
		transac.CompanyNumber__c = '05448736';
		transac.finishedAttachments__c = false;

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
		documentStatusPage.getParameters().put('nonce', 'dwojdwoj');
		documentStatusPage.getParameters().put('code', 'dwojdwoj');
		documentStatusPage.getParameters().put('documentsigningstatus', SecurityManager.encryptText('DS01' + AppConstants.ID_DELIM_CHAR + 'test@email.com' + AppConstants.ID_DELIM_CHAR + transac.id + AppConstants.ID_DELIM_CHAR + '05448736'));
		Test.setCurrentPage(documentStatusPage);
				Cookie t_value = new Cookie('t_value', SecurityManager.encryptText('DS01'), null, 0, true);

    t_value = new Cookie('t_value', SecurityManager.encryptText('DS01'), null, -1, true);
    //user_Email
    Cookie d_valueCookieStatus2 = new Cookie('d_valueCookieStatus', SecurityManager.encryptText('initial'), null, -1, true);
    Cookie user_Email = new Cookie('user_Email', SecurityManager.encryptText('test@email.com'), null, -1, true);
    Cookie searched_company = new Cookie('searched_company', SecurityManager.encryptText('05448736'), null, -1, true);
//05448736
    ApexPages.currentPage().setCookies(new Cookie[] { t_value, d_valueCookieStatus2, user_Email, searched_company });

		SecurityManager.createSessionValidityCookie('test@test.com');
		AccountsAuthCallbackController test2controller = new AccountsAuthCallbackController();
		Company_Authorisation__c testAuth = new Company_Authorisation__c();
		testAuth.Company_Access_Token__c = 'test';
		testAuth.Company_Number__c = '9872734234';
		testAuth.userEmail__c = 'test@test.com';
		testAuth.User_Id__c = 'testuserId';
		testAuth.Nonce__c = 'testNonce';
		testAuth.Transaction_Type__c = 'DS01';
		insert testAuth;
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockFailTokenAuth());
		test2controller.initialiseAction();

		test2controller.CallPageRedirect();
		try{
			documentStatusPage.getParameters().clear();
			test2controller.parseQueryString();
		}
		catch(Exception e)
		{

		}

		try{
			documentStatusPage.getParameters().put('state', 'nonce');
			test2controller.parseQueryString();
		}
		catch(Exception e)
		{

		}
		Test.stopTest();


	}
	
}