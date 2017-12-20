/*
Name:  TransactionStepControllerBaseTest.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Test suite for the TransactionStepControllerBaseTest.cls virtual class.

Coverage for classes below (target 90%):
TransactionStepControllerBaseTest.cls : 86%

Todo :
1. Negative test cases.
2. Historical valid step validate test case.

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-06-03  Initial development.
*/
@isTest(SeeAllData=false)
private class TransactionStepControllerBaseTest {
    /*
    Test cases: 
        singleTestCase1 -  
        ..
        negativeTestCase1 -  
        ..
        bulkTestCase1 - not defined.
        ..
        restrictedUserTest1 - not defined.
    */
    
        
    class testController extends TransactionStepControllerBase {    
        public Boolean validatePageStateTest(){
            return validatePageState();
        }
    }
    
    /* **/
    static testMethod void singleTestCase1() {
        // Test case 1 : 
        Cookie sessionValidity = new Cookie(SecurityManager.DEFAULT_SF_CHS_COOKIE_NAME, SecurityManager.encryptText('jsmith@methods.digital.testing' + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().addDays(-1).getTime())), '', 720, true);

        String tt = getActiveTransactionType();
        System.debug(LoggingLevel.ERROR, 'tt:'+tt);  
        
        Map<Id, Transaction_Type_Step__mdt> stepsById = new Map<Id, Transaction_Type_Step__mdt>( [select Id, DeveloperName, Step_Number__c from Transaction_Type_Step__mdt where Is_Active__c=true and Transaction_Type__c=:tt order by Step_Number__c asc] );
        List<Id> sortedStepIds = new List<Id>( stepsById.keySet() );
                
        Id firstStepId = sortedStepIds[0];
        //Id secondStepId = sortedStepIds[1];
        //Id thirdStepId = sortedStepIds[2];
        
        System.debug(LoggingLevel.ERROR,firstStepId);
        //System.debug(LoggingLevel.ERROR,secondStepId);
        //System.debug(LoggingLevel.ERROR,thirdStepId);                 

        // Instantiate manager instance with the first step Id.
        TransactionManager tm = new TransactionManager(firstStepId);
        
        RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];

        Account presenter = new Account(FirstName='John', LastName='Smith', RecordType=personAccountRecordType, PersonEmail='jsmith@methods.digital.testing');
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
        
        Test.setCurrentPageReference(pr);

        pr.setCookies(new Cookie[]{sessionValidity});
            
        testController c = new testController();
        
        pr = c.initialiseAction();
        
        System.assert(c.isPageAuthenticated, 'Authentication failed');
        System.assert(c.isPageInitialised, 'Initialisation failed');
        //TODO System.assert(c.isPageAlreadyValidStep, 'Validation failed');
        
        System.assert(c.validatePageStateTest(), 'Explicit validation failed');
        System.assert(c.nextStep()!=null, 'Next step navigation failed');
        System.assert(c.previousStep()!=null, 'Previous step navigation failed');
        
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
    
    // End Test helper methods.          
}