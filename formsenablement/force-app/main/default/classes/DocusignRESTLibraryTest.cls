@isTest
private class DocusignRESTLibraryTest {
    @isTest static void EnvelopeSendingSuccessTest(){
        Test.setMock(HttpCalloutMock.class, new DocusignRESTAPIMock.EnvelopeCreateSendSuccess());
        Test.startTest();

        HttpResponse response = DocusignRESTLibrary.createAndSendEnvelope(new DocusignResponsiveRestAPI.Envelope());

        Test.stopTest();

        system.assertEquals(201, response.getStatusCode());
        DocusignRESTLibrary.EnvelopeResponse b = (DocusignRESTLibrary.EnvelopeResponse)JSON.deserialize(response.getBody(), DocusignRESTLibrary.EnvelopeResponse.class);
        system.assertEquals('EnvelopeId1', b.envelopeId);
        system.assertEquals('Sent', b.status);
        system.assertEquals('Now', b.statusDateTime);
    }

    @isTest static void EnvelopeSendingFailureTest(){
        Test.setMock(HttpCalloutMock.class, new DocusignRESTAPIMock.EnvelopeCreateSendFailure());
        Test.startTest();

        HttpResponse response = DocusignRESTLibrary.createAndSendEnvelope(new DocusignResponsiveRestAPI.Envelope());

        Test.stopTest();

        system.assertEquals(400, response.getStatusCode());
        DocusignRESTLibrary.EnvelopeResponse b = (DocusignRESTLibrary.EnvelopeResponse)JSON.deserialize(response.getBody(), DocusignRESTLibrary.EnvelopeResponse.class);
        system.assertEquals('You cannot do that', b.message);
        system.assertEquals('2849', b.errorCode);
    }

    @isTest static void URLRequestSuccessTest(){
        Test.setMock(HttpCalloutMock.class, new DocusignRESTAPIMock.GetURLEmbeddedSuccess());
        Test.startTest();
                
        HttpResponse response = DocusignRESTLibrary.getEmbeddedURL(new DocusignRESTLibrary.EmbeddedEnvelopeSignerDetails(), 'envelopeId');

        Test.stopTest();

        system.assertEquals(201, response.getStatusCode());
        DocusignRESTLibrary.URLResponse c = (DocusignRESTLibrary.URLResponse)JSON.deserialize(response.getBody(), DocusignRESTLibrary.URLResponse.class);
        system.assertEquals('TESTURL', c.url);
        
    }

    @isTest static void URLRequestFailureTest(){
        Test.setMock(HttpCalloutMock.class, new DocusignRESTAPIMock.GetURLEmbeddedFailure());
        Test.startTest();
        HttpResponse response = DocusignRESTLibrary.getEmbeddedURL(new DocusignRESTLibrary.EmbeddedEnvelopeSignerDetails(), 'envelopeId');

        Test.stopTest();

        system.assertEquals(201, response.getStatusCode());
        DocusignRESTLibrary.URLResponse c = (DocusignRESTLibrary.URLResponse)JSON.deserialize(response.getBody(), DocusignRESTLibrary.URLResponse.class);
        system.assertEquals('Because this time you really cannot', c.message);
        system.assertEquals('22949', c.errorCode);
    }

    @isTest static void getNotificationTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.Notification notif =  DocusignRESTLibrary.getNotification('TestNot');

        Test.stopTest();

