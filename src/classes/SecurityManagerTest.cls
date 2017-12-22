@isTest
private class SecurityManagerTest {

	@isTest static void test_method_one() {

		SecurityManager secManagerControllerTester = new SecurityManager();

		secManagerControllerTester.validateAuthenticatedState('test String', 'testString');

		secManagerControllerTester.getUserAuthRedirect(null);
		secManagerControllerTester.getNonce();
		SecurityManager.decryptText(SecurityManager.encryptText('text encrypted'));
		SecurityManager.encryptText('texttoencrypt');
		secManagerControllerTester.getCompanyAuthRedirect('05448736', 'DS01');
		secManagerControllerTester.getDownloadAuthRedirect('05448736', 'DS01');
		secManagerControllerTester.getDocumentStatusAuthRedirect('05448736', 'DS01');
		SecurityManager.createSessionValidityCookie('Email');
		SecurityManager.checkSessionValidityCookie('Email', null, null, null);
		SecurityManager.removeSessionValidityCookie();
		SecurityManager.checkSessionValidityCookie('Email', null, null, null);
	}
}