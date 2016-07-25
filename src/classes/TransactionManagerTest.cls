/*
Name:  TransactionManagerTest.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Test suite for the TransactionManager.cls class.

Coverage for classes below (target 90%):
TransactionManager.cls : 82%

Note - CMT records are metadata not data and do not support DML via Apex.
Best practice is to assume the existence of the CMT records packaged
by the application. Use of test-only CMT is not appropriate here. 

Todo :
1. Static binding to a specific transaction type that includes Apex steps.

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-06-03  Initial development.
*/
@isTest(SeeAllData=false)
private class TransactionManagerTest {
    /*
    Test cases: 
        singleTestCase1 - Instantiate Manager with Transaction Type (sequence start). 
        singleTestCase2 - Instantiate Manager with Step Id (mid-sequence).
        singleTestCase3 - Valid Ids test.
        ..
        negativeTestCase1 - Instantiate Manager with Invalid Transaction Type (sequence start). 
        negativeTestCase2 - Instantiate Manager with Invalid Step Id (mid-sequence).
        negativeTestCase3 - Invalid Ids test.         
        ..
        bulkTestCase1 - not defined.
        ..
        restrictedUserTest1 - not defined.
    */

    
    /* **/
    static testMethod void singleTestCase1() {
        // Test case 1 : Instantiate Manager with Transaction Type (sequence start).
        
        // use the first active transaction type found with more than two active steps.
        String tt = getActiveTransactionType();
        System.debug(LoggingLevel.ERROR, 'tt:'+tt); 
        System.assert(!String.isBlank(tt), 'Transaction type should be returned.'); 

        // Instantiate manager instance with a transaction type.
        TransactionManager tm = new TransactionManager(tt);

        Account presenter = new Account(FirstName='John', LastName='Smith', PersonEmail='jsmith@methods.digital.testing');
        insert presenter;

        Account company = new Account(Name='Methods Digital');
        insert company;     
        
        SubmissionManager sm = new SubmissionManager();
        Id submissionId = sm.initialise(tt, presenter.Id, presenter.PersonEmail, company, tm.td); 
        System.assert(submissionId!=null, 'Submission Id should be returned.');
        
        // first step only.
        PageReference pr;
        
        Test.startTest();
        pr = tm.firstStep(submissionId);
        System.assert(pr!=null, 'First step should be returned.');

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
        
        System.debug(LoggingLevel.ERROR,firstStepId);
        System.debug(LoggingLevel.ERROR,secondStepId);
        System.debug(LoggingLevel.ERROR,thirdStepId);                   

        // Instantiate manager instance with the first step Id.
        TransactionManager tm = new TransactionManager(firstStepId);
        
        Account presenter = new Account(FirstName='John', LastName='Smith', PersonEmail='jsmith@methods.digital.testing');
        insert presenter;

        Account company = new Account(Name='Methods Digital');
        insert company;     
        
        SubmissionManager sm = new SubmissionManager();
        Id submissionId = sm.initialise(tt, presenter.Id, presenter.PersonEmail, company, tm.td); 
        
        // first step - then step navigation.
        PageReference pr;
        
        Test.startTest();

        pr = tm.getCurrentStep(submissionId); // first step
        System.assert(pr!=null, 'Current step should be returned.');
        
        pr = tm.nextStep(submissionId);  // to step 2.
        System.assert(pr!=null, 'Next step should be returned.');

        System.debug(LoggingLevel.ERROR, [select Id,Valid_Step_Ids__c,Historical_Valid_Step_Ids__c from Transaction__c where Id=:submissionId ] );      

        tm = new TransactionManager(secondStepId);
        pr = tm.previousStep(submissionId); // to step 1.
        System.assert(pr!=null, 'Previous step should be returned.');
        
        System.debug(LoggingLevel.ERROR, [select Id,Valid_Step_Ids__c,Historical_Valid_Step_Ids__c from Transaction__c where Id=:submissionId ] );

        tm = new TransactionManager(firstStepId);
        pr = tm.nextStep(submissionId); // to step 2.
        System.assert(pr!=null, 'Next step should be returned.');
        
        System.debug(LoggingLevel.ERROR, [select Id,Valid_Step_Ids__c,Historical_Valid_Step_Ids__c from Transaction__c where Id=:submissionId ] );
        
        tm = new TransactionManager(secondStepId);
        System.debug(LoggingLevel.ERROR,tm);    
        pr = tm.nextStep(submissionId); // to step 3.
        System.assert(pr!=null, 'Next step should be returned.');
        
        System.debug(LoggingLevel.ERROR, [select Id,Valid_Step_Ids__c,Historical_Valid_Step_Ids__c from Transaction__c where Id=:submissionId ] );

        tm = new TransactionManager(thirdStepId);
        pr = tm.previousStep(submissionId); // to step 2.
        System.assert(pr!=null, 'Previous step should be returned.');
        
        System.debug(LoggingLevel.ERROR, [select Id,Valid_Step_Ids__c,Historical_Valid_Step_Ids__c from Transaction__c where Id=:submissionId ] );

        System.assert(!tm.isLastPage(), 'Step should not be the last in the sequence.');
        
        Test.stopTest();        
    }
    /* */  
    
