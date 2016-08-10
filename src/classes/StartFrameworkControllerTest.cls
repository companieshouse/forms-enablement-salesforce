@IsTest public with sharing class StartFrameworkControllerTest {
	@IsTest(SeeAllData = true) public static void StartFrameworkControllerTest() {
		test_method_two();
		//noGuidancePage();
	}

	@isTest static void noGuidancePage() {
		//PageReference noGuidanceTestPage = Page.StartFramework;
		//noGuidanceTestPage.getParameters().put('t', 'CC04');

		//Test.setCurrentPage(noGuidanceTestPage);

		//Test.StartTest();

		//StartFrameworkController nogcontroller = new StartFrameworkController();
		////controller.pageTitle = 'PageTitle';
		////controller.pageText = 'pageText';
		////controller.pageTextAfterButton = 'PageTextAfterButton';
		////controller.initialiseAction();
		//pageReference w = nogcontroller.initialiseAction();

		//nogcontroller.transactionType = 'CC04';
		//SecurityManager securityMgr = new SecurityManager();

		//System.assertEquals(nogcontroller.startAction(), securityMgr.getUserAuthRedirect() );

		//System.assertEquals(nogcontroller.initialiseAction(), null);

		//Test.StopTest();

	}

	@isTest static void test_method_two() {

// build page with t parameter and initialize controller
		PageReference startTestPage = Page.StartFramework;
		startTestPage.getParameters().put('t', 'DS01');

		Test.setCurrentPage(startTestPage);

		Test.StartTest();

		StartFrameworkController controller = new StartFrameworkController();

		pageReference p = controller.initialiseAction();

		controller.transactionType = 'DS01';
		PageReference pr = new PageReference('/Guidance');
		pr.getParameters().put('t', controller.transactionType);
		pr.setRedirect(true);

		System.assertEquals(controller.startAction(), pr);

		System.assertEquals(controller.initialiseAction(), null);

		Test.StopTest();
	}
}