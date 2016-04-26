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
    public String pageTitle { get; private set; }
    public String pageText  { get; private set; }  
    public String tokenURL  { get; private set; }
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

        tx = [Select Id, Name, CompanyName__c, Status__c,
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
            
            return nextAction();

        // Transaction is signed
        } else if(tx.Status__c == 'Signed') {

            return nextAction();
        
        // Else create a new evelope
        } else {
        
            SendToDocuSign sendToDS = new SendToDocuSign();
            tokenURL = sendToDS.embedDocuSignOpen(tx);
            //PageReference pr = new PageReference('/EmbedDocuSign');
            //pr.getParameters().putAll(friendlyUrl.getParameters());
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