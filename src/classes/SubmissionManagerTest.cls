@isTest
private class SubmissionManagerTest {

	//This methods is used to test the valid step field and historical valid step
	@isTest static void test_setValidsStep()
	{
		Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

		Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;

		Transaction_Type_Step__mdt testStep2 = CompaniesHouseTestData.getInstance().testStep2;

		Transaction_Type_Step__mdt testStep3 = CompaniesHouseTestData.getInstance().testStep3;

		Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

		Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

		Transaction__c trans;

		insert testPresenter;

		insert testCompany;

		//Initialise the Submission Manager
		SubmissionManager subMan = new SubmissionManager();

		subMan.initialise(testForm.Family__c,testPresenter.Id ,'sylvain.picory@methodsdigital.co.uk', testCompany, testForm);

		Test.startTest();

		SubmissionManager.setValidSteps(subMan.submission.Id, null, testStep1.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		List<String> histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('0', histSplit[1]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep1.Id, testStep2.Id);
		
		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[1]);
		system.assertEquals('0', histSplit[3]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep2.Id, testStep3.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep2.Id, null);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[1]);
		system.assertEquals('1', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep1.Id, null);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[1]);
		system.assertEquals('1', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep1.Id, testStep2.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('2', histSplit[1]);
		system.assertEquals('2', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep2.Id, testStep3.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('2', histSplit[1]);
		system.assertEquals('3', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		subMan.submission.Valid_Step_Ids__c = '';
		subMan.submission.Historical_Valid_Step_Ids__c = '';
		update subMan.submission;


		SubmissionManager.setValidSteps(subMan.submission.Id, testStep3.Id, testStep1.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[1]);
		system.assertEquals('0', histSplit[3]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep1.Id, testStep2.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('1', histSplit[1]);
		system.assertEquals('1', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep2.Id, testStep3.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('2', histSplit[1]);
		system.assertEquals('1', histSplit[3]);
		system.assertEquals('1', histSplit[5]);

		subMan.submission.Valid_Step_Ids__c = '';
		subMan.submission.Historical_Valid_Step_Ids__c = '';
		update subMan.submission;


		SubmissionManager.setValidSteps(subMan.submission.Id, null, testStep1.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('0', histSplit[1]);

		SubmissionManager.setValidSteps(subMan.submission.Id, testStep3.Id, testStep2.Id);

		trans = [Select Id,Historical_Valid_Step_Ids__c From Transaction__c Where Id = :subMan.submission.Id ];

		histSplit = trans.Historical_Valid_Step_Ids__c.split(AppConstants.DELIM_HISTORICAL_STEP);

		system.assertEquals('0', histSplit[1]);
		system.assertEquals('1', histSplit[3]);
		system.assertEquals('0', histSplit[5]);

		Test.stopTest();


	} 
	
}