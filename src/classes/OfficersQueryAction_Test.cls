/**
 * Test Class for OfficersQueryAction
 *
 * Unit Test:
 * - no active Director Officers
 *
 * To Do: Update mock to return a company with multiple active Directors.
 * 
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/
@isTest(SeeAllData=false)
public class OfficersQueryAction_Test {

	public static testMethod void getOfficers_Test() {
		List<String> inputList = new List<String>();
		List<String> returnList;

		Transaction__c trans = createTransaction();

		Test.startTest();
		inputList.add(trans.Id);
        Test.setMock(HttpCalloutMock.class, new ChApiMock());

		returnList = OfficersQueryAction.getOfficers(inputList);

		System.assertEquals(1, returnList.size()); 
		System.assertEquals('', returnList.get(0)); //mock generator is returning 0 current Officers
		System.debug(returnList);
		Test.stopTest();
	}

	public static testMethod void getOfficersByCompanyNumber_Test() {
		String companyNumber = '00000000';

		String officerList = ChApiMock.OFFICERS_LIST;

		//Initialise the data
		CompaniesHouseCalloutsResponse resp = new CompaniesHouseCalloutsResponse();
		List<CompaniesHouse.OfficerDetails> directorDetailsListExpected = resp.getResponseOfficerList(officerList).items;

		Test.startTest();
		
        Test.setMock(HttpCalloutMock.class, new ChApiMock());

		List<CompaniesHouse.OfficerDetails> directorDetailsList = OfficersQueryAction.getOfficers(companyNumber);
		System.assertEquals(1, directorDetailsList.size()); 
		System.assertEquals(directorDetailsListExpected + '' , directorDetailsList + ''); //We use dynamic casting 
		Test.stopTest();
	}

	/**************** Aux ****************/
	private static Transaction__c createTransaction() {
		Transaction__c trans = new Transaction__c();
		trans.CompanyName__c = 'Test Company';
		trans.CompanyNumber__c = '00000000';
		trans.Status__c = 'Draft';
		insert trans;

		return trans;
	}
}