        system.assertEquals('TestNot', notif.UseAccountDefaults);
    }

    @isTest static void getTextCustomFieldTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.TextCustomField customF = DocusignRESTLibrary.getTextCustomField('Value1', 'Name1');

        Test.stopTest();

        system.assertEquals('Value1', customF.value);
        system.assertEquals('Name1', customF.name);
    }

    @isTest static void getSignerTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.Signer signer = DocusignRESTLibrary.getSigner('recipientId1', 'clientUserId1', 'email1', 'name1', 'routingOrder1', null);

        Test.stopTest();

        system.assertEquals('recipientId1', signer.recipientId);
        system.assertEquals('clientUserId1', signer.clientUserId);
        system.assertEquals('email1', signer.email);
        system.assertEquals('name1', signer.name);
        system.assertEquals('routingOrder1', signer.routingOrder);
        system.assertEquals(null, signer.customFields);
    }

    @isTest static void getEnvelopeTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.Envelope env = DocusignRESTLibrary.getEnvelope('emailSubject1', 'status1', 'brandId1', 'emailBlurb1', null, null);

        Test.stopTest();

        system.assertEquals('emailSubject1', env.emailSubject);
        system.assertEquals('status1', env.status);
        system.assertEquals('brandId1', env.brandId);
        system.assertEquals('emailBlurb1', env.emailBlurb);
        system.assertEquals(null, env.notification);
        system.assertEquals(null, env.customFields);
    }

    @isTest static void getHtmlDefinitionTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.HtmlDefinition htmlDef = DocusignRESTLibrary.getHtmlDefinition('maxScreenWidth1', 'source1');

        Test.stopTest();

        system.assertEquals('maxScreenWidth1', htmlDef.maxScreenWidth);
        system.assertEquals('source1', htmlDef.source);
    }

    @isTest static void getDocumentTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.Document doc = DocusignRESTLibrary.getDocument('documentId1', 'name1', null);

        Test.stopTest();

        system.assertEquals('documentId1', doc.documentId);
        system.assertEquals('name1', doc.name);
        system.assertEquals(null, doc.htmlDefinition);
    }

    @isTest static void initDocumentsTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.Envelope env = DocusignRESTLibrary.initDocuments(new DocusignResponsiveRestAPI.Envelope(), 1);

        Test.stopTest();

        system.assertNotEquals(null, env.documents);
        system.assertEquals(0, DocusignRESTLibrary.documentPos);
    }

    @isTest static void addDocumentTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.Envelope env = DocusignRESTLibrary.addDocument(new DocusignResponsiveRestAPI.Envelope(), new DocusignResponsiveRestAPI.Document());

        Test.stopTest();

        system.assertNotEquals(null, env.documents);
        system.assertNotEquals(null, env.documents[0]);
        system.assertEquals(1, DocusignRESTLibrary.documentPos);
    }

    @isTest static void addSignerTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.Recipient rec = DocusignRESTLibrary.addSigner(new DocusignResponsiveRestAPI.Recipient(), new DocusignResponsiveRestAPI.Signer());

        Test.stopTest();

        system.assertNotEquals(null, rec.signers);
        system.assertNotEquals(null, rec.signers[0]);
        system.assertEquals(1, DocusignRESTLibrary.signerPos);
    }

    @isTest static void initSignersTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.Recipient rec = DocusignRESTLibrary.initSigners(new DocusignResponsiveRestAPI.Recipient(), 1);

        Test.stopTest();

        system.assertNotEquals(null, rec.signers);
        system.assertEquals(0, DocusignRESTLibrary.signerPos);
    }

    @isTest static void addTextCustomFieldTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.TextCustomFields rec = DocusignRESTLibrary.addTextCustomField(new DocusignResponsiveRestAPI.TextCustomFields(), new DocusignResponsiveRestAPI.TextCustomField());

        Test.stopTest();

        system.assertNotEquals(null, rec.textCustomFields);
        system.assertNotEquals(null, rec.textCustomFields[0]);
        system.assertEquals(1, DocusignRESTLibrary.textCustomFieldPos);
    }

    @isTest static void initTextCustomfieldsTest()
    {
        Test.startTest();

        DocusignResponsiveRestAPI.TextCustomFields rec = DocusignRESTLibrary.initTextCustomfields(new DocusignResponsiveRestAPI.TextCustomFields(), 1);

        Test.stopTest();

        system.assertNotEquals(null, rec.textCustomFields);
        system.assertEquals(0, DocusignRESTLibrary.textCustomFieldPos);
    }
}