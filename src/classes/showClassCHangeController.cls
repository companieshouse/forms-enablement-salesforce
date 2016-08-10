/*
Name:  showClassCHangeController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: showClassCHange

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-06  Initial development.
*/
public with sharing class showClassCHangeController extends TransactionStepControllerBase {
	public String classofshares {
		get;
		set;
	}
	public String classofsharesNew {
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
	public Boolean hasPageErrors {
		get;
		set;
	}
	public String currentErrorMessage {
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
	public List < Shares__c > currentShares {
		get;
		set;
	}
	public Boolean showTable {
		get;
		set;
	}
	public Id shareID {get; set;}

	public String previousButtonText {get; set;}

	public Datetime sharechangeDate {
		get;
		set;
	}
	public Integer varDay {
		get;
		set;
	}
	public Integer varYear {
		get;
		set;
	}
	public Integer varMonth {
		get;
		set;
	}
	public String errorVal1 {get; set;}
	public String errormessage1 {get; set;}
	public showClassCHangeController() {
		super();
		if (isPageInitialised) initialiseStep();
	}
	public void initialiseStep() {
		//throw new Form_CustomException(' ERror here ');
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
		previousButtonText = transactionMgr.currentStep.PreviousButtonText__c;
		showShares();
	}
	public void showShares() {
		if (submissionMgr.submission.Shares__r.size() > 0) {
			showTable = true;
			currentShares = submissionMgr.submission.Shares__r;
		} else {
			showTable = false;
		}
	}

	public PageReference deleteShare() {
		try {
			List < Shares__c > deletedrecord = [SELECT Id, Name, Currency__c From Shares__c where ID = : shareID];
			//throw new Form_CustomException('record you are deleting is' + deletedrecord);
			delete deletedrecord[0];
		} catch (DmlException e) {
			System.debug('DML Error with ' + e.getMessage());
		} catch (Exception e) {
			System.debug('DML Error with ' + e.getMessage());
		}
		return previousAction();
	}
	private void persistStep() {
		submissionMgr.persist();
	}

	public PageReference nextAction() {
		if (varDay == null || varDay == 0 || varDay > 31) {
			hasPageErrors = true;
			errorVal1 = 'error';
			errormessage1 = 'Please enter the correct day';
			return null;
		}
		if (varMonth == null || varMonth == 0 || varMonth > 12) {
			hasPageErrors = true;
			errorVal1 = 'error';
			errormessage1 = 'Please enter the correct Month';
			return null;
		}
		if (varYear == null || varyear == 0 ) {
			hasPageErrors = true;
			errorVal1 = 'error';
			errormessage1 = 'Please enter the correct Year';
			return null;
		}
		Datetime sharechangeDate = Datetime.newInstance(varYear, varMonth, varDay);
		sharechangeDate.format('dd MMMMM yyyy');
		if (sharechangeDate > Date.Today()) {
			hasPageErrors = true;
			errorVal1 = 'error';
			errormessage1 = 'Date must not be in the future';
			return null;
		}
		Date savedDate = sharechangeDate.date();
		List<shares__c> sharestoSave = new List<Shares__c>();
		for (Shares__c sharestoAddDatesto : submissionMgr.submission.Shares__r) {
			if (sharestoAddDatesto.SHARETYPE__c == submissionMgr.submission.Form_Name__c) {
				sharestoAddDatesto.Date__c = savedDate;
				sharestoSave.add(sharestoAddDatesto);
			}
		}
		update sharestoSave;
		// persist and save if validaiton passes
		if (!validatePageState()) return Page.TransactionException;
		persistStep();
		return nextStep();
	}
	public PageReference previousAction() {
		if (!validatePageState()) return Page.TransactionException;
		return previousStep();
	}
}