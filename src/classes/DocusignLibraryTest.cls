@isTest
private class DocusignLibraryTest {
	
	@isTest static void test_buildAuthString() {
		// Implement test code
		//

		String username = 'SylvainTest';
		String password = 'SylvainPassword';
		String integratorKey = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

		String expectedResult = '<DocuSignCredentials><Username>SylvainTest</Username><Password>SylvainPassword</Password><IntegratorKey>ABCDEFGHIJKLMNOPQRSTUVWXYZ</IntegratorKey></DocuSignCredentials>';

		system.assertEquals(expectedResult, DocusignLibrary.buildAuthString(username, password, integratorKey));
	}

	@isTest static void test_buildHTTPHeaders() {
		// Implement test code
		String auth = 'authString';

		Map<String, String> expectedResult = new Map<String, String>();

		expectedResult.put('X-DocuSign-Authentication', auth);

		system.assertEquals(expectedResult, DocusignLibrary.buildHTTPHeaders(auth));
	}
	 
	@isTest static void test_getNotification(){
		
		DocuSignAPI.Notification expectedResult = new DocuSignAPI.Notification();
		expectedResult.UseAccountDefaults = true;

		system.assertEquals(expectedResult.UseAccountDefaults, DocusignLibrary.getNotification(true).UseAccountDefaults);
	}

}