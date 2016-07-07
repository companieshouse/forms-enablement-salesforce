/*
Name:  DigitalSignatureController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: DigitalSignature

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-07-04  Initial development.
*/
public class DigitalSignatureController extends TransactionStepControllerBase{

	public Boolean pendingPage {get; set;}
	public String compName {get; set;}
	public List<String> listOfDirectors {get; set;}
	public String emailPresenter {get; set;}
	public Boolean successSigning {get; set;}
	public Boolean failureSigning {get; set;}
	public Boolean skipPage {get; set;}
    public Boolean presenterSigning {get; set;}

	public DigitalSignatureController(){
		super();

		initialiseStep();
	}

	public void initialiseStep() {
		pendingPage = false;
		successSigning = false;
		failureSigning = false;
		skipPage = false;
        presenterSigning = false;
		compName = submissionMgr.submission.CompanyName__c;
		
		listOfDirectors = new List<String>();
		for(Officer__c off: submissionMgr.submission.Officers__r)
		{
			if(off.isSignatory__c)
				listOfDirectors.add(off.Name);
            if(off.IsPresenter__c)
            {
                presenterSigning = true;
            }
		}

		emailPresenter = submissionMgr.submission.Presenter__r.Name;
    }

    public PageReference initSignature(){
        initialiseAction();

        if(!submissionMgr.submission.isDigitalSignatureNeeded__c )
        {
        	skipPage = true;
        	return nextAction();
        }
    	
    	if(submissionMgr.submission.isSigningStarted__c || !presenterSigning)
    	{
    		//Determine if it has been declined or not
			if(submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_SIGNED)
			{
				successSigning = true;
				return null;
			}
			else if(submissionMgr.submission.Status__c == AppConstants.DOCUSIGN_STATUS_REJECTED)
			{
				failureSigning = true;
				return null;
			}
    		pendingPage = true;
    		return null;
    	}

    	

        return nextAction();    
        
    }
    
    private void persistStep(){
    	
    	if(!pendingPage && !successSigning && !failureSigning && !skipPage)
    	{
    		submissionMgr.submission.isSigningStarted__c = true;
    		submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_PENDING_SIGNATURES;
    	}

    	if(successSigning || failureSigning)
    	{
    		submissionMgr.submission.isSigningFinished__c = true;
    	}
    	
    	if(listOfDirectors.size() > 1)
    	{
    		submissionMgr.submission.MultipleDirectors__c = true;
    	}

        submissionMgr.persist();    
    }
    // End Instance methods.    

    // Action methods.     
    public PageReference nextAction(){ 
        if (!validatePageState()) return Page.TransactionException;

        persistStep(); 

        if(!pendingPage && !successSigning && !failureSigning && !skipPage && presenterSigning)
        {
        	PageReference pg = new PageReference('/ExternalEmbedDocuSign');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id+AppConstants.ID_DELIM_CHAR+transactionMgr.currentStep.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);

            return pg;
        }

  		return nextStep();
        
    }
    
    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }
    // End Action methods.
}