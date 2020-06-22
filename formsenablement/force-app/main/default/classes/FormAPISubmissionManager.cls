/*
Name:  FormAPISubmissionManager.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------
Prepare and send forms to FormsAPI Client

To do:
-------
update sendForm to receive a package

======================================================
======================================================
History
------- 
Ver. Author            Date        Detail
1.0  Antonio Bravo     2016-04-29  Initial development.
*/
public class FormAPISubmissionManager {
    String output;
    
    public with sharing class Barcode {
        public string barcode;
    }

    //This methods logs API submittion call inside the Transaction
    public Transaction__c addIntegrationLog(String resultIntegration, Transaction__c currentTransaction )
    {

        String log = '<br/>-----------------------------------------------------------------------------------';
        log += '<br/> Integration Date Time: ' + System.now();
        log += '<br/> Transaction Id: ' + currentTransaction.Id;
        log += '<br/> Barcode: ' + currentTransaction.Barcode__c;
        log += '<br/> Company Number: ' + currentTransaction.CompanyNumber__c;
        log += '<br/> Doc Type: ' + currentTransaction.Transaction_Type__c;
        log += '<br/> Result Integration (Result of the call): ' + resultIntegration;
        log += '<br/>-----------------------------------------------------------------------------------';
        if(String.isBlank(currentTransaction.AmendmentHistory__c))
            currentTransaction.AmendmentHistory__c = log;
        else
            currentTransaction.AmendmentHistory__c += log;

        return currentTransaction;
    }

    public Transaction__c updatePayment(Transaction__c tx)
    {
        FormsApiClient client = new FormsApiClient();
        HTTPResponse response = client.updatePayment(tx); 

        output = response.getStatusCode() + ': ' + response.getStatus() + '\n\n' + response.getBody();

        if(response.getStatusCode() == 200){
            tx.Status__c = AppConstants.REQUEST_STATUS_SUBMITTED;
            tx.ErrorDescription__c = '';
            tx = addIntegrationLog('Update Payment Success', tx);
        } else {
            tx.Status__c = AppConstants.REQUEST_STATUS_ERROR;
            tx.ErrorDescription__c = (output.length() > 10000 ? output.substring(0, 9999) : output);
            tx = addIntegrationLog('Update Payment Failed<br/> Reason: ' + tx.ErrorDescription__c , tx);
        }

        return tx;
    }
    
    public Transaction__c sendForm(Transaction__c tx){
        // - This function will receive a Package with multiple transactions
        
        System.debug('FormAPISubmissionManager begin: ' + tx);
        System.debug('FormAPISubmissionManager begin barcode: ' + tx.Barcode__c);
        //Get Barcode
        if(tx.Barcode__c == null || tx.Barcode__c == ''){

            //try {
                FormsApiClient client = new FormsApiClient();
                HTTPResponse response = client.requestBarcode(tx);    
                output = response.getStatusCode() + ': ' + response.getStatus() + '\n\n' + response.getBody();
                
                if(response.getStatusCode() == 200) {
                    Barcode b = (Barcode)JSON.deserialize(response.getBody(), Barcode.class);

                    tx.Barcode__c =  b.barcode;
                    tx.ErrorDescription__c = '';

                    tx = addIntegrationLog('Barcode Success', tx);

                } else {
                    if(tx.Form_Name__c.contains('DS02'))
                    {
                        tx.Status__c = AppConstants.REQUEST_STATUS_ERROR;
                    }
                    else {
                        tx.PrePaymentIntegrationStatus__c = AppConstants.REQUEST_STATUS_ERROR;
                    }
                    tx.ErrorDescription__c = (output.length() > 10000 ? output.substring(0, 9999) : output) ;
                    tx = addIntegrationLog('Barcode failed.<br/> Reason: ' + tx.ErrorDescription__c , tx);
                }

           // }
            //catch (Exception e) {
            //    tx.Status__c = AppConstants.REQUEST_STATUS_ERROR;
            //    tx.ErrorDescription__c = e.getMessage();
            //}
        }

        //To do: One Transacation (Package in the future) can only be send if all Transactions contain a barcode
        if(tx.Barcode__c == null || tx.Barcode__c == ''){
            return tx;
        }

        System.debug('FormAPISubmissionManager before send: ' + tx);
        System.debug('FormAPISubmissionManager before send: ' + tx.Barcode__c);
        //Send form
        //try {
            FormsApiClient client = new FormsApiClient();
            HTTPResponse response = client.sendForm(tx);    
            output = response.getStatusCode() + ': ' + response.getStatus() + '\n\n' + response.getBody();

            
            if(response.getStatusCode() == 202){
                if(tx.Form_Name__c.contains('DS02'))
                {
                    tx.Status__c = AppConstants.REQUEST_STATUS_SUBMITTED;
                }
                else {
                    tx.PrePaymentIntegrationStatus__c = AppConstants.REQUEST_STATUS_SUBMITTED;
                }
                tx.ErrorDescription__c = '';
                tx = addIntegrationLog('SendForm Success', tx);
            } else {
                if(tx.Form_Name__c.contains('DS02'))
                {
                    tx.Status__c = AppConstants.REQUEST_STATUS_ERROR;
                }
                else {
                    tx.PrePaymentIntegrationStatus__c = AppConstants.REQUEST_STATUS_ERROR;
                }
                tx.Barcode__c = '';
                tx.ErrorDescription__c = (output.length() > 10000 ? output.substring(0, 9999) : output);
                tx = addIntegrationLog('SendForm Failed<br/> Reason: ' + tx.ErrorDescription__c , tx);
            }
                
        //}
        //catch (Exception e) {
        //    tx.Status__c = AppConstants.REQUEST_STATUS_ERROR;
        //    tx.ErrorDescription__c = e.getMessage();
            
        //}
        return tx;
    }
}