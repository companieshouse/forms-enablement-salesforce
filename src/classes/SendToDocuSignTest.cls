/**
 * Test Class for SendToDocuSignController
 *
 * Unit Test:
 * - sendNowTest: This unit test cover creating and sending envelope, 
 * - getTokenTest: Unit test to check if token is return when Presenter is an Officer. Token url 
 * allowed embeded signature
 * - authorizedSignerTest: Unit test for deceased, power of attorney and corporate directors scenarios
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
    public static String SUCCESS_STATUS = 'Success';
    public static String ERROR_STATUS = 'Error';
	
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

    static Transaction__c queryTransaction(String txId){
        return [Select Id,Form_Name__c,CompanyName__c, 
                    (Select Id,Name, Email__c,isPresenter__c,isSignatory__c, RecipientId__c,
                        AuthorizedSigner__c, isDeceased__c, isPowerOfAttorney__c, isCorporateDirector__c 
                    from Officers__r) 
                from Transaction__c where Id=:txId];
    }


    @isTest(seeAllData=false)
    static void sendNowTest() {
        String tokenURL;

        //Create Transaction
        Transaction__c tx = createTransaction();

        //create officer
        Officer__c off = createOfficer(tx);
        
        test.startTest();

        //Set Mock WebService Response
        Test.setMock(WebServiceMock.class, new MockWebServiceResponseGenerator());

        // This unit test is not linked with framework. Need to query transaction
        tx = queryTransaction(tx.Id);

        SendToDocuSign sendToDS = new SendToDocuSign();
        sendToDS.embedDocuSignOpen(tx);
        
        test.stopTest();

        //Validate
        System.assertEquals(SUCCESS_STATUS, sendToDS.envelopeId);

    }

    @isTest(seeAllData=false)
    static void getTokenTest() {
        String tokenURL;

    	//Create Transaction
    	Transaction__c tx = createTransaction();

    	//create officer
    	Officer__c off = createOfficer(tx);
        
        //Set Officer as presenter
        off.isPresenter__c = true;
        update off;
        
        
        test.startTest();

    	//Set Mock WebService Response
        Test.setMock(WebServiceMock.class, new MockWebServiceResponseGenerator());

        // This unit test is not linked with framework. Need to query transaction
        tx = queryTransaction(tx.Id);

        SendToDocuSign sendToDS = new SendToDocuSign();
        tokenURL = sendToDS.embedDocuSignOpen(tx);
    	
    	test.stopTest();

        //Validate
        System.assertEquals(TOKEN_URL, tokenURL);

    }

    @isTest(seeAllData=false)
    static void authorizedSignerTest() {
        String tokenURL;
        String recipientName = 'Authorized Signer Name';

        //Create Transaction
        Transaction__c tx = createTransaction();

        //create officer
        Officer__c off = createOfficer(tx);

        //Set Officer as Desead, Power Of Attorney or Corporate Director
        //isDeceased__c, isPowerOfAttorney__c, isCorporateDirector__c
        off.isCorporateDirector__c = true;
        off.AuthorizedSigner__c = recipientName;
        update off;
        
        test.startTest();

        //Set Mock WebService Response
        Test.setMock(WebServiceMock.class, new MockWebServiceResponseGenerator());
        MockWebServiceResponseGenerator.isSigningOnBehalf = true;
        MockWebServiceResponseGenerator.authorizedSignerName = recipientName;

        // This unit test is not linked with framework. Need to query transaction
        tx = queryTransaction(tx.Id);

        SendToDocuSign sendToDS = new SendToDocuSign();
        sendToDS.embedDocuSignOpen(tx);
        
        test.stopTest();

        //Validate
        System.assertEquals(SUCCESS_STATUS, sendToDS.envelopeId);

    }

    @isTest(seeAllData=false)
    static void checkAuthorizedSignerisPopulateCorrectTest() {
        String tokenURL;
        String recipientName = 'Authorized Signer Name';
        String wrongRecipientName = 'Wrong Recipient Name';

        //Create Transaction
        Transaction__c tx = createTransaction();

        //create officer
        Officer__c off = createOfficer(tx);

        //Set Officer as Desead
        off.isDeceased__c = true;
        off.AuthorizedSigner__c = recipientName;
        update off;
        
        test.startTest();

        //Set Mock WebService Response
        Test.setMock(WebServiceMock.class, new MockWebServiceResponseGenerator());
        MockWebServiceResponseGenerator.isSigningOnBehalf = true;
        MockWebServiceResponseGenerator.authorizedSignerName = wrongRecipientName;

        // This unit test is not linked with framework. Need to query transaction
        tx = queryTransaction(tx.Id);

        SendToDocuSign sendToDS = new SendToDocuSign();
        sendToDS.embedDocuSignOpen(tx);
        
        test.stopTest();

        //Validate
        System.assertEquals(ERROR_STATUS, sendToDS.envelopeId);

    }
}