@isTest
private class CompanyControllerTest {

	@isTest static void test_method_one() {
		PageReference companyTestPage = Page.Company;
		companyTestPage.getParameters().put('t', 'DS01');

		Test.setCurrentPage(companyTestPage);

		CompanyController controller = new CompanyController();

		controller.companyNumber = '123456789';
		controller.nextAction();
		controller.previousAction();

		controller.companyNumber = '12345678';
		controller.nextAction();
		controller.previousAction();

	}


}