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
public class SendToDocuSignControllerTest {

    public static String TOKEN_URL = 'https://demo.docusign.net/Signing/xxxx'; 
	
	//Create Data
    //Create Transaction
	static Transaction__c createTransaction() {
		Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
		tx.Status__c = 'Draft';
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

	//Create Custom Setting
    static void createDocuSignSetting() {
    	DocuSignSetting__c dsSett = new DocuSignSetting__c();
    	dsSett.Name = 'Test setting';
    	dsSett.AccountId__c = 'AccountId';
    	dsSett.IntegratorKey__c = 'Key';
    	dsSett.Username__c = 'username';
    	dsSett.Password__c = 'password';
    	dsSett.URL__c = 'DocuSign';

    	insert dsSett;
    }

    @IsTest(SeeAllData=false)
    static void SendNowTest() {

    	//Create Transaction
    	Transaction__c tx = createTransaction();

    	//Create Custom Setting
    	createDocuSignSetting();

    	//create officer
    	Officer__c off = createOfficer(tx);

        test.startTest();

    	//Set Mock WebService Response
        Test.setMock(WebServiceMock.class, new MockWebServiceResponseGenerator());

        //Set Page
        PageReference pageRef = Page.EmbedDocuSign;
        pageRef.getParameters().put('Id', String.valueOf(tx.Id));
        Test.setCurrentPage(pageRef);

        SendToDocuSignController testController = new SendToDocuSignController();
    	testController.embedDocuSignOpen();
    	
    	test.stopTest();

        //Validate
        String tokenURL = testController.tokenURL;
        System.assertEquals(TOKEN_URL, tokenURL);

    }
}