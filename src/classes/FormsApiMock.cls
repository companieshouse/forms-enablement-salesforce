/**
 * Use this to mock the HTTP response returned in unit tests when the Forms API client calls out.
 * 
 * Author: eliot.stock@methods.co.uk
 */
public class FormsApiMock implements HttpCalloutMock {

	public HTTPResponse respond(HTTPRequest request) {
		HttpResponse response = new HttpResponse();
        
        // Every request gets a 200, OK.
        response.setBody('OK');
        response.setStatusCode(200);
        
        return response;
    }

}