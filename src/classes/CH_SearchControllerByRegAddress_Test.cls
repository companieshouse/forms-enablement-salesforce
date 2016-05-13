@isTest(SeeAllData=true)
public with sharing class CH_SearchControllerByRegAddress_Test {
    
     public static testMethod void testmethod_CH_RegAddress(){
         CH_SearchControllerByRegAddressClass ch  = new CH_SearchControllerByRegAddressClass();
         ch.CH_searchTextNumber  = '47853469';
         
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new ChApiMock());
         PageReference pr = ch.CH_Search_functionByRegAddress();

         test.stopTest();
         
         system.assertEquals(ch.itemsToDisplay.toString(), 'RegisteredOfficeAddress:[address_line_1=16 St. Martins Le Grand, address_line_2=Test Line 2, care_of=null, country=Test Country, etag=j234kj3h2kjhjk, locality=London, po_box=123456, postal_code=EC1A 4EN, premises=Test Premises, region=Test Region]');
     }
    
}