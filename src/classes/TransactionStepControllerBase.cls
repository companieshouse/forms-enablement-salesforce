/*
Name:  TransactionStepControllerBase.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Base class for all Transaction Step pages.

Encapsulates : 	authentication logic
				state restoration - transaction defintion
				state restoration - submission data

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-05  Initial development.
*/
public virtual class TransactionStepControllerBase {
       
	// Public class members.        
	public Boolean isPageAuthenticated=false;
	public Boolean isPageInitialised=false;
	public Boolean isPageAlreadyValidStep=false;
    
    public SecurityManager securityMgr;
    public SubmissionManager submissionMgr;    
	public TransactionManager transactionMgr;
	
	public Id stepId;
	public Id submissionId;
	
	// Public properties.
	public Boolean isLastPage { get; private set; }
        
    // Constructors.
    public TransactionStepControllerBase(){
    	initialise();
    }
    // End Constructors.
        
    // Initialisation methods.    
    private void initialise(){  
    	System.debug(LoggingLevel.ERROR,'in initialise'); 		
    	try {
    		
    		isPageAuthenticated=false;
    		isPageInitialised=false;

			// todo reinstate authorisation.

			// Authorsation state (User and Company).
			//Cookie companyAuthCookie = ApexPages.currentPage().getCookies().get('company_auth');
			//System.debug(LoggingLevel.ERROR,'companyAuthCookie:'+companyAuthCookie);
			//if (companyAuthCookie==null) return;			
			//String companyAuthId = SecurityManager.decryptText(companyAuthCookie.getValue());
			
			//Cookie userAuthCookie = ApexPages.currentPage().getCookies().get('user_auth');
			//System.debug(LoggingLevel.ERROR,'userAuthCookie:'+userAuthCookie);
			//if (userAuthCookie==null) return;
			//String userAuthId = SecurityManager.decryptText(userAuthCookie.getValue());			
			
			//securityMgr = new SecurityManager();
			//if (!securityMgr.validateAuthenticatedState(companyAuthId,userAuthId)) return;
			isPageAuthenticated=true;
			// Transaction context.
    		if (!ApexPages.currentPage().getParameters().containsKey('c') || 
    				String.isBlank(ApexPages.currentPage().getParameters().get('c'))) return;
			
			String paramValue = SecurityManager.decryptText(ApexPages.currentPage().getParameters().get('c'));    				

			// Submission state.
			submissionId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];
			if (!SubmissionManager.isValidSubmissionId(submissionId)) return;

    		stepId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];
    		if (!TransactionManager.isValidTransactionStep(stepId)) return;

    		// Finally check that the step Id is valid for the submission 
    		// todo - merge with submission id check early in context.
    		if (!SubmissionManager.isValidSubmissionStepId(submissionId,stepId)) return;

    		transactionMgr = new TransactionManager(stepId);
			isLastPage = transactionMgr.isLastPage();

			isPageInitialised=loadStepSubmissionState();

			
    	
    	} catch (Exception e){ return; }
    	return;
    }
    
	public PageReference initialiseAction(){		
		if (!isPageAuthenticated) return Page.TransactionException; // todo - default behaviour is to redirect back to start page. Further consideration required.
		if (!isPageInitialised) return Page.TransactionException;
		return null;
	}
	
    protected virtual Boolean loadStepSubmissionState(){    	
    	try {
    		submissionMgr = new SubmissionManager(submissionId); // default state loading invoked unless overridden by the step controller class.
    	} catch(Exception e){
    		return false;
    	}    	
    	return true;
    }
    
    protected Boolean validatePageState(){    	
    	initialise();
    	return ( isPageAuthenticated && isPageInitialised );    	
    }
    	
	// Navigation methods.
	public PageReference nextStep(){
		return transactionMgr==null ? null : transactionMgr.nextStep(submissionId);
	}
	
	public PageReference previousStep(){
		return transactionMgr==null ? null : transactionMgr.previousStep(submissionId);
	}
	// End navigation methods.    
}