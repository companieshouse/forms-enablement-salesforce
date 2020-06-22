/*
Name:  withdrawController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------
Controller class for the Visualforce Page: WithdrawDissolution
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-08-08  Initial development.
*/
public class withdrawController extends TransactionStepControllerBase {
    public String currentErrorMessage {
        get;
        set;
    }
    public String errorVal {
        get;
        set;
    }
    public Boolean hasPageErrors {
        get;
        set;
    }
    public Boolean confirmationVal {
        get;
        set;
    }
    public String companyName {get; set;}
    public String pageText {get; set;}
    public String pageTitle {get; set;}
    public String textCheckbox {get; set;}
    public withdrawController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    private void initialiseStep() {
        companyName = submissionMgr.submission.CompanyName__c  == null ? '' : submissionMgr.submission.CompanyName__c;
        pageText = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        pageTitle = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        textCheckbox = (transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c);
        pageText = pageText.replace('COMPANYNAME', companyName);

    }
    
    public void confirmWithdraw() {}
    
    public void buildDocument() {
        if (submissionMgr.submission.Attachments.size() > 0) {
            try {
                Delete[Select id, name from Attachment where ParentId = : submissionMgr.submission.id];
            } catch (DmlException e) {
                System.debug('DML Error in deleting' + submissionMgr.submission.Form_Name__c + 'Error Details are' + ' ' + e.getMessage());
            } catch (Exception e) {
                System.debug('General Error in deleting' + submissionMgr.submission.Form_Name__c + 'Error Details are' + ' ' + e.getMessage());
            }
        }
        Attachment pdfAttachment = new Attachment();
        Blob pdfBlob;
        PageReference pageRef = new PageReference('/apex/' + submissionMgr.submission.Form_Name__c);
        pageRef.getParameters().put('id', submissionMgr.submission.Id);
        if (Test.IsRunningTest()) { pdfBlob = Blob.valueOf('This is a test');}
        else {pdfBlob = pageRef.getContent();}
        pdfAttachment.ParentId = submissionMgr.submission.Id;
        pdfAttachment.Name = submissionMgr.submission.Form_Name__c + '.pdf';
        pdfAttachment.Description = submissionMgr.submission.Form_Name__c;
        pdfAttachment.Body = pdfBlob;
        try {
            insert pdfAttachment;
        } catch (DmlException e) {
            System.debug('DML Error in inserting' + submissionMgr.submission.Form_Name__c + 'Error Details are' + ' ' + e.getMessage());
        } catch (Exception e) {
            System.debug('General Error in inserting' + submissionMgr.submission.Form_Name__c + 'Error Details are' + ' ' + e.getMessage());
        }
        submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_PENDING_SUBMISSION;
        persistStep();
    }

    private void persistStep() {
        submissionMgr.submission.submissionTime__c = String.valueOf(system.now().time());
        submissionMgr.submission.submissionDate__c = String.valueOf(system.today().format());
        submissionMgr.persist();
    }

    public PageReference nextAction() {
        if (confirmationVal == null || confirmationVal == false) {
            errorVal = 'govuk-form-group--error';
            hasPageErrors = true;
            currentErrorMessage = 'You must confirm to continue';
            return null;
        }
        submissionMgr.submission.SubmissionId__c = 'FE' + submissionMgr.submission.Id;

        if (Test.isRunningTest()) {
            system.debug('Test is running and the Forms API will be called here ');
            system.debug('During testing Salesforce doesn\'t support webservice Callouts');

        } else {
            if (submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_PENDING_SUBMISSION) {
                FormAPISubmissionManager submissionMgrAPI = new FormAPISubmissionManager();
                submissionMgr.submission = submissionMgrAPI.sendForm(submissionMgr.submission);
            }
        }

        persistStep();

        
        if (submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_ERROR) {
            PageReference pg = new PageReference('/IntegrationError');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }

        if(Test.isRunningTest())
        {
            return null;
        }
        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
}