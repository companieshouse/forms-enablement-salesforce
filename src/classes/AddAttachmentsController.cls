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
    public String companyName {
        get;
        set;
    }
    public String currentErrorMessage {
        get;
        set;
    }
    public Boolean hasPageErrors {
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
    public String attachmentDescription {
        get;
        set;
    }
    public Id attachmentId {
        get;
        set;
    }
    public String attachmentName {
        get;
        set;
    }
    public Id attachmenttoDeleteId {
        get;
        set;
    }
    public Id deleteattachmentId {
        get;
        set;
    }
    public Boolean showRemoveButtonLink {
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
    public String docStatus2 {
        get;
        set;
    }
    public String docStatus1 {
        get;
        set;
    }
    public String previousButtonText {
        get;
        set;
    }
    transient public Blob file1 {
        get;
        set;
    }
    transient public Blob file2 {
        get;
        set;
    }
    public String title {
        get;
        set;
    }
    public String information {
        get;
        set;
    }
    public String docName {
        get;
        set;
    }
    public String docName2 {
        get;
        set;
    }
    public String formType {
        get;
        set;
    }
    public Boolean showPoller {
        get;
        set;
    }
    public String errorVal {
        get;
        set;
    }
    public AddAttachmentsController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    private void initialiseStep() {
        displayText = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;
        displayText4 = transactionMgr.currentStep.Display_Text_4__c == null ? '' : transactionMgr.currentStep.Display_Text_4__c;
        displayText5 = transactionMgr.currentStep.Display_Text_5__c == null ? '' : transactionMgr.currentStep.Display_Text_5__c;
        displayText6 = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c;
        headerText2 = transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c;
        headerText3 = transactionMgr.currentStep.Header_Text_3__c == null ? '' : transactionMgr.currentStep.Header_Text_3__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c == null ? '' : transactionMgr.currentStep.ContinueButtonText__c;
        previousButtonText = transactionMgr.currentStep.PreviousButtonText__c == null ? '' : transactionMgr.currentStep.PreviousButtonText__c;
        companyName = submissionMgr.submission.CompanyName__c == null ? '' : submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c == null ? '' : submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.PersonEmail == null ? '' : submissionMgr.submission.Presenter__r.PersonEmail;
        presenterName = submissionMgr.submission.PresenterName__c == null ? '' : submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c == null ? '' : submissionMgr.submission.PresenterPhoneNumber__c;
        attachmentId = submissionMgr.submission.Id == null ? '' : submissionMgr.submission.Id;
        hasPageErrors = submissionMgr.submission.errors__c == null ? false : submissionMgr.submission.errors__c;
        errorVal = submissionMgr.submission.errors__c == true ? 'error' : '';
        currentErrorMessage = submissionMgr.submission.errorsMessage__c == null ? '' : submissionMgr.submission.errorsMessage__c;
        checkAttachmentStatus();
        return;
    }
    public PageReference goForward() {
        if (submissionMgr.submission.finishedAttachments__c == true && submissionMgr.submission.finishedAddingShares__c == true) {
            return nextStep();
        } else if (submissionMgr.submission.finishedAttachments__c == true && submissionMgr.submission.finishedpart1__c == true) {
            return nextStep();
        }
        return null;
    }
    public void DeleteAttachments() {
        for (Attachment attachmentToDelete : submissionMgr.submission.Attachments) {
            if (attachmentToDelete.Id == deleteattachmentId) {
                try {
                    delete attachmentToDelete;
                } catch (DmlException e) {
                    System.debug('DML Exception' + e.getMessage());
                } catch (Exception e) {
                    System.debug('General Exception' + e.getMessage());
                }
            }
        }
    }
    public void shimfunction() {}
    public void checkAttachmentStatus() {
        Integer attSize = submissionMgr.submission.Attachments.size();
        if (submissionMgr.submission.Form_Name__c == 'CC04') {
            docName = 'Resolution agreeing change';
            docName2 = 'Revised Articles';
            formType = 'CC04';
            title = 'Supporting documents';
            information = '';
        } else if (submissionMgr.submission.Form_Name__c == 'SH19') {
            docName = 'Resolution';
            docName2 = 'Solvency statement';
            formType = 'SH19';
            title = 'Additional documents';
            information = 'You need to file additional documents before the company’s capital can be reduced. If these documents have already been filed, there is no need to file them again.';
        }
        if (attSize > 0) {
            for (Attachment checkedAttachments : submissionMgr.submission.Attachments) {
                if (submissionMgr.submission.Form_Name__c == 'SH19') {
                    if (attSize == 1) {
                        if (checkedAttachments.Name == docName + '.pdf') {
                            docStatus1 = 'Uploaded';
                            docStatus2 = 'Not yet uploaded';
                        }
                        if (checkedAttachments.Name == docName2 + '.pdf') {
                            docStatus2 = 'Uploaded';
                            docStatus1 = 'Not yet uploaded';
                        }
                    } else if (attSize >= 2) {
                        if (checkedAttachments.Name == docName + '.pdf') {
                            docStatus1 = 'Uploaded';
                        } else if (checkedAttachments.Name == docName2 + '.pdf') {
                            docStatus2 = 'Uploaded';
                        }
                    }
                } else if (submissionMgr.submission.Form_Name__c == 'CC04') {
                    if (attSize == 1) {
                        if (checkedAttachments.Name == docName + '.pdf') {
                            docStatus1 = 'Uploaded';
                            docStatus2 = 'Not yet uploaded';
                        }
                        if (checkedAttachments.Name == docName2 + '.pdf') {
                            docStatus2 = 'Uploaded';
                            docStatus1 = 'Not yet uploaded';
                        }
                    } else if (attSize >= 2) {
                        if (checkedAttachments.Name == docName + '.pdf') {
                            docStatus1 = 'Uploaded';
                        } else if (checkedAttachments.Name == docName2 + '.pdf') {
                            docStatus2 = 'Uploaded';
                        }
                    }
                }
            }
        } else {
            docStatus2 = 'Not yet uploaded';
            docStatus1 = 'Not yet uploaded';
        }
    }
    public PageReference upload1() {
        if (file1.size() > 1000000) {
            hasPageErrors = true;
            currentErrorMessage = 'File is too large, must be less than 1 MB';
            return refresh();
        }
        if (submissionMgr.submission.Attachments.size() == 0) {
            build1stDoc();
        } else if (submissionMgr.submission.Attachments.size() > 0) {

            for (Attachment doc1updates : submissionMgr.submission.Attachments) {

                if (submissionMgr.submission.Attachments.size() == 1) {
                    if (doc1updates.name == docName) {
                        doc1updates.body = file1;
                        update doc1updates;
                    } else if (doc1updates.name == docName2 && doc1updates.name != docName) {
                        build1stDoc();
                    }
                } else if (submissionMgr.submission.Attachments.size() == 2) {
                    if (doc1updates.name == docName) {
                        doc1updates.body = file1;
                        update doc1updates;
                    }

                }
            }
        }
        checkAttachmentStatus();
        hasPageErrors = false;
        currentErrorMessage = '';
        return refresh();
    }
    public PageReference upload2() {
        if (file2.size() > 1000000) {
            hasPageErrors = true;
            currentErrorMessage = 'File is too large, must be less than 1 MB';
            return refresh();
        }
        if (submissionMgr.submission.Attachments.size() == 0) {
            build2ndDoc();
        } else if (submissionMgr.submission.Attachments.size() > 0) {
            for (Attachment doc2updates : submissionMgr.submission.Attachments) {
                if (submissionMgr.submission.Attachments.size() == 1) {
                    if (doc2updates.name == docName2 && doc2updates.name != docName) {
                        doc2updates.body = file2;
                        update doc2updates;
                    } else if (doc2updates.name == docName && doc2updates.name != docName2) {
                        build2ndDoc();
                    }

                } else if (submissionMgr.submission.Attachments.size() == 2) {
                    if (doc2updates.name == docName2) {
                        doc2updates.body = file2;
                        update doc2updates;
                    }

                }
            }
        }

        checkAttachmentStatus();
        hasPageErrors = false;
        currentErrorMessage = '';
        return refresh();
    }
    public void build1stDoc() {

        Attachment aTTResolution = new Attachment();
        aTTResolution.parentId = attachmentId;
        aTTResolution.body = file1;
        aTTResolution.description = docName;
        aTTResolution.name = docName + '.pdf';
        try {
            insert aTTResolution;

        } catch (DmlException e) {
            throw new Form_CustomException('DML Error with this upload' + e.getMessage());

            System.debug('DML Error with this upload' + e.getMessage());
        } catch (Exception e) {
            throw new Form_CustomException('DML Error with this upload' + e.getMessage());

            System.debug('General Exception' + e.getMessage());
        }
    }
    public void build2ndDoc() {

        Attachment aTTSolvency = new Attachment();
        aTTSolvency.parentId = attachmentId;
        aTTSolvency.body = file2;
        aTTSolvency.description = docName2;
        aTTSolvency.name = docName2 + '.pdf';
        try {
            insert aTTSolvency;
        } catch (DmlException e) {
            throw new Form_CustomException('DML Error with this upload' + e.getMessage());

            System.debug('DML Error with this upload' + e.getMessage());

        } catch (Exception e) {
            throw new Form_CustomException('DML Error with this upload' + e.getMessage());

            System.debug('General Exception' + e.getMessage());

        }
    }
    private void persistStep() {
        submissionMgr.submission.errors__c = hasPageErrors;
        submissionMgr.submission.errorsMessage__c = currentErrorMessage;
        submissionMgr.persist();
    }
    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;
        submissionMgr.submission.finishedAttachments__c = true;
        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
        submissionMgr.submission.finishedAddingShares__c = false;
        persistStep();
        if (!validatePageState()) return Page.TransactionException;
        if (submissionMgr.submission.Form_Name__c == 'SH19') {
            PageReference pg = new PageReference('/SCapital3');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        } else if (submissionMgr.submission.Form_Name__c == 'CC04') {
            PageReference pg = new PageReference('/ObjectsCompany');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }
        return null;
    }
    public PageReference refresh() {
        persistStep();
        PageReference pg = new PageReference('/Attachments');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
    }
}