    /* **/
    static testMethod void singleTestCase3() {
        // Test case 3 : Valid Ids test.
        
        // use the first active transaction type found with more than two active steps.
        String tt = getActiveTransactionType();
        System.debug(LoggingLevel.ERROR, 'tt:'+tt);
        
        Id stepId = getFirstStepIdForTransactionType(tt);
        System.debug(LoggingLevel.ERROR, 'stepId:'+stepId);

        // Instantiate manager instance with a transaction type.
        Test.startTest();
        System.assert(TransactionManager.isValidTransactionType(tt), 'Valid Transaction Type Fail');
        System.assert(TransactionManager.isValidTransactionStep(stepId), 'Valid Transaction Step Id Fail');
        Test.stopTest();
    }
    /* */         
    
    /* **/
    static testMethod void negativeTestCase1() {
        // Test case 1 : Instantiate Manager with Invalid Transaction Type (sequence start).

        String tt = 'x_';
        System.debug(LoggingLevel.ERROR, 'tt:'+tt); 
        System.assert(!String.isBlank(tt), 'Transaction type should be returned.'); 

        // Instantiate manager instance with a transaction type.
        Test.startTest();
        TransactionManager tm = new TransactionManager(tt);
        System.assert(tm.td==null, 'Transaction type is not set.');
        Test.stopTest();
    }
    /* */
        
    /* **/
    static testMethod void negativeTestCase2() {
        // Test case 2 : Instantiate Manager with Invalid Step Id (mid-sequence).
        
        // use the first active transaction type found with more than two active steps.
        String tt = getActiveTransactionType();
        System.debug(LoggingLevel.ERROR, 'tt:'+tt);  
        
        Id stepId = getFirstStepIdForTransactionType(tt);
        System.debug(LoggingLevel.ERROR, 'stepId:'+stepId);
                    
        // Instantiate manager instance with a transaction type.
        Test.startTest();
        TransactionManager tm;
        Boolean isError=false;
        try {
            tm = new TransactionManager(stepId+'x');
        } catch (Exception e){
            isError=true;
        }
        System.assert(!isError, 'Runtime exception should be thrown.'); //TODO - error handling code required in the manager class.
        Test.stopTest();        
    }
    /* */
    
    /* **/
    static testMethod void negativeTestCase3() {
        // Test case 3 : Invalid Ids test.
        
        // use the first active transaction type found with more than two active steps.
        String tt = getActiveTransactionType();
        System.debug(LoggingLevel.ERROR, 'tt:'+tt);
        
        Id stepId = getFirstStepIdForTransactionType(tt);
        System.debug(LoggingLevel.ERROR, 'stepId:'+stepId);

        Test.startTest();
        // Instantiate manager instance with a transaction type.
        System.assert(!TransactionManager.isValidTransactionType('?.+'), 'Invalid Transaction Type Success');       
        System.assert(!TransactionManager.isValidTransactionStep(stepId+'x'), 'Invalid Transaction Step Id Success');
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
        
        Map<Id, Transaction_Type__mdt> transactionsById = new Map<Id, Transaction_Type__mdt>( [select Id, DeveloperName from Transaction_Type__mdt where DeveloperName in:transactionTypeToStepIds.keySet()] );

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
}