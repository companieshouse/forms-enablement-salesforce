@IsTest public with sharing class  GuidanceControllerTest {
	//@IsTest(SeeAllData = true) public static void GuidanceControllerTest() {
	//	test_method_one();

	//	test_method_two();
	//}

	@isTest static void test_method_one() {
		// test guidance page and not set aggree box
		PageReference guidanceTestPage = Page.Guidance;
		guidanceTestPage.getParameters().put('t', 'DS01');

		Test.setCurrentPage(guidanceTestPage);


		GuidanceController controller = new GuidanceController();
		controller.customGuidanceView = false;
		controller.standardGuidanceView = true;
		controller.agreeBoxChoice = false;

		controller.setAgreeValue();

		controller.nextAction();

		controller.previousAction();

	}

	@isTest static void test_method_two() {

// test guidance page and set aggree box
		PageReference guidance2TestPage = Page.Guidance;
		guidance2TestPage.getParameters().put('t', 'TestForm');

		Test.setCurrentPage(guidance2TestPage);



		GuidanceController test2controller = new GuidanceController();

		test2controller.customGuidanceView = true;
		test2controller.standardGuidanceView = false;
		test2controller.agreeBoxChoice = true;

		test2controller.setAgreeValue();

		test2controller.nextAction();

		test2controller.previousAction();


	}

}