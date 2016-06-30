@isTest
private class TransactionSerialiserTest {

	//Class test to test the convertion of a transaction record into JSON
	@IsTest
	static void test_method_transactionToJSON(){
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction__c transac = testData.tx;

		insert transac;

		Officer__c off = testData.off;

		off.DateSigned__c = system.today();

		off.Transaction__c = transac.Id;

		insert off;

		Officer__c off2 = testData.off2;

		off2.DateSigned__c = system.today();

		off2.Name = 'BLABLA';

		off2.Transaction__c = transac.Id;

		insert off2;

		Attachment att = testData.pdf;
		att.ParentId = transac.Id;

		insert att;

		String resultBody = EncodingUtil.base64Encode(att.Body);

		test.startTest();

		String result = TransactionSerialiser.transactionToJSON(transac);
		throw new Form_CustomException('' + result);

		test.stopTest();

		//Assert
		TransactionSerialiser.metadataWraper mat = (TransactionSerialiser.metadataWraper)JSON.deserialize(result, TransactionSerialiser.metadataWraper.class);
		TransactionSerialiser.formdataWraper form = (TransactionSerialiser.formdataWraper) JSON.deserialize(result, TransactionSerialiser.formdataWraper.class);
		TransactionSerialiser.attachmentsWraper lAtt = (TransactionSerialiser.attachmentsWraper) JSON.deserialize(result, TransactionSerialiser.attachmentsWraper.class);

		//Test metadata
		system.assertEquals(mat.metadata.submissionReference, transac.SubmissionId__c);
		system.assertEquals(mat.metadata.version, transac.Version_Form__c);

		//Test form
		system.assertEquals(form.formdata.filingDetails.barcode, transac.Barcode__c);
		system.assertEquals(form.formdata.filingDetails.receiptDate, system.today().year() + '-' + system.today().month() + '-' + system.today().day());
		system.assertEquals(form.formdata.corporateBody.incorporationNumber ,transac.CompanyNumber__c );
		system.assertEquals(form.formdata.corporateBody.corporateBodyName ,transac.CompanyName__c );

		//Test Attachments
		system.assertEquals(lAtt.attachments.size(), 1);
		system.assertEquals(lAtt.attachments[0].data ,resultBody );


	}
	
}