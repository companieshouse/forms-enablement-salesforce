@isTest(SeeAllData=false)
public with sharing class CH_SearchByNumberClass_Test {
    
    public static testMethod void testmethod_CH_SearchByNumber(){
        CH_SearchControllerByNumberClass ch = new CH_SearchControllerByNumberClass();
        
        ch.CH_searchTextNumber = '12345678';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        PageReference pr = ch.CH_Search_functionByNumber();
        Test.stopTest();
        
        System.assert(ch.CH_companydetails.toString() == 'CompanyProfile:[accounts=Account:[accounting_reference_date=AccountingReferenceDate:[day=31, month=03], last_accounts=LastAccounts:[made_up_to=2014-03-31, type=audit-exemption-subsidiary], next_due=2000-01-01, next_made_up_to=2015-03-31, overdue=false], annual_return=AnnualReturn:[last_made_up_to=2015-02-14, next_due=2016-03-13, next_made_up_to=2016-02-14, overdue=false], can_file=true, company_name=TEST COMPANY LIMITED, company_number=12345678, company_status=active, company_status_detail=Test Details, date_of_creation=1900-01-01, date_of_dissolution=2000-01-01 00:00:00, etag=000000000000, has_been_liquidated=false, has_charges=false, has_insolvency_history=false, jurisdiction=england-wales, last_full_members_list_date=2000-01-01, officer_summary=OfficerSummary:[active_count=4, officers=(Officers:[appointed_on=2000-03-31, appointments=null, date_of_birth=DateOfBirth:[Day=null, Month=9, Year=1900], name=TEST COMPANY LIMITED, officer_role=corporate-secretary], Officers:[appointed_on=2000-03-31, appointments=null, date_of_birth=DateOfBirth:[Day=null, Month=9, Year=1900], name=PERSON 1, Test, officer_role=director], Officers:[appointed_on=2000-12-20, appointments=null, date_of_birth=DateOfBirth:[Day=null, Month=2, Year=1900], name=PERSON 2, Test, officer_role=director], Officers:[appointed_on=2000-12-22, appointments=null, date_of_birth=DateOfBirth:[Day=null, Month=5, Year=1900], name=PERSON 3, Test, officer_role=director]), resigned_count=13], registered_office_address=RegisteredOfficeAddress:[address_line_1=Test Line 1, address_line_2=Test Line 2, care_of=null, country=Test Country, etag=null, locality=Test Locality, po_box=1234 567, postal_code=1234 2FN, premises=Test Premises, region=Test Region], registered_office_is_in_dispute=false, sic_codes=(00000), type=ltd, undeliverable_registered_office_address=false]');
    }
    
}