/*
Name:  SCapitalController2.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: SCapitalController2

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-07  Initial development.
*/
public with sharing class SCapitalController2 extends TransactionStepControllerBase {
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
	public String prescribedParticular {get; set;}
	public String shareClassType {get; set;}
	public String currencyType {get; set;}
	public Decimal numberofshares {get; set;}
	public Decimal nominalvalue {get; set;}
	public Boolean hasPageErrors {get; set;}
	public String currentErrorMessage {get; set;}
	public Decimal aggUnpaid {get; set;}
	public SCapitalController2() {
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
		shareClassType = submissionMgr.submission.selectShareType__c;
		prescribedParticular = submissionMgr.submission.prescribedParticular__c;
		checkstatus();
	}
	public PageReference checkstatus () {
		if (submissionMgr.submission.finishedAddingShares__c == true) {
			return nextStep();
		}
		return null;
	}
	public PageReference AddtocurrentShare() {
		submissionMgr.persist();
		return nextStep();
	}
	private void persistStep() {
		submissionMgr.persist();
	}
	public PageReference addnewShares() {
		if (currencyType == null) {
			hasPageErrors = true;
			currentErrorMessage = 'Must add the share currency';
			return null;
		}
		if (numberofshares == 0 || numberofshares == null) {
			hasPageErrors = true;
			currentErrorMessage = 'Must add the number of shares';
			return null;
		}
		//throw new Form_CustomException('agg nominal value is ' + nominalvalue);
		if (nominalvalue == 0 || nominalvalue == null) {
			hasPageErrors = true;
			currentErrorMessage = 'Aggregate nominal value must be greater than 0';
			return null;
		}
		if (aggUnpaid > 0) {
			hasPageErrors = true;
			currentErrorMessage = 'numeric';
		}
		//if (aggUnpaid == 0 || aggUnpaid == null)  {
		//    hasPageErrors = true;
		//    currentErrorMessage = 'Must add the  total amount unpaid on each share (if any)';
		//    return null;
		//}
		List < Shares__c > sharesToAdd = new List < Shares__c > ();
		try {
			sharesToAdd.add(new Shares__c(Total_aggregate_amount_unpaid__c = aggUnpaid, Aggregate_nominal_value__c = nominalvalue, Number_of_Shares__c = numberofshares, Currency__c = currencyType, SHARETYPE__c = 'STATEMENTOFCAPITAL', Prescribed_Particulars__c = prescribedParticular , Name = shareClassType, Transaction__c = submissionMgr.submission.Id, Class_of_Shares__c = shareClassType, ActiveData__c = true));
			insert sharesToAdd;
		} catch (DmlException e) {System.debug('DML error =' + ' ' + e.getMessage());} catch (Exception e) {System.debug('Exception =' + ' ' + e.getMessage());}

		PageReference pg = new PageReference('/SCapital3');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;

	}
	public void grabCurrencyType () {
		//throw new Form_CustomException('here is the currency type'+ currencyType);
	}
	public void grabnumberOfShares () {
		//throw new Form_CustomException('here is the number of shares '+ numberofshares);

	}
	public void grabAggNomValue () {
		//throw new Form_CustomException('here is the nominal value '+ nominalvalue);

	}
	public void grabAggUnpaid () {
		//throw new Form_CustomException('here is the agg unpaid '+ aggUnpaid);

	}

	public PageReference addsameShare() {

		PageReference pg = new PageReference('/SCapital2');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
	public PageReference nextAction() {


		if (!validatePageState()) return Page.TransactionException;
		persistStep();
		return nextStep();
	}
	public PageReference previousAction() {
		if (!validatePageState()) return Page.TransactionException;
		PageReference pg = new PageReference('/SCapital1');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
}