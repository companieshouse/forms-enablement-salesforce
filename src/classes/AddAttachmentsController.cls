/*
Name:  AddAttachments.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: AddAttachment

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy&    2016-06-07  Initial development.
note: attachment size limited to 5MB
*/
public class AddAttachmentsController extends TransactionStepControllerBase {

    // error properties.
    public Boolean hasPageErrors {
        get;
        set;
    }

    // Private class members.
    Boolean isPageInitialised = false;
    Boolean isUserAuthenticated = false;
    SecurityManager securityMgr;
    SubmissionManager submissionMgr;
    TransactionManager transactionMgr;
    String transactionType;
    public Attachment attachment {
        get {
            if (attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }


    // page variables
    public String companyName {
        get;
        set;
    }
    public String companyNumber {
        get;
        set;
    }
    public String presenterEmail {
        get;
        set;
    }
    public String presenterName {
        get;
        set;
    }
    public String presenterPhone {
        get;
        set;
    }

  

    // Constructors.
    public AddAttachmentsController() {

            super();
            if (isPageInitialised) initialiseStep();
        }
        // End Constructors. 

    // Instance methods.
    private void initialiseStep() {
        securityMgr = new SecurityManager();
        submissionMgr = new SubmissionManager();

        //page information

        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.Name;
        presenterName = submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c;
        // attachment list - may loop through attachments on page to show previously upload if user research calls for it
        attachment = submissionMgr.submission.Attachments;
        try {

            // todo - check for valid user auth cookie.	
            isUserAuthenticated = true;

            if (!ApexPages.currentPage().getParameters().containsKey('t') ||
                String.isBlank(ApexPages.currentPage().getParameters().get('t')) ||
                !TransactionManager.isValidTransactionType(ApexPages.currentPage().getParameters().get('t'))) return;

            transactionType = ApexPages.currentPage().getParameters().get('t');
            transactionMgr = new TransactionManager(transactionType);

            isPageInitialised = true;
        } catch (Exception e) {
            return;
        }
        return;
    }

    public PageReference upload() {
    
        try {
            insert attachment;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error uploading attachment'));
            return null;
        } finally {
            attachment = new Attachment();
        }

        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Attachment uploaded successfully'));
        return null;
    }



    private void persistStep() {
        submissionMgr.persist();
    }


    public PageReference nextAction() {

        if (!validatePageState()) return Page.TransactionException;

        persistStep();

        return nextStep();
    }

    public PageReference previousAction() {

            if (!validatePageState()) return Page.TransactionException;

            return previousStep();
        }
        // End Instance methods.
}