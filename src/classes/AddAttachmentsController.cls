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
    public Boolean hasPageErrors {
        get;
        set;
    }
    public Boolean showTable {
        get;
        set;
    }
    public List < Attachment > attachments {
        get;
        set;
    }
    public List < Attachment > newAttachments {
        get;
        set;
    }
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
    public String currentErrors {
        get;
        set;
    }
    public Id attachmenttoDeleteId {
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
    public String solvencyStatus {get; set;}
    public String resolutionStatus {get; set;}
    public String previousButtonText {get; set;}
    public Blob attBody {get; set;}
    public Blob resBody {get; set;}
    public Blob solvencyBody {get; set;}

    public String attName {get; set;}
    public String attDescription {get; set;}
    public static final Integer NUMOFATTACHMENTSALLOWED = 1;
    public AddAttachmentsController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    private void initialiseStep() {

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
        previousButtonText = transactionMgr.currentStep.PreviousButtonText__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.PersonEmail;
        presenterName = submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c;
        attachmentId = submissionMgr.submission.Id;
        if (submissionMgr.submission.Attachments.size() > 0) {
            attachments = submissionMgr.submission.Attachments;
        }
        checkAttachmentStatus();
        return;
    }
    public PageReference goForward() {

        if (submissionMgr.submission.finishedAttachments__c == true) {
            return nextStep();
        }
        return null;
    }

    public void DeleteAttachments() {
        //throw new Form_CustomException(' your attachment ID is ' + attachmentId);
        for (Attachment attachmentToDelete : submissionMgr.submission.Attachments) {
            if (attachmentToDelete.Id == attachmentId) {
                try {
                    //throw new Form_CustomException(' your attachment ID is ' + attachmentToDelete);
                    delete attachmentToDelete;
                } catch (DmlException e) {} catch (Exception e) {} finally {
                    //persistStep();
                }
            }
        }
    }
    public void checkAttachmentStatus() {
        if (submissionMgr.submission.Attachments.size() > 0) {
            for (Attachment checkedAttachments : submissionMgr.submission.Attachments) {
                if (checkedAttachments.Name == 'Resolution') {
                    resolutionStatus = 'Uploaded';
                } else if (checkedAttachments.Name != 'Resolution') {
                    resolutionStatus = 'Not yet uploaded';
                }
                if (checkedAttachments.Name == 'Solvency statement') {
                    solvencyStatus = 'Uploaded';
                } else if (checkedAttachments.Name != 'Solvency statement') {
                    solvencyStatus = 'Not yet uploaded';
                }
            }
        } else {
            solvencyStatus = 'Not yet uploaded';
            resolutionStatus = 'Not yet uploaded';
        }
    }





    public void addSolvencyStatement() {


    }

    public PageReference uploadaTT() {
        Attachment aTT = new Attachment();

        aTT.parentId = attachmentId;
        aTT.body = attBody;
        aTT.description = attDescription;
        aTT.name = attName;

        try {
            insert aTT;

        } catch (DmlException e) {
            System.debug('DML Error with this upload' + e.getMessage());
        } catch (Exception e) {
            System.debug('General Exception' + e.getMessage());
        }
        checkAttachmentStatus();
        return null;
    }

    private void persistStep() {
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

        PageReference pg = new PageReference('/SCapital3');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
    }
    public PageReference refresh() {
        PageReference pg = new PageReference('/Attachments');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
    }
}