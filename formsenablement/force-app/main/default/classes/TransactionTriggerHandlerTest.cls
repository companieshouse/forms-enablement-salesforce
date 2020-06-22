@isTest
private class TransactionTriggerHandlerTest {
	
	@isTest static void test_beforeUpdate() {
    CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

    Transaction__c transac = testData.tx;
    transac.isPaymentRequired__c = true;
    transac.isPaymentAccount__c = true;
    transac.Form_Name__c = 'DS01';
    transac.Status__c = AppConstants.REQUEST_STATUS_PENDING_SIGNATURES;
    transac.AccountNumber__c = '94948';
    transac.ContactEmail__c = 'test@test.com';
    transac.ApplicationBaseURL__c = 'https://guidedfiling.companieshouse.gov.uk/start?t=DS01';

    Transaction__c tran = transac.clone(true, true, true);
    tran.Status__c = AppConstants.REQUEST_STATUS_SUBMITTED;
    insert tran;
    insert transac;

    List<Transaction__c> lTransac = new List<Transaction__c>();

    lTransac.add(transac);
    lTransac.add(tran);

    TransactionTriggerHandler.beforeUpdate(lTransac);
		// Implement test code


	}
	
}