/*
Name:  ConfirmationController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Confirmation

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class ConfirmationFrameworkController extends TransactionStepControllerBase {
    // Public properties.
    public String title {
        get;
        private set;
    }
    public String size {
        get;
        private set;
    }
    public String todayThreeMonths {
        get;
        set;
    }
    public Id attachmentId {
        get;
        private set;
    }
    public String submissionId {
        get;
        private set;
    }
    public String companyName {
        get;
        set;
    }
    public Boolean showDoc {
        get;
        private set;
    }
    public String displayText3 {
        get;
        set;
    }
    public String confirmationHeading1 {
        get;
        set;
    }
    public String confirmationContent1 {
        get;
        set;
    }
    public String confirmationContent2 {
        get;
        set;
    }
    public String confirmationContent3 {
        get;
        set;
    }
    public String confirmationNextStepContent {
        get;
        set;
    }
    public String confirmationWarningTitle {
        get;
        set;
    }
    public String confirmationWarningContent1 {
        get;
        set;
    }
    public String confirmationHeading2 {
        get;
        set;
    }
    public String confiratmionWarningContent2 {
        get;
        set;
    }
    public String companyNameText {
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
    //added payment reference
    public String paymentReference {
        get;
        set;
    }

    public Boolean isDS01 {get; set;}
    public Boolean isDS02 {get; set;}

    public String pageTitle {get; set;}
    public String pageTitle2 {get; set;}
    public String pageTitle3 {get; set;}

    public String pageBody {get; set;}
    public String pageBody1 {get; set;}
    public String pageBody2 {get; set;}
    public String warningText {get; set;}
    public Boolean showSHVIEW {get; set;}
    public String formName {get; set;}
    public List<Attachment> downloadDocs {get; set;}
    // Constructors.
    public ConfirmationFrameworkController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    // End Constructors.
    // Instance methods.
    @TestVisible
    private void initialiseStep() {
         try {
            if (Test.isRunningTest()) {
                system.debug('test is running now');
            } else {
                standardView = transactionMgr.currentStep.StandardView__c;
                customView = transactionMgr.currentStep.CustomView__c;
            }
            if (standardView) {
                if (submissionMgr.submission.SubmissionId__c == null || submissionMgr.submission.Barcode__c == null) {
                    // we need to submit the transaction to chips..... or change the status
                    // we need to change the submissionID__c to be our internal ID: SF ConfirmationID
                    // the SubmissionID__c will generated from CHIPS and passed back to us eventually

                    //SP 13/06/17: Code changed to point to integration page error if we end up on the confirmation page with no valid barcode
                    //submissionMgr.submission.SubmissionId__c =  'FE' + submissionMgr.submission.Id;
                    //submissionMgr.submission.Status__c = AppConstant.REQUEST_STATUS_PENDING_SUBMISSION; //  'Awaiting Submission';
                }
                formName = submissionMgr.submission.Form_Name__c;
                submissionId = submissionMgr.submission.CompanyNumber__c;
                companyName = submissionMgr.submission.CompanyName__c;           
                // added payment reference to info on last page
                paymentReference = submissionMgr.submission.PaymentReference__c;
                companyNameText = transactionMgr.currentStep.CompanyNameText__c;
                pageTitle = transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c;
                pageTitle2 = transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c;
                pageTitle3 = transactionMgr.currentStep.Header_Text_3__c == null ? '' : transactionMgr.currentStep.Header_Text_3__c;                pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
                pageBody1 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
                pageBody1 += transactionMgr.currentStep.Display_Text_5__c == null ? '' : transactionMgr.currentStep.Display_Text_5__c;
                pageBody2 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;
                pageBody2 += transactionMgr.currentStep.Display_Text_4__c == null ? '' : transactionMgr.currentStep.Display_Text_4__c;
                warningText = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;
                if (submissionMgr.submission.Transaction_Type__c.contains('DS01')) {
                    isDS01 = true;
                    isDS02 = false;
                } else  if (submissionMgr.submission.Transaction_Type__c.contains('DS02')) {
                    isDS02 = true;
                    isDS01 = false;

                }
                // Added payment reference to last page
                pageTitle2 = pageTitle2.replace('REFNUMB',  String.isBlank(submissionMgr.submission.CompanyNumber__c) ? '' : submissionMgr.submission.CompanyNumber__c);
                pageTitle3 = pageTitle3.replace('PAYNUMB',  String.isBlank(submissionMgr.submission.PaymentReference__c) ? '' : submissionMgr.submission.PaymentReference__c);

                if (submissionMgr.submission.attachments != null) {
                    if (submissionMgr.submission.attachments.size() > 0) {
                        showDoc = true;
                        attachmentId = submissionMgr.submission.attachments[0].Id;
                        title = submissionMgr.submission.attachments[0].Name;
                        Integer sizeInt = submissionMgr.submission.attachments[0].BodyLength;
                        String tempSize = String.valueOf(sizeInt);
                        size = tempSize.left(3);
                        //MB
                        if (tempSize.length() >= 9) {
                            size += 'M';
                        }
                        //KB
                        else if (tempSize.length() >= 6 && tempSize.length() < 9) {
                            size += 'K';
                        }
                    }
                } else {
                    title = 'NA';
                    size = 'NA';
                    attachmentId = null;
                }
                todayThreeMonths = system.today().day() + '-' + system.today().addMonths(3).month() + '-' + system.today().year();
            } else if (customView) {
                showDoc = true;

                if (submissionMgr.submission.Transaction_Type__c.contains('SH') || submissionMgr.submission.Transaction_Type__c.contains('CC')) {
                    showSHVIEW = true;
                }
                downloadDocs = submissionMgr.submission.attachments;
                if (submissionMgr.submission.SubmissionId__c == null) {
                    // we need to submit the transaction to chips..... or change the status
                    // we need to change the submissionID__c to be our internal ID: SF ConfirmationID
                    // the SubmissionID__c will generated from CHIPS and passed back to us eventually

                    submissionMgr.submission.SubmissionId__c =  'FE' + submissionMgr.submission.Id;
                    submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_PENDING_SUBMISSION; //  'Awaiting Submission';
                }
                if (submissionMgr.submission.Form_Name__c == 'SH05_6_7') {
                    formName = 'SH06';
                } else {
                    formName = submissionMgr.submission.Form_Name__c;
                }
                submissionId = submissionMgr.submission.CompanyNumber__c;
                companyName = submissionMgr.submission.CompanyName__c;
                // added payment reference
                paymentReference = submissionMgr.submission.PaymentReference__c;
                companyNameText = transactionMgr.currentStep.CompanyNameText__c;
                confirmationHeading1 = transactionMgr.currentStep.Header_Text_1__c;
                confirmationContent1 = transactionMgr.currentStep.Display_Text_1__c;
                confirmationContent2 = transactionMgr.currentStep.Display_Text_2__c;
                confirmationContent3 = transactionMgr.currentStep.Display_Text_3__c;
                confirmationNextStepContent = transactionMgr.currentStep.Display_Text_4__c;
                confirmationWarningTitle = transactionMgr.currentStep.Display_Text_5__c;
                confirmationWarningContent1 = transactionMgr.currentStep.Display_Text_6__c;
                confirmationHeading2 = transactionMgr.currentStep.Header_Text_2__c;
                confiratmionWarningContent2 = transactionMgr.currentStep.Header_Text_3__c;
                standardView = transactionMgr.currentStep.StandardView__c;
                customView = transactionMgr.currentStep.CustomView__c;

                if (confirmationContent3.contains('COMPANYNAME')) {
                    confirmationContent3 = confirmationContent3.replace('COMPANYNAME', companyName);
                }

                if (submissionMgr.submission.attachments != null && submissionMgr.submission.attachments.size() > 0) {

                }
                todayThreeMonths = system.today().day() + '-' + system.today().addMonths(3).month() + '-' + system.today().year();
            }
        } catch (Exception e) {
            return;
        }
        return;
    }

    public PageReference redirectDS02() {
        if(submissionMgr.submission.Form_Name__c.contains('LL'))
        {
            PageReference pg = new PageReference('/StartFramework?t=LLDS02');
            pg.setRedirect(true);
            return pg;
        }
        PageReference pg = new PageReference('/StartFramework?t=DS02');
        pg.setRedirect(true);
        return pg;
    }

    //public String attSizer(Attachment fileAttachment) {
    //    if (fileAttachment.BodyLength > 0) {
    //        Integer sizeInt = fileAttachment.BodyLength;
    //        String tempSize = String.valueOf(sizeInt);
    //        size = tempSize.left(3);
    //        //MB
    //        if (tempSize.length() >= 9) {
    //            size += 'M';
    //            return size;
    //        }
    //        //KB
    //        else if (tempSize.length() >= 6 && tempSize.length() < 9) {
    //            size += 'K';
    //            return size;
    //        }
    //        return size;
    //    } else {

    //      size = 'NA';
    //      return size;
    //  }
    //}
    public PageReference saveTransaction() {
        PageReference res = initialiseAction();

        if(res != null)
            return res;
            
        if(submissionMgr.submission.isSignout__c)
        {
            
            PageReference pg = new PageReference('https://www.gov.uk/government/organisations/companies-house');

            pg.setRedirect(true);

            return pg;
        }
        
        if(submissionMgr.submission.Barcode__c == null)
        {
            PageReference pg = new PageReference('/IntegrationError');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }        
        
        persistStep();

        return null;
    }
    @TestVisible
    private void persistStep() {
        submissionMgr.persist();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }

    public PageReference signoutAction(){

        //Build the signout page
        PageReference pg = new PageReference('/SignOut');
        pg.setRedirect(true);
        return pg;
    }

}