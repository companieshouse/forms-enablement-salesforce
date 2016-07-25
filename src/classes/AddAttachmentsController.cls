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
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.PersonEmail;
        presenterName = submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c;
        //attachments = submissionMgr.submission.Attachments;
        attachmentId = submissionMgr.submission.Id;
        if (submissionMgr.submission.Attachments.size() > 0) {
            attachments = submissionMgr.submission.Attachments;
        }
        newAttachments = new List < Attachment > {
            new Attachment()
        };
        return;
    }
    public void addMore() {
        for (Integer idx = 0; idx < NUMOFATTACHMENTSALLOWED; idx++) {
            newAttachments.add(new Attachment());
        }
        hasPageErrors = false;
    }
    public void remove() {
        if (newAttachments.size() == 0) {
            hasPageErrors = true;
            currentErrors = 'You have no new attachments to remove';
        } else if (newAttachments.size() > 0) {
            newAttachments.remove(0);
        }
    }
    public void DeleteAttachments() {
throw new Form_CustomException(' your attachment ID is ' + attachmentId);
        for (Attachment attachmentToDelete: submissionMgr.submission.Attachments) {
            if (attachmentToDelete.Id == attachmentId) {
                try {
                    throw new Form_CustomException(' your attachment ID is ' + attachmentToDelete);
                    delete attachmentToDelete;
                } catch (DmlException e) {} catch (Exception e) {}finally{
                            persistStep();

                }
            }
        }

       // throw new Form_CustomException(' your attachment ID is ' + attachmentId);
        //for (Attachment deletedAttachment: submissionMgr.submission.Attachments) {
        //    if (deletedAttachment.Id == attachmenttoDeleteId) {
        //        try {
        //            //deletedAttachment.delete();
        //        } catch (DmlException e) {
        //            hasPageErrors = true;
        //            currentErrors = 'Attachment Deletion Error' + e.getMessage();
        //            console.log('DML error in removing attachment' + e.getMessage());
        //        } catch (Exception e) {
        //            hasPageErrors = true;
        //            currentErrors = 'Attachment Deletion Error' + e.getMessage();
        //            console.log('error in removing attachment' + e.getMessage());
        //        } finally {
        //            //PageReference pg = new PageReference('/Attachments');
        //            //pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        //            //pg.setRedirect(true);
        //            //return pg;
        //            refresh();
        //        }
        //    }
        //}
    }
    public PageReference save() {
        List < Attachment > toInsert = new List < Attachment > ();
        for (Attachment newAtt: newAttachments) {
            if (newAtt.Body != null) {
                newAtt.parentId = attachmentId;
                toInsert.add(newAtt);
            }
        }
        insert toInsert;
        newAttachments.clear();
        newAttachments.add(new Attachment());
        attachments = null;
        PageReference pg = new PageReference('/Attachments');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
        //refresh();
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
    public PageReference refresh() {
        PageReference pg = new PageReference('/Attachments');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);
        return pg;
    }
}