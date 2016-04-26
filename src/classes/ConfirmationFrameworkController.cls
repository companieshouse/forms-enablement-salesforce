/*
Name:  ConfirmationController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Confirmation

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class ConfirmationFrameworkController extends TransactionStepControllerBase {
    
    // Public properties.
    public String confirmationTitle { get; private set; }
    public String confirmationText { get; private set; }    			    
    public Boolean confirmationFlag { get; set; }
            
    // Constructors.
    public ConfirmationFrameworkController(){
    	super();
    	
    	if (isPageInitialised) initialiseStep();
    }
    // End Constructors.
    
    // Instance methods.
    private void initialiseStep(){
    	try {

    		System.debug(LoggingLevel.ERROR, submissionMgr.submission); 
    		confirmationFlag = submissionMgr.submission.Warning_Confirmation_Flag__c;
    		System.debug(LoggingLevel.ERROR, confirmationFlag);
			
			confirmationTitle = transactionMgr.currentStep.Header_Text_1__c;
			confirmationText = transactionMgr.currentStep.Display_Text_1__c;

    	} catch (Exception e){ return; }    	
    	return;
    }
	
	private void persistStep(){
		submissionMgr.submission.Warning_Confirmation_Flag__c = confirmationFlag;
		submissionMgr.persist();    
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