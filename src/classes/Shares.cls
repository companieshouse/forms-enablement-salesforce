/*
Name:  Shares.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Shares
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class Shares extends TransactionStepControllerBase {

    // Public properties.
    public String pageTitle {
        get;
        private set;
    }
    public String pageText {
        get;
        private set;
    }
    public List < DynamicField > dynamicFields {
        get;
        private set;
    }

    // Constructors.
    public Shares() {
            super();

            if (isPageInitialised) initialiseStep();
        }
        // End Constructors.

    // Instance methods.
    protected override Boolean loadStepSubmissionState() {
        // override the base class method to load step specific state.
        try {
            system.debug('load step this is the sobject type' + ' ' + transactionMgr.currentStep.SObject_Type__c);
            system.debug('load step this is the fieldset name' + ' ' + transactionMgr.currentStep.Query_FieldSet_1_Name__c);

            if (transactionMgr.currentStep.SObject_Type__c != null && transactionMgr.currentStep.Query_FieldSet_1_Name__c != null) {
                submissionMgr = new SubmissionManager(submissionId, transactionMgr.currentStep.SObject_Type__c, transactionMgr.currentStep.Query_FieldSet_1_Name__c);
            } else submissionMgr = new SubmissionManager(submissionId);

        } catch (Exception e) {
            system.debug('load step this is the error in the protected override' + ' ' + e);

            return false;
        }
        return true;
    }

    private void initialiseStep() {
        try {

            System.debug(LoggingLevel.ERROR, ' initialiseStep' + ' ' + submissionMgr.submission);
            pageTitle = transactionMgr.currentStep.Header_Text_1__c;
            pageText = transactionMgr.currentStep.Display_Text_1__c;

            System.debug(LoggingLevel.ERROR, ' initialiseStep' + ' ' + transactionMgr.currentStep.SObject_Type__c);
            System.debug(LoggingLevel.ERROR, ' initialiseStep' + ' ' + transactionMgr.currentStep.Query_FieldSet_1_Name__c);

            if (transactionMgr.currentStep.SObject_Type__c != null && transactionMgr.currentStep.Query_FieldSet_1_Name__c != null) {

                // enumerate field and instantiate DynamicField instances and add to collection	
                Schema.DescribeSObjectResult d = Schema.getGlobalDescribe().get(transactionMgr.currentStep.SObject_Type__c).getDescribe();
                //if (!d.isAccessible()) continue; //& todo add object access/fls security checks. 

                if (d.fieldSets.getMap().containsKey(transactionMgr.currentStep.Query_FieldSet_1_Name__c)) {
                    system.debug('this is the query key for the dynamic field set' + ' ' + transactionMgr.currentStep.Query_FieldSet_1_Name__c);

                    dynamicFields = new List < DynamicField > ();
                    system.debug('this is the dynamic field set' + ' ' + dynamicFields);
                    Schema.FieldSet fs = d.fieldSets.getMap().get(transactionMgr.currentStep.Query_FieldSet_1_Name__c);

                    System.debug(LoggingLevel.ERROR, 'FieldSet Found:' + fs);
                   // system.debug('this is the schema' + ' ' + Schema);

                    System.debug('this is the field set member' + ' ' + fs.getFields());

                    for (Schema.FieldSetMember f: fs.getFields()) {
                        // todo - pass field values of non-string types.
                        dynamicFields.add(new DynamicField(f.getFieldPath(), f.getLabel(), String.valueOf(submissionMgr.submissionShares.get(f.getFieldPath())), f.getType()));
                        system.debug('this is the dynamic field set part 2' + ' ' + dynamicFields);

                    }


                    System.debug(LoggingLevel.ERROR, 'this is the dynamic field set 2' + ' ' + 'dynamicFields:' + dynamicFields);
                }
            }

        } catch (Exception e) {
            return;
        }
        return;
    }

    private void persistStep() {
            try {
                for (DynamicField f: dynamicFields) {
                    System.debug(LoggingLevel.ERROR, 'dynamicFields f:' + f);

                    if (f.displayType == Schema.Displaytype.String ||
                        f.displayType == Schema.Displaytype.PickList ||
                        f.displayType == Schema.Displaytype.Email ||
                        f.displayType == Schema.Displaytype.URL ||
                        f.displayType == Schema.Displaytype.Phone ||
                        f.displayType == Schema.Displaytype.TextArea) {

                        submissionMgr.submission.put(f.fieldName, (String) f.fieldValue);

                    } else if (f.displayType == Schema.Displaytype.Currency ||
                        f.displayType == Schema.Displaytype.Double ||
                        f.displayType == Schema.Displaytype.Integer ||
                        f.displayType == Schema.Displaytype.Percent) {

                        submissionMgr.submission.put(f.fieldName, Decimal.valueOf(f.fieldValue));

                    } else if (f.displayType == Schema.Displaytype.Boolean) {
                        submissionMgr.submission.put(f.fieldName, Boolean.valueOf(f.fieldValue));

                    } else if (f.displayType == Schema.Displaytype.Datetime) {
                        submissionMgr.submission.put(f.fieldName, Datetime.valueOf(f.fieldValue));

                    } else if (f.displayType == Schema.Displaytype.Date) {
                        submissionMgr.submission.put(f.fieldName, Date.valueOf(f.fieldValue));

                    }
                }
                submissionMgr.persist();
            } catch (Exception e) {
                System.debug(LoggingLevel.ERROR, e.getMessage() + ' ' + e.getStackTraceString());
            }
        }
        // End Instance methods.

    // Action methods.           
    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;

        persistStep();
        return nextStep();
    }

    public PageReference previousAction() {
            if (!validatePageState()) return Page.TransactionException;

            return previousStep();
        }
        // End Action methods.    
}