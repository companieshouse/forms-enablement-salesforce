/*
Name:  SCapitalController1.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: SCapitalController1

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-07  Initial development.
*/
public with sharing class SCapitalController1 extends TransactionStepControllerBase {
	public String companyName {
		get;
		set;
	}
	public String companyNumber {
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
	public String previousButtonText {
		get;
		set;
	}
	public String prescribedParticular {
		get;
		set;
	}
	public String shareClassType {
		get;
		set;
	}
	public Boolean rightsErrors {
		get;
		set;
	}
	public Boolean shareClassErrors {
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
	public String errorsClass {
		get;
		set;
	}
	public String errorsClass2 {
		get;
		set;
	}
	public Boolean showparticular {get; set;}
	public Boolean showShare {get; set;}
	public SCapitalController1() {
		super();
		if (isPageInitialised) initialiseStep();
	}
	public void grabShareType() {
		if (shareClassType != null) {
			System.debug('sharetype == ' + ' ' + shareClassType);
			//throw new Form_CustomException('share class type is ' +shareClassType);
		}
	}
	public void grabPrescribedParticular() {
		if (prescribedParticular != null) {
			showparticular = true;
			System.debug('sharetype == ' + ' ' + prescribedParticular);
			//throw new Form_CustomException('prescribed particular is ' +prescribedParticular);
		}
	}
	public void initialiseStep() {
		companyName = submissionMgr.submission.CompanyName__c;
		companyNumber = submissionMgr.submission.CompanyNumber__c;
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
	}
	public PageReference checkstatus() {
		if (submissionMgr.submission.finishedAddingShares__c == true) {
			return nextStep();
		}
		return null;
	}
	public void openShare() {
		showShare = true;
	}
	public void openParticular() {
		showparticular = true;
	}
	public PageReference AddtocurrentShare() {
		submissionMgr.persist();
		return nextStep();
	}
	private void persistStep() {
		if (prescribedParticular != null && shareClassType != null) {
			submissionMgr.submission.selectShareType__c = shareClassType;
			submissionMgr.submission.prescribedParticular__c = prescribedParticular;
		}
		submissionMgr.persist();
	}
	public PageReference nextAction() {

		if (shareClassType == null) {
			errorsClass = 'error';
			shareClassErrors = true;
			hasPageErrors = true;
			currentErrorMessage = 'You are missing the class of share';
			return null;
		} else if (shareClassType != null) {
			shareClassErrors = false;
			errorsClass = '';
		}
		if (prescribedParticular == null) {
			errorsClass2 = 'error';
			rightsErrors = true;
			hasPageErrors = true;
			currentErrorMessage = 'You are missing the rights attached to these shares';
			return null;
		} else if (prescribedParticular != null) {
			rightsErrors = false;
			errorsClass2 = '';
		}
		if (!validatePageState()) return Page.TransactionException;
		persistStep();
		PageReference pg = new PageReference('/SCapital2');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
		//return nextStep();
	}
	public PageReference previousAction() {
		if (!validatePageState()) return Page.TransactionException;
		return previousStep();
	}
}