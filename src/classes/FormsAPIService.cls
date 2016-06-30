/*
Name:  FormsAPIService.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Rest webservice to be called from FormsAPI
This service allows to receive approvals or rejections
from CHIPS per form (barcode)

======================================================
======================================================
History
------- 
Ver. Author         Date        Detail
1.0  Antonio Bravo  2016-01-02  Initial development.
*/

@RestResource(urlMapping='/FormsAPIService/*')
global with sharing class FormsAPIService {
    private static final String CHIPS_APPROVED = AppConstants.CHIPS_APPROVED;
    private static final String CHIPS_REJECTED = AppConstants.CHIPS_REJECTED;

    private static final String TRANSACTION_NOT_FOUND = 'Salesforce Internal error: No transaction record found with this barcode.';
    private static final String UNKNOWN_STATUS = 'Salesforce Internal error: Unknown Status. Use 0 for approved or 1 for rejeted.';

    // Webservice inputs
    //global String barcode;
    //global String submissionReference;
    //global String status;
    //global List<Reason> rejectReasons;

    global class Reason {
        global String description;
        global String id;
        global String textEnglish;
        global String textWelsh;
        global String order;
    }

    global class StatusReply {
        global String status;
        global String errorMessage;
    }


    @HttpPatch
    global static StatusReply updateTransaction(String barcode, String submissionReference, String status, List<Reason> rejectReasons) {
        Transaction__c tx;

        try{
            List<Transaction__c> txList = [Select Id, Barcode__c, Status__c, ErrorDescription__c from Transaction__c where Barcode__c = :barcode];
            
            //Check if Transaction found
            if(txList.isEmpty())
                return getStatus(AppConstants.ERROR_STATUS, TRANSACTION_NOT_FOUND);
            else
                tx = txList[0];



            //return getStatus(AppConstants.ERROR_STATUS, string.valueOf(tx));
            //CHIPS Approved
            if(status == CHIPS_APPROVED) {
               tx.Status__c = AppConstants.REQUEST_STATUS_APPROVED;
            
            //CHIPS Rejected
            } else if(status == CHIPS_REJECTED) {
                tx.ErrorDescription__c = '';

                tx.Status__c = AppConstants.REQUEST_STATUS_REJECTED;
                
                for(Reason r : rejectReasons){
                    tx.ErrorDescription__c += r.textEnglish;
                }

            //Unknown status
            } else {
                return getStatus(AppConstants.ERROR_STATUS, UNKNOWN_STATUS );
            }

            update tx;
            return getStatus(AppConstants.SUCCESS_STATUS, '');

        }catch(Exception e){
            return getStatus(AppConstants.ERROR_STATUS, e.getMessage());
        }
    }


    public static StatusReply getStatus(String status, String errorMessage){
        StatusReply s = new StatusReply();
        s.status = status;
        s.errorMessage = errorMessage;
        return s;
    }    

}