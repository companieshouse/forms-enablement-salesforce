/**
 * Controller for the transaction review page on which the user arrives after signing
 * the PDF on Docusign. Presents the user with an inline rendering of the PDF and a submit
 * button that takes them to the payment page at SmartPay.
 * 
 * Author: eliot.stock@methods.co.uk
 */
public class ReviewController {
    
    public Transaction__c tx {get; private set;}
    public Id attachmentId {get; private set;}
    public String title {get; private set;}

    public String size {get; private set;}
    
    public ReviewController() {
        init();
    }
    
    public void init() {
        String txId = ApexPages.currentPage().getParameters().get('txid'); //ad change from tid to txid
        
        if (txId == null || txId.length() == 0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
					'No transaction ID on query string.'));
            return;
        }
        
        // Binary fields cannot be selected in join queries, so we need two queries here.
        try {
    	    tx = [SELECT Id, (SELECT Id,BodyLength, Name FROM Attachments) FROM Transaction__c WHERE Id = :txId];
    	}
        catch (QueryException qe) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
					'No such transaction:' + txId));
            return;
        }
        
        if (tx.attachments.size() != 1) {
            // This should never happen.
     //       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
					//'Transaction should have one and only one attachment. This one ('
					//+ txId + ') has ' + tx.attachments.size()));
            return;
        }
        
        title = tx.attachments[0].Name; 
        Integer sizeInt = tx.attachments[0].BodyLength;
        String tempSize = String.valueOf(sizeInt);
        size = tempSize.left(3);
        //MB
        if(tempSize.length() >= 9)
        {   
            size += 'M';
        }
        //KB
        else if(tempSize.length() >= 6 && tempSize.length() < 9)
        {   
            size += 'K';
        } 
    	attachmentId = tx.attachments[0].Id;
        return;
    }
    
    public PageReference submit() {
		// Let the PaymentController figure out how to do the redirect to SmartPay.
        PageReference pageReference = new PageReference('/apex/Payment?txId=' + tx.Id); // ab added tx Id
        return pageReference;
    }
    
    public PageReference startOver() {
        // Go back to the start of the process.
        // TODO: When we have a "Start here" page in Salesforce, go there instead of the start of the flow.
        PageReference pageReference = new PageReference('/apex/Form_DS0Page0');
        return pageReference;
    }

}