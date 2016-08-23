/*
Name:  nonPrescribed.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: nonPrescribed

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-11-08  Initial development.
*/
public with sharing class nonPrescribed extends TransactionStepControllerBase {
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
	public String companyName {
		get;
		set;
	}
	public String companyNumber {
		get;
		set;
	}
	//public Boolean hasPageErrors {
	//	get;
	//	set;
	//}
	//public String currentErrorMessage {
	//	get;
	//	set;
	//}

	public nonPrescribed() {
		super();
		if (isPageInitialised) initialiseStep();
	}
	public void initialiseStep() {
		displayText = transactionMgr.currentStep.Display_Text_1__c;
		displayText2 = transactionMgr.currentStep.Display_Text_2__c;
		displayText3 = transactionMgr.currentStep.Display_Text_3__c;
		displayText4 = transactionMgr.currentStep.Display_Text_4__c;
		displayText5 = transactionMgr.currentStep.Display_Text_5__c;
		displayText6 = transactionMgr.currentStep.Display_Text_6__c;
		headerText1 = transactionMgr.currentStep.Header_Text_1__c;
		headerText2 = transactionMgr.currentStep.Header_Text_2__c;
		headerText3 = transactionMgr.currentStep.Header_Text_3__c;
		companyName = submissionMgr.submission.CompanyName__c;
		companyNumber = submissionMgr.submission.CompanyNumber__c;
		continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
	}

	private void persistStep() {
		submissionMgr.persist();
	}
	public PageReference nextAction() {
		if (!validatePageState()) return Page.TransactionException;
		persistStep();
		//return nextStep();
		PageReference pg = new PageReference('/Nonprescribed2');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
	public PageReference previousAction() {
		if (!validatePageState()) return Page.TransactionException;
		//return previousStep();
		PageReference pg = new PageReference('/companyDetails');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
}