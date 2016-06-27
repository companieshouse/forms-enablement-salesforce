/*
Name:  CH_SearchControllerByNumberClass.cls
============================================================================================================
============================================================================================================
Purpose:
-------
Company Profile API Function - Controller Class to hit web service and receive the deserialized response back
============================================================================================================
============================================================================================================
*/

public with sharing class CH_SearchControllerByNumberClass {
    
    public String resultDisplay {get;set;}  
    public String CH_searchTextNumber{get;set;}
    
    public CompaniesHouse.Account itemsToDisplay1 {get;set;}
    public CompaniesHouse.CompanyProfile CH_companydetails {get; set;}
    public CompaniesHouse.RegisteredOfficeAddress CH_OfficeDetails {get; set;}
    public CompaniesHouse.OfficerSummary CH_OfficerSummary {get;set;}
    public CompaniesHouse.AnnualReturn CH_AnnualReturn {get;set;}
    
    
    public CH_SearchControllerByNumberClass(){
        
    }
    
    //Search Method
    public PageReference CH_Search_functionByNumber(){
        
        CompaniesHouseCalloutsRequest req = new CompaniesHouseCalloutsRequest();
        CompaniesHouseCalloutsResponse res = new CompaniesHouseCalloutsResponse(); 
        CompaniesHouse.CompanyProfile jsonData = new CompaniesHouse.CompanyProfile ();
        
        resultDisplay = req.getRequestCompanyNumber(CH_searchTextNumber);
        jsonData      = res.getResponseCompanyProfile(resultDisplay);
        
        itemsToDisplay1   = jsonData.Accounts;
        CH_companydetails = jsonData;
        if(jsonData !=null)
        {
            CH_OfficeDetails  =  jsonData.registered_office_address;
            CH_AnnualReturn   =  jsonData.annual_return;
            CH_OfficerSummary =  jsonData.officer_summary;
            
        }
        return null; 
    } 
    
}