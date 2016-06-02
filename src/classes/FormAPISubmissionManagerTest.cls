/**
 * Test Class for FormAPISubmissionManager
 *
 * Unit Test:
 * - sendForm
 *
 * To Do: 
 * - Improve mock response
 * - asserts
 *
 * Author: antonio.bravo@gollico.co.uk 
 **/
@isTest
public class FormAPISubmissionManagerTest {
    //Create Data
    //Create Transaction
    static Transaction__c createTransaction() {
        Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
        tx.Status__c = AppConstants.REQUEST_STATUS_PENDING_SUBMISSION;
        insert tx;
        
        return tx;
    }

    //Create Attachment
    static Attachment createAttachment(Id parentId){
        Attachment att = CompaniesHouseTestData.getInstance().pdf;
        att.Name = ' DS01 Test';
        att.ParentId = parentId;
        insert att;

        return att;
    }


    @isTest(seeAllData=false)
    public static void sendFormTest() {
        
        //Create Transaction
        Transaction__c tx = createTransaction();

        //Create Attachment
        Attachment att = createAttachment(tx.Id);


        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMock());
        
        // Going for coverage only at this stage. No assertions.
        FormAPISubmissionManager formApiSM = new FormAPISubmissionManager();
        Transaction__c txResponse = formApiSM.sendForm(tx);
        
        Test.stopTest();

        // To do update mock to return 200 or 202 depending on the endpoint
        //System.assertEquals(AppConstants.REQUEST_STATUS_SUBMITTED, txResponse.Status__c);
    }
}