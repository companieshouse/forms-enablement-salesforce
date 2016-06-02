/**
 * Base per application URL
 *
 * Author: leo.bitoy@methods.digital.co.uk
 * 
 *  This trigger handler builds the base url for all environments
 *
 *
 *
 **/
public with sharing class BaseURLHandler {


    private static Environment_Variables__c getSettings() {

        for (Environment_Variables__c s: Environment_Variables__c.getAll().values()) {
            return s;
        }

        System.debug(LoggingLevel.ERROR, 'No active Environment Variables in Custom Settings' + 'Can\'t build the system Host URL.');

        return null;
    }

    public BaseURLHandler() {

    }


    public static void beforeUpdate(List < Transaction__c > transactionsList) {

        for (Transaction__c transactionupdater: transactionsList) {
            // list of transactions to update at the end
            if (transactionupdater.ApplicationBaseURL__c == null) {
                Environment_Variables__c settings = getSettings();

                // parameters needed for C value
                String baseURL = settings.Host_Address__c;
                String parametername = baseURL;

                parametername += '/start?t=';

                parametername += transactionupdater.Form_Name__c;

                PageReference basereference = new PageReference(parametername);

                System.debug('your base url is' + basereference);

                transactionupdater.ApplicationBaseURL__c = parametername;
            }
        }


    }
}