/**
 * Author: ?
 * Reviewer: eliot.stock@methodsdigital.co.uk
 * 
 * WIP. Propsoed rewrite of CompaniesHouseCalloutsRequest.
 */
public class ChApiClient {

    public String getCompanyName(String searchString) {
    	String hitURL;
        String encodedUrl = EncodingUtil.urlEncode(searchString, 'UTF-8');
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        // 
        // TODO: hitURL = endpoint + '?q=' + encodedUrl+'&items_per_page=1000';
        // TODO: return doCallout(hitURL);
        // 
        return null;
    }
    
    private String getJson(String searchString) {
        return 'TODO';
    }
    
}