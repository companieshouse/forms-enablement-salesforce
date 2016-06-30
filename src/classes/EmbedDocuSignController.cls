/*
Name:  EmbedDocuSignController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: EmbedDocuSign

======================================================
======================================================
History
------- 
Ver. Author            Date        Detail
1.0  Antonio Bravo     2016-02-04  Initial development.
LB updated multiple directors flag for review status integration
*/
public with sharing class EmbedDocuSignController extends TransactionStepControllerBase {
    
    // Public properties.
    public Boolean hasPageErrors { get; set; }
    public String externalURL {get; set;}
    public Boolean showButtons {get; set;}
    public Boolean requestedSignatures {get; set;}
    public Boolean declined {get; set;}

    public String pageTitle { get; private set; }
    public String pageText  { get; private set; }  
    public String pageText2  { get; private set; }  
    public String companyName { get; private set; }
    public String presenterEmail { get; private set; }
    public Boolean noEmbedDoc {get; set;}

    public List<Officer__c> offResquestedToSign { get; private set; } 
    
    
    // Constructors.
    public EmbedDocuSignController(){
        super();
        
        if (isPageInitialised) 
            initialiseStep();
    }
    // End Constructors.
    
    // Instance methods.
    private void initialiseStep(){
        try {

            System.debug(LoggingLevel.ERROR, submissionMgr.submission); 
            pageTitle = transactionMgr.currentStep.Header_Text_1__c;
            pageText = transactionMgr.currentStep.Display_Text_1__c;
            pageText2 = transactionMgr.currentStep.Display_Text_2__c;

            companyName = submissionMgr.submission.CompanyName__c;
            presenterEmail = submissionMgr.submission.Presenter__r.Name;

       
        } catch (Exception e){ return; }        
        return;
    }
    // End Instance methods.

    public PageReference actionFunction(){
        initialiseAction();


        // Transaction context.
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
        

        // Transaction context
        // Check if transaction is returned from DocuSign with event signing complete
        // Or it is signed
        // Else create a new envelope 
        System.debug(LoggingLevel.ERROR, 'Get getParameters: ' + ApexPages.currentPage().getParameters().get('event'));    
        // If returning from signing and is complete
        if (ApexPages.currentPage().getParameters().containsKey('event') && 
                    !String.isBlank(ApexPages.currentPage().getParameters().get('event'))
                    && ApexPages.currentPage().getParameters().get('event')=='OnSigningComplete') {
            
            if(submissionMgr.submission.Officers__r.size() > 1) { //there are more officers
                requestedSignatures = true;
                offResquestedToSign = submissionMgr.submission.Officers__r;
                //tx.MultipleDirectors__c = true; // if there are more officers flag = true
                //update tx; // flag set to true even if presenter is not director.
                return null;
            } else { // There is only the presenter as officer
                submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_SIGNED;
                persistStep();
                return nextAction();
            }
            
        // Transaction has been declined
        } else if (submissionMgr.submission.Status__c == AppConstants.DOCUSIGN_STATUS_DECLINED_SIG){
            declined = true;
            return null;
        
        // Transaction is signed
        } else if(isPageAlreadyValidStep) {
            showButtons=true;
           noEmbedDoc = true;
            return null;

        // Transaction is pending signatures    
        } else if (submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_PENDING_SIGNATURES) {
            requestedSignatures = true;
            noEmbedDoc = true;
            offResquestedToSign = submissionMgr.submission.Officers__r;
            return null;
         
        // Else create a new envelope
        } else {

            SendToDocuSign sendToDS = new SendToDocuSign();
            externalURL = sendToDS.embedDocuSignOpen(submissionMgr.submission);

            submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_PENDING_SIGNATURES;
            submissionMgr.submission.Expiry_Date_Length__c = transactionMgr.td.Expiry_Date_Length__c; // set the expiry date
            offResquestedToSign = submissionMgr.submission.Officers__r;

            //there are more than one officer
            if(submissionMgr.submission.Officers__r.size() > 1) {
                submissionMgr.submission.MultipleDirectors__c = true; 
            }

            //presenter is not a director
            if(externalURL == null){
                requestedSignatures = true;
                
                // need to have this flag to notify the presenter that signature is completed
                // when is a Sole Directer
                // to do: update field name to emailSignaturesRequested
                submissionMgr.submission.MultipleDirectors__c = true; 
            }

            //else sole Director as presenter
            //continue

            persistStep(); 
            
            return null;

        }        
    }

    private void persistStep(){
        submissionMgr.persist();    
    }

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