/**
 * Test Class for EmbedDocuSignController
 *
 * Unit Test:
 * - 
 *
 * To Do: 
 * - create a global test class to build 'c' param
 * - unit test for sucess scenario
 * - unit tests for exceptions
 * 
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/

@isTest
public class EmbedDocuSignControllerTest {
	public static String TOKEN_URL = 'https://demo.docusign.net/Signing/xxxx'; 
	
	//Create Data
    //Create Transaction
	static Transaction__c createTransaction() {
		Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
		insert tx;
		
		return tx;
	}
	//Create Officer
	static Officer__c createOfficer(Transaction__c tx) {
		Officer__c off = CompaniesHouseTestData.getInstance().off;
		off.Transaction__c = tx.Id;
		insert off;

		return off;
	}

	@IsTest(SeeAllData=false)
    static void actionFunctionTest() {
        String tokenURL;

    	//Create Transaction
    	Transaction__c tx = createTransaction();

    	//create officer
    	Officer__c off = createOfficer(tx);


        test.startTest();

    	//Set Mock WebService Response
        Test.setMock(WebServiceMock.class, new MockWebServiceResponseGenerator());


        EmbedDocuSignController embedDS = new EmbedDocuSignController();
        // To do get a Global Test Class to build 'c' paramter
        //PageReference pr = embedDS.actionFunction();
        tokenURL = embedDS.tokenURL;
    	
    	test.stopTest();

        //Validate
        //System.assertEquals(TOKEN_URL, tokenURL);

    }
}