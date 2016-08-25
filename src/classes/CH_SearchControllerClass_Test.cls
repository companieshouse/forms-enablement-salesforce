@isTest(SeeAllData=false)
public with sharing class CH_SearchControllerClass_Test {
    
    public static testMethod void testmethod_CH_Search(){
        CH_SearchControllerClass ch = new CH_SearchControllerClass();
        ch.CH_searchTextName = 'test company';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        PageReference pr =  ch.CH_Search_functionByName();
        
        Test.stopTest();
      
        //System.assert(ch.itemsTopLevelInfo.toString() == 'CompanySearchList:[etag=123123123, items=(CompanySearchDetails:[address=RegisteredOfficeAddress:[address_line_1=Test Line 1, address_line_2=Test Line 2, care_of=Test Care Of, country=Test Country, etag=null, locality=Test Locality, po_box=1234 567, postal_code=1234 567, premises=Test Premises, region=Test Region], company_number=12345678, company_status=active, company_type=ltd, date_of_creation=1900-01-01, description=Test Description, description_identifier=(incorporated-on), kind=searchresults#company, markdown_description=1900-01-01 00:00:00, markdown_title=TEST COMPANY LIMITED, snippet=Test Snippet, title=TEST COMPANY LIMITED, url=/company/12345678]), items_per_page=20, kind=searchresults, page_number=1, start_index=0, total_results=1]');
    }
    
}