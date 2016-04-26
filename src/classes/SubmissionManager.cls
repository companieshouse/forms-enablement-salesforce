/*
Name:  SubmissionManager.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Manager class for the Transaction Submission Custom Object.
Encapsulates all data access and business logic.

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-02  Initial development.
*/
public with sharing class SubmissionManager {
    
    // Public properties.
    public Transaction__c submission { get; set; }    
    
    // Constructors.
    public SubmissionManager(){}
    
    public SubmissionManager(Id submissionId){      
        List<Transaction__c> recs = [select Id, Name, Warning_Confirmation_Flag__c,Amount__c from Transaction__c where Id=:submissionId];
        if (recs.size()==1) submission = recs[0];   
        
        System.debug(LoggingLevel.ERROR, submission);   
    }
    
    public SubmissionManager(Id submissionId, String SObjectType, String fieldSetName){

        String q='select Id, Name';

        Schema.DescribeSObjectResult d = Schema.getGlobalDescribe().get(SObjectType).getDescribe();                     
        //if (!d.isAccessible()) continue; //& todo add object access/fls security checks. 
                
        if (d.fieldSets.getMap().containsKey(fieldSetName)){                    

            Schema.FieldSet fs = d.fieldSets.getMap().get(fieldSetName);
                    
            for(Schema.FieldSetMember f : fs.getFields()){                      
                q+=','+f.getFieldPath();                    
            }
        }
        q+=' from Transaction__c where Id=:submissionId';

        
        List<Transaction__c> recs = Database.query(q);
        if (recs.size()==1) submission = recs[0];   
        
        System.debug(LoggingLevel.ERROR, submission);   
    }
    // End Constructors.
    
    // Instance methods.
    public Id initialise(String transactionType, String presenterId, String companyId, Decimal amount){
        
        // Only initialise with pending submissions.
        List<Transaction__c> recs = [select Id,Amount__c from Transaction__c 
                                                    where Presenter__c=:presenterId 
                                                            and Company__c=:companyId 
                                                            and Transaction_Type__c=:transactionType
                                                            and Status__c=:AppConstants.SUBMISSION_STATUS_PENDING]; // should factor in status.
        if (recs.size()==1) return recs[0].Id;                  
        
        submission = new Transaction__c(Presenter__c=presenterId, Amount__c = amount, Company__c=companyId, Transaction_Type__c=transactionType);
        insert submission;
        return submission.Id;       
    }
    
    public void persist(){
        Database.update(submission);
    }
    // End Instance methods.
    
    // Static methods.
    public static Boolean isValidSubmissionId(Id submissionId){ return ([select count() from Transaction__c where Id=:submissionId]>0); }
   
    public static Boolean isValidSubmissionStepId(Id submissionId, Id stepId){ 
        
        // todo - validation, error handling etc.
        
        Map<Id, Transaction__c> idToSubmission = new Map<Id, Transaction__c>( [select Id, Valid_Step_Ids__c from Transaction__c where Id=:submissionId ] );
        
        Transaction__c s = idToSubmission.values()[0];
        if (String.isBlank(s.Valid_Step_Ids__c)) return false;
        
        for (String validStepId : s.Valid_Step_Ids__c.split(AppConstants.ID_DELIM_SPLIT_CHAR)){
            if (validStepId.equalsIgnoreCase(stepId)) return true;
        }
        return false;               
    }
    
    public static void setValidSteps(Id submissionId, Id previousStepId, Id nextStepId){
        
        // The Valid_Step_Ids__c field will hold all previous Steps and the next Step only.
        // the content should be fully re-evaluated on each step change
        // as user inputs may redirect the Step Path.
                
        // todo - validation, error handling etc.
        
        Map<Id, Transaction__c> idToSubmission = new Map<Id, Transaction__c>( [select Id, Valid_Step_Ids__c from Transaction__c where Id=:submissionId ] );
        
        Transaction__c s = idToSubmission.values()[0];
        
        String newValidStepIdPath = '';
        
        if (previousStepId==null) {
            
            newValidStepIdPath=nextStepId;

        } else if (String.isBlank(s.Valid_Step_Ids__c)){
            
            newValidStepIdPath=previousStepId+AppConstants.ID_DELIM_CHAR+nextStepId;            
            
        } else {
            
            for (String validStepId : s.Valid_Step_Ids__c.split(AppConstants.ID_DELIM_SPLIT_CHAR)){
            
                newValidStepIdPath+=AppConstants.ID_DELIM_CHAR+validStepId;
                
                if (validStepId.equalsIgnoreCase(previousStepId)) break;
            }           
            newValidStepIdPath = newValidStepIdPath.removeStart(AppConstants.ID_DELIM_CHAR)+(nextStepId!=null ? AppConstants.ID_DELIM_CHAR+nextStepId : '');        
        }
                        
        s.Valid_Step_Ids__c=newValidStepIdPath;     
        update s;
    }
    
    public static Id getPreviousStepId(Id submissionId, Id currentStepId){
        
        // todo - validation, error handling etc.
        
        Map<Id, Transaction__c> idToSubmission = new Map<Id, Transaction__c>( [select Id, Valid_Step_Ids__c from Transaction__c where Id=:submissionId ] );     
        if (idToSubmission.size()==0) return null;
        
        Transaction__c s = idToSubmission.values()[0];
        
        if (String.isBlank(s.Valid_Step_Ids__c)){
            
            return null;
            
        } else {
            
            Id previousStepId;
            
            for (String validStepId : s.Valid_Step_Ids__c.split(AppConstants.ID_DELIM_SPLIT_CHAR)){
            
                if (validStepId.equalsIgnoreCase(currentStepId)) return previousStepId;
                
                previousStepId = validStepId;
            }           
            
            return null;
        }
    }
    // End Static methods.
}