@isTest
private class AccountsAuthCallbackControllerTest {
	
	private static final String QUERY_STRING_PARAM_NONCE = 'state';
    private static final String QUERY_STRING_PARAM_AUTH_CODE = 'code';

	@isTest static void test_method_one() {
		// Implement test code
		AccountsAPIHelper.UserProfile testUP = new AccountsAPIHelper.UserProfile();
		testUP.email = 'Syl@lfl.com';
		testUP.id = '2222222';

		PageReference testP = Page.AccountsAuthCallback;

		testP.getParameters().put(QUERY_STRING_PARAM_NONCE, 'dwawdwadw');
		testP.getParameters().put(QUERY_STRING_PARAM_AUTH_CODE, 'dwawdwadw');

		Test.setCurrentPage(testP);

		AccountsAuthCallbackController at = new AccountsAuthCallbackController();

		at.nonce = 'dwawdwa';
		at.authCode = 'dawawda';
		at.userProfileApiResponse = testUP;


		at.initialiseAction();

	}
	
}