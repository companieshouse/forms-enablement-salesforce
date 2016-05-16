public with sharing class CH_ChargeController{

    
    public string searchParam {get;set;}
    public string chargeParam {get;set;}
    public String classData {get;set;}

    public CompaniesHouse.ChargeDetails charge {get;set;}
    public CompaniesHouse.ChargeList cList {get;set;}
    
    public CH_ChargeController(){
    
    }
     
    public PageReference doCallout(){

        CompaniesHouseCalloutsRequest req = new CompaniesHouseCalloutsRequest();
        string jsonResponse;
        charge = null;
        cList = new CompaniesHouse.ChargeList();
        
        CompaniesHouseCalloutsResponse res = new CompaniesHouseCalloutsResponse();
        if (!String.isEmpty(chargeParam)){
            jsonResponse = req.getRequestChargeHistory(searchParam, chargeParam );           
            charge =  res.getResponseChargeDetails(jsonResponse);
            classData = charge.toString();
            List<CompaniesHouse.ChargeDetails> newList = new List<CompaniesHouse.ChargeDetails>();
            newList.add(charge);
            cList.items = newList;
        }
        else{
            jsonResponse = req.getRequestChargeHistoryList(searchParam);
            cList = res.getResponseChargeList(jsonResponse);
            classData = cList.toSTring();
       }

        return null;

    }
    
    
    public PageReference showDate(){
        return null;
    }
}