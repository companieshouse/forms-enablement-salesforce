/*
Name:  SubmitTransactionFormButton.cls
Copyright © 2017  Ribbonfish LTD
======================================================
======================================================
Purpose:
-------

This button will be used to submit back an Transaction whenever it is pressed

======================================================
======================================================
History
------- 
Ver. Author            Date        Detail
1.0  Sylvain Picory    2017-05-26  Initial draft of code.
*/
public with sharing class SubmitTransactionFormButton {

	private ApexPages.StandardController standardController;

	public SubmitTransactionFormButton(ApexPages.StandardController stdController) {
		this.standardController = stdController;
	}

	public Pagereference initButton()
	{
		Id profileID = UserInfo.getProfileId();

		Profile prof = [Select Id, Name From Profile where Id = :profileID];
		
		Id transactionID = standardController.getId();

		if(!prof.Name.equals('System Administrator'))
			return new Pagereference('/' + transactionID);		

		Transaction__c submission = [select Session_Log__c,PrePaymentIntegrationStatus__c, AmendmentHistory__c, SentreviewURL__c,isSignout__c,AccountAuthorisationCode__c ,shareChangeSelection__c, shareClassSelection__c, errors__c, errorsMessage__c, finishedPart1__c, finishedAttachments__c, prescribedParticular__c, selectShareType__c, Transaction_Type__c, CompanyType__c, Company__r.CompanyNumber__c, CompanyStatus__c, CompanyIncorporationDate__c, officerTerminology__c, isLtdPlc__c, isLP__c, submissionDate__c, submissionTime__c, paymentDate__c, containsPackage__c, Product_Code__c, paymentReference__c, isPaymentAccount__c, isPaymentCard__c, isPaymentPaypal__c, AccountNumber__c, hasPromoter__c, Version_Form__c, Presenter__r.PersonEmail, Company__c, Company__r.Name, Company__r.Id, ApplicationDate__c, trueTransactionName__c, isSigningFinished__c, isDigitalSignatureNeeded__c, isSigningStarted__c, sharecurrencyselection__c, Barcode__c, isBehalfSignatoryEnable__c, isPresenterMultipleDirectors__c, SoleDirectorPresenter__c, OfficerCount__c, hasPaid__c, isPaymentRequired__c, CompanyLocality__c, CompanyCountry__c, CompanyPostCode__c, CompanyRegion__c, CompanyAddress1__c, CompanyAddress2__c, Id, Form_Name__c, Presenter__c, ExpiryDate__c, Presenter__r.Name, isMajorityRequired__c, Expiry_Date_Length__c,
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
                                     from Transaction__c where Id = :transactionID];
		
		FormAPISubmissionManager submissionMgrAPI = new FormAPISubmissionManager();
        if(submission.Form_Name__c.contains('DS02'))
        {
            submission = submissionMgrAPI.sendForm(submission);
        }
        else{
            if(submission.PrePaymentIntegrationStatus__c == AppConstants.REQUEST_STATUS_SUBMITTED)
                submission = submissionMgrAPI.updatePayment(submission);
            else if(submission.PrePaymentIntegrationStatus__c == AppConstants.REQUEST_STATUS_ERROR)
            {
                submission = submissionMgrAPI.sendForm(submission);
                submission = submissionMgrAPI.updatePayment(submission);
            }
                
        }
        
        submission.AmendmentHistory__c += '<br/>-----------------------------------------------------------------------------------';
        submission.AmendmentHistory__c += '<br/> Number Of Call static (Integration Page Fail): ' + FormsApiClient.numberOfTimeCalled;
        submission.AmendmentHistory__c += '<br/>-----------------------------------------------------------------------------------';
        
		submission.submissionTime__c = String.valueOf(system.now().time());
        submission.submissionDate__c = String.valueOf(system.today().format());
		Database.update(submission.Attachments);
		Database.update(submission.Officers__r);
		Database.update(submission);

		return new Pagereference('/' + transactionID);
	}	
}