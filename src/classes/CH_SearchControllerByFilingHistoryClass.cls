public with sharing class CH_SearchControllerByFilingHistoryClass {
    
    public String CH_searchTextNumber{get;set;}
    public String CH_searchCategory{get;set;}
    public String resultDisplay {get;set;}  
    public String CH_searchTrans{get;set;}
    
    
    public String jsonResToDisplay{get;set;} 

    public CompaniesHouse.FilingHistoryList    cList {get;set;}
    
    
    //controller
    public CH_SearchControllerByFilingHistoryClass(){
        
    }
    
    
    CompaniesHouse.FilingHistoryList    jsonData  = new CompaniesHouse.FilingHistoryList ();
    CompaniesHouse.FilingHistoryDetails jsonData1 = new CompaniesHouse.FilingHistoryDetails ();
    
    public CompaniesHouse.FilingHistoryList itemsTopLevelInfo{get;set;}
    public List<CompaniesHouse.FilingHistoryDetails> itemsToDisplayItems {get;set;}
    public CompaniesHouse.FilingHistoryDetails itemsResult {get;set;}
    
    public PageReference CH_Search_functionByFilingHistory(){
        string jsonResponse;
        cList = new CompaniesHouse.FilingHistoryList();
        
        CompaniesHouseCalloutsRequest req = new CompaniesHouseCalloutsRequest();
        CompaniesHouseCalloutsResponse res = new CompaniesHouseCalloutsResponse();
        
        //To search Company Number/Transaction ID
        if (!String.isEmpty(CH_searchTrans)){
            
            resultDisplay = req.getRequestFilingHistoryTransaction(CH_searchTextNumber,CH_searchTrans);
            jsonData1 = res.getResponseFilingHistoryDetails(resultDisplay);
            itemsResult = jsonData1;
            jsonResToDisplay = itemsResult.toString();
            
        }
        
        //To search Company Number/Category
        else{
            
            resultDisplay = req.getRequestFilingHistoryList(CH_searchTextNumber,CH_searchCategory);
            jsonData = res.getResponseFilingHistoryList(resultDisplay);
            itemsTopLevelInfo= jsonData;
            itemsToDisplayItems = jsonData.items;
            jsonResToDisplay = itemsTopLevelInfo.toString();
            
        }
        
        return null; 
    } 
}