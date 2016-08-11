/*
Name:  withdrawController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------
Controller class for the Visualforce Page: WithdrawDissolution
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-08-08  Initial development.
*/
public with sharing class withdrawController extends TransactionStepControllerBase {
	public String currentErrorMessage {
		get;
		set;
	}
	public String errorVal {
		get;
		set;
	}
	public Boolean hasPageErrors {
		get;
		set;
	}
	public Boolean confirmationVal {
		get;
		set;
	}
	public withdrawController() {
		super();
		if (isPageInitialised) initialiseStep();
	}
	private void initialiseStep() {}
	public void saveTransaction() {
		persistStep();
	}
	public void confirmWithdraw() {}
	private void persistStep() {
		submissionMgr.persist();
	}
	public void buildDocument() {
		if (submissionMgr.submission.Attachments.size() > 0) {
			try {
				Delete[Select id, name from Attachment where ParentId = : submissionMgr.submission.id];
			} catch (DmlException e) {
				System.debug('DML Error in deleting' + submissionMgr.submission.Form_Name__c + 'Error Details are' + ' ' + e.getMessage());
			} catch (Exception e) {
				System.debug('General Error in deleting' + submissionMgr.submission.Form_Name__c + 'Error Details are' + ' ' + e.getMessage());
			}
		}
		Attachment pdfAttachment = new Attachment();
		Blob pdfBlob;
		PageReference pageRef = new PageReference('/apex/' + submissionMgr.submission.Form_Name__c);
		pageRef.getParameters().put('id', submissionMgr.submission.Id);
		if (Test.IsRunningTest()) pdfBlob = Blob.valueOf('This is a test');
		else pdfBlob = pageRef.getContent();
		pdfAttachment.ParentId = submissionMgr.submission.Id;
		pdfAttachment.Name = submissionMgr.submission.Form_Name__c;
		pdfAttachment.Description = submissionMgr.submission.Form_Name__c;
		pdfAttachment.Body = pdfBlob;
		try {
			insert pdfAttachment;
		} catch (DmlException e) {
			System.debug('DML Error in inserting' + submissionMgr.submission.Form_Name__c + 'Error Details are' + ' ' + e.getMessage());
		} catch (Exception e) {
			System.debug('General Error in inserting' + submissionMgr.submission.Form_Name__c + 'Error Details are' + ' ' + e.getMessage());
		}
	}
	public PageReference nextAction() {
		if (confirmationVal == null || confirmationVal == false) {
			errorVal = 'error';
			hasPageErrors = true;
			currentErrorMessage = 'You must confirm to continue';
			return null;
		}
		submissionMgr.submission.SubmissionId__c = 'FE' + submissionMgr.submission.Id;

		FormAPISubmissionManager submissionMgrAPI = new FormAPISubmissionManager();
		submissionMgr.submission = submissionMgrAPI.sendForm(submissionMgr.submission);

		system.debug('Before save tx: ' + submissionMgr.submission);
		if (!validatePageState()) return Page.TransactionException;
		persistStep();
		return nextStep();
	}
	public PageReference previousAction() {
		if (!validatePageState()) return Page.TransactionException;
		return previousStep();
	}
}