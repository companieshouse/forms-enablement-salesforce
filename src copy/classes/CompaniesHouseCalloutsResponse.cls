/*
Name:  CompaniesHouseCalloutsResponse.cls
============================================================================================================
============================================================================================================
Purpose:
-------
Class handling generic parsing of the response json messages coming from Companies House system.
============================================================================================================
============================================================================================================
*/

global class CompaniesHouseCalloutsResponse {
    
    //This method returns response mapped from json to apex class instance objects - (Search by Name API)
    global CompaniesHouse.CompanySearchList getResponseCompanySearchList(String jsonResponse) {
        jsonResponse = preProcessJson(jsonResponse);
        CompaniesHouse.CompanySearchList jsonData = (CompaniesHouse.CompanySearchList) JSON.deserialize(jsonResponse, CompaniesHouse.CompanySearchList.class);
        return jsonData;
        
    }
    
    //This method returns response mapped from json to apex class instance objects - (Search by Number API)
    global CompaniesHouse.CompanyProfile getResponseCompanyProfile(String jsonResponse) {
        jsonResponse = preProcessJson(jsonResponse);
        CompaniesHouse.CompanyProfile jsonDataByNumber = (CompaniesHouse.CompanyProfile) JSON.deserialize(jsonResponse, CompaniesHouse.CompanyProfile.class);
        return jsonDataByNumber;
        
    }
    
    //This method returns response mapped from json to apex class instance objects - (Registered Address API)
    global CompaniesHouse.RegisteredOfficeAddress getResponseRegisteredOfficeAddress(String jsonResponse) {
        jsonResponse= preProcessJson(jsonResponse);
        CompaniesHouse.RegisteredOfficeAddress jsonDataByRegAddress = (CompaniesHouse.RegisteredOfficeAddress) JSON.deserialize(jsonResponse, CompaniesHouse.RegisteredOfficeAddress.class);
        return jsonDataByRegAddress;
        
    }
    
    //This method returns response mapped from json to apex class instance objects - (Officer List API)
    global CompaniesHouse.OfficerList getResponseOfficerList(String jsonResponse) {
        jsonResponse=preProcessJson(jsonResponse);
        CompaniesHouse.OfficerList jsonDataByOfficerList = (CompaniesHouse.OfficerList) JSON.deserialize(jsonResponse, CompaniesHouse.OfficerList.class);
        return jsonDataByOfficerList;
        
    }
    
    //This method returns response mapped from json to apex class instance objects - (Insolvency API)
    global CompaniesHouse.CompanyInsolvency getResponseCompanyInsolvency(String jsonResponse) {
        jsonResponse=preProcessJson(jsonResponse);
        CompaniesHouse.CompanyInsolvency jsonDataByInsolvency = (CompaniesHouse.CompanyInsolvency) JSON.deserialize(jsonResponse, CompaniesHouse.CompanyInsolvency.class);
        return jsonDataByInsolvency;
        
    }
    
    //This method returns response mapped from json to apex class instance objects - (List - Filing History API)
    global CompaniesHouse.FilingHistoryList getResponseFilingHistoryList(String jsonResponse) {
        jsonResponse=preProcessJson(jsonResponse);
        CompaniesHouse.FilingHistoryList jsonDataByFiling = (CompaniesHouse.FilingHistoryList) JSON.deserialize(jsonResponse, CompaniesHouse.FilingHistoryList.class);
        return jsonDataByFiling;
    }
    
    //This method returns response mapped from json to apex class instance objects - (Get- Filing History API)
    global CompaniesHouse.FilingHistoryDetails getResponseFilingHistoryDetails(String jsonResponse) {
        jsonResponse=preProcessJson(jsonResponse);
        CompaniesHouse.FilingHistoryDetails jsonDataByFiling = (CompaniesHouse.FilingHistoryDetails) JSON.deserialize(jsonResponse, CompaniesHouse.FilingHistoryDetails.class);
        return jsonDataByFiling;
    }
    
    //This method returns response mapped from json to apex class instance objects - (Get- Charge API)
    global CompaniesHouse.ChargeDetails getResponseChargeDetails(String jsonResponse){
        
        jsonResponse=preProcessJson(jsonResponse);
        CompaniesHouse.ChargeDetails response = (CompaniesHouse.ChargeDetails )JSON.deserialize(jsonResponse, CompaniesHouse.ChargeDetails.class);
        return response;
        
    }
    
    //This method returns response mapped from json to apex class instance objects - (LIST- Charge API)
    global CompaniesHouse.ChargeList getResponseChargeList(String jsonResponse){
        jsonResponse=preProcessJson(jsonResponse);
        CompaniesHouse.ChargeList response = (CompaniesHouse.ChargeList )JSON.deserialize(jsonResponse, CompaniesHouse.ChargeList.class);
        return response;
    }
    
    global CompaniesHouse.ErrorList getResponseErrors(String jsonResponse){
        CompaniesHouse.ErrorList response = (CompaniesHouse.ErrorList)JSON.deserialize(jsonResponse, CompaniesHouse.ErrorList.class);
        return response;
    }
    
    private static String preProcessJson(String jsonResponse){
        jsonResponse = jsonResponse.replace('"case":','"chCase":');
        jsonResponse = jsonResponse.replace('"number":','"chNumber":');
        jsonResponse = jsonResponse.replace('"date":','"chDate":');
        jsonResponse = jsonResponse.replace('"currency":','"chCurrency":');
        return jsonResponse;
        
    }
}