/*
Name:  StartController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Start

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-02  Initial development.
*/
public with sharing class StartFrameworkController {
    
    // Public properties.
    public String pageTitle { get; private set; }
    public String pageText { get; private set; }
       
    // Private class members.
    Boolean isPageInitialised=false;
    SecurityManager securityMgr;  
	TransactionManager transactionMgr;
	String transactionType;
    
    // Constructors.
    public StartFrameworkController(){
    	initialise();
    }
    
    private void initialise(){
   		securityMgr = new SecurityManager();		
    	
    	try {

    		if (!ApexPages.currentPage().getParameters().containsKey('t') || 
    				String.isBlank(ApexPages.currentPage().getParameters().get('t')) ||
    				!TransactionManager.isValidTransactionType(ApexPages.currentPage().getParameters().get('t'))) return;
    	
    		transactionType = ApexPages.currentPage().getParameters().get('t');
    		transactionMgr = new TransactionManager(transactionType);
			
			pageTitle = transactionMgr.td.Landing_Page_Title__c;
			pageText = transactionMgr.td.Landing_Page_Text__c;
			    	
    		isPageInitialised=true;
    	} catch (Exception e){ return; }    	
    	return;
    }
    // End Constructors.    
    
    // Instance methods.
    public PageReference initialiseAction(){
		if (!isPageInitialised) return Page.TransactionException;
		return null;
    }
        
    public PageReference startAction(){
    	
    	// todo - the code below forces reauthentication.
    	// todo - code should check for non-expired User_Authorisation__c record (record Id stored in user_auth cookie).    	
          	    
        // todo - reinstate user authentication
    	//return securityMgr.getUserAuthRedirect();
    	
    	PageReference pr = new PageReference('/Company');
    	pr.getParameters().put('t',transactionType);
    	return pr;
    }
    // End Instance methods.
}