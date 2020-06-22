@isTest(SeeAllData=false)
public with sharing class CH_SearchControllerByInsolvency_Test {
    
    public static testMethod void testmethod_CH_Insolvency(){	
        CH_SearchControllerByInsolvencyClass ch = new CH_SearchControllerByInsolvencyClass();
        
		ch.CH_searchTextNumber = '12345678';        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        PageReference pr =  ch.CH_Search_functionByInsolvency();
        
        Test.stopTest();
        
        System.assert(ch.topItems.toString() == 'CompanyInsolvency:[cases=(chCase:[case_number=null, chNumber=1, dates=(Dates:[chDate=2006-02-14, type=wound-up-on]), links=Links:[chCase=null, charge=Test Charge, document_metadata=null, filing=null, insolvency_case=null, officer=null, self=null], notes=(Test Notes), practitioners=(Practitioners:[address=RegisteredOfficeAddress:[address_line_1=TEST & COMPANY, address_line_2=000 Test Street, care_of=null, country=null, etag=null, locality=London, po_box=null, postal_code=ABC 2DE, premises=null, region=null], appointed_on=2000-02-14, ceased_to_act_on=2000-03-11, name=Test Test, role=practitioner]), transaction_id=null, type=creditors-voluntary-liquidation]), etag=asjdaskd3e342, status=(liquidation)]');
    }
   
}