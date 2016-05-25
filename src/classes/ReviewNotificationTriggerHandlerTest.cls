@isTest
private class ReviewNotificationTriggerHandlerTest {
	
		// instantiate a new transaction from companies house test data
	static Transaction__c createNewTransaction(){
		Transaction__c newtransaction = CompaniesHouseTestData.getInstance().tx;

		insert newtransaction;
		
		return newtransaction;
	}

	@IsTest(SeeAllData=false)
    static void multidirectorsSigned(){


    	Transaction__c tx = createNewTransaction();

    	// redirect should be the string passed in the trigger and the multi director should be true
    	String redirectURL = 'http://www.google.com';
    	test.startTest();

    	tx.MultipleDirectors__c = true;
		tx.Status__c = AppConstants.REQUEST_STATUS_SIGNED;
		update tx;
    	test.stopTest();

        Transaction__c txAfter = [Select Id, Status__c, ReviewRedirect__c, MultipleDirectors__c from Transaction__c where Id = :tx.Id];
    	
        System.assertEquals(true, txAfter.MultipleDirectors__c);
    	System.assertEquals(AppConstants.REQUEST_STATUS_SIGNED, txAfter.Status__c);
    	System.assertEquals(redirectURL, txAfter.ReviewRedirect__c);

    }	

    @IsTest(SeeAllData=false)
    static void soleDirectorSigned(){
       
        Transaction__c tx = createNewTransaction();

        // redirect should be empty and multi director should be false
        test.startTest();
        tx.MultipleDirectors__c = false;
		tx.Status__c = AppConstants.REQUEST_STATUS_SIGNED;
		update tx;
        test.stopTest();

        String redirectURL = null;
        Transaction__c txAfter = [Select Id, Status__c, ReviewRedirect__c, MultipleDirectors__c  from Transaction__c where Id = :tx.Id];
        
        System.assertEquals(false, txAfter.MultipleDirectors__c);
    	System.assertEquals(AppConstants.REQUEST_STATUS_SIGNED, txAfter.Status__c);
    	System.assertEquals(redirectURL, txAfter.ReviewRedirect__c);
    }

    @IsTest(SeeAllData=false)
    static void multidirectorUnsigned(){

        Transaction__c tx = createNewTransaction();

    	// redirect should be empty

    	test.startTest();
    	tx.MultipleDirectors__c = true;
		tx.Status__c = AppConstants.REQUEST_STATUS_DRAFT;
		update tx;
    	test.stopTest();
    	
    	String redirectURL = null;

        Transaction__c txAfter = [Select Id, Status__c, ReviewRedirect__c, MultipleDirectors__c  from Transaction__c where Id = :tx.Id];
    	
        System.assertEquals(true, txAfter.MultipleDirectors__c);
    	System.assertEquals(AppConstants.REQUEST_STATUS_DRAFT, txAfter.Status__c);
    	System.assertEquals(redirectURL, txAfter.ReviewRedirect__c);

    }

	
}