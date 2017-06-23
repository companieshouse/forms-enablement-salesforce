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
public with sharing class OfficersQueryAction_Test {



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


}