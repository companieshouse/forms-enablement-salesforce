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
1.1  Antonio Bravo 2016-04-26  Update Constants
*/
public with sharing class SubmissionManager {
    
    // Public properties.
    public Transaction__c submission { get; set; }    
    
    // Constructors.
    public SubmissionManager(){}
    
    public SubmissionManager(Id submissionId){      
        List<Transaction__c> recs = [select Id, Presenter__r.Name,PresenterName__c, PresenterPhoneNumber__c, Name,Historical_Valid_Step_Ids__c,CompanyNumber__c,Status__c,CompanyName__c, ContactEmail__c, MultipleDirectors__c, SubmissionId__c, Warning_Confirmation_Flag__c,Amount__c, (SELECT Id,BodyLength, Name FROM Attachments),(Select Id,Name, Email__c,isPresenter__c From Officers__r) from Transaction__c where Id=:submissionId];
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
    public Id initialise(String transactionType, String presenterId, String presenterEmail, SObject companyId, Transaction_Type__mdt td){
        
        // Only initialise with pending submissions.
        List<Transaction__c> recs = [select Id, Presenter__c, ,PresenterName__c, PresenterPhoneNumber__c, Historical_Valid_Step_Ids__c,CompanyName__c,CompanyNumber__c, ContactEmail__c, MultipleDirectors__c,  Status__c,Amount__c,SubmissionId__c,(SELECT Id,BodyLength, Name FROM Attachments),(Select Id,Name, Email__c,isPresenter__c From Officers__r) from Transaction__c 
                                                    where Presenter__c=:presenterId 
                                                            and Company__c=:companyId.Id
                                                            and Transaction_Type__c=:transactionType
                                                            and (Status__c=:AppConstants.REQUEST_STATUS_DRAFT
                                                                or Status__c=:AppConstants.REQUEST_STATUS_SIGNED)]; // should factor in status.
        if (recs.size()==1) return recs[0].Id;                  
        
        submission = new Transaction__c(Presenter__c=presenterId, ContactEmail__c=presenterEmail, Amount__c = td.Fee__c, Form_Name__c = td.DeveloperName, Company__c=((Account)companyId).Id, CompanyNumber__c=((Account)companyId).Name, Transaction_Type__c=transactionType);
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
        
        Map<Id, Transaction__c> idToSubmission = new Map<Id, Transaction__c>( [select Id, Valid_Step_Ids__c,Historical_Valid_Step_Ids__c from Transaction__c where Id=:submissionId ] );
        
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

        String historicalSteps = s.Historical_Valid_Step_Ids__c;
        String result = '';
        String previousStepIdTXT = previousStepId;
        String nextStepIdTXT = nextStepId;
        if(historicalSteps != null)
        {
            Boolean previousButton = false;
            if(nextStepIdTXT == null)
            {
                previousButton = true;
            }
            //throw new Form_CustomException(previousStepIdTXT + 'NEXT' + nextStepIdTXT + 'HISTO' + historicalSteps);
            if(previousStepIdTXT != null)
            {
                if(!previousButton)
                {
                    if(historicalSteps.contains(previousStepIdTXT))
                    {
                        List<String> lHist = historicalSteps.split(AppConstants.DELIM_HISTORICAL_STEP);
                        
                        for(Integer i = 0; i <= lHist.size()-1; i++)
                        {
                            if(lHist[i] == previousStepIdTXT)
                            {
                                 result +=  lHist[i] + AppConstants.DELIM_HISTORICAL_STEP + (Integer.valueOf(lHist[i+1])+1 ) + AppConstants.DELIM_HISTORICAL_STEP ;
                                 i = i + 1;
                            }
                            else{
                                result += lHist[i] + AppConstants.DELIM_HISTORICAL_STEP;
                            }   
                        }
                        historicalSteps = result;
                        result = '';
                    }
                    else
                    {
                        historicalSteps += ''+ previousStepIdTXT + AppConstants.DELIM_HISTORICAL_STEP + 1 + AppConstants.DELIM_HISTORICAL_STEP;
                    } 
                    if(historicalSteps.contains(nextStepIdTXT))
                    {
                        List<String> lHist = historicalSteps.split(AppConstants.DELIM_HISTORICAL_STEP);
                        

                        for(Integer i = 0; i <= lHist.size()-1; i++)
                        {
                            if(lHist[i] == nextStepIdTXT)
                            {

                                if(Integer.valueOf(lHist[i+1]) != 0)
                                {
                                    result +=  lHist[i] + AppConstants.DELIM_HISTORICAL_STEP + (Integer.valueOf(lHist[i+1])+1 ) + AppConstants.DELIM_HISTORICAL_STEP ;
                                    i = i + 1;
                                }
                                else{
                                    result += lHist[i] + AppConstants.DELIM_HISTORICAL_STEP;
                                }
                            }
                            else{
                                result += lHist[i] + AppConstants.DELIM_HISTORICAL_STEP;
                            }   
                        }
                        historicalSteps = result;
                    }
                    else{
                        historicalSteps += ''+ nextStepIdTXT + AppConstants.DELIM_HISTORICAL_STEP + 0 + AppConstants.DELIM_HISTORICAL_STEP;
                    }

                }
            }
        }
        else{
            if(previousStepIdTXT != null)
            {
                historicalSteps = '' + previousStepIdTXT + AppConstants.DELIM_HISTORICAL_STEP + 1 + AppConstants.DELIM_HISTORICAL_STEP;
            }

            if(nextStepIdTXT != null)
            {
                if(historicalSteps == null)
                {
                    historicalSteps = '' + nextStepIdTXT + AppConstants.DELIM_HISTORICAL_STEP + 0 + AppConstants.DELIM_HISTORICAL_STEP;
                }
                else{
                    historicalSteps += '' + nextStepIdTXT + AppConstants.DELIM_HISTORICAL_STEP + 0 + AppConstants.DELIM_HISTORICAL_STEP;
                }
            }

        }
        
        s.Historical_Valid_Step_Ids__c = historicalSteps;
        s.Valid_Step_Ids__c=newValidStepIdPath;    
        s.MultipleDirectors__c = false;
        

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