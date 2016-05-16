/**
 * Test Class for SendToDocuSignController
 *
 * Unit Test:
 * - SendNowTest: This unit test cover creating and sending envelope, plus getting a token url 
 * to allowed embeded signature
 *
 * To Do: 
 * - unit tests for exceptions
 * 
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/

@isTest
public class SendToDocuSignTest {

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
    static void SendNowTest() {
        String tokenURL;

    	//Create Transaction
    	Transaction__c tx = createTransaction();

    	//create officer
    	Officer__c off = createOfficer(tx);

        test.startTest();

    	//Set Mock WebService Response
        Test.setMock(WebServiceMock.class, new MockWebServiceResponseGenerator());

        //Set Page
        PageReference pageRef = Page.EmbedDocuSign;
        pageRef.getParameters().put('Id', String.valueOf(tx.Id));
        Test.setCurrentPage(pageRef);

        SendToDocuSign sendToDS = new SendToDocuSign();
        tokenURL = sendToDS.embedDocuSignOpen(tx);
    	
    	test.stopTest();

        //Validate
        System.assertEquals(TOKEN_URL, tokenURL);

    }
}