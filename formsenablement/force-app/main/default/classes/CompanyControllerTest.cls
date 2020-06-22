@isTest
private class CompanyControllerTest {

	@isTest static void test_method_one() {
		PageReference companyTestPage = Page.Company;
		companyTestPage.getParameters().put('t', 'DS01');

		Test.setCurrentPage(companyTestPage);
				SecurityManager.createSessionValidityCookie('test@test.com');


		CompanyController controller = new CompanyController();
		controller.companyNumber = '';
		controller.nextAction();
		controller.companyNumber = '123456789';
		controller.nextAction();
		controller.companyNumber = '12345';
		controller.nextAction();
		controller.companyNumber = '12345jkl';
		controller.nextAction();
		controller.companyNumber = '1234567';
		controller.nextAction();
		controller.previousAction();

		controller.companyNumber = '12345678';
		controller.nextAction();

	}


	@isTest static void test_method_two() {
		PageReference companyTestPage = Page.Company;
		companyTestPage.getParameters().put('t', 'DS02');

		Test.setCurrentPage(companyTestPage);
				SecurityManager.createSessionValidityCookie('test@test.com');


		CompanyController controller = new CompanyController();
		controller.companyNumber = '';
		controller.nextAction();
		controller.companyNumber = '123456789';
		controller.nextAction();
		controller.companyNumber = '12345';
		controller.nextAction();
		controller.companyNumber = '12345jkl';
		controller.nextAction();
		controller.companyNumber = '1234567';
		controller.nextAction();
		controller.previousAction();
		Cookie current_userEmail = new Cookie('user_Email', SecurityManager.encryptText('sylvain.picory@methodsdigita.co.uk'), null, -1, true);
        // set time to 0 instead of -1 to remove cookie

        ApexPages.currentPage().setCookies(new Cookie[] { current_userEmail });

		controller.initialiseAction();
		controller.companyNumber = '12345678';
		controller.nextAction();

	}

	@isTest static void test_Test() {
		PageReference companyTestPage = Page.Company;
		companyTestPage.getParameters().put('t', 'DS02');

		Test.setCurrentPage(companyTestPage);
				SecurityManager.createSessionValidityCookie('test@test.com');

		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessTokenAuth());
		CompanyController controller = new CompanyController();
		controller.validateStep();

		controller.companyNumber = 'TestTestTest';
		controller.validateStep();		
		controller.companyNumber = 'TestTest';
		controller.validateStep();		
		controller.companyNumber = 'stTest';
		controller.validateStep();			
		Test.stopTest();
	}

	@isTest static void test_Test2() {
		PageReference companyTestPage = Page.Company;
		companyTestPage.getParameters().put('t', 'DS02');

		Test.setCurrentPage(companyTestPage);
				SecurityManager.createSessionValidityCookie('test@test.com');

		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessTokenAuth());
		CompanyController controller = new CompanyController();
		
		controller.companyNumber = '05448736';
		controller.transactionType = 'LLDS01';
		controller.validateStep();		
		Test.stopTest();
	}

		@isTest static void test_Test3() {
		PageReference companyTestPage = Page.Company;
		companyTestPage.getParameters().put('t', 'DS02');

		Test.setCurrentPage(companyTestPage);
				SecurityManager.createSessionValidityCookie('test@test.com');

		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessTokenAuthLLP());
		CompanyController controller = new CompanyController();
		
		controller.companyNumber = '05448736';
		controller.transactionType = 'DS01';
		controller.validateStep();		
		Test.stopTest();
	}

	@isTest static void test_Test4() {
		PageReference companyTestPage = Page.Company;
		companyTestPage.getParameters().put('t', 'DS02');

		Test.setCurrentPage(companyTestPage);
				SecurityManager.createSessionValidityCookie('test@test.com');

		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessTokenAuthERRORCOMPANY());
		CompanyController controller = new CompanyController();
		
		controller.companyNumber = '05448736';
		controller.transactionType = 'DS01';
		controller.validateStep();		
		Test.stopTest();
	}

		@isTest static void test_Test5() {
		PageReference companyTestPage = Page.Company;
		companyTestPage.getParameters().put('t', 'DS02');

		Test.setCurrentPage(companyTestPage);
				SecurityManager.createSessionValidityCookie('test@test.com');

		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessTokenAuth());
		CompanyController controller = new CompanyController();
		
		controller.companyNumber = '05448736';
		controller.transactionType = 'DS01';
		controller.nextAction();		
		controller.previousAction();
		Test.stopTest();
	}
}