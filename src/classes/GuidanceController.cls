/*
Name:  GuidanceController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:


Controller which is link to the guidance page 
======================================================
======================================================
History

Ver. Author        		Date        Detail
1.0  Sylvain Picory     2016-05-28  Initial development.
*/
public with sharing class GuidanceController extends TransactionStepControllerBase{

	public TrackUserClass userTracker;


	//Generic text from the metadata
	//
	public String displayText0 {get; set;}
	
	public String checkboxText0 {get; set;}

	//Checkbox in the page
	//
	public Boolean warningAgreeBox {get; set;}

	//Constructor of the controller
	public GuidanceController() {
        super();
        if (isPageInitialised) initialiseStep();

    }
    
    public void initialiseStep() {
    	warningAgreeBox = false;
    	displayText0 = '';
    	displayText0 += transactionMgr.currentStep.Header_Text_1__c;
    	displayText0 += transactionMgr.currentStep.Display_Text_1__c;
    	displayText0 += transactionMgr.currentStep.Display_Text_2__c;
    	displayText0 += transactionMgr.currentStep.Display_Text_3__c;
    	displayText0 += transactionMgr.currentStep.Display_Text_4__c;
    	displayText0 += transactionMgr.currentStep.Display_Text_5__c;

    	if(String.isEmpty(displayText0))
    		displayText0 = null;

    	checkboxText0 = transactionMgr.currentStep.Display_Text_6__c;

        return;
    }

    public void loadStep(){
    	initialiseAction();

    }

    public void updateBox(){
    	if(warningAgreeBox == true)
    		warningAgreeBox = false;
    	else
    		warningAgreeBox = true;
    	return;
    }

    private void persistStep(){
    	submissionMgr.submission.Warning_Confirmation_Flag__c = warningAgreeBox;
        submissionMgr.persist();    
    }
    // End Instance methods.    
    
    // Action methods.     
    public PageReference nextAction(){ 
        if (!validatePageState()) return Page.TransactionException;
        
        persistStep();  

        //return nextStep();    

        //We don't redirect to the next step but to the auth
        userTracker = new TrackUserClass();

        // todo - the code below forces reauthentication.
        // todo - code should check for non-expired User_Authorisation__c record (record Id stored in user_auth cookie).        
		userTracker.saveUserDocumentInfo();
        //userTracker.getUserDocument();

       
        // todo - reinstate user authentication by returning the pagereference below instead of logging it out.
        return securityMgr.getUserAuthRedirect();
              
    }
    
    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }
    // End Action methods.    
    
}