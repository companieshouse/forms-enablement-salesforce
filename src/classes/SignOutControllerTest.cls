@isTest
private class SignOutControllerTest {

	@isTest static void test_signOut() {

		PageReference signOutTestPage = Page.SignOut;
		
		Test.setCurrentPage(signOutTestPage);

		SignOutController testSignOutController = new SignOutController();
		testSignOutController.signOut();

	}

}