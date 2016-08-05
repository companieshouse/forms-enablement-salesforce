/*
Name:  SigningController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: SigningController

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-06  Initial development.
*/
public with sharing class SigningController extends TransactionStepControllerBase {
    public String companyName {
        get;
        set;
    }
    public String companyNumber {
        get;
        set;
    }
    public String signingOptions {
        get;
        set;
    }
    public Boolean signingchoice {
        get;
        set;
    }
    public String whoAuthorised {
        get;
        set;
    }
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String currentErrorMessage {
        get;
        set;
    }
    public String displayText {
        get;
        set;
    }
    public String displayText2 {
        get;
        set;
    }
    public String displayText3 {
        get;
        set;
    }
    public String displayText4 {
        get;
        set;
    }
    public String displayText5 {
        get;
        set;
    }
    public String displayText6 {
        get;
        set;
    }
    public String headerText1 {
        get;
        set;
    }
    public String headerText2 {
        get;
        set;
    }
    public String headerText3 {
        get;
        set;
    }
    public String continueButtonText {
        get;
        set;
    }
    public Boolean standardView {
        get;
        set;
    }
    public Boolean customView {
        get;
        set;
    }
    public String signingError {get; set;}
    public SigningController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void initialiseStep() {
        standardView = transactionMgr.currentStep.StandardView__c;
        customView = transactionMgr.currentStep.CustomView__c;
        displayText = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        displayText4 = transactionMgr.currentStep.Display_Text_4__c;
        displayText5 = transactionMgr.currentStep.Display_Text_5__c;
        displayText6 = transactionMgr.currentStep.Display_Text_6__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        headerText2 = transactionMgr.currentStep.Header_Text_2__c;
        headerText3 = transactionMgr.currentStep.Header_Text_3__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
    }
    public void buildDocument() {

        Attachment pdfAttachment = new Attachment();
        Blob pdfBlob;
        PageReference pageRef = new PageReference('/apex/' + submissionMgr.submission.Form_Name__c);
        pageRef.getParameters().put('id', submissionMgr.submission.Id);
        if (Test.IsRunningTest())
            pdfBlob = Blob.valueOf('This is a test');
        else
            pdfBlob = pageRef.getContent();
        pdfAttachment.ParentId = submissionMgr.submission.Id;
        pdfAttachment.Name = submissionMgr.submission.Form_Name__c;
        pdfAttachment.Description = submissionMgr.submission.Form_Name__c;
        pdfAttachment.Body = pdfBlob;

        try {
            insert pdfAttachment;
        } catch (DmlException e) {
            System.debug('DML Error in inserting' + submissionMgr.submission.Form_Name__c + 'Error Details are' + ' ' + e.getMessage() );
        } catch (Exception e) {
            System.debug('General Error in inserting' + submissionMgr.submission.Form_Name__c + 'Error Details are' + ' ' + e.getMessage() );
        }
    }

    private void persistStep() {
        if (signingchoice) {
            submissionMgr.submission.Status__c = 'Signed';
        }
        submissionMgr.persist();
    }
    public void setAuthorizerValue() {

        if (signingchoice != null) {
            if (signingchoice == true) {
                buildDocument();
                system.Debug('building Document');
            } else if (signingchoice == false) {
                List<Attachment> attachmenttoDelete = [select Id, Name from Attachment where ParentId = :submissionMgr.submission.Id];
                for (Attachment checkedAttachment : attachmenttoDelete) {
                    if (checkedAttachment.Name == submissionMgr.submission.Form_Name__c) {
                        try {delete checkedAttachment;} catch (DmlException e) {System.debug('DML Exception' + e.getMessage());} catch (Exception e) {System.debug('General Exception ' + e.getMessage());}
                    }
                }
            }
        }
    }
    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;
        if (signingchoice == null) {
            currentErrorMessage = 'You must select Yes to Proceed';
            hasPageErrors = true;
            signingError = 'error';
            return null;
        } else if (!signingchoice) {
            currentErrorMessage = 'You must select Yes to Proceed';
            hasPageErrors = true;
            signingError = 'error';
            return null;
        } else if (signingchoice) {
            currentErrorMessage = '';
            hasPageErrors = false;
        }

        FormAPISubmissionManager submissionMgrAPI = new FormAPISubmissionManager();
        submissionMgr.submission = submissionMgrAPI.sendForm(submissionMgr.submission);

        system.debug('Before save tx: ' + submissionMgr.submission);

        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
}