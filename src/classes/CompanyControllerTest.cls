@isTest
private class CompanyControllerTest {

	@isTest static void test_method_one() {
		PageReference companyTestPage = Page.Company;
		companyTestPage.getParameters().put('t', 'DS01');

		Test.setCurrentPage(companyTestPage);
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('true' + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	companyTestPage.setCookies(new Cookie[]{sessionValidity});

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
		companyTestPage.getParameters().put('t', 'SH02');

		Test.setCurrentPage(companyTestPage);
		Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('true' + String.valueOf(DateTime.now().getTime())), '', 120, true);

    	companyTestPage.setCookies(new Cookie[]{sessionValidity});

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
		controller.initialiseAction();
		controller.companyNumber = '12345678';
		controller.nextAction();

	}
}