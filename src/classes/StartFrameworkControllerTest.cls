@IsTest public with sharing class StartFrameworkControllerTest {

	@isTest static void noGUidance() {
		PageReference noGuidanceTestPage = Page.StartFramework;
		noGuidanceTestPage.getParameters().put('t', '');
		Test.setCurrentPage(noGuidanceTestPage);
		StartFrameworkController noguidancecontroller = new StartFrameworkController();
		noguidancecontroller.hasGuidancePage = false;
		noguidancecontroller.startAction();
	}

	@isTest static void test_method_two() {

// build page with t parameter and initialize controller
		PageReference startTestPage = Page.StartFramework;
		startTestPage.getParameters().put('t', 'DS01');
		Test.setCurrentPage(startTestPage);
		StartFrameworkController controller = new StartFrameworkController();
		pageReference p = controller.initialiseAction();
		controller.transactionType = 'DS01';
		PageReference pr = new PageReference('/Guidance');
		pr.getParameters().put('t', controller.transactionType);
		pr.setRedirect(true);
		controller.startAction();
	}
}