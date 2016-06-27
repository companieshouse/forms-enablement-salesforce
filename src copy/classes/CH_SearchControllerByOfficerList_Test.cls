@isTest(SeeAllData=true)
public with sharing class CH_SearchControllerByOfficerList_Test {
    
    public static testMethod void testmethod_CH_OfficerList(){
        CH_SearchControllerByOfficerListClass ch = new CH_SearchControllerByOfficerListClass();
       
        ch.CH_searchTextNumber = '12345678';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        PageReference pr = ch.CH_Search_functionByOfficerList();
        Test.stopTest();
        
        system.assertEquals(ch.itemsToDisplayTopLevel.toString(), 'OfficerList:[active_count=1, etag=ac025c92a30a972ef72b22782244aa99c6c6297f, items=(OfficerDetails:[address=RegisteredOfficeAddress:[address_line_1=Test Line 1, address_line_2=Test Line 2, care_of=Test Care of, country=Test Country, etag=null, locality=Test Locality, po_box=123 456, postal_code=123 7BG, premises=Test Premises, region=Test Region], appointed_on=1992-04-15, country_of_residence=Test, date_of_birth=DateOfBirth:[Day=1, Month=9, Year=1900], links=Links:[chCase=null, charge=null, document_metadata=null, filing=null, insolvency_case=null, officer=Officers:[appointed_on=null, appointments=/officers/63pi9RxHCq3C3Lhp4pDRMN8u53g/appointments, date_of_birth=null, name=null, officer_role=null], self=null], name=PEETT, Edward John, nationality=British, occupation=Company Director, officer_role=director, resigned_on=1997-01-01 00:00:00]), items_per_page=35, kind=officer-list, links=Links:[chCase=null, charge=null, document_metadata=null, filing=null, insolvency_case=null, officer=null, self=/company/12345678/appointments], resigned_count=13, start_index=1, total_results=17]');
    }
    
}