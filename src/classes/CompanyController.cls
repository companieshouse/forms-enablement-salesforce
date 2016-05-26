/*
Name:  CompanyController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Company

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-09  Initial development.
*/
public with sharing class CompanyController {
    
    // Public properties.
    public String companyNumber { get; set; }
    public Boolean hasPageErrors { get; set; }
    public String transactionType {get; set;}

    // Private class members.
    Boolean isPageInitialised=false;
    Boolean isUserAuthenticated=false;
    SecurityManager securityMgr;
    SubmissionManager submissionMgr;    
    TransactionManager transactionMgr;
    //String transactionType;
    TrackUserClass trackuser;
        
    // Constructors.
    public CompanyController(){
		trackuser = new TrackUserClass();
        trackuser.saveUserDocumentInfo();
        initialise();
    }
    // End Constructors. 
    
    // Instance methods.
    private void initialise(){
        securityMgr = new SecurityManager();        
        submissionMgr = new SubmissionManager();

        try {
            
            // todo - check for valid user auth cookie. 
            isUserAuthenticated=true;
        
            if (!ApexPages.currentPage().getParameters().containsKey('t') || 
                    String.isBlank(ApexPages.currentPage().getParameters().get('t')) ||
                    !TransactionManager.isValidTransactionType(ApexPages.currentPage().getParameters().get('t'))) return;
                
            transactionType = ApexPages.currentPage().getParameters().get('t');
            transactionMgr = new TransactionManager(transactionType);
                
            isPageInitialised=true;
        } catch (Exception e){ return; }        
        return;
    }
    
    private Boolean validateStep(){
        return !String.isBlank(companyNumber);
    }
    
    public PageReference initialiseAction(){
        if (!isUserAuthenticated) return Page.StartFramework;
        if (!isPageInitialised) return Page.TransactionException;
        return null;
    }
        
    public PageReference nextAction(){
        
        hasPageErrors=!validateStep();
        if (hasPageErrors) return null;
        trackuser = new TrackUserClass();
        // todo - the code below forces reauthentication.
        // todo - code should check for non-expired User_Authorisation__c record (record Id stored in user_auth cookie).
        // todo - reinstate company authentication
        
        
        //Merged From Leo 03 May 2016
        trackuser.getSearchedCompany(companyNumber);
        return securityMgr.getCompanyAuthRedirect(companyNumber,transactionType);
        //Id submissionId = submissionMgr.initialise( transactionType, '0014E000003oEPN', '0014E000003oEPI',transactionMgr.td.Fee__c );                         
        //return transactionMgr==null ? null : transactionMgr.firstStep(submissionId);
    }
    
    public PageReference previousAction(){  
		trackuser = new TrackUserClass();
       	trackuser.saveUserDocumentInfo(); 
        if(transactionMgr.td.hasGuidancePage__c)
        {
            return new PageReference('/Guidance?t=' + transactionType);
        }

        return new PageReference('/?t='+transactionType);
    }
    // End Instance methods.

}