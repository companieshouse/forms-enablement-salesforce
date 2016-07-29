/*
Name:  TransactionManager.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Manager class for the Transaction Type Custom Metadata Type entities.
Encapsulates all data access and business logic.

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class TransactionManager {
    
    // Public properties.
    public Transaction_Type__mdt td { get; private set; }
    public Transaction_Type_Step__mdt currentStep { get; private set; }
    
    // Private class members.
    private Map<Id, Transaction_Type_Step__mdt> stepsById;
    private String transactionType;
    private Integer stepCount=0; 
    
    // Constructors.
    private TransactionManager(){}
    
    public TransactionManager(String transactionType){
    	    	//throw new Form_CustomException('transaction type is ' + transactionType);

    	this.transactionType=transactionType;
		retrieveTransactionType(transactionType);
    }
    
    public TransactionManager(Id stepId){    	
    	// query the transaction type Id from the stepId then load the transaction def.
    	transactionType = [select Transaction_Type__c from Transaction_Type_Step__mdt where Id=:stepId].Transaction_Type__c;
    	this.transactionType=transactionType;
		retrieveTransactionType(transactionType);
		
		stepCount = stepsById.size();
		
		for (Transaction_Type_Step__mdt step : stepsById.values()){
			if (step.Id.equals(stepId)){
				currentStep = step;
				break;
			}
		}
		if (currentStep==null) {


		} // todo - error handling.
    }    
    // End Constructors.
    
    // Instance methods.
    private void retrieveTransactionType(String transactionType){

		List<Transaction_Type__mdt> recs = [select Id,Company_Page_HiddenT3__c,Company_Page_HiddenT2__c,Company_Page_HiddenT1__c,Company_Page_Body_4__c,Company_Page_Body_3__c,Company_Page_Body_2__c,Company_Page_Body_1__c,Company_Page_Title__c,Product_Code__c, customGuidanceView__c, StandardGuidanceView__c ,companySearchPageText__c,isDigitalSignatureNeeded__c ,FeeFastTrack__c,isPaypalAllowed__c,isPaymentRequired__c,Below_Button_Title2__c,Below_Button_Text4__c,Below_Button_Text5__c,Below_Button_Text6__c,isSameDayPayment__c,isCardAllowed__c,isAccountPayment__c,Expiry_Date_Length__c ,Guidance_Text_1__c,Guidance_Text_2__c,Guidance_Text_3__c,Guidance_Text_4__c,Guidance_Text_5__c,Guidance_Text_6__c,GuidanceWarningText__c,hasGuidancePage__c,isMajorityForm__c, Below_Button_Title__c, Landing_Page_Text2__c,Landing_Page_Text3__c, Landing_Page_Text4__c, Landing_Page_Text5__c, Landing_Page_Text6__c,  above_button_text__c, Below_Button_Text3__c,Below_Button_Text2__c,Below_Button_Text__c,  DeveloperName, Landing_Page_Title__c, Landing_Page_Text__c, Fee__c, Family__c from Transaction_Type__mdt where DeveloperName=:transactionType];
		if (recs.size()==1){
			
			td = recs[0];
			
			stepsById = new Map<Id, Transaction_Type_Step__mdt>( [select  CustomView__c, StandardView__c, CompanyNameText__c, Header_Text_2__c, Header_Text_3__c, previousButtonText__c, ContinueButtonText__c,Display_Text_4__c,Display_Text_6__c,Display_Text_5__c,Id, DeveloperName, Step_Number__c, Step_Type__c, Visualforce_Page_Name__c, Apex_Class_Name__c, Query_FieldSet_1_Name__c, Persist_FieldSet_1_Name__c, 
																		Header_Text_1__c, Display_Text_1__c,Display_Text_2__c,Display_Text_3__c, Is_Active__c, Document_Template_Name__c, SObject_Type__c 
																	from Transaction_Type_Step__mdt 
																	where Transaction_Type__c=:td.DeveloperName and Is_Active__c=true order by Step_Number__c asc]);
									
		} else {
			// todo - error handling.
		}
    }    
    public PageReference getCurrentStep(Id submissionId){    	
		PageReference pr = getNextStepPageReference(Integer.valueOf(currentStep.Step_Number__c)-1, submissionId);  
		
		//pr.setCookies(new List<Cookie> { new Cookie('submission', SecurityManager.encryptText(submissionId), null, 600, true) } );
		pr.setRedirect(true);
		return pr;		
    }        
       
    public PageReference firstStep(Id submissionId){    	
		PageReference pr = getNextStepPageReference(0,submissionId);
		
		//pr.setCookies(new List<Cookie> { new Cookie('submission', SecurityManager.encryptText(submissionId), null, 600, true) } );
		pr.setRedirect(true);
		return pr;		
    }    
    
    public PageReference nextStep(Id submissionId){

		if (currentStep.Step_Number__c>=stepCount) return null; 
		
		PageReference pr = getNextStepPageReference(Integer.valueOf(currentStep.Step_Number__c), submissionId);     	
    	pr.setRedirect(true);
    	System.debug(LoggingLevel.ERROR,'in nextStep:'+pr);
		return pr;		    	
    }
    
    public PageReference previousStep(Id submissionId){
    	if (currentStep.Step_Number__c==1) return new PageReference('/Company?t='+transactionType);
		if (currentStep.Step_Number__c<1) return null; 
		
		PageReference pr = getPrevStepPageReference(submissionId);     	
    	pr.setRedirect(true);
    	System.debug(LoggingLevel.ERROR,'in previousStep:'+pr);
		return pr;
    }
    
	private PageReference getNextStepPageReference(Integer currentStepNumber, Id submissionId){  
		System.debug(LoggingLevel.ERROR,'in getNextStepPageReference:'+currentStepNumber+':'+td+':'+stepsById);
		  
		try {
			
	    	if (td==null || stepsById==null || stepsById.isEmpty()) return null;
	    	    
	    	Transaction_Type_Step__mdt nextStep;
	    	
			for (Transaction_Type_Step__mdt step : stepsById.values()){
				if (step.Step_Number__c>currentStepNumber){
					
					System.debug(LoggingLevel.ERROR,'in getNextStepPageReference>step:'+step);
					
					if (step.Step_Type__c.equalsIgnoreCase(AppConstants.TRANSACTION_TYPE_VISUALFORCE_PAGE)){
						nextStep = step;
						break;
							
					} else if (step.Step_Type__c.equalsIgnoreCase(AppConstants.TRANSACTION_TYPE_APEX_CODE)){
						
						Id nextStepId = getNextStepIdByApex(step.Apex_Class_Name__c, submissionId);
						nextStep = stepsById.get(nextStepId);
						break;
											
					}			
				}
			}
			if (nextStep==null) return null; // todo - error handling
			
			System.debug(LoggingLevel.ERROR,'in getNextStepPageReference>nextStep:'+nextStep);
			
			PageReference pr = new PageReference('/'+nextStep.Visualforce_Page_Name__c);
			pr.getParameters().put('c', SecurityManager.encryptText(submissionId+AppConstants.ID_DELIM_CHAR+nextStep.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));				
			
			SubmissionManager.setValidSteps(submissionId,(currentStep==null ? null : currentStep.Id), nextStep.Id);
			
			return pr;
		} catch (Exception e){
			System.debug(LoggingLevel.ERROR,'in getNextStepApex:'+e.getMessage()+':'+e.getStacktraceString());
		}
		return null;		
	}
	
	private PageReference getPrevStepPageReference(Id submissionId){  
		System.debug(LoggingLevel.ERROR,'in getPrevStepPageReference:'+submissionId+':'+td);
		
		Id previousStepId = SubmissionManager.getPreviousStepId(submissionId,currentStep.Id);
		if (previousStepId==null) return new PageReference('/Company?t='+transactionType); // todo - check this logic.
		
		Transaction_Type_Step__mdt previousStep = stepsById.get(previousStepId);
		
		System.debug(LoggingLevel.ERROR,'in getPrevStepPageReference>previousStep:'+previousStep);
		
		PageReference pr = new PageReference('/'+previousStep.Visualforce_Page_Name__c);
		pr.getParameters().put('c', SecurityManager.encryptText(submissionId+AppConstants.ID_DELIM_CHAR+previousStep.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));				
		
		SubmissionManager.setValidSteps(submissionId,previousStep.Id,null);
				
		return pr;
		
		/*
    	if (td==null || stepsById.isEmpty()) return null;
    	   
    	PageReference pr;
    	Transaction_Type_Step__mdt step;
    	
    	for (Integer i=stepsById.values().size()-1; i>-1; i--){
			step = stepsById.values()[i];
			
			System.debug(LoggingLevel.ERROR,'in loop:'+step+':'+i);

			if (step.Step_Number__c<currentStepNumber){
				
				if (step.Step_Type__c.equalsIgnoreCase(AppConstants.TRANSACTION_TYPE_VISUALFORCE_PAGE)){
					pr = new PageReference('/'+step.Visualforce_Page_Name__c);	
				} else if (step.Step_Type__c.equalsIgnoreCase(AppConstants.TRANSACTION_TYPE_APEX_CODE)){				
					pr = getPreviousStepApex(step.Apex_Class_Name__c, submissionId);
				}
				
				System.debug(LoggingLevel.ERROR,'in getPrevStepPageReference>pr:'+pr);
				pr.getParameters().put('c', SecurityManager.encryptText(submisionId+AppConstants.ID_DELIM_CHAR+step.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));
				break;
			}
    	}
    	
		System.debug(LoggingLevel.ERROR,'in getPrevStepPageReference:pr:'+pr);
		return pr;
		*/
		//return null;
	} 
	
	private Id getNextStepIdByApex(String navigableClassName, Id submissionId){
		
		// todo - validate the input
		System.debug(LoggingLevel.ERROR,'in getNextStepIdByApex:'+navigableClassName+':'+submissionId);
				
		try {
			Type t = Type.forName(navigableClassName);
			IStepNavigable stepNavigable = (IStepNavigable)t.newInstance(); // cast as the interface type and call an interface method.
			return stepNavigable.getNextStepIdByApex(submissionId);
			
		} catch (Exception e){
			System.debug(LoggingLevel.ERROR,'in getNextStepApex:'+e.getMessage()+':'+e.getStacktraceString());
		}
		return null;
	}
	
    public Boolean isLastPage(){    	
		for (Transaction_Type_Step__mdt step : stepsById.values()){
			if (step.Step_Number__c>currentStep.Step_Number__c){
				return false;
			}
		}
    	return true;
    }
	// End Instance methods.
	
    // Static methods.
    public static Boolean isValidTransactionType(String transactionType){ return ([select count() from Transaction_Type__mdt where DeveloperName=:transactionType]>0); }
    public static Boolean isValidTransactionStep(String stepId){ return ([select count() from Transaction_Type_Step__mdt where Id=:stepId]>0); }    
    // End Static methods.
}