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

    public class Barcode {
        public string barcode;
    }


    public Transaction__c sendForm(Transaction__c tx) {
        // - This function will receive a Package with multiple transactions

        System.debug('FormAPISubmissionManager begin: ' + tx);
        System.debug('FormAPISubmissionManager begin barcode: ' + tx.Barcode__c);
        //Get Barcode
        if (tx.Barcode__c == null || tx.Barcode__c == '') {

            //try {
            FormsApiClient client = new FormsApiClient();
            HTTPResponse response = client.requestBarcode();
            output = response.getStatusCode() + ': ' + response.getStatus() + '\n\n' + response.getBody();

            if (response.getStatusCode() == 200) {
                Barcode b = (Barcode)JSON.deserialize(response.getBody(), Barcode.class);

                tx.Barcode__c =  b.barcode;
                tx.ErrorDescription__c = '';

            } else {
                tx.Status__c = AppConstants.REQUEST_STATUS_ERROR;
                tx.ErrorDescription__c = output;
            }

            // }
            //catch (Exception e) {
            //    tx.Status__c = AppConstants.REQUEST_STATUS_ERROR;
            //    tx.ErrorDescription__c = e.getMessage();
            //}
        }

        //To do: One Transacation (Package in the future) can only be send if all Transactions contain a barcode
        if (tx.Barcode__c == null || tx.Barcode__c == '') {
            return tx;
        }

        System.debug('FormAPISubmissionManager before send: ' + tx);
        System.debug('FormAPISubmissionManager before send: ' + tx.Barcode__c);
        //Send form
        //try {
        FormsApiClient client = new FormsApiClient();
        HTTPResponse response = client.sendForm(tx);
        output = response.getStatusCode() + ': ' + response.getStatus() + '\n\n' + response.getBody();


        if (response.getStatusCode() == 202) {
            tx.Status__c = AppConstants.REQUEST_STATUS_SUBMITTED;
            tx.ErrorDescription__c = '';
        } else {
            tx.Status__c = AppConstants.REQUEST_STATUS_ERROR;
            tx.ErrorDescription__c = output;
        }

        //}
        //catch (Exception e) {
        //    tx.Status__c = AppConstants.REQUEST_STATUS_ERROR;
        //    tx.ErrorDescription__c = e.getMessage();

        //}
        return tx;
    }
}