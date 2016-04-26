/*
Name:  DynamicTestController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: DynamicTest
(Note - Test suffixed class name was a poor choice)

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class DynamicTestController extends TransactionStepControllerBase {
    
    // Public properties.
    public String pageTitle { get; private set; }
    public String pageText { get; private set; }						        
    public List<DynamicField> dynamicFields { get; private set; }   
            
    // Constructors.
    public DynamicTestController(){
    	super();
    	
    	if (isPageInitialised) initialiseStep();
    }
    // End Constructors.
    
    // Instance methods.
	protected override Boolean loadStepSubmissionState(){
		// override the base class method to load step specific state.
    	try {
    		
    		if (transactionMgr.currentStep.SObject_Type__c!=null && transactionMgr.currentStep.Query_FieldSet_1_Name__c!=null){    		
    			submissionMgr = new SubmissionManager(submissionId, transactionMgr.currentStep.SObject_Type__c, transactionMgr.currentStep.Query_FieldSet_1_Name__c);
    		} else submissionMgr = new SubmissionManager(submissionId);
    		
    	} catch(Exception e){
    		return false;
    	}    	
    	return true;
	}    
    
    private void initialiseStep(){
    	try {

    		System.debug(LoggingLevel.ERROR, submissionMgr.submission); 
			pageTitle = transactionMgr.currentStep.Header_Text_1__c;
			pageText = transactionMgr.currentStep.Display_Text_1__c;

			System.debug(LoggingLevel.ERROR, transactionMgr.currentStep.SObject_Type__c);
			System.debug(LoggingLevel.ERROR, transactionMgr.currentStep.Query_FieldSet_1_Name__c);
						
			if (transactionMgr.currentStep.SObject_Type__c!=null && transactionMgr.currentStep.Query_FieldSet_1_Name__c!=null){
				
				// enumerate field and instantiate DynamicField instances and add to collection	
				Schema.DescribeSObjectResult d = Schema.getGlobalDescribe().get(transactionMgr.currentStep.SObject_Type__c).getDescribe();        	        	
        		//if (!d.isAccessible()) continue; //& todo add object access/fls security checks. 
        		
        		if (d.fieldSets.getMap().containsKey(transactionMgr.currentStep.Query_FieldSet_1_Name__c)){ 					
					dynamicFields = new List<DynamicField>();
					
					Schema.FieldSet fs = d.fieldSets.getMap().get(transactionMgr.currentStep.Query_FieldSet_1_Name__c);
					
					System.debug(LoggingLevel.ERROR, 'FieldSet Found:'+fs);
					for(Schema.FieldSetMember f : fs.getFields()){						
						// todo - pass field values of non-string types.
						dynamicFields.add(new DynamicField(f.getFieldPath(),f.getLabel(),String.valueOf(submissionMgr.submission.get(f.getFieldPath())),f.getType()));					
					}


					System.debug(LoggingLevel.ERROR, 'dynamicFields:'+dynamicFields);
				}
			}

    	} catch (Exception e){ return; }    	
    	return;
    }
    
	private void persistStep(){
		try {
			for (DynamicField f : dynamicFields){
				System.debug(LoggingLevel.ERROR, 'dynamicFields f:'+f);

				if (f.displayType==Schema.Displaytype.String ||
	                f.displayType==Schema.Displaytype.PickList || 
	                f.displayType==Schema.Displaytype.Email ||
	                f.displayType==Schema.Displaytype.URL ||
	                f.displayType==Schema.Displaytype.Phone ||
	                f.displayType==Schema.Displaytype.TextArea){           
            
            		submissionMgr.submission.put(f.fieldName, (String)f.fieldValue);
                	
            	} else if (f.displayType==Schema.Displaytype.Currency ||
                    f.displayType==Schema.Displaytype.Double ||
                    f.displayType==Schema.Displaytype.Integer ||
                    f.displayType==Schema.Displaytype.Percent){

					submissionMgr.submission.put(f.fieldName, Decimal.valueOf(f.fieldValue));                                                            	
                	             
	            } else if (f.displayType==Schema.Displaytype.Boolean){	                
	                submissionMgr.submission.put(f.fieldName, Boolean.valueOf(f.fieldValue)); 
	                
	            } else if (f.displayType==Schema.Displaytype.Datetime){          	                
	                submissionMgr.submission.put(f.fieldName, Datetime.valueOf(f.fieldValue));
	                 	                
	            } else if (f.displayType==Schema.Displaytype.Date){	                
					submissionMgr.submission.put(f.fieldName, Date.valueOf(f.fieldValue));
					 					                
				}					                
			}
			submissionMgr.persist();
		} catch (Exception e){
			System.debug(LoggingLevel.ERROR, e.getMessage()+' '+e.getStackTraceString());
		}
	}
    // End Instance methods.

	// Action methods.           
    public PageReference nextAction(){
    	if (!validatePageState()) return Page.TransactionException;
    	
    	persistStep(); 
		return nextStep();    	
    }
    
    public PageReference previousAction(){
    	if (!validatePageState()) return Page.TransactionException;
    	    	
    	return previousStep();
    }
    // End Action methods.    
}