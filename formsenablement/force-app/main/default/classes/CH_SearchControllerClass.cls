/*
Name:  CH_SearchControllerClass.cls
============================================================================================================
============================================================================================================
Purpose:
-------
Search API Function - Controller Class to hit web service and receive the deserialized response back
============================================================================================================
============================================================================================================

*/
public with sharing class CH_SearchControllerClass {
    
    public String resultDisplay {get;set;}  
    public String CH_searchTextName{get;set;}    
    
    public List<CompaniesHouse.CompanySearchDetails> itemsToDisplay {get;set;}
    public CompaniesHouse.CompanySearchList itemsTopLevelInfo {get;set;}
   
    CompaniesHouse.CompanySearchList jsonData = new CompaniesHouse.CompanySearchList ();
    
    //constructor
    public CH_SearchControllerClass(){
        
    }
    // Search Method that invokes getResponseGenericData() method and assigns the values to the fields to diplay in visualforce page
    public PageReference CH_Search_functionByName(){ 

	    CompaniesHouseCalloutsResponse res = new CompaniesHouseCalloutsResponse();
        CompaniesHouseCalloutsRequest req = new CompaniesHouseCalloutsRequest();
        
        resultDisplay = req.getRequestCompanyName(CH_searchTextName);
        jsonData = res.getResponseCompanySearchList(resultDisplay);

        itemsToDisplay = jsonData.items;
        itemsTopLevelInfo = jsonData;
        resultDisplay = '';
        
        return null; 
    }
}