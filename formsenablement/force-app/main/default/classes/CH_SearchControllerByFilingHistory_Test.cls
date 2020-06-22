/**
 * Author: Sameer
 * Reviewer: eliot.stock@methodsdigital.co.uk
 */
@isTest(SeeAllData=false)
public with sharing class CH_SearchControllerByFilingHistory_Test {
    
    // Number / Transaction ID
    public static testMethod void testmethod_CH_GetFilingHistoryController(){
        
        CH_SearchControllerByFilingHistoryClass ch = new CH_SearchControllerByFilingHistoryClass();
        
        ch.CH_searchTextNumber = '00000000';
        ch.CH_searchTrans ='AABCMjk34FG1N2FkaXF6a2N4';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());  
        PageReference pr = ch.CH_Search_functionByFilingHistory();
        
        Test.stopTest();
        System.assert(ch.itemsResult.toString() == 'FilingHistoryDetails:[action_date=null, annotations=(Annotation:[annotation=Test, chDate=2000-01-01 00:00:00, description=Test Description]), associated_filings=(AssociatedFiling:[chDate=2000-01-01, description=Test Description, type=Test Type]), barcode=123456, category=insolvency, chDate=2013-03-13 00:00:00, description=liquidation-voluntary-cease-to-act-as-liquidator, links=Links:[chCase=null, charge=null, document_metadata=https://document-api.companieshouse.gov.uk/document/1, filing=null, insolvency_case=null, officer=null, self=/company/1234567/filing-history/2000], pages=1, paper_filed=true, resolutions=(Resolution:[category=Test, description=Test Description, document_id=1234, receive_date=2000-01-01 00:00:00, subcategory=null, type=Test Type]), subcategory=voluntary, transaction_id=1000, type=4.40]');
    }
    
    // Number / Category
    public static testMethod void testmethod_CH_ListFilingHistoryController(){
        CH_SearchControllerByFilingHistoryClass ch = new CH_SearchControllerByFilingHistoryClass();
        
        ch.CH_searchTextNumber = '00000000';
        ch.CH_searchCategory='Test';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());  
        PageReference pr = ch.CH_Search_functionByFilingHistory();
        
        Test.stopTest();
        System.assert(ch.itemsTopLevelInfo.toString() == 'FilingHistoryList:[etag=jkh3k24jh23kj4hjkh, filing_history_status=Test Status, items=(FilingHistoryDetails:[action_date=null, annotations=(Annotation:[annotation=Test, chDate=2000-01-01 00:00:00, description=Test Description]), associated_filings=null, barcode=12345, category=Test Category, chDate=2000-01-01 00:00:00, description=Test Description, links=null, pages=1, paper_filed=true, resolutions=(Resolution:[category=liquidation, description=Test Description, document_id=null, receive_date=null, subcategory=(resolution), type=ABCDEF]), subcategory=Test SubCategory, transaction_id=123456, type=Test Type]), items_per_page=12, kind=Test Kind, start_index=1, total_count=1]');
    }
    
}