@IsTest public with sharing class  GuidanceControllerTest {


	@isTest static void test_method_one() {
		PageReference guidanceTestPage = Page.Guidance;
		guidanceTestPage.getParameters().put('t', 'DS01');

		Test.setCurrentPage(guidanceTestPage);
		SecurityManager.createSessionValidityCookie('test@test.com');
		GuidanceController controller = new GuidanceController();
		controller.customGuidanceView = false;
		controller.standardGuidanceView = true;
		controller.agreeBoxChoice = null;
		controller.setAgreeValue();
		controller.nextAction();
		controller.previousAction();
		controller.initialiseStep();
		controller.agreeBoxChoice = true;
		controller.setAgreeValue();
		controller.nextAction();
		controller.previousAction();
	}

	@isTest static void test_method_two() {

		PageReference guidance2TestPage = Page.Guidance;
		guidance2TestPage.getParameters().put('t', 'TestForm');
		Test.setCurrentPage(guidance2TestPage);
		SecurityManager.createSessionValidityCookie('test@test.com');
		GuidanceController test2controller = new GuidanceController();
		test2controller.customGuidanceView = true;
		test2controller.standardGuidanceView = false;
		test2controller.agreeBoxChoice = null;
		test2controller.setAgreeValue();
		test2controller.nextAction();
		test2controller.previousAction();
		test2controller.customGuidanceView = false;
		test2controller.standardGuidanceView = true;
		test2controller.agreeBoxChoice = true;
		test2controller.initialiseStep();
		test2controller.setAgreeValue();
		test2controller.nextAction();
		test2controller.previousAction();
		test2controller.agreeBoxChoice = false;
		test2controller.setAgreeValue();
		test2controller.nextAction();
		test2controller.previousAction();

	}

}