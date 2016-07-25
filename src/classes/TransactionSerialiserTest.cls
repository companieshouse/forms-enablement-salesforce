@isTest
private class TransactionSerialiserTest {

	//Class test to test the convertion of a transaction record into JSON
	@IsTest
	static void test_method_transactionToJSON(){
		CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

		Transaction__c transac = testData.tx;
		transac.isPaymentRequired__c = true;
		transac.isPaymentAccount__c = true;
		transac.AccountNumber__c = 94948;
		transac.ContactEmail__c = 'sylvain.picory@methodsdigital.co.uk';
		insert transac;

		Contact testCont = CompaniesHouseTestData.getInstance().contact1;
		Contact testCont2 = CompaniesHouseTestData.getInstance().contact2;

		Account testComp = CompaniesHouseTestData.getInstance().companyAccount;

		insert testComp;

		testCont.AccountId = testComp.ID;
		testCont.Transaction__c = transac.Id;

		insert testCont;

		testCont2.AccountId = testComp.Id;
		testCont2.Transaction__c = transac.Id;

		insert testCont2;

		Officer__c off = testData.off;

		off.DateSigned__c = system.today();

		off.Surname__c = 'DDDJDJDJ';

		off.Transaction__c = transac.Id;

		off.Contact__c = testCont.Id;

		insert off;

		Officer__c off2 = testData.off2;

		off2.DateSigned__c = system.today();

		off2.Surname__c = 'BLABLA';

		off2.Transaction__c = transac.Id;

		off2.Contact__c = testCont2.Id;

		insert off2;

		Attachment att = testData.pdf;
		att.ParentId = transac.Id;

		insert att;

		String resultBody = EncodingUtil.base64Encode(att.Body);

		test.startTest();

		String result = TransactionSerialiser.transactionToJSON(transac);
		test.stopTest();

		//Assert
		TransactionSerialiser.metadataWraper mat = (TransactionSerialiser.metadataWraper)JSON.deserialize(result, TransactionSerialiser.metadataWraper.class);
		TransactionSerialiser.formdataWraper form = (TransactionSerialiser.formdataWraper) JSON.deserialize(result, TransactionSerialiser.formdataWraper.class);
		TransactionSerialiser.attachmentsWraper lAtt = (TransactionSerialiser.attachmentsWraper) JSON.deserialize(result, TransactionSerialiser.attachmentsWraper.class);

		//Test metadata
		system.assertEquals(mat.metadata.submissionReference, transac.Id);
		system.assertEquals(mat.metadata.version, Integer.valueOf(transac.Version_Form__c));

		//Test form
		system.assertEquals(form.formdata.filingDetails.barcode, transac.Barcode__c);
		system.assertEquals(form.formdata.filingDetails.receiptDate, TransactionSerialiser.getFormatedDate(system.today()));
		system.assertEquals(form.formdata.corporateBody.incorporationNumber ,transac.CompanyNumber__c );
		system.assertEquals(form.formdata.corporateBody.corporateBodyName ,transac.CompanyName__c );

		//Test Attachments
		system.assertEquals(lAtt.attachments.size(), 1);
		system.assertEquals(lAtt.attachments[0].data ,resultBody );


	}
	
}