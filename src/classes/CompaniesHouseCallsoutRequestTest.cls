/**
 * Author: Sameer
 * Reviewer: eliot.stock@methodsdigital.co.uk
 */
@isTest(SeeAllData = true)
public with sharing class CompaniesHouseCallsoutRequestTest {
    
    // Search by Name
    public static testMethod void testmethod_CH_SearchByName(){
        CompaniesHouseCalloutsRequest ch = new CompaniesHouseCalloutsRequest();
        String CH_search = 'Test Company';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        String res = ch.getRequestCompanyName(CH_search);
        Test.stopTest();
        
        System.assert(res != null);
    }
    
    // Search company profile by number
    public static testMethod void testmethod_CH_CompanyProfile(){
        CompaniesHouseCalloutsRequest ch = new CompaniesHouseCalloutsRequest();
        String CH_searchTextNumber = '12345678';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        String res  = ch.getRequestCompanyNumber(CH_searchTextNumber);
        Test.stopTest();
        
        System.assert(res != null);
    }
    
    // Registered Address
    public static testMethod void testmethod_CH_RegisteredAddress(){
        CompaniesHouseCalloutsRequest ch = new CompaniesHouseCalloutsRequest();
        String CH_searchTextNumber = '12345678';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        String res = ch.getRequestRegisteredAddress(CH_searchTextNumber);
        Test.stopTest();
        
        System.assert(res != null);
    }

	// Insolvency
    public static testMethod void testmethod_CH_Insolvency(){
        CompaniesHouseCalloutsRequest ch = new CompaniesHouseCalloutsRequest();
        String CH_searchTextNumber = '12345678';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        String res = ch.getRequestInsolvency(CH_searchTextNumber);
        Test.stopTest();
        
        System.assert(res != null);
    }
    
    // Officers List
    public static testMethod void testmethod_CH_OfficerList(){
        CompaniesHouseCalloutsRequest ch = new CompaniesHouseCalloutsRequest();
        String CH_searchTextNumber = '12345678';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        String res = ch.getRequestOfficersList(CH_searchTextNumber);
        Test.stopTest();
        
        System.assert(res != null);
    }
    
    // Get Filing History
    public static testMethod void testmethod_CH_GetFilingHistoryController(){
        CompaniesHouseCalloutsRequest ch = new CompaniesHouseCalloutsRequest();
        String CH_searchTextNumber = '00000000';
        
        String CH_searchTrans='AABCMjk34FG1N2FkaXF6a2N4';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        String res = ch.getRequestFilingHistoryTransaction( CH_searchTextNumber, CH_searchTrans);
        Test.stopTest();
        
        System.assert(res != null);
    }
    
    // List Filing History
    public static testMethod void testmethod_CH_ListFilingHistoryController(){
        
        CompaniesHouseCalloutsRequest ch = new CompaniesHouseCalloutsRequest();
        String CH_searchTextNumber = '00000000';
        String CH_searchCategory   = 'Test';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        String res = ch.getRequestFilingHistoryList( CH_searchTextNumber, CH_searchCategory);
        Test.stopTest();
        
        System.assert(res != null);
        
    }
    
    // Get Charges
    public static testMethod void testmethod_CH_GetChargeController(){
        CompaniesHouseCalloutsRequest ch = new CompaniesHouseCalloutsRequest();
        String CH_searchTextNumber = '12345678';
        String CH_chargeParam   = 'h23j4h23k23h4jh3';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        String res = ch.getRequestChargeHistory( CH_searchTextNumber, CH_chargeParam);
        Test.stopTest();
        
        System.assert(res != null);
    }

    // List Charges
    public static testMethod void testmethod_CH_ListChargeController(){
        CompaniesHouseCalloutsRequest ch = new CompaniesHouseCalloutsRequest();
        String CH_searchTextNumber = '12345678';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        String res = ch.getRequestChargeHistoryList( CH_searchTextNumber);
        Test.stopTest();
        
        System.assert(res != null);
    }
    
}