/*
Name:  CH_SearchControllerByRegAddressClass.cls
============================================================================================================
============================================================================================================
Purpose:
-------
Registered Address API Function - Controller Class to hit web service and receive the deserialized response back
============================================================================================================
============================================================================================================
*/

public with sharing class CH_SearchControllerByRegAddressClass {
    
    public String resultDisplay {get;set;}  
    public String CH_searchTextNumber{get;set;}    
    public CompaniesHouse.RegisteredOfficeAddress itemsToDisplay {get;set;}
    
    //Registered Address API
    public PageReference CH_Search_functionByRegAddress(){
        
        CompaniesHouseCalloutsRequest req = new CompaniesHouseCalloutsRequest();
        CompaniesHouseCalloutsResponse res = new CompaniesHouseCalloutsResponse();
        CompaniesHouse.RegisteredOfficeAddress jsonData = new CompaniesHouse.RegisteredOfficeAddress ();
        
        resultDisplay = req.getRequestRegisteredAddress(CH_searchTextNumber);
        jsonData = res.getResponseRegisteredOfficeAddress(resultDisplay);
        itemsToDisplay = jsonData;
        
        return null; 
    } 
    
}