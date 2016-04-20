/**
 * Test Class for AttachmentTriggerHandler
 *
 * Unit Test:
 * - Update ParentID when Prefix Name is ATTPREFIXNAME
 * - Do not update when Prefix Name is different from ATTPREFIXNAME
 * 
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/
@isTest
public class AttachmentTriggerHandlerTest {
    
    //Create Data
	static Transaction__c createTransaction(){
		Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
		tx.Status__c = 'Draft';
        tx.Form_Name__c = 'DS01 Test';
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
    static void updateRelatedTo(){

    	//Create Transaction record
    	Transaction__c tx = createTransaction();

    	//Create DocuSign Status record
    	dsfs__DocuSign_Status__c dss = createDocSignStatus(tx);

    	
    	test.startTest();
        
        Attachment att = CompaniesHouseTestData.getInstance().pdf;
        att.Name = 'DS01 Test';
        att.ParentId = dss.Id;
        insert att;
    	
    	test.stopTest();

        //Validate
        Attachment attAfter = [Select Id, ParentId from Attachment where ParentId = :tx.Id];
        System.assertEquals(tx.Id, attAfter.ParentId);
    }

    @IsTest(SeeAllData=false)
    static void doNotUpdateRelatedTo(){
        // Attachment with prefix Name different from ATTNAMEPREFIX should not update ParentId
        // e.g. DocuSign is creating Certificates. This attachments should stay related to DocuSign Status record


        //Create Transaction record
    	Transaction__c tx = createTransaction();

    	//Create DocuSign Status record
    	dsfs__DocuSign_Status__c dss = createDocSignStatus(tx);

    	    	
    	test.startTest();
        
        Attachment att = CompaniesHouseTestData.getInstance().pdf;
        att.Name = 'Certificate'; 
        att.ParentId = dss.Id;
        insert att;
    	
    	test.stopTest();

        //Validate
        Attachment attAfter = [Select Id, ParentId from Attachment where ParentId = :dss.Id];
        System.assertEquals(dss.Id, attAfter.ParentId);
    }
}