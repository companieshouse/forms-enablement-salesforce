/**
 * Useful for kicking off method calls from the UI.
 * 
 * Author: eliot.stock@methodsdigitial.co.uk
 *
 * Update 11/04/2016 
 * Author: antonio.bravo@gollico.co.uk 
 */
public class DeveloperToolsController {
    
    public String output { get; private set; }
    public String transactionId {get {
        if(transactionId == null)
            transactionId = 'a024E0000014Dqs';
        return transactionId;
        } set;}
    public String barcodeRef {get;set;}
    
    public DeveloperToolsController() {
        output = '';
    }

    public class Barcode {
        public string barcode;
    }   
    
    public PageReference doSendForm() {
        //To do: 
        // This function will receive a Package with multiple transactions
        List<Transaction__c> txList = new List<Transaction__c>();
        
        //Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
        Transaction__c tx = [Select Id, Status__c, Barcode__c, Form_Name__c, 
                                Version_Form__c, SubmissionID__c, CompanyName__c,
                                CompanyNumber__c from Transaction__c where Id = :transactionId]; 
        
        // Add transaction
        txList.add(tx); 

        //Send form
        try {
            FormsApiClient client = new FormsApiClient();
            HTTPResponse response = client.sendForm(txList);    
            output = response.getStatusCode() + ': ' + response.getStatus() + '\n\n' + response.getBody();

            for(Transaction__c txTemp : txList){
                if(response.getStatusCode() == 202)
                    txTemp.Status__c = 'Submitted';
                else
                    txTemp.Status__c = 'Error';
                
            }
            update txList;
        }
        catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return null;
        }
        
        
        return null;
    }

    public PageReference requestBarcode() {
        
        //Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
        Transaction__c tx = [Select Id, Status__c, Barcode__c, Form_Name__c, 
                                Version_Form__c, SubmissionID__c, CompanyName__c,
                                CompanyNumber__c from Transaction__c where Id = :transactionId];

        //Get Barcode
        try {
            FormsApiClient client = new FormsApiClient();
            HTTPResponse response = client.requestBarcode();    
            output = response.getStatusCode() + ': ' + response.getStatus() + '\n\n' + response.getBody();
            
            Barcode b = (Barcode)JSON.deserialize(response.getBody(), Barcode.class);
            barcodeRef = b.barcode;

            tx.Barcode__c =  b.barcode;
            update tx;
        }
        catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return null;
        }
        
        
        return null;
    }

}