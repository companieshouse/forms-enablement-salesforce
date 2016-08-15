/**
 * Test Class for DocuSignStatusTriggerHandler
 *
 * Unit Test:
 * - update Transaction when DocuSign Status change to SIGNEDSTATUS
 * - do not update Transaction when DocuSign Status is different from COMPLETEDSTATUS
 * 
 * Author: antonio.bravo@golligo.co.uk
 * ab
 * lb - updated rejected status test
 **/
@isTest
public class DocuSignStatusTriggerHandlerTest {


	static Transaction__c createTransaction(){
		Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
        tx.Valid_Step_Ids__c = 'm0058000000D8jPAAS|m0058000000D8jSAAS|m0058000000D8jTAAS';
		insert tx;
		
		return tx;
	}

	static dsfs__DocuSign_Status__c createDocSignStatus(Transaction__c tx){
		dsfs__DocuSign_Status__c dss = CompaniesHouseTestData.getInstance().dss;
		dss.Transaction__c = tx.Id;
		insert dss;

		return dss;
	}

    @IsTest(SeeAllData=false)
    static void updateTransaction(){

    	//Create Transaction record
    	Transaction__c tx = createTransaction();

    	//Create DocuSign Status record
    	dsfs__DocuSign_Status__c dss = createDocSignStatus(tx);

        dsfs__DocuSign_Recipient_Status__c dss2 = new dsfs__DocuSign_Recipient_Status__c();

        Account company = new Account(Name='Methods Digital');
        insert company;

        Contact ct = new Contact();
        ct.LastName = 'dawwaawwda';
        ct.AccountId = company.Id;
        insert ct;


        dss2.dsfs__Date_Signed__c = System.today();
        dss2.dsfs__Contact__c = ct.Id;
        dss2.dsfs__Parent_Status_Record__c = dss.Id;
        dss2.dsfs__DocuSign_Recipient_Id__c = '1';
        insert dss2;

        dss2.dsfs__Date_Signed__c = System.today();
        update dss2;

    	
    	test.startTest();
        dss.dsfs__Envelope_Status__c = AppConstants.DOCUSIGN_STATUS_COMPLETED;
    	update dss;
    	test.stopTest();

        //Validate
        Transaction__c txAfter = [Select Id, Status__c from Transaction__c where Id = :tx.Id];
    	
        System.assertEquals(dss.Transaction__c, txAfter.Id);
    	System.assertEquals(AppConstants.REQUEST_STATUS_SIGNED, txAfter.Status__c);
    }

    @IsTest(SeeAllData=false)
    static void doNotUpdateTransaction(){
        //Verify that transaction status does not change when DocuSign Status != COMPLETEDSTATUS

        //Create Transaction record
        Transaction__c tx = createTransaction();

        //Create DocuSign Status record
        dsfs__DocuSign_Status__c dss = createDocSignStatus(tx);
        
        test.startTest();
        dss.dsfs__Envelope_Status__c = AppConstants.REQUEST_STATUS_DRAFT;
        update dss;
        test.stopTest();

        //Validate
        Transaction__c txAfter = [Select Id, Status__c from Transaction__c where Id = :tx.Id];
        
        System.assertEquals(dss.Transaction__c, txAfter.Id);
        System.assertnotEquals(AppConstants.REQUEST_STATUS_SIGNED, txAfter.Status__c);
    }

      @IsTest(SeeAllData=false)
      static void updateRejectedTransaction(){

        //Create Transaction record
        Transaction__c tx = createTransaction();

        //Create DocuSign Status record
        dsfs__DocuSign_Status__c dss = createDocSignStatus(tx);
        
        test.startTest();
        dss.dsfs__Envelope_Status__c = AppConstants.DOCUSIGN_STATUS_REJECTED;
        update dss;
        test.stopTest();

        //Validate
        Transaction__c txAfter = [Select Id, Status__c from Transaction__c where Id = :tx.Id];
        
        System.assertEquals(dss.Transaction__c, txAfter.Id);
        System.assertEquals(AppConstants.DOCUSIGN_STATUS_REJECTED, txAfter.Status__c);
    }


}