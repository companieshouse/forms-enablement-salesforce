public with sharing class DocusignRESTAPIMock {

    public class EnvelopeCreateSendSuccess implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            DocusignRESTLibrary.EnvelopeResponse resp = new DocusignRESTLibrary.EnvelopeResponse();
            resp.envelopeId = 'EnvelopeId1';
            resp.status = 'Sent';
            resp.statusDateTime = 'Now';
            // Every request gets a 200, OK.
            response.setBody(JSON.serialize(resp, true));
            response.setStatusCode(201);

            
            return response;
        }
    }

    public class EnvelopeCreateSendFailure implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            DocusignRESTLibrary.EnvelopeResponse resp = new DocusignRESTLibrary.EnvelopeResponse();
            resp.message = 'You cannot do that';
            resp.errorCode = '2849';
            // Every request gets a 400, OK.
            response.setBody(JSON.serialize(resp, true));
            response.setStatusCode(400);

            
            return response;
        }
    }

    public class GetURLEmbeddedSuccess implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            DocusignRESTLibrary.URLResponse  resp = new DocusignRESTLibrary.URLResponse();
            resp.url = 'TESTURL';
            // Every request gets a 200, OK.
            response.setBody(JSON.serialize(resp, true));
            response.setStatusCode(201);

            
            return response;
        }
    }

    public class GetURLEmbeddedFailure implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            DocusignRESTLibrary.URLResponse  resp = new DocusignRESTLibrary.URLResponse();
            resp.errorCode = '22949';
            resp.message = 'Because this time you really cannot';
            // Every request gets a 200, OK.
            response.setBody(JSON.serialize(resp, true));
            response.setStatusCode(201);

            
            return response;
        }
    }
 

}