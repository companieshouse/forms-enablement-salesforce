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
}