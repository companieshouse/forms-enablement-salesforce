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
	public String maincurrentErrorMessage {
		get;
		set;
	}
	public String errorsClass {
		get;
		set;
	}
	public Boolean addObjects {
		get;
		set;
	}
	public Boolean removeObjects {
		get;
		set;
	}
	public Boolean alterObjects {
		get;
		set;
	}
	public Boolean confirmObjects {
		get;
		set;
	}
	public String errorVal {
		get;
		set;
	}
	public String mainErrorVal {
		get;
		set;
	}
	public CompanyObjectsController() {
		super();
		if (isPageInitialised) initialiseStep();
	}
	public void saveAddValue() {
		//throw new Form_CustomException('add ==' + addObjects);
	}
	public void saveRemoveValue() {
		//throw new Form_CustomException('remove ==' + removeObjects);
	}
	public void saveAlterValue() {
		//throw new Form_CustomException('alter ==' + alterObjects);
	}
	public void saveConfirmValue() {
		//throw new Form_CustomException('confirm ==' + confirmObjects);
	}
	public void initialiseStep() {
		companyName = submissionMgr.submission.CompanyName__c == null ? '' : submissionMgr.submission.CompanyName__c;
		companyNumber = submissionMgr.submission.CompanyNumber__c == null ? '' : submissionMgr.submission.CompanyNumber__c;
		displayText = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
		displayText2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
		displayText3 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;
		displayText4 = transactionMgr.currentStep.Display_Text_4__c == null ? '' : transactionMgr.currentStep.Display_Text_4__c;
		displayText5 = transactionMgr.currentStep.Display_Text_5__c == null ? '' : transactionMgr.currentStep.Display_Text_5__c;
		displayText6 = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;
		headerText1 = transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c;
		headerText2 = transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c;
		headerText3 = transactionMgr.currentStep.Header_Text_3__c == null ? '' : transactionMgr.currentStep.Header_Text_3__c;
		continueButtonText = transactionMgr.currentStep.ContinueButtonText__c == null ? '' : transactionMgr.currentStep.ContinueButtonText__c;
		previousButtonText = transactionMgr.currentStep.PreviousButtonText__c == null ? '' : transactionMgr.currentStep.PreviousButtonText__c;
	}
	private void persistStep() {
		submissionMgr.submission.finishedpart1__c = true;
		submissionMgr.persist();
	}
	public PageReference nextAction() {
		if (alterObjects == null && removeObjects == null && addObjects == null) {
			hasPageErrors = true;
			maincurrentErrorMessage = 'Please select the type of object notification';
			currentErrorMessage = '';
			errorVal = '';
			mainErrorVal = 'error';
			return null;
		}
		if (confirmObjects == null || confirmObjects == false) {
			hasPageErrors = true;
			currentErrorMessage = 'Please confirm to continue';
			maincurrentErrorMessage = '';
			mainErrorVal = '';
			errorVal = 'error';
			return null;
		}

		alterObjects = alterObjects == null ? false : true;
		addObjects = addObjects == null ? false : true;
		removeObjects = removeObjects == null ? false : true;
		//find prevous company objects  and delete them - shares should already be in the submission manager
		// this component only allows one object to be sent
		if (submissionMgr.submission.Shares__r.size() > 0) {

			try {
				System.debug('Inserting Shares now');
				Delete [select ID, Name, SHARETYPE__c from Shares__c where Transaction__c = :submissionMgr.submission.Id];
			} catch (DmlException e) {
				System.debug('DML Exception' + e.getMessage());
			} catch (Exception e) {
				System.debug('General Exception' + e.getMessage());
			}
		}

		Shares__c newShare = new Shares__c(Transaction__c = submissionMgr.submission.Id, SHARETYPE__c = 'COMPANYOBJECTS', addingObjects__c = addObjects, removeObjects__c = removeObjects, alterObjects__c = alterObjects, ActiveData__c = TRUE);
		try {
			System.debug('Inserting Shares now');
			insert newShare;
		} catch (DmlException e) {
			System.debug('DML Exception' + e.getMessage());
		} catch (Exception e) {
			System.debug('General Exception' + e.getMessage());
		}
		System.debug('Shares save successful');

		if (!validatePageState()) return Page.TransactionException;
		persistStep();
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