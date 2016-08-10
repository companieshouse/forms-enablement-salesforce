/*
Name:  SCapitalController3.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: SCapitalController3

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-07  Initial development.
*/
public with sharing class SCapitalController3 extends TransactionStepControllerBase {
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
	public Boolean shareStatus {
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
	public Id shareID {
		get;
		set;
	}
	public List < Shares__c > sharesforBuilding {
		get;
		set;
	}
	public Map < String, Shares__c > shareCurrencyMap {
		get;
		set;
	}
	public List < Shares__c > matchedShares {
		get;
		set;
	}
	public Map < Integer, List < Shares__c >> viewmap {
		get;
		set;
	}
	public Map < Integer, String > viewkeys {
		get;
		set;
	}
	public Boolean showStatementofCapital {
		get;
		set;
	}
	public SCapitalController3() {
		super();
		if (isPageInitialised) initialiseStep();
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
		sharesforBuilding = new List < Shares__c > ();
		shareCurrencyMap = new map < String, Shares__c > ();
		matchedShares = new List < Shares__c > ();
		viewmap = new Map < Integer, List < Shares__c >> ();
		viewkeys = new Map < Integer, String > ();
		buildCapitalMap();
	}
	public PageReference checkstatus() {
		if (submissionMgr.submission.finishedAddingShares__c == true) {
			return nextStep();
		}
		return null;
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
		PageReference pg = new PageReference('/SCapital3');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
	public PageReference restartJourney() {
		PageReference pg = new PageReference('/SCapital1');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
	public void buildCapitalMap() {
		if (submissionMgr.submission.Shares__r.size() > 0) {
			for (Shares__c totalShares : submissionMgr.submission.Shares__r) {
				if (totalShares.SHARETYPE__c == 'STATEMENTOFCAPITAL' && totalShares.Class_of_Shares__c == submissionMgr.submission.selectShareType__c) {
					sharesforBuilding.add(totalShares);
				}
			}
			if (sharesforBuilding.size() > 0) {
				showStatementofCapital = true;
				prescribedParticular = submissionMgr.submission.prescribedParticular__c;
				shareClassType = submissionMgr.submission.selectShareType__c;
			}
		} else {
			showStatementofCapital = false;
			System.debug('you have no statement of capital to iterate over');
		}
	}
	public PageReference AddtocurrentShare() {
		submissionMgr.persist();
		return nextStep();
	}
	private void persistStep() {
		if (shareStatus != null) {
			if (!shareStatus) {
				submissionMgr.submission.finishedAddingShares__c = false;
			} else if (shareStatus) {
				submissionMgr.submission.finishedAddingShares__c = true;
			}
			submissionMgr.persist();
		}
	}
	public void confirmShares() {}
	public PageReference addmoreShares() {
		PageReference pg = new PageReference('/SCapital1');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
	public PageReference addsameShare() {
		PageReference pg = new PageReference('/SCapital2');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
	public PageReference choosePath() {
		if (!shareStatus) {
			persistStep();
			return addmoreShares();
		} else if (shareStatus) {
			return nextAction();
		} else if (String.valueOf(shareStatus) == 'undefined') {
			currentErrorMessage = '<span class="error-message">You must make a selection</span>';
			hasPageErrors = true;
			return null;
		}
		return null;
	}
	public PageReference nextAction() {
		if (!validatePageState()) return Page.TransactionException;
		persistStep();
		if (shareStatus != null) {
			if (!shareStatus) {
				return addmoreShares();
			}
		}
		
		submissionMgr.submission.finishedAttachments__c = false;
		submissionMgr.persist();
		PageReference pg = new PageReference('/Attachments');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
	public PageReference previousAction() {
		if (!validatePageState()) return Page.TransactionException;
		return previousStep();
	}
}