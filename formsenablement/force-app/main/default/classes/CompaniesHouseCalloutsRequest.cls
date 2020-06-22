/*
Name:  CompaniesHouseCalloutsRequest.cls
=============================================================================
=============================================================================
Purpose:
-------
Class handling request processing for SF -> Companies House callouts
=============================================================================
=============================================================================

*/
Global with sharing class CompaniesHouseCalloutsRequest {
    private string endpoint;
    private string authenticationToken;
    private string endpointCompanyNumber;
    public Boolean success {get; set;}
    private static final Integer SUCCESS_CODE = 200;
  
    //WSCalloutsRequest Constructor
    public CompaniesHouseCalloutsRequest () {
        API_Org_Settings__c orgSettings = API_Org_Settings__c.getOrgDefaults();
        
        this.endpoint = orgSettings.CH_Endpoint__c;
        this.authenticationToken = orgSettings.CH_Authentication_Token__c;

        this.endpointCompanyNumber = orgSettings.CH_Endpoint_cNum_URL__c;
        
    }
    
    // web service call method-Search Company by Name API Function
    Global string getRequestCompanyName(String searchString){
    
        String hitURL;
        String encodedUrl = EncodingUtil.urlEncode(searchString, 'UTF-8');
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        hitURL = endpoint + '?q=' + encodedUrl+'&items_per_page=1000';
        return doCallout(hitURL); 
        
    }
    
    // Web service call method-Search Company by Number API Function    
    Global string getRequestCompanyNumber(String searchString){

        String hitURL;
        String encodedUrl = EncodingUtil.urlEncode(searchString, 'UTF-8');
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        
        hitURL = endpointCompanyNumber + '/' + encodedUrl;
        return doCallout(hitURL);
        
    }
    
    // web service call method- Registered Address API Function
    Global string getRequestRegisteredAddress(String searchString){

        String hitURL;
        String encodedUrl = EncodingUtil.urlEncode(searchString, 'UTF-8');
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        hitURL = endpointCompanyNumber + '/' + encodedUrl + '/registered-office-address';
        return doCallout(hitURL);      
    }
    
     // web service call method- Officer List API Function
    Global string getRequestOfficersList(String searchString){


        String hitURL;
        String encodedUrl = EncodingUtil.urlEncode(searchString, 'UTF-8');
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
       
        //hitURL = endpointCompanyNumber + '/' + encodedUrl + '/officers';
        
        hitURL = endpointCompanyNumber + '/' + encodedUrl + '/officers?items_per_page=120';
        return doCallout(hitURL);     
    }
    
    // web service call method- Officer List API Function
    Global string getRequestInsolvency(String searchString){


        String hitURL;
        String encodedUrl = EncodingUtil.urlEncode(searchString, 'UTF-8');
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        
        hitURL = endpointCompanyNumber + '/' + encodedUrl + '/insolvency';
        return doCallout(hitURL);
       
    }
    
     // web service call method- LIST Filing History API Function
    Global string getRequestFilingHistoryList(String searchString,String searchCategory){


        
        String hitURL;
        String encodedUrl = EncodingUtil.urlEncode(searchString, 'UTF-8');
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
       
        hitURL = endpointCompanyNumber + '/' + encodedUrl + '/filing-history?category='+ searchCategory;
        return doCallout(hitURL);
       
    }
    
    // web service call method- GET Filing History API Function
     Global string getRequestFilingHistoryTransaction(String searchString,String searchTranscationId){

        String hitURL;
        String encodedUrl = EncodingUtil.urlEncode(searchString, 'UTF-8');
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
       
        hitURL = endpointCompanyNumber + '/' + encodedUrl + '/filing-history/'+ searchTranscationId;
        return doCallout(hitURL);
       
    }
    
    // web service call method- GET Charge History API Function
    Global string getRequestChargeHistory(String searchString, String searchCharge){
        
        String hitURL;
        String encodedUrl = EncodingUtil.urlEncode(searchString, 'UTF-8');
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
       
        hitURL = endpointCompanyNumber + '/' + encodedUrl + '/charges/'  + EncodingUtil.urlEncode(searchCharge, 'UTF-8');
        return doCallout(hitURL);
        
    }
    
    // web service call method- GET Charge History List Function
    Global String getRequestChargeHistoryList(String searchString){
        String hitURL;
        String encodedUrl = EncodingUtil.urlEncode(searchString, 'UTF-8');
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
       
        hitURL = endpointCompanyNumber + '/' + encodedUrl + '/charges';
        return doCallout(hitURL);
    }
  
    
    private String doCallout(String hitURL){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(hitURL);
        req.setMethod('GET');
        req.setTimeout(120000);

        
        Blob headerValue = Blob.valueOf(this.authenticationToken + ':');
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        
        req.setHeader('Authorization', authorizationHeader);

        HttpResponse res;

        // Send the request, and return a response
        try {
                res = h.send(req);
        } catch (CalloutException e) {
                return e.getMessage();
        }
        System.debug('STATUS CODE REQUEST:' + res.getStatusCode() );

        if (res.getStatusCode() == SUCCESS_CODE || res.getStatusCode() == 404)
            success = true;
        else
            success = false;
        return res.getBody(); 
    
    }

}