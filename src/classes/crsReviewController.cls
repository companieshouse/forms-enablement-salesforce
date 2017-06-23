/*
Name:  crsReviewController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: CRSREVIEW

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-08-08  Initial development.
*/
public with sharing class crsReviewController extends TransactionStepControllerBase {
	public String companyName {
		get;
		set;
	}
	public String companyNumber {
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
	public Boolean hasPageErrors {
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
	public Date shareChangeDate {
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
	public String selectedNotice {
		get;
		set;
	}
	public String classofshares {
		get;
		set;
	}
	public List < Shares__c > sharesforBuilding {
		get;
		set;
	}
	public Map < Integer, List < Shares__c >> viewmap {
		get;
		set;
	}
	public List < Shares__c > matchedShares {
		get;
		set;
	}
	public Map < Integer, String > viewkeys {
		get;
		set;
	}
	public Map < String, Shares__c > shareClassMap {
		get;
		set;
	}
	public Id shareID {get; set;}
	public String errorVal1 {get; set;}
	public String errormessage1 {get; set;}

	public crsReviewController() {
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
		previousButtonText = transactionMgr.currentStep.PreviousButtonText__c;
		selectedNotice = submissionMgr.submission.shareChangeSelection__c;
		classofshares = submissionMgr.submission.shareClassSelection__c;
		currentShares = new List < Shares__c > ();
		sharesforBuilding = new List < Shares__c > ();
		viewmap = new Map < Integer, List < Shares__c >> ();
		matchedShares = new List < Shares__c > ();
		viewkeys = new Map < Integer, String > ();
		shareClassMap = new map < String, Shares__c > ();
		sharesforBuilding = submissionMgr.submission.Shares__r;
		buildInverseCapitalMap();
	}
	public PageReference goForward() {
		if (submissionMgr.submission.finishedPart1__c == true) {
			return nextStep();
		}
		return null;
	}
	public void buildInverseCapitalMap() {
		if (sharesforBuilding.size() > 0) {
			for (Shares__c shareclasslimiter : sharesforBuilding) {
				shareClassMap.put(shareclasslimiter.SHARETYPE__c, shareclasslimiter);
			}
			List < String > listKeys2 = new List < String > (shareClassMap.keyset());
			for (Integer i = 0; i < listKeys2.size(); i++) {
				matchedShares = new List < Shares__c > ();
				for (Shares__c buildShares : sharesforBuilding) {
					if (buildShares.SHARETYPE__c == listKeys2.get(i) && buildShares.SHARETYPE__c != 'STATEMENTOFCAPITAL'  ) {
						matchedShares.add(buildShares);
						viewmap.put(i, matchedShares);
						viewkeys.put(i, buildShares.SHARETYPE__c);
					}
				}
			}
			if (matchedShares.size() > 0) {
				showTable = true;
			}
		} else {
			System.debug('you have no statement of capital to iterate over');
		}
	}
	private void persistStep() {
		submissionMgr.submission.finishedPart1__c = true;
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
		if (varYear == null || String.valueOf(varyear).length() < 4 ) {
			hasPageErrors = true;
			errorVal1 = 'error';
			errormessage1 = 'Year is too short';
			return null;
		}
		if (varYear < 1700 ) {
			hasPageErrors = true;
			errorVal1 = 'error';
			errormessage1 = 'Please enter the correct Year after 1700';
			return null;
		}
		shareChangeDate = Date.newInstance(varYear, varMonth, varDay);
		//Date savedDate = shareChangeDate.date();

		//shareChangeDate.format('dd MMMMM yyyy');
		if (shareChangeDate > Date.Today()) {
			hasPageErrors = true;
			errorVal1 = 'error';
			errormessage1 = 'Date must not be in the future';
			return null;
		}
		List<shares__c> sharestoSave = new List<Shares__c>();
		for (Shares__c sharestoAddDatesto : submissionMgr.submission.Shares__r) {
			if (sharestoAddDatesto.SHARETYPE__c == selectedNotice) {
				sharestoAddDatesto.Date__c = shareChangeDate;
				sharestoSave.add(sharestoAddDatesto);
			}
		}
		update sharestoSave;
		// persist and save if validaiton passes
		if (!validatePageState()) return Page.TransactionException;
		persistStep();
		PageReference pg = new PageReference('/SCapital1');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
	public PageReference deleteShare() {

		if (shareID != null) {
			persistStep();

			try {
				List < Shares__c > deletedrecord = [SELECT Id, Name, Currency__c From Shares__c where ID = : shareID];
				//throw new Form_CustomException('record you are deleting is' + deletedrecord);
				delete deletedrecord[0];
			} catch (DmlException e) {
				System.debug('DML Error with ' + e.getMessage());
			} catch (Exception e) {
				System.debug('DML Error with ' + e.getMessage());
			}

			PageReference pg = new PageReference('/CRS');
			pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
			pg.setRedirect(true);
			return pg;
		}
		return null;
	}
	public PageReference changeMoreShares() {
		if (!validatePageState()) return Page.TransactionException;
		PageReference pg = new PageReference('/CRS');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
}