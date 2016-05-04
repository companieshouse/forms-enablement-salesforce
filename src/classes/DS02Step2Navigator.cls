/*
Name:  DS02Step2Navigator.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Implements framework interface IStepNavigable.
Applies custom logic specifically for DS02 step2.

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class DS02Step2Navigator implements IStepNavigable {
	
	public Id getNextStepIdByApex(Id submissionId) {
		
		// todo - Load submission - check state and return appropriate step page reference.
		SubmissionManager submissionMgr = new SubmissionManager(submissionId);
		    	
		return submissionMgr.submission.Warning_Confirmation_Flag__c ? 'm01580000004HFk' : 'm01580000004GlJ';
		
	}
}