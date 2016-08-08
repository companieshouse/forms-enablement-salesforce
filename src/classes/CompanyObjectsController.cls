public with sharing class CompanyObjectsController extends TransactionStepControllerBase {
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
	public String addObjects {get; set;}
	public String removeObjects {get; set;}
	public String alterObjects {get; set;}
	public String confirmObjects {get; set;}

	public CompanyObjectsController() {
		super();
		if (isPageInitialised) initialiseStep();
	}
	public void saveAddValue () {
	}
	public void saveRemoveValue () {
	}
	public void saveAlterValue () {
	}
	public void saveConfirmValue () {
	}
	public void initialiseStep() {
		companyName = submissionMgr.submission.CompanyName__c == null ? '' : submissionMgr.submission.CompanyName__c;
		companyNumber = submissionMgr.submission.CompanyNumber__c == null ? '' : submissionMgr.submission.CompanyNumber__c;
		displayText = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
		displayText2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
		displayText3 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;
		displayText4 = transactionMgr.currentStep.Display_Text_4__c == null ? '' : transactionMgr.currentStep.Display_Text_4__c;
		displayText5 = transactionMgr.currentStep.Display_Text_5__c == null ? '' :  transactionMgr.currentStep.Display_Text_5__c;
		displayText6 = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;
		headerText1 = transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c;
		headerText2 = transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c;
		headerText3 = transactionMgr.currentStep.Header_Text_3__c == null ? '' : transactionMgr.currentStep.Header_Text_3__c;
		continueButtonText = transactionMgr.currentStep.ContinueButtonText__c == null ? '' : transactionMgr.currentStep.ContinueButtonText__c;
		previousButtonText = transactionMgr.currentStep.PreviousButtonText__c == null ? '' : transactionMgr.currentStep.PreviousButtonText__c;
	}
	private void persistStep() {

		submissionMgr.persist();
	}
	public PageReference nextAction() {
		if (!validatePageState()) return Page.TransactionException;
		persistStep();
		return nextStep();
	}
	public PageReference previousAction() {
		if (!validatePageState()) return Page.TransactionException;
		return previousStep();
	}
}