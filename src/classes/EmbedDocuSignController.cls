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
*/
public with sharing class EmbedDocuSignController extends TransactionStepControllerBase {
    
    // Public properties.
    public Boolean hasPageErrors { get; set; }
    public String externalURL {get; set;}
    public Boolean showButtons {get; set;}

    public String pageTitle { get; private set; }
    public String pageText  { get; private set; }  
    
    public String temp  { get; private set; } //debug

    private Transaction__c tx;   


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

            //Debug
            temp=ApexPages.currentPage().getParameters().get('event');
       
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

        tx = [Select Id, Name, CompanyName__c, Status__c,Form_Name__c,
                    (Select Id, Name, Email__c from Officers__r),
                    (Select Id, dsfs__DocuSign_Envelope_ID__c, dsfs__Envelope_Status__c from DocuSign_Status__r)
                from Transaction__c where id = :submissionId];
        

        // Transaction context
        // Check if transaction is returned from DocuSign with event signing complete
        // Or it is signed
        // Else create a new envelope 
        System.debug(LoggingLevel.ERROR, 'Get getParameters: ' + ApexPages.currentPage().getParameters().get('event'));    
        // If returning from signing and is complete
        if (ApexPages.currentPage().getParameters().containsKey('event') && 
                    !String.isBlank(ApexPages.currentPage().getParameters().get('event'))
                    && ApexPages.currentPage().getParameters().get('event')=='OnSigningComplete') {
            tx.Status__c = 'Signed';
            update tx;
            return nextAction();

        // Transaction is signed
        //} else if(isPageAlreadyValidStep) {
        } else if(tx.Status__c == 'Signed') {

            showButtons=true;
            return null;
        
        // Else create a new evelope
        } else {
        
            SendToDocuSign sendToDS = new SendToDocuSign();
            externalURL = sendToDS.embedDocuSignOpen(tx);
            return null;

        }        

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