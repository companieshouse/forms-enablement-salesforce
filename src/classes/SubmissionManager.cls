/*
Name:  SubmissionManager.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Manager class for the Transaction Submission Custom Object.
Encapsulates all data access and business logic.

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-02  Initial development.
1.1  Antonio Bravo 2016-04-26  Update Constants
1.2  Antonio Bravo 2016-05-20  Update Query
*/
public with sharing class SubmissionManager {

    // Public properties.
    public Transaction__c submission { get; set; }

    // Constructors.
    public SubmissionManager() {}

    public SubmissionManager(Id submissionId) {
        List<Transaction__c> recs = [select errors__c, errorsMessage__c, finishedPart1__c, finishedAttachments__c, prescribedParticular__c, selectShareType__c, Transaction_Type__c, CompanyType__c, Company__r.CompanyNumber__c, CompanyStatus__c, CompanyIncorporationDate__c, officerTerminology__c, isLtdPlc__c, isLP__c, submissionDate__c, submissionTime__c, paymentDate__c, containsPackage__c, Product_Code__c, paymentReference__c, isPaymentAccount__c, isPaymentCard__c, isPaymentPaypal__c, AccountNumber__c, hasPromoter__c, Version_Form__c, Presenter__r.PersonEmail, Company__c, Company__r.Name, Company__r.Id, ApplicationDate__c, trueTransactionName__c, isSigningFinished__c, isDigitalSignatureNeeded__c, isSigningStarted__c, sharecurrencyselection__c, Barcode__c, isBehalfSignatoryEnable__c, isPresenterMultipleDirectors__c, SoleDirectorPresenter__c, OfficerCount__c, hasPaid__c, isPaymentRequired__c, CompanyLocality__c, CompanyCountry__c, CompanyPostCode__c, CompanyRegion__c, CompanyAddress1__c, CompanyAddress2__c, Id, Form_Name__c, Presenter__c, ExpiryDate__c, Presenter__r.Name, isMajorityRequired__c, Expiry_Date_Length__c,
                                     PresenterName__c, PresenterPhoneNumber__c, RequiredOfficerSign__c, ContactEmail__c,
                                     MultipleDirectors__c, Name, Historical_Valid_Step_Ids__c, CompanyNumber__c, finishedAddingShares__c,
                                     Status__c, CompanyName__c, SubmissionId__c, Valid_Step_Ids__c, Amount__c, isLLP__c,
                                     (Select Id, Name, Email__c, DocusignName__c, hasInputBehalfDetails__c, isSignatoryBehalf__c, isPresenter__c, isSignatory__c, RecipientId__c,
                                      AuthorizedSigner__c, isPowerOfAttorney__c, isCorporateDirector__c
                                      From Officers__r),
                                     (SELECT Id, BodyLength, Description, Name FROM Attachments), (SELECT removeObjects__c, addingObjects__c, alterObjects__c, FreeForm__c, OldNominalValue__c, oldNumSharesIssued__c, NewNominalValu__c, newNumSharesIssued__c, valOfStock__c, Aggregate_nominal_value_New__c, AssignmentDate__c, redenominateDate__c, reduceCapitalDate__c, considerationGiven__c, benefitGiven__c, amountPaidUp__c, SHARETYPE__c, Total_aggregate_amount_paid__c, AggValueLessAuthMin__c, PrelimExpense__c, Signatory__c, varationField__c, Class_of_Share_new__c, Date__c, cancelled_shares__c, totalNumAggregate__c, totalNumofShares__c , ActiveData__c, Aggregate_nominal_value__c, Class_of_Shares__c, Company_Name__c, CreatedById, CreatedDate, Currency__c, IsDeleted, Number_of_Shares__c, Prescribed_Particulars__c, Id, Name, Total_aggregate_amount_unpaid__c, Transaction__c FROM Shares__r),
                                     (Select Id, Name, Email, DocusignName__c, hasInputBehalfDetails__c, isSignatoryBehalf__c, isPresenter__c, isSignatory__c, RecipientId__c,
                                      AuthorizedSigner__c,RecipientStatus__c, Title, Middlenames__c, FirstName, LastName, isPowerOfAttorney__c, isCorporateDirector__c
                                      From Contacts__r), (SELECT Name, dsfs__DocuSign_Envelope_ID__c, dsfs__Envelope_Link__c, dsfs__Envelope_Status__c, dsfs__Sender__c, dsfs__Sender_Email__c, dsfs__Subject__c FROM DocuSign_Status__r)
                                     from Transaction__c where Id = :submissionId];
        if (recs.size() == 1) submission = recs[0];

        System.debug(LoggingLevel.ERROR, submission);
    }

    public SubmissionManager(Id submissionId, String SObjectType, String fieldSetName) {

        String q = 'select Transaction_Type__c,Company__r.CompanyNumber__c,CompanyType__c,CompanyStatus__c,CompanyIncorporationDate__c,Id,officerTerminology__c,Product_Code__c, isLP__c ,containsPackage__c,Company__r.Name,Company__r.Id, Name,(SELECT Id,BodyLength, Description, Name FROM Attachments), (SELECT Aggregate_nominal_value_New__c, AssignmentDate__c,redenominateDate__c, reduceCapitalDate__c, considerationGiven__c, benefitGiven__c, amountPaidUp__c, SHARETYPE__c, Total_aggregate_amount_paid__c, AggValueLessAuthMin__c, PrelimExpense__c, Signatory__c, varationField__c, Class_of_Share_new__c, Date__c, cancelled_shares__c, totalNumAggregate__c,totalNumofShares__c , ActiveData__c, Aggregate_nominal_value__c, Class_of_Shares__c, Company_Name__c, CreatedById, CreatedDate, Currency__c, IsDeleted, Number_of_Shares__c, Prescribed_Particulars__c, Id, Name, Total_aggregate_amount_unpaid__c, Transaction__c FROM Shares__r),(Select Id,Name, Email,DocusignName__c,hasInputBehalfDetails__c,isSignatoryBehalf__c,isPresenter__c,isSignatory__c, RecipientId__c,AuthorizedSigner__c, isPowerOfAttorney__c, isCorporateDirector__c From Contacts__r), (SELECT Name,dsfs__DocuSign_Envelope_ID__c,dsfs__Envelope_Link__c,dsfs__Envelope_Status__c,dsfs__Sender__c,dsfs__Sender_Email__c,dsfs__Subject__c FROM DocuSign_Status__r)';

        Schema.DescribeSObjectResult d = Schema.getGlobalDescribe().get(SObjectType).getDescribe();
        //if (!d.isAccessible()) continue; //& todo add object access/fls security checks.

        if (d.fieldSets.getMap().containsKey(fieldSetName)) {

            Schema.FieldSet fs = d.fieldSets.getMap().get(fieldSetName);

            for (Schema.FieldSetMember f : fs.getFields()) {
                q += ',' + f.getFieldPath();
            }
        }
        q += ' from Transaction__c where Id=:submissionId';


        List<Transaction__c> recs = Database.query(q);
        if (recs.size() == 1) submission = recs[0];

        System.debug(LoggingLevel.ERROR, submission);
    }
    // End Constructors.

    // Instance methods.
    public Id initialise(String transactionType, String presenterId, String presenterEmail, SObject companyId, Transaction_Type__mdt td) {
        //Only initialise with pending submissions.
        List<Transaction__c> recs = [select errors__c, errorsMessage__c, finishedPart1__c, finishedAttachments__c, prescribedParticular__c, selectShareType__c, Transaction_Type__c, Company__r.CompanyNumber__c, CompanyType__c, CompanyStatus__c, CompanyIncorporationDate__c, officerTerminology__c, isLtdPlc__c, isLP__c, submissionDate__c, submissionTime__c, paymentDate__c, containsPackage__c, Product_Code__c, paymentReference__c, isPaymentAccount__c, isPaymentCard__c, isPaymentPaypal__c, AccountNumber__c, hasPromoter__c, Version_Form__c, Presenter__r.PersonEmail, Company__c, Company__r.Name, Company__r.Id, ApplicationDate__c, trueTransactionName__c, isSigningFinished__c, isDigitalSignatureNeeded__c, isSigningStarted__c, sharecurrencyselection__c, Barcode__c, isBehalfSignatoryEnable__c, isPresenterMultipleDirectors__c, SoleDirectorPresenter__c, OfficerCount__c, Id, hasPaid__c, isPaymentRequired__c, CompanyLocality__c, CompanyCountry__c, CompanyPostCode__c, CompanyRegion__c, CompanyAddress1__c, CompanyAddress2__c, Presenter__c, Form_Name__c, ExpiryDate__c, Presenter__r.Name, isMajorityRequired__c,
                                     PresenterName__c, PresenterPhoneNumber__c, RequiredOfficerSign__c, ContactEmail__c,
                                     MultipleDirectors__c, Valid_Step_Ids__c, Historical_Valid_Step_Ids__c, CompanyName__c, CompanyNumber__c,
                                     Status__c, Amount__c, isLLP__c, SubmissionId__c, finishedAddingShares__c,
                                     (Select Id, Name, Email__c, DocusignName__c, hasInputBehalfDetails__c, isSignatoryBehalf__c, isPresenter__c, isSignatory__c, RecipientId__c,
                                      AuthorizedSigner__c, isPowerOfAttorney__c, isCorporateDirector__c
                                      From Officers__r),
                                     (SELECT Id, BodyLength, Description, Name FROM Attachments), (SELECT removeObjects__c, addingObjects__c, alterObjects__c, FreeForm__c, OldNominalValue__c, oldNumSharesIssued__c, NewNominalValu__c, newNumSharesIssued__c, valOfStock__c, Aggregate_nominal_value_New__c, redenominateDate__c, reduceCapitalDate__c, considerationGiven__c, benefitGiven__c, amountPaidUp__c, SHARETYPE__c, Total_aggregate_amount_paid__c, AggValueLessAuthMin__c, PrelimExpense__c, Signatory__c, varationField__c, Class_of_Share_new__c,  Date__c, cancelled_shares__c, totalNumAggregate__c, totalNumofShares__c , ActiveData__c, Aggregate_nominal_value__c, Class_of_Shares__c, Company_Name__c, CreatedById, CreatedDate, Currency__c, IsDeleted, Number_of_Shares__c, Prescribed_Particulars__c, Id, Name, Total_aggregate_amount_unpaid__c, Transaction__c FROM Shares__r),
                                     (Select Id, Name, LastName, Email, DocusignName__c, isSignatoryBehalf__c, isPresenter__c, isSignatory__c, RecipientId__c,
                                      AuthorizedSigner__c,RecipientStatus__c, Title, Middlenames__c, FirstName, hasInputBehalfDetails__c,  isPowerOfAttorney__c, isCorporateDirector__c
                                      From Contacts__r), (SELECT Name, dsfs__DocuSign_Envelope_ID__c, dsfs__Envelope_Link__c, dsfs__Envelope_Status__c, dsfs__Sender__c, dsfs__Sender_Email__c, dsfs__Subject__c FROM DocuSign_Status__r)
                                     from Transaction__c
                                     where Presenter__c = :presenterId
                                             and Form_Name__c = :td.DeveloperName
                                                     and ContactEmail__c = :presenterEmail
                                                             and Company__c = :companyId.Id
                                                                     and Transaction_Type__c = :transactionType
                                                                             and Status__c != :AppConstants.REQUEST_STATUS_SUBMITTED];
        //  or Status__c=:AppConstants.REQUEST_STATUS_SIGNED)]; // should factor in status.
        if (recs.size() == 1) {
            submission = recs[0] ;
            return recs[0].Id;
        }

        //Determine is the payment is needed or not.
        Boolean isPaymentNeeded = (td.isPaymentRequired__c == null ? false : td.isPaymentRequired__c);
        Boolean isDigitalSigning = (td.isDigitalSignatureNeeded__c == null ? false : td.isDigitalSignatureNeeded__c);

        Decimal expiryDate = 0.00;

        if (isDigitalSigning)
            expiryDate = td.Expiry_Date_Length__c; // set the expiry date

        submission = new Transaction__c(Product_Code__c = td.Product_Code__c, Version_Form__c = '1', Expiry_Date_Length__c = expiryDate, isDigitalSignatureNeeded__c = isDigitalSigning , Presenter__c = presenterId, ContactEmail__c = presenterEmail, isPaymentRequired__c = isPaymentNeeded, Form_Name__c = td.DeveloperName, isMajorityRequired__c = td.isMajorityForm__c, Company__c = ((Account)companyId).Id, CompanyNumber__c = ((Account)companyId).CompanyNumber__c, Transaction_Type__c = transactionType);
        insert submission;
        return submission.Id;
    }

    public void persist() {
        Database.update(submission.Attachments);
        Database.update(submission.Shares__r);
        Database.update(submission.Officers__r);
        Database.update(submission);
    }
    // End Instance methods.

    // Static methods.
    public static Boolean isValidSubmissionId(Id submissionId) { return ([select count() from Transaction__c where Id = :submissionId] > 0); }

    public static Boolean isValidSubmissionStepId(Id submissionId, Id stepId) {

        // todo - validation, error handling etc.

        Map<Id, Transaction__c> idToSubmission = new Map<Id, Transaction__c>( [select Id, Valid_Step_Ids__c from Transaction__c where Id = :submissionId ] );

        Transaction__c s = idToSubmission.values()[0];
        if (String.isBlank(s.Valid_Step_Ids__c)) return false;


        for (String validStepId : s.Valid_Step_Ids__c.split(AppConstants.ID_DELIM_SPLIT_CHAR)) {
            if (validStepId.equalsIgnoreCase(stepId)) return true;
        }
        return false;
    }

    public static void setValidSteps(Id submissionId, Id previousStepId, Id nextStepId) {

        // The Valid_Step_Ids__c field will hold all previous Steps and the next Step only.
        // the content should be fully re-evaluated on each step change
        // as user inputs may redirect the Step Path.

        // todo - validation, error handling etc.

        Map<Id, Transaction__c> idToSubmission = new Map<Id, Transaction__c>( [select Id, Valid_Step_Ids__c, Historical_Valid_Step_Ids__c from Transaction__c where Id = :submissionId ] );

        Transaction__c s = idToSubmission.values()[0];

        String newValidStepIdPath = '';

        if (previousStepId == null) {

            newValidStepIdPath = nextStepId;

        } else if (String.isBlank(s.Valid_Step_Ids__c)) {

            newValidStepIdPath = previousStepId + AppConstants.ID_DELIM_CHAR + nextStepId;

        } else {

            for (String validStepId : s.Valid_Step_Ids__c.split(AppConstants.ID_DELIM_SPLIT_CHAR)) {

                newValidStepIdPath += AppConstants.ID_DELIM_CHAR + validStepId;

                if (validStepId.equalsIgnoreCase(previousStepId)) break;
            }
            newValidStepIdPath = newValidStepIdPath.removeStart(AppConstants.ID_DELIM_CHAR) + (nextStepId != null ? AppConstants.ID_DELIM_CHAR + nextStepId : '');
        }

        String historicalSteps = s.Historical_Valid_Step_Ids__c;
        String result = '';
        String previousStepIdTXT = previousStepId;
        String nextStepIdTXT = nextStepId;
        if (historicalSteps != null) {
            Boolean previousButton = false;
            if (nextStepIdTXT == null) {
                previousButton = true;
            }
            //throw new Form_CustomException(previousStepIdTXT + 'NEXT' + nextStepIdTXT + 'HISTO' + historicalSteps);
            if (previousStepIdTXT != null) {
                if (!previousButton) {
                    if (historicalSteps.contains(previousStepIdTXT)) {
                        List<String> lHist = historicalSteps.split(AppConstants.DELIM_HISTORICAL_STEP);

                        for (Integer i = 0; i <= lHist.size() - 1; i++) {
                            if (lHist[i] == previousStepIdTXT) {
                                result +=  lHist[i] + AppConstants.DELIM_HISTORICAL_STEP + (Integer.valueOf(lHist[i + 1]) + 1 ) + AppConstants.DELIM_HISTORICAL_STEP ;
                                i = i + 1;
                            } else {
                                result += lHist[i] + AppConstants.DELIM_HISTORICAL_STEP;
                            }
                        }
                        historicalSteps = result;
                        result = '';
                    } else {
                        historicalSteps += '' + previousStepIdTXT + AppConstants.DELIM_HISTORICAL_STEP + 1 + AppConstants.DELIM_HISTORICAL_STEP;
                    }
                    if (historicalSteps.contains(nextStepIdTXT)) {
                        List<String> lHist = historicalSteps.split(AppConstants.DELIM_HISTORICAL_STEP);


                        for (Integer i = 0; i <= lHist.size() - 1; i++) {
                            if (lHist[i] == nextStepIdTXT) {

                                if (Integer.valueOf(lHist[i + 1]) != 0) {
                                    result +=  lHist[i] + AppConstants.DELIM_HISTORICAL_STEP + (Integer.valueOf(lHist[i + 1]) + 1 ) + AppConstants.DELIM_HISTORICAL_STEP ;
                                    i = i + 1;
                                } else {
                                    result += lHist[i] + AppConstants.DELIM_HISTORICAL_STEP;
                                }
                            } else {
                                result += lHist[i] + AppConstants.DELIM_HISTORICAL_STEP;
                            }
                        }
                        historicalSteps = result;
                    } else {
                        historicalSteps += '' + nextStepIdTXT + AppConstants.DELIM_HISTORICAL_STEP + 0 + AppConstants.DELIM_HISTORICAL_STEP;
                    }

                }
            }
        } else {
            if (previousStepIdTXT != null) {
                historicalSteps = '' + previousStepIdTXT + AppConstants.DELIM_HISTORICAL_STEP + 1 + AppConstants.DELIM_HISTORICAL_STEP;
            }

            if (nextStepIdTXT != null) {
                if (historicalSteps == null) {
                    historicalSteps = '' + nextStepIdTXT + AppConstants.DELIM_HISTORICAL_STEP + 0 + AppConstants.DELIM_HISTORICAL_STEP;
                } else {
                    historicalSteps += '' + nextStepIdTXT + AppConstants.DELIM_HISTORICAL_STEP + 0 + AppConstants.DELIM_HISTORICAL_STEP;
                }
            }

        }

        s.Historical_Valid_Step_Ids__c = historicalSteps;
        s.Valid_Step_Ids__c = newValidStepIdPath;

        s.MultipleDirectors__c = false;

        update s;
    }


    public static Id getPreviousStepId(Id submissionId, Id currentStepId) {

        // todo - validation, error handling etc.

        Map<Id, Transaction__c> idToSubmission = new Map<Id, Transaction__c>( [select Id, Valid_Step_Ids__c from Transaction__c where Id = :submissionId ] );
        if (idToSubmission.size() == 0) return null;

        Transaction__c s = idToSubmission.values()[0];

        if (String.isBlank(s.Valid_Step_Ids__c)) {

            return null;

        } else {

            Id previousStepId;

            for (String validStepId : s.Valid_Step_Ids__c.split(AppConstants.ID_DELIM_SPLIT_CHAR)) {

                if (validStepId.equalsIgnoreCase(currentStepId)) return previousStepId;

                previousStepId = validStepId;
            }

            return null;
        }
    }
    // End Static methods.
}