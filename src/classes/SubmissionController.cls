/*
Name:  SubmissionController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Submission

======================================================
======================================================
History
-------
Ver. Author         Date        Detail
1.0  Antonio Bravo  2016-05-27  Initial development.
*/
public with sharing class SubmissionController extends TransactionStepControllerBase {
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
    public Boolean showDoc {
            get;
            private set;
        }
    // Public properties.

    //public String title {get; private set;}

    //public String size {get; private set;}

    //public Id attachmentId {get; private set;}

    public String companyAddress {
        get;
        set;
    }
    public String companyAddress1 {
        get;
        set;
    }
    public String companyAddress2 {
        get;
        set;
    }
    public String companyregion {
        get;
        set;
    }
    public String companypostcode {
        get;
        set;
    }
    public String companyCountry {
        get;
        set;
    }
    public String companyLocality {
        get;
        set;
    }

    public String companyNumber {
        get;
        set;
    }

    public String submissionId {get; private set;}
    public String companyName {get; set;}

    //public Boolean showDoc {get; private set;}
    public String displayHeader {get; set;}
    public String displayText1 {get; set;}
    public String displayText2 {get; set;}
    public List<Officer__c> companyDirectors {get; set;}
    //public String subDate {get; set;}
    //public String subTime {get; set;}

    // Constructors.
    public SubmissionController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    // End Constructors.

    // Instance methods.
    private void initialiseStep() {
        try {

            if (submissionMgr.submission.SubmissionId__c == null) {
                // we need to submit the transaction to chips..... or change the status
                // we need to change the submissionID__c to be our internal ID: SF ConfirmationID
                // the SubmissionID__c will generated from CHIPS and passed back to us eventually

                submissionMgr.submission.SubmissionId__c =  'FE' + submissionMgr.submission.Id;
            }

            submissionId = submissionMgr.submission.SubmissionId__c == null ? '' : submissionMgr.submission.SubmissionId__c;
            companyName = submissionMgr.submission.CompanyName__c == null ? '' : submissionMgr.submission.CompanyName__c;
            
            companyNumber = submissionMgr.submission.CompanyNumber__c;

            companyDirectors = new List<Officer__c>();
            for (Officer__c off : submissionMgr.submission.Officers__r) {
                if (off.isSignatory__c) {
                    companyDirectors.add(off);
                }
            }

            companyAddress1 = submissionMgr.submission.CompanyAddress1__c;
            companyAddress2 = submissionMgr.submission.CompanyAddress2__c;
            companyregion = submissionMgr.submission.CompanyRegion__c;
            companypostcode = submissionMgr.submission.CompanyPostCode__c;
            companyCountry = submissionMgr.submission.CompanyCountry__c;
            companyLocality = submissionMgr.submission.CompanyLocality__c;
            companyAddress = (companyAddress1 == null ? '' : companyAddress1 + '<br/>') + (companyAddress2 == null ? '' : companyAddress2 + '<br/>') + (companyregion == null ? '' : companyregion + '<br/>') + (companyLocality == null ? '' : companyLocality + '<br/>') + (companypostcode == null ? '' : companypostcode + '<br/>') + (companyCountry == null ? '' : companyCountry);

            displayHeader = transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c;
                        
            displayText1 = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
            displayText1 = displayText1.replace('COMPANYNAME', companyName);
            
            displayText2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
            if (submissionMgr.submission.attachments != null) {
                if (submissionMgr.submission.attachments.size() > 0) {
                    showDoc = true;
                    attachmentId = submissionMgr.submission.attachments[0].Id;
                    title = 'View the application';
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
        } catch (Exception e) { return; }


        return;
    }
    // End Instance methods.


    private void persistStep() {
        submissionMgr.submission.submissionTime__c = String.valueOf(system.now().time());
        submissionMgr.submission.submissionDate__c = String.valueOf(system.today().format());
        submissionMgr.persist();
    }

    public PageReference nextAction() {
        //Refresh the transaction record
        submissionMgr.submission = [select Session_Log__c, AmendmentHistory__c, SentreviewURL__c,isSignout__c,AccountAuthorisationCode__c ,shareChangeSelection__c, shareClassSelection__c, errors__c, errorsMessage__c, finishedPart1__c, finishedAttachments__c, prescribedParticular__c, selectShareType__c, Transaction_Type__c, CompanyType__c, Company__r.CompanyNumber__c, CompanyStatus__c, CompanyIncorporationDate__c, officerTerminology__c, isLtdPlc__c, isLP__c, submissionDate__c, submissionTime__c, paymentDate__c, containsPackage__c, Product_Code__c, paymentReference__c, isPaymentAccount__c, isPaymentCard__c, isPaymentPaypal__c, AccountNumber__c, hasPromoter__c, Version_Form__c, Presenter__r.PersonEmail, Company__c, Company__r.Name, Company__r.Id, ApplicationDate__c, trueTransactionName__c, isSigningFinished__c, isDigitalSignatureNeeded__c, isSigningStarted__c, sharecurrencyselection__c, Barcode__c, isBehalfSignatoryEnable__c, isPresenterMultipleDirectors__c, SoleDirectorPresenter__c, OfficerCount__c, hasPaid__c, isPaymentRequired__c, CompanyLocality__c, CompanyCountry__c, CompanyPostCode__c, CompanyRegion__c, CompanyAddress1__c, CompanyAddress2__c, Id, Form_Name__c, Presenter__c, ExpiryDate__c, Presenter__r.Name, isMajorityRequired__c, Expiry_Date_Length__c,
                                     PresenterName__c, PresenterPhoneNumber__c, RequiredOfficerSign__c, ContactEmail__c,
                                     MultipleDirectors__c, Name, Historical_Valid_Step_Ids__c, CompanyNumber__c, finishedAddingShares__c,
                                     Status__c, CompanyName__c, SubmissionId__c, Valid_Step_Ids__c, Amount__c, isLLP__c,
                                     (Select Id, Name, Email__c, DocusignName__c, hasInputBehalfDetails__c, isSignatoryBehalf__c, isPresenter__c, isSignatory__c, RecipientId__c,
                                      AuthorizedSigner__c, isPowerOfAttorney__c, isCorporateDirector__c
                                      From Officers__r),
                                     (SELECT Id, BodyLength, Description, Name FROM Attachments),
                                     (Select Id, Name, Email, DocusignName__c, hasInputBehalfDetails__c, isSignatoryBehalf__c, isPresenter__c, isSignatory__c, RecipientId__c,
                                      AuthorizedSigner__c,RecipientStatus__c, Title, Middlenames__c, FirstName, LastName, isPowerOfAttorney__c, isCorporateDirector__c
                                      From Contacts__r), (SELECT Name, dsfs__DocuSign_Envelope_ID__c, dsfs__Envelope_Link__c, dsfs__Envelope_Status__c, dsfs__Sender__c, dsfs__Sender_Email__c, dsfs__Subject__c FROM DocuSign_Status__r)
                                     from Transaction__c where Id = :submissionMgr.submission.Id];

        PageReference result = authenticatedSession();
        
        if(result != null)
            return result;
                                     
        submissionMgr.submission.SubmissionId__c =  'FE' + submissionMgr.submission.Id;
        if (submissionMgr.submission.Status__c == 'Paid' && submissionMgr.submission.Barcode__c == null) {
            if (Test.isRunningTest()) {
                system.debug('test is running now');


            } else {
                FormAPISubmissionManager submissionMgrAPI = new FormAPISubmissionManager();
                submissionMgr.submission = submissionMgrAPI.sendForm(submissionMgr.submission);
            }
        }
        else
        {
            //Fix: We do want as there is a barcode overide the status to be submitted
            if(submissionMgr.submission.Status__c != 'Approved' || submissionMgr.submission.Status__c != 'Rejected' )
            {
                //In this case we have either the duplicatee barcode issue hence we want to proceed to the next page or
                //We just expired from previous session and in this case we didn't submit on success as the status aren't approved or reject
                //BUT we don't want the user to get an email when there is no barcode so we adjust the status to be on error
                //And the confirmation will redirect the user automatically to the error page as there is no barcode...
                if(submissionMgr.submission.Barcode__c != null)
                {
                    submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_SUBMITTED;
                }
                else{
                    submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_ERROR;
                    persistStep();
                    PageReference pg = new PageReference('/IntegrationError');

                    pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
                    pg.setRedirect(true);
                    return pg;
                }   
            }
            persistStep();
            return nextStep();
        }

        system.debug('Before save tx: ' + submissionMgr.submission);
        if (Test.isRunningTest()) {
            system.debug('test is running now');

            // test error in test mode;
            submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_ERROR;
        }
        submissionMgr.submission.AmendmentHistory__c += '<br/>-----------------------------------------------------------------------------------';
        submissionMgr.submission.AmendmentHistory__c += '<br/> Number Of Call static (Submit Page): ' + FormsApiClient.numberOfTimeCalled;
        submissionMgr.submission.AmendmentHistory__c += '<br/>-----------------------------------------------------------------------------------';
        persistStep();

        if (submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_ERROR) {
            PageReference pg = new PageReference('/IntegrationError');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }
        // if(!validatePageState() || submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_ERROR)
        //   return Page.TransactionException;

        if (Test.isRunningTest()) {
            system.debug('test is running now');

        } else {
            return nextStep();
        }
        return null;
    }

    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        if (Test.isRunningTest()) {
            system.debug('test is running now');

        } else {
            return previousStep();
        }
        return null;
    }
    // End Action methods.
}