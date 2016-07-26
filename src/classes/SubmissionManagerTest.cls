/*
Name:  SubmissionManagerTest.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Test suite for the SubmissionManager.cls class.

Coverage for classes below (target 90%):
SubmissionManager.cls : 88%

Note - CMT records are metadata not data and do not support DML via Apex.
Best practice is to assume the existence of the CMT records packaged
by the application. Use of test-only CMT is not appropriate here. 

Todo :
1. Additional negative test cases.
2. Detailed asserts relating to the content of the Historical Steps field to be implemented into singleTestCase2 (restore some aspects of the previous test case)

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-06-03  Test class re-development.
*/
@isTest(SeeAllData=false)
private class SubmissionManagerTest {
    /*
    Test cases: 
        singleTestCase1 - Manager initialisation by constructors.
        singleTestCase2 - 
        singleTestCase3 - Valid Ids test.
        ..
        negativeTestCase1 - Invalid Ids test.         
        ..
        bulkTestCase1 - not defined.
        ..
		restrictedUserTest1 - not defined.
    */
    
    
    
    /* **/
    static testMethod void singleTestCase1() {
        // Test case 1 : Manager initialisation by constructors.
        
        // use the first active transaction type found with more than two active steps.
		String tt = getActiveTransactionType();
		System.debug(LoggingLevel.ERROR, 'tt:'+tt);	 
		
		Map<Id, Transaction_Type_Step__mdt> stepsById = new Map<Id, Transaction_Type_Step__mdt>( [select Id, DeveloperName, Step_Number__c from Transaction_Type_Step__mdt where Is_Active__c=true and Transaction_Type__c=:tt order by Step_Number__c asc] );
		List<Id> sortedStepIds = new List<Id>( stepsById.keySet() );
				
		Id firstStepId = sortedStepIds[0];
		Id secondStepId = sortedStepIds[1];
		Id thirdStepId = sortedStepIds[2];
		
		System.debug(LoggingLevel.ERROR,firstStepId);
		System.debug(LoggingLevel.ERROR,secondStepId);
		System.debug(LoggingLevel.ERROR,thirdStepId);					

		// Instantiate manager instance with the first step Id.
		TransactionManager tm = new TransactionManager(firstStepId);
		
		RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
		Account presenter = new Account(FirstName='John', LastName='Smith',RecordType=personAccountRecordType, PersonEmail='jsmith@methods.digital.testing');
		insert presenter;

		Account company = new Account(Name='Methods Digital' +'00000000' + AppConstants.PERCENTAGE_REPLACEMENT,CompanyNumber__c = '00000000');
		insert company;		

		Test.startTest();
				
		SubmissionManager sm = new SubmissionManager();
		Id submissionId = sm.initialise(tt, presenter.Id, presenter.PersonEmail, company, tm.td); 
				
		sm = new SubmissionManager(submissionId); // reinitialise via constructor.
		System.assert(sm.submission!=null, 'Submission did not initialise.');

		sm.persist(); // coverage only.
		
		sm = new SubmissionManager(submissionId, 'Account', 'DS01_Query'); // reinitialise via constructor.

		System.assert(sm.submission!=null, 'Submission did not initialise.');
		
		sm.persist(); // coverage only.
		
		Test.stopTest();		
    }
    /* */
    
