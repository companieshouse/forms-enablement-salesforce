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
	 
	@isTest static void test_getCaptiveInfo(){
		
		DocuSignAPI.RecipientCaptiveInfo expectedResult = new DocuSignAPI.RecipientCaptiveInfo();
		expectedResult.ClientUserId = 'true';

		system.assertEquals(expectedResult.ClientUserId, DocusignLibrary.getCaptiveInfo('true').ClientUserId);
	}

	@isTest static void test_getNotification(){
		
		DocuSignAPI.Notification expectedResult = new DocuSignAPI.Notification();
		expectedResult.UseAccountDefaults = true;

		system.assertEquals(expectedResult.UseAccountDefaults, DocusignLibrary.getNotification(true).UseAccountDefaults);
	}

	@isTest static void test_getEnvelope(){
		String accountId = 'SylvainAcc';
		String subject = 'SylvainSubject';
		String emailBlurb = 'Blurb';
		String brandId = '001';

		DocuSignAPI.Envelope expectedResult = new DocuSignAPI.Envelope();

		expectedResult.AccountId = accountId;
		expectedResult.Subject = subject;
		expectedResult.EmailBlurb = emailBlurb;
		expectedResult.BrandId = brandId;

		DocuSignAPI.Envelope result = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);

		system.assertEquals(expectedResult.AccountId, result.AccountId);
		system.assertEquals(expectedResult.Subject, result.Subject);
		system.assertEquals(expectedResult.EmailBlurb, result.EmailBlurb);
		system.assertEquals(expectedResult.BrandId, result.BrandId);
	}

	@isTest static void test_addNotification(){
		String accountId = 'SylvainAcc';
		String subject = 'SylvainSubject';
		String emailBlurb = 'Blurb';
		String brandId = '001';
		DocuSignAPI.Envelope expectedResult = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);
		expectedResult.Notification = DocusignLibrary.getNotification(true);

		DocuSignAPI.Envelope result = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);

		System.assertEquals(expectedResult.Notification.UseAccountDefaults, (DocusignLibrary.addNotification(result,DocusignLibrary.getNotification(true))).Notification.UseAccountDefaults);
	}

	@isTest static void test_getCustomField(){
		String name = 'Sylvain';
		String value = 'ValueS';
		String type = 'TypeS';

		DocuSignAPI.CustomField expectedResult = new DocuSignAPI.CustomField();
		expectedResult.Name = name;
		expectedResult.Value = value;
		expectedResult.CustomFieldType = type;

		DocuSignAPI.CustomField result = DocusignLibrary.getCustomField(name, value, type);

		system.assertEquals(expectedResult.Name, result.Name);
		system.assertEquals(expectedResult.Value, result.Value);
		system.assertEquals(expectedResult.CustomFieldType, result.CustomFieldType);
	}

    @isTest static void test_addCustomFields(){
    	String accountId = 'SylvainAcc';
		String subject = 'SylvainSubject';
		String emailBlurb = 'Blurb';
		String brandId = '001';
		String name = 'Sylvain';
		String value = 'ValueS';
		String type = 'TypeS';
		
		DocuSignAPI.Envelope expectedResult = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);
		DocusignLibrary.initCustomFields(expectedResult, 10);

		DocuSignAPI.CustomField expectedResultCF = DocusignLibrary.getCustomField(name, value, type);

		expectedResult.CustomFields.CustomField[0] = expectedResultCF;

		DocuSignAPI.Envelope result = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);
		
		System.assertEquals(expectedResult.CustomFields.CustomField[0].Name, DocusignLibrary.addCustomFields(result, expectedResultCF).CustomFields.CustomField[0].Name);
		System.assertEquals(expectedResult.CustomFields.CustomField[0].Value, DocusignLibrary.addCustomFields(result, expectedResultCF).CustomFields.CustomField[0].Value );
		System.assertEquals(expectedResult.CustomFields.CustomField[0].CustomFieldType, DocusignLibrary.addCustomFields(result, expectedResultCF).CustomFields.CustomField[0].CustomFieldType);
    }

    @isTest static void test_initCustomFields(){
    	String accountId = 'SylvainAcc';
		String subject = 'SylvainSubject';
		String emailBlurb = 'Blurb';
		String brandId = '001';
		Integer size = 100;

		DocuSignAPI.Envelope expectedResult = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);

		expectedResult = DocusignLibrary.initCustomFields(expectedResult, size);

		System.assertNotEquals(null, expectedResult.CustomFields);
		System.assertNotEquals(null, expectedResult.CustomFields.CustomField);

    }

    @isTest static void test_initTabs(){
    	String accountId = 'SylvainAcc';
		String subject = 'SylvainSubject';
		String emailBlurb = 'Blurb';
		String brandId = '001';
		Integer size = 100;

		DocuSignAPI.Envelope expectedResult = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);

		expectedResult = DocusignLibrary.initTabs(expectedResult, size);

		System.assertNotEquals(null, expectedResult.Tabs);
		System.assertNotEquals(null, expectedResult.Tabs.Tab);

    }

    @isTest static void test_addTabs(){
    	String accountId = 'SylvainAcc';
		String subject = 'SylvainSubject';
		String emailBlurb = 'Blurb';
		String brandId = '001';
		String type = 'Type';
		Integer recipientId = 1;
		Integer documentId = 1;
		String anchorTabString = 'anchorTabString';
		
		DocuSignAPI.Envelope expectedResult = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);
		DocusignLibrary.initTabs(expectedResult, 10);

		DocuSignAPI.Tab expectedResultT = DocusignLibrary.getTab(type, recipientId, documentId, DocusignLibrary.getAnchorTab(anchorTabString));

		expectedResult.Tabs.Tab[0] = expectedResultT;

		DocuSignAPI.Envelope result = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);

		System.assertEquals(expectedResult.Tabs.Tab[0].Type_x, DocusignLibrary.addTabs(result, expectedResultT).Tabs.Tab[0].Type_x);
		System.assertEquals(expectedResult.Tabs.Tab[0].RecipientID, DocusignLibrary.addTabs(result, expectedResultT).Tabs.Tab[0].RecipientID);
		System.assertEquals(expectedResult.Tabs.Tab[0].DocumentID, DocusignLibrary.addTabs(result, expectedResultT).Tabs.Tab[0].DocumentID);
		System.assertEquals(expectedResult.Tabs.Tab[0].AnchorTabItem.AnchorTabString, DocusignLibrary.addTabs(result, expectedResultT).Tabs.Tab[0].AnchorTabItem.AnchorTabString);
    }

    @isTest static void test_initDocs(){
    	String accountId = 'SylvainAcc';
		String subject = 'SylvainSubject';
		String emailBlurb = 'Blurb';
		String brandId = '001';
		Integer size = 100;

		DocuSignAPI.Envelope expectedResult = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);

		expectedResult = DocusignLibrary.initDocs(expectedResult, size);

		System.assertNotEquals(null, expectedResult.Documents);
		System.assertNotEquals(null, expectedResult.Documents.Document);

    }

    @isTest static void test_addDocs(){
    	String accountId = 'SylvainAcc';
		String subject = 'SylvainSubject';
		String emailBlurb = 'Blurb';
		String brandId = '001';
		Integer id = 1;
		String byteDocument = 'bytes';
		String name = 'Doc'; 
		String fileExtension = 'pdf';
		
		DocuSignAPI.Envelope expectedResult = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);
		DocusignLibrary.initDocs(expectedResult, 10);

		DocuSignAPI.Document expectedResultD = DocusignLibrary.getDocument(id, byteDocument, name, fileExtension);

		expectedResult.Documents.Document[0] = expectedResultD;

		DocuSignAPI.Envelope result = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);

		System.assertEquals(expectedResult.Documents.Document[0].ID, DocusignLibrary.addDocs(result, expectedResultD).Documents.Document[0].ID);
		System.assertEquals(expectedResult.Documents.Document[0].pdfBytes, DocusignLibrary.addDocs(result, expectedResultD).Documents.Document[0].pdfBytes);
		System.assertEquals(expectedResult.Documents.Document[0].Name, DocusignLibrary.addDocs(result, expectedResultD).Documents.Document[0].Name);
		System.assertEquals(expectedResult.Documents.Document[0].FileExtension, DocusignLibrary.addDocs(result, expectedResultD).Documents.Document[0].FileExtension);
    }

    @isTest static void test_initRecipients(){
    	String accountId = 'SylvainAcc';
		String subject = 'SylvainSubject';
		String emailBlurb = 'Blurb';
		String brandId = '001';
		Integer size = 100;

		DocuSignAPI.Envelope expectedResult = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);

		expectedResult = DocusignLibrary.initRecipients(expectedResult, size);

		System.assertNotEquals(null, expectedResult.Recipients);
		System.assertNotEquals(null, expectedResult.Recipients.Recipient);

    }

    @isTest static void test_addRecipients(){
    	String accountId = 'SylvainAcc';
		String subject = 'SylvainSubject';
		String emailBlurb = 'Blurb';
		String brandId = '001';
		Integer id = 1;
		String type = 'type';
		Integer routingOrder = 1;
		String email = 'email@email.com';
		String userName = 'username';
		DocuSignAPI.RecipientCaptiveInfo repCapInfo = DocusignLibrary.getCaptiveInfo('info');
		Boolean requireIDLookup = false;
		
		DocuSignAPI.ArrayOfString1 arrayOfString = new DocuSignAPI.ArrayOfString1();
        arrayOfString.CustomField = new String[1];
        arrayOfString.CustomField[0] = 'ArrayOfString1';
		
		DocuSignAPI.Envelope expectedResult = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);
		DocusignLibrary.initRecipients(expectedResult, 10);

		DocuSignAPI.Recipient expectedResultD = DocusignLibrary.getRecipient(id, type, routingOrder, email, username, repCapInfo, requireIDLookup, arrayOfString);

		expectedResult.Recipients.Recipient[0] = expectedResultD;

		DocuSignAPI.Envelope result = DocusignLibrary.getEnvelope(accountId, subject, emailBlurb, brandId);

		System.assertEquals(expectedResult.Recipients.Recipient[0].Id, DocusignLibrary.addRecipients(result, expectedResultD).Recipients.Recipient[0].Id);
		System.assertEquals(expectedResult.Recipients.Recipient[0].Type_x, DocusignLibrary.addRecipients(result, expectedResultD).Recipients.Recipient[0].Type_x);
		System.assertEquals(expectedResult.Recipients.Recipient[0].RoutingOrder, DocusignLibrary.addRecipients(result, expectedResultD).Recipients.Recipient[0].RoutingOrder);
		System.assertEquals(expectedResult.Recipients.Recipient[0].Email, DocusignLibrary.addRecipients(result, expectedResultD).Recipients.Recipient[0].Email);
		System.assertEquals(expectedResult.Recipients.Recipient[0].Username, DocusignLibrary.addRecipients(result, expectedResultD).Recipients.Recipient[0].Username);
		System.assertEquals(expectedResult.Recipients.Recipient[0].CaptiveInfo.ClientUserId, DocusignLibrary.addRecipients(result, expectedResultD).Recipients.Recipient[0].CaptiveInfo.ClientUserId);
		System.assertEquals(expectedResult.Recipients.Recipient[0].RequireIDLookup, DocusignLibrary.addRecipients(result, expectedResultD).Recipients.Recipient[0].RequireIDLookup);
		System.assertEquals(expectedResult.Recipients.Recipient[0].CustomFields.CustomField[0], DocusignLibrary.addRecipients(result, expectedResultD).Recipients.Recipient[0].CustomFields.CustomField[0]);
    }
}