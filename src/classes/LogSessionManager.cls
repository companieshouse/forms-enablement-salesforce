/*
Name:  LogSessionManager.cls
Copyright © 2017  Ribbonfish LTD
======================================================
======================================================
Purpose:
-------

This class will be used to log anything related to the cookie system.

It will be managed using the custom setting SessionLogManager__c
======================================================
======================================================
History
------- 
Ver. Author            Date        Detail
1.0  Sylvain Picory    2017-05-26  Initial draft of code.
*/
public with sharing class LogSessionManager {
	
    public static Boolean isSystemEnable {get; set;}
    public static String log {get; set;}

    public static void initSystem(){
        SessionLogManager__c managerSettings = SessionLogManager__c.getOrgDefaults();

        if(managerSettings == null || managerSettings.Active__c == null || managerSettings.Id == null)
        {
            isSystemEnable = false;
        }
        else{
            isSystemEnable = managerSettings.Active__c;
        }
    }

    public static void initLog(){
        if(isSystemEnable == null || !isSystemEnable){
            initSystem();
        }

        log = '<br/>-----------------------------------------------------------------------------------';
    }

    public static void addLog(String logSentence){
        if(log == null)
        {
            initLog();
        }

        if(isSystemEnable == null || !isSystemEnable) return;

        log += logSentence;
    }

    public static void updateTransactionLog(Transaction__c submission)
    {
        if(isSystemEnable == null || !isSystemEnable) return;

        if(!String.isBlank(log) && submission != null && submission.Id != null)
        {
            if(String.isBlank(submission.Session_Log__c))
                submission.Session_Log__c = log;
            else
            {
                if(submission.Session_Log__c.length() > 100000)
                    submission.Session_Log__c = '';
                submission.Session_Log__c += log;
            }

        }

        initLog();
    }

    public static void commitChangeToTransaction(Transaction__c submission, TransactionManager transactionMgr)
    {
        if(isSystemEnable == null || !isSystemEnable) return;

        if(transactionMgr != null && transactionMgr.currentStep != null && transactionMgr.currentStep.Step_Number__c > 10  && !String.isBlank(log) && submission != null && submission.Id != null)
        {
            if(String.isBlank(submission.Session_Log__c))
                submission.Session_Log__c = log;
            else
            {
                if(submission.Session_Log__c.length() > 100000)
                    submission.Session_Log__c = '';
                submission.Session_Log__c += log;
            }

            update submission;
        }

        initLog();
    }
}