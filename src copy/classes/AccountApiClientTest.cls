/**
 * Author: eliot.stock@methods.digital.co.uk.
 */
@isTest
public class AccountApiClientTest {
    
    public class AccountApiTokenMock implements HttpCalloutMock {
        
        private final String MOCK_RESPONSE = '{\n'
                + '  "access_token": "2312312312312312",\n'
                + '  "expires_in": 86400,\n'
                + '  "token_type": "Bearer",\n'
                + '  "refresh_token": "fuhe9u3f9euge9uge"\n'
                + '}\n';
    
        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            
            // Every request gets a 200.
            response.setBody(MOCK_RESPONSE);
            response.setStatusCode(200);
            
            return response;
        }
    
    }
    
    public class AccountApiUserProfileMock implements HttpCalloutMock {
        
        private final String MOCK_RESPONSE = '{\n'
                + '  "surname": "Director",\n'
                + '  "forename": "Denis",\n'
                + '  "email": "denis@company.co.uk",\n'
                + '  "id": "00000001"\n'
                + '}\n';
    
        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            
            // Every request gets a 200.
            response.setBody(MOCK_RESPONSE);
            response.setStatusCode(200);
            
            return response;
        }
    
    }
    
    @isTest
    public static void canGetUserAuthUrl() {
        Test.startTest();
        
        // Going for coverage only at this stage. No assertions.
        AccountApiClient client = new AccountApiClient();
        String nonce = client.getNonce();
        String authUrl = client.getUserAuthUrl(nonce);
        
        Test.stopTest();
    }
    
    @isTest
    public static void canGetCompanyAuthUrl() {
        Test.startTest();
        
        // Going for coverage only at this stage. No assertions.
        AccountApiClient client = new AccountApiClient();
        String nonce = client.getNonce();
        String authUrl = client.getCompanyAuthUrl(nonce, '08906750');
        
        Test.stopTest();
    }

    @isTest
    public static void canSendTokenRequest() {
        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new AccountApiClientTest.AccountApiTokenMock());
        
        // Going for coverage only at this stage. No assertions.
        AccountApiClient client = new AccountApiClient();
        AccountApiClient.Token token = client.getAccessToken('unit_test_auth_code');
        
        Test.stopTest();
    }

    @isTest
    public static void canSendProfileRequest() {
        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new AccountApiUserProfileMock());
        
        // Going for coverage only at this stage. No assertions.
        AccountApiClient client = new AccountApiClient();
        AccountApiClient.UserProfile profile = client.getUserProfile('unit_access_token');
        
        Test.stopTest();
    }
    
}