    /* **/
    static testMethod void singleTestCase2() {
        // Test case 2 : Instantiate Manager with Step Id (mid-sequence).
        
        // use the first active transaction type found with more than two active steps.
		String tt = getActiveTransactionType();
		System.debug(LoggingLevel.ERROR, 'tt:'+tt);	 
		
		Map<Id, Transaction_Type_Step__mdt> stepsById = new Map<Id, Transaction_Type_Step__mdt>( [select Id, DeveloperName, Step_Number__c from Transaction_Type_Step__mdt where Is_Active__c=true and Transaction_Type__c=:tt order by Step_Number__c asc] );
		List<Id> sortedStepIds = new List<Id>( stepsById.keySet() );
				
		Id firstStepId = sortedStepIds[0];
		Id secondStepId = sortedStepIds[1];
		Id thirdStepId = sortedStepIds[2];
		Id fourthStepId = sortedStepIds[3];
		
		System.debug(LoggingLevel.ERROR,firstStepId);
		System.debug(LoggingLevel.ERROR,secondStepId);
		System.debug(LoggingLevel.ERROR,thirdStepId);					

		// Instantiate manager instance with the first step Id.
		TransactionManager tm = new TransactionManager(firstStepId);
		
		RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
		Account presenter = new Account(FirstName='John', LastName='Smith',RecordType=personAccountRecordType, PersonEmail='jsmith@methods.digital.testing');
		insert presenter;

		Account company = new Account(Name='Methods Digital');
		insert company;		
		
		SubmissionManager sm = new SubmissionManager();
		Id submissionId = sm.initialise(tt, presenter.Id, presenter.PersonEmail, company, tm.td); 
		
		// first step - then step navigation.
		PageReference pr;
		
		Test.startTest();

		SubmissionManager.setValidSteps(submissionId, firstStepId, secondStepId);
		
		Transaction__c t = [select Id,Valid_Step_Ids__c,Historical_Valid_Step_Ids__c from Transaction__c where Id=:submissionId ];
		System.assert(t.Valid_Step_Ids__c!=null,'Valid step ids not set.');
		System.assert(t.Historical_Valid_Step_Ids__c!=null,'Historical valid step ids not set.');
		
		System.assertEquals(firstStepId, SubmissionManager.getPreviousStepId(submissionId, secondStepId));

		SubmissionManager.setValidSteps(submissionId, secondStepId, thirdStepId);
		
		t = [select Id,Valid_Step_Ids__c,Historical_Valid_Step_Ids__c from Transaction__c where Id=:submissionId ];
		System.assert(t.Valid_Step_Ids__c!=null,'Valid step ids not set.');
		System.assert(t.Historical_Valid_Step_Ids__c!=null,'Historical valid step ids not set.');
		
		SubmissionManager.setValidSteps(submissionId, thirdStepId, thirdStepId);
		
		t = [select Id,Valid_Step_Ids__c,Historical_Valid_Step_Ids__c from Transaction__c where Id=:submissionId ];
		System.assert(t.Valid_Step_Ids__c!=null,'Valid step ids not set.');
		System.assert(t.Historical_Valid_Step_Ids__c!=null,'Historical valid step ids not set.');


		Test.stopTest();
    }
    /* */
    
	/* **/
    static testMethod void singleTestCase3() {
        // Test case 3 : Valid Ids test.
        
		String tt = getActiveTransactionType();
		System.debug(LoggingLevel.ERROR, 'tt:'+tt);	 
		
		Map<Id, Transaction_Type_Step__mdt> stepsById = new Map<Id, Transaction_Type_Step__mdt>( [select Id, DeveloperName, Step_Number__c from Transaction_Type_Step__mdt where Is_Active__c=true and Transaction_Type__c=:tt order by Step_Number__c asc] );
		List<Id> sortedStepIds = new List<Id>( stepsById.keySet() );
				
		Id firstStepId = sortedStepIds[0];
		Id secondStepId = sortedStepIds[1];
		Id thirdStepId = sortedStepIds[2];
		
		System.debug(LoggingLevel.ERROR,firstStepId);
		System.debug(LoggingLevel.ERROR,secondStepId);
		System.debug(LoggingLevel.ERROR,thirdStepId);					

		// Instantiate manager instance with the first step Id.
		TransactionManager tm = new TransactionManager(firstStepId);
		
		RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
		Account presenter = new Account(FirstName='John', LastName='Smith',RecordType=personAccountRecordType, PersonEmail='jsmith@methods.digital.testing');
		insert presenter;

		Account company = new Account(Name='Methods Digital');
		insert company;		
		
		SubmissionManager sm = new SubmissionManager();
		Id submissionId = sm.initialise(tt, presenter.Id, presenter.PersonEmail, company, tm.td); 

		SubmissionManager.setValidSteps(submissionId, firstStepId, secondStepId);

		Test.startTest();
		// Instantiate manager instance with a transaction type.
		System.assert(SubmissionManager.isValidSubmissionId(submissionId), 'Valid Submission Fail');
		System.assert(SubmissionManager.isValidSubmissionStepId(submissionId,firstStepId), 'Valid Submission Step Id Fail');
		Test.stopTest();
    }
    /* */
    
	/* **/
    static testMethod void negativeTestCase1() {
        // Test case 1 : Invalid Ids test.
        
		String tt = getActiveTransactionType();
		System.debug(LoggingLevel.ERROR, 'tt:'+tt);	 
		
		Map<Id, Transaction_Type_Step__mdt> stepsById = new Map<Id, Transaction_Type_Step__mdt>( [select Id, DeveloperName, Step_Number__c from Transaction_Type_Step__mdt where Is_Active__c=true and Transaction_Type__c=:tt order by Step_Number__c asc] );
		List<Id> sortedStepIds = new List<Id>( stepsById.keySet() );
				
		Id firstStepId = sortedStepIds[0];
		Id secondStepId = sortedStepIds[1];
		Id thirdStepId = sortedStepIds[2];
		
		System.debug(LoggingLevel.ERROR,firstStepId);
		System.debug(LoggingLevel.ERROR,secondStepId);
		System.debug(LoggingLevel.ERROR,thirdStepId);					

		// Instantiate manager instance with the first step Id.
		TransactionManager tm = new TransactionManager(firstStepId);
		
		RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
		Account presenter = new Account(FirstName='John', LastName='Smith',RecordType=personAccountRecordType, PersonEmail='jsmith@methods.digital.testing');
		insert presenter;

		Account company = new Account(Name='Methods Digital');
		insert company;		
		
		SubmissionManager sm = new SubmissionManager();
		Id submissionId = sm.initialise(tt, presenter.Id, presenter.PersonEmail, company, tm.td); 

		Test.startTest();
		// Instantiate manager instance with a transaction type.
		System.assert(!SubmissionManager.isValidSubmissionId(String.valueOf(submissionId).left(String.valueOf(submissionId).length()-1)+'X'), 'Valid Submission Fail');
		System.assert(!SubmissionManager.isValidSubmissionStepId(submissionId,firstStepId), 'Valid Submission Step Id Fail');
		Test.stopTest();				
    }
    /* */       
    
    // Test helper methods.
    
    /* **/
    private static String getActiveTransactionType(){
    	// returns the first active transaction type found with more than two active steps.
    	
		Map<Id, Transaction_Type_Step__mdt> stepsById = new Map<Id, Transaction_Type_Step__mdt>( [select Id, Transaction_Type__c from Transaction_Type_Step__mdt where Is_Active__c=true order by Transaction_Type__c, Step_Number__c asc] );
		
		System.debug(LoggingLevel.ERROR, 'stepsById:'+stepsById);
		System.assert(!stepsById.isEmpty(), 'No active Transaction Steps defined.');
		
		Map<String, Set<Id>> transactionTypeToStepIds = new Map<String, Set<Id>>(); 
		for (Id stepId : stepsById.keySet()){
			if (!transactionTypeToStepIds.containsKey(stepsById.get(stepId).Transaction_Type__c)){ transactionTypeToStepIds.put(stepsById.get(stepId).Transaction_Type__c, new Set<Id>()); }			
			transactionTypeToStepIds.get(stepsById.get(stepId).Transaction_Type__c).add(stepId);			 
		}
		
		System.debug(LoggingLevel.ERROR, 'transactionTypeToStepIds:'+transactionTypeToStepIds);
		
		for (String t : transactionTypeToStepIds.keySet().clone()){
			if (transactionTypeToStepIds.get(t).size()<3) transactionTypeToStepIds.remove(t); 
		}
		
		System.debug(LoggingLevel.ERROR, 'transactionTypeToStepIds:'+transactionTypeToStepIds);
		System.assert(!transactionTypeToStepIds.isEmpty(), 'No Transactions with at least 2 active Transaction Steps defined.');
		
		Map<Id, Transaction_Type__mdt> transactionsById = new Map<Id, Transaction_Type__mdt>( [select Id, Product_Code__c,DeveloperName,isPaymentRequired__c from Transaction_Type__mdt where DeveloperName in:transactionTypeToStepIds.keySet()] );

		System.debug(LoggingLevel.ERROR, 'transactionsById:'+transactionsById);
		System.assert(!transactionsById.isEmpty(), 'No active Transactions defined.');
		
		return transactionsById.values()[0].DeveloperName; // return the first.    	
    } 
    /* */
    
    /* **/
    private static Id getFirstStepIdForTransactionType(String transactionType){
		
		Map<Id, Transaction_Type_Step__mdt> stepsById = new Map<Id, Transaction_Type_Step__mdt>( [select Id from Transaction_Type_Step__mdt where Is_Active__c=true and Transaction_Type__c=:transactionType order by Step_Number__c asc limit 1] );
		
		System.debug(LoggingLevel.ERROR, 'stepsById:'+stepsById);
		System.assert(!stepsById.isEmpty(), 'No active Transaction Steps defined.');
		
		return new List<Id>( stepsById.keySet() )[0];   	
    } 
    /* */    
	
	// End Test helper methods.
	//This methods is used to test the valid step field and historical valid step
	@isTest static void test_setValidsStep()
	{
		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;

		Transaction_Type_Step__mdt testStep2 = CompaniesHouseTestData.getInstance().testStep2;

		Transaction_Type_Step__mdt testStep3 = CompaniesHouseTestData.getInstance().testStep3;

		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Transaction__c trans;

		insert testPresenter;

		insert testCompany;

		//Initialise the Submission Manager
		SubmissionManager subMan = new SubmissionManager();

		subMan.initialise(testForm.Family__c,testPresenter.Id ,'sylvain.picory@methodsdigital.co.uk', testCompany, testForm);

		Test.startTest();

		SubmissionManager.setValidSteps(subMan.submission.Id, null, testStep1.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		List<String> histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('0', histSplit[1]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep1.Id, testStep2.Id);
		
		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[1]);
		system.assertEquals('0', histSplit[3]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep2.Id, testStep3.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep2.Id, null);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[1]);
		system.assertEquals('1', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep1.Id, null);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[1]);
		system.assertEquals('1', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep1.Id, testStep2.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('2', histSplit[1]);
		system.assertEquals('2', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep2.Id, testStep3.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('2', histSplit[1]);
		system.assertEquals('3', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		subMan.submission.Valid_Step_Ids__c = '';
		subMan.submission.Historical_Valid_Step_Ids__c = '';
		update subMan.submission;


		SubmissionManager.setValidSteps(subMan.submission.Id, testStep3.Id, testStep1.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[1]);
		system.assertEquals('0', histSplit[3]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep1.Id, testStep2.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[1]);
		system.assertEquals('1', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep2.Id, testStep3.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('2', histSplit[1]);
		system.assertEquals('1', histSplit[3]);
		system.assertEquals('1', histSplit[5]);

		subMan.submission.Valid_Step_Ids__c = '';
		subMan.submission.Historical_Valid_Step_Ids__c = '';
		update subMan.submission;


		SubmissionManager.setValidSteps(subMan.submission.Id, null, testStep1.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('0', histSplit[1]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep3.Id, testStep2.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('0', histSplit[1]);
		system.assertEquals('1', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		Test.stopTest();


	} 
	
}