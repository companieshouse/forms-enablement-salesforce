/*
Name:  SummaryController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Summary

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class SummaryController extends TransactionStepControllerBase {
    
    // Public properties.
    public String pageTitle { get; private set; }
    public String pageText { get; private set; }   
            
    // Constructors.
    public SummaryController(){
    	super();
    	
    	if (isPageInitialised) initialiseStep();
    }
    // End Constructors.
    
    // Instance methods.
    private void initialiseStep(){
    	try {

    		System.debug(LoggingLevel.ERROR, submissionMgr.submission); 
			pageTitle = transactionMgr.currentStep.Header_Text_1__c;
			pageText = transactionMgr.currentStep.Display_Text_1__c;

    	} catch (Exception e){ return; }    	
    	return;
    }
    // End Instance methods.
           
	// Action methods.           
    public PageReference nextAction(){     	
    	if (!validatePageState()) return Page.TransactionException; 
    	return nextStep();		    	    	
    }
    
    public PageReference previousAction(){    	
    	if (!validatePageState()) return Page.TransactionException;
    	return previousStep();
    }
    // End Action methods.
}