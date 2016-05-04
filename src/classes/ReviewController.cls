/**
 * Controller for the transaction review page on which the user arrives after signing
 * the PDF on Docusign. Presents the user with an inline rendering of the PDF and a submit
 * button that takes them to the payment page at SmartPay.
 * 
 * Author: eliot.stock@methods.co.uk
 */
public class ReviewController extends TransactionStepControllerBase{
    
// Public properties.
    public Boolean hasPageErrors { get; set; }

    public String displayText1 {get; set;}
    public String displayText2 {get; set;}
    public String displayText3 {get; set;}
    

    public ReviewController() {
        super();
        if (isPageInitialised) initialiseStep();

    }
    
    public void initialiseStep() {
        displayText1 = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        return;
        
    }

    private void persistStep(){
        submissionMgr.persist();    
    }
    // End Instance methods.    
    
    // Action methods.     
    public PageReference nextAction(){ 
        if (!validatePageState()) return Page.TransactionException;
        
        persistStep();      

        return nextStep();      
    }
    
    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }
    // End Action methods.    
    
}