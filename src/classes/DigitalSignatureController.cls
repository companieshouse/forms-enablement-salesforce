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
	public List<wrapperDirector> listOfDirectors {get; set;}
	public String emailPresenter {get; set;}
	public Boolean successSigning {get; set;}
	public Boolean failureSigning {get; set;}
	public Boolean skipPage {get; set;}
    public Boolean presenterSigning {get; set;}
    public Boolean multipleDirectors {get; set;}
    public String pageTitle {get; set;}
    public String pageTitle2 {get; set;}
    public String pageTitle3 {get; set;}
    public String pageBody {get; set;}
    public String pageBody2 {get; set;}
    public String pageBodySuccess {get; set;}
    public String pageBodyFailure {get; set;}

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
        multipleDirectors = false;
		compName = submissionMgr.submission.CompanyName__c;
		Integer i = 0;
		listOfDirectors = new List<wrapperDirector>();

        pageTitle = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        pageTitle2 = (transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c);
        pageTitle3 = (transactionMgr.currentStep.Header_Text_3__c == null ? '' : transactionMgr.currentStep.Header_Text_3__c);
        pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        pageBody = pageBody.replace('COMPANYNAME', compName);
        pageBody2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        pageBodySuccess = transactionMgr.currentStep.Display_Text_5__c == null ? '' : transactionMgr.currentStep.Display_Text_5__c;
        pageBodyFailure = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;

        pageTitle = pageTitle.replace('Director', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        pageBody = pageBody.replace('director', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));

        pageBodySuccess = pageBodySuccess.replace('director(s)', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        pageBodyFailure = pageBodyFailure.replace('director(s)', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
		for(Contact off: submissionMgr.submission.Contacts__r)
		{
			if(off.isSignatory__c)
            {
                i++;
				listOfDirectors.add(new wrapperDirector(off.Name, off.Email));
            }
            if(off.IsPresenter__c)
            {
                presenterSigning = true;
            }
		}

		emailPresenter = submissionMgr.submission.Presenter__r.PersonEmail;
    }

    public PageReference initSignature(){
        initialiseAction();

        if (!ApexPages.currentPage().getParameters().containsKey('c') || 
            String.isBlank(ApexPages.currentPage().getParameters().get('c'))) return null;

        String paramInput = ApexPages.currentPage().getParameters().get('c');

        if(paramInput.contains(' '))
        {
            paramInput = paramInput.replace(' ', '+');

            ApexPages.currentPage().getParameters().put('c',paramInput);

            ApexPages.currentPage().setRedirect(true);

            return ApexPages.currentPage();
        }

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



            //Send to docusign as no presenter don t load the external embed page
            if(!submissionMgr.submission.isSigningStarted__c)
            {
                ExternalEmbedDocuSignController.docusignSignature(submissionMgr, transactionMgr);
                persistStep();
            }
    		pendingPage = true;
            
    		return null;
    	}

    	

        return nextAction();    
        
    }

    public PageReference restartPresenterSigning()
    {
        if(submissionMgr.submission.isSigningStarted__c && presenterSigning && submissionMgr.submission.Status__c != AppConstants.REQUEST_STATUS_SIGNED)
        {
            PageReference pg = new PageReference('/ExternalEmbedDocuSign');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id+AppConstants.ID_DELIM_CHAR+transactionMgr.currentStep.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);

            return pg;
        }

        return null;
    }
    
    private void persistStep(){
    	
    	if(!pendingPage && !successSigning && !failureSigning && !skipPage)
    	{
    		submissionMgr.submission.isSigningStarted__c = true;
    		submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_PENDING_SIGNATURES;
            if(!presenterSigning)
            {
                submissionMgr.submission.MultipleDirectors__c = true;
            }
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

    public with sharing class wrapperDirector{
        public String name {get; set;}
        public String email {get; set;}

        public wrapperDirector(String name, String email)
        {
            this.name = name;
            this.email = email;
        }
    }
    // End Action methods.
}