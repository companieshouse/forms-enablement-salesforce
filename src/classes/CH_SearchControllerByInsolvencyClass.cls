public with sharing class CH_SearchControllerByInsolvencyClass {
    
    public String resultDisplay {get;set;}  
    public String CH_searchTextNumber{get;set;}    
    public String results{get;set;}
    
    public List<CompaniesHouse.chCase> itemsToDisplayTopLevel {get;set;}
    public CompaniesHouse.CompanyInsolvency topItems{get;set;}
    

    //Insolvency API
    public PageReference CH_Search_functionByInsolvency(){
        
        CompaniesHouseCalloutsRequest req = new CompaniesHouseCalloutsRequest();
        CompaniesHouseCalloutsResponse res = new CompaniesHouseCalloutsResponse();
        
        CompaniesHouse.CompanyInsolvency jsonData = new CompaniesHouse.CompanyInsolvency ();
        resultDisplay = req.getRequestInsolvency(CH_searchTextNumber);
        
        jsonData = res.getResponseCompanyInsolvency(resultDisplay);

        If(jsonData.cases == null){
            results = 'No records found';


        }else{
            topItems = jsonData;
            results = 'Record(s) found';
            
            itemsToDisplayTopLevel = topItems.cases;
            
        }
        return null; 
    } 
}