@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
   	public static String GET_CHARGES_JSON 	= '{"classification": {"type": "charge-description", "description": "Test Description" },"etag": "23j4g234jhg23j4hg3",  "status": "fully-satisfied",  "charge_number": 1,  "satisfied_on": "2000-01-01",  "created_on": "2000-01-01",  "delivered_on": "2000-01-01",   "acquired_on" : "2000-01-01","charge_code" : "Test Code",  "assets_ceased_released":"Test",  "covering_instrument_date":"2000-01-01",  "more_than_four_persons_entitled":true,  "resolved_on":"2000-01-01","insolvency_cases": [{"case_number" :123,"transaction_id":123456, "links": {"chCase":"Test Case" } } ],"particulars": {"type":"short-particulars","description":"Test Description","chargor_acting_as_bare_trustee":true,"contains_fixed_charge":true,"contains_floating_charge":true,"contains_negative_pledge":false,"floating_charge_covers_all":true},"links": { "self": "/company/12345678/charges/Charge12345" },"persons_entitled": [{ "name": "Test Name"}],"scottish_alterations": { "has_alterations_to_order":true, "has_alterations_to_prohibitions":false,  "has_restricting_provisions":false  },"secured_details": {"description": "Test Description","type": "amount-secured"},"transactions": [ {  "delivered_on": "2000-01-01", "links": { "filing": "/company/12345678/filing-history/12345","insolvency_case": "Test Case" },"filing_type": "create-charge-pre-2006-companies-act", "insolvency_case_number":12345, "transaction_id": 1234 }] }';
    public static STring LIST_CHARGES_JSON	= '{"total_count":1,"unfiltered_count":1,"satisfied_count":1,"items":[{"classification":{"type":"charge-description","description":"Test Description"},"resolved_on":"2000-01-01","more_than_four_persons_entitled":false,"covering_instrument_date":"2000-01-01","charge_code":"aa12seflkj3","assets_ceased_released":"Test","acquired_on":"2000-01-01","etag":"6fce842af6wewrwerwehjhkhebf2beb0","links":{"self":"/company/12345678/charges/CHARGE001"},"delivered_on":"2005-11-04","scottish_alterations":{"has_alterations_to_order":true,"has_alterations_to_prohibitions":false,"has_restricting_provisions":true},"particulars":{"chargor_acting_as_bare_trustee":true,"contains_fixed_charge":false,"contains_floating_charge":true,"contains_negative_pledge":true,"floating_charge_covers_all":false,"type":"short-particulars","description":"Test Description."},"satisfied_on":"2011-02-16","transactions":[{"delivered_on":"2005-11-04","links":{"filing":"/company/12345678/filing-history/0001"},"filing_type":"create-charge-pre-2006-companies-act"},{"delivered_on":"2011-02-16","links":{"filing":"/company/12345678/filing-history/0000"},"filing_type":"charge-satisfaction-pre-april-1900"}],"status":"fully-satisfied","charge_number":1,"persons_entitled":[{"name":"Test Bank PLC"}],"secured_details":{"description":"Test Description","type":"amount-secured"},"created_on":"2005-11-03"}],"part_satisfied_count":0,"etag":"6fce842af6wewrwerwehjhkhebf2beb0"}';
    public static String GET_FILING_JSON 	= '{"description":"liquidation-voluntary-cease-to-act-as-liquidator","type":"4.40","category":"insolvency","subcategory":"voluntary","date":"2013-03-13","links":{"document_metadata":"https://document-api.companieshouse.gov.uk/document/1","self":"/company/1234567/filing-history/2000"},"pages":1,"paper_filed":true,"barcode":"123456","transaction_id":"1000","annotations": [{"annotation":"Test","chDate":"2000-01-01","description":"Test Description"}],"resolutions": [{"category":"Test","description":"Test Description","document_id":"1234","receive_date":"2000-01-01","type":"Test Type"}],"associated_filings":[{"chDate":"2000-01-01","description":"Test Description","type":"Test Type"}]}';
    public static String LIST_FILING_JSON 	= '{"etag" : "jkh3k24jh23kj4hjkh","filing_history_status" : "Test Status","items_per_page" : 12,"kind" : "Test Kind","start_index" : 1,"total_count" : 1,"items":[{"annotations" :[{"annotation" : "Test", "chDate" : "2000-01-01","description" : "Test Description"}],"subcategory":"Test SubCategory","transaction_id":"123456","type":"Test Type","barcode":"12345","category":"Test Category","chDate":"2000-01-01","description":"Test Description","pages":1,"paper_filed":true,"resolutions":[{"category": "liquidation","type": "ABCDEF","description": "Test Description","subcategory": ["resolution"]}]}]}';
    public static String INSOLVENCY_JSON 	= '{"cases": [{"practitioners": [{"name": "Test Test","ceased_to_act_on": "2000-03-11","appointed_on": "2000-02-14","role": "practitioner","address": {"address_line_1": "TEST & COMPANY", "locality": "London", "address_line_2": "000 Test Street", "postal_code": "ABC 2DE"}}],"type": "creditors-voluntary-liquidation","number": "1","dates": [{"type": "wound-up-on","date": "2006-02-14"}],"notes":["Test Notes"],"links":{"charge":"Test Charge"} }],"status": ["liquidation"],"etag":"asjdaskd3e342"}';
    public static String ADDRESS_JSON 		= '{"postal_code":"EC1A 4EN","address_line_1":"16 St. Martins Le Grand","locality":"London","address_line_2":"Test Line 2","country":"Test Country","po_box":"123456","premises":"Test Premises","region":"Test Region","etag":"j234kj3h2kjhjk"}';
    public static String SEARCH_COMPANY     = '{"items_per_page": 20,"page_number": 1,"kind": "searchresults","start_index": 0,"total_results": 1,"etag": "123123123","items": [{"description_identifier": ["incorporated-on"],"date_of_creation": "1900-01-01","company_status": "active","company_number": "12345678","snippet": "Test Snippet","url": "/company/12345678","markdown_title": "TEST COMPANY LIMITED","markdown_description": "1900-01-01","links": {"self": "/company/1234567"},"kind": "searchresults#company","description": "Test Description","address": {"address_line_1": "Test Line 1","region": "Test Region","postal_code": "1234 567","locality":"Test Locality","address_line_2": "Test Line 2","country":"Test Country","po_box":"1234 567","premises":"Test Premises","care_of":"Test Care Of"},"company_type": "ltd","title": "TEST COMPANY LIMITED"}]}';
    public static String COMPANY_PROFILE    = '{"undeliverable_registered_office_address": false,"date_of_creation": "1900-01-01","company_status": "active","has_charges": false,"can_file": true,"last_full_members_list_date": "2000-01-01","company_number": "12345678","sic_codes": ["00000"],"jurisdiction": "england-wales","company_name": "TEST COMPANY LIMITED","type": "ltd","has_been_liquidated": false,"has_insolvency_history": false,"etag": "000000000000","date_of_dissolution":"2000-01-01","company_status_detail":"Test Details","registered_office_is_in_dispute":false,"accounts": {"accounting_reference_date": {"month": "03","day": "31"},"next_due": "2000-01-01","overdue": false,"last_accounts": {"made_up_to": "2014-03-31","type": "audit-exemption-subsidiary"},"next_made_up_to": "2015-03-31"},"annual_return": {"next_due": "2016-03-13","last_made_up_to": "2015-02-14","next_made_up_to": "2016-02-14","overdue": false},"registered_office_address": {"locality": "Test Locality","address_line_2": "Test Line 2","region": "Test Region","address_line_1": "Test Line 1","postal_code": "1234 2FN","country":"Test Country","po_box":"1234 567","premises":"Test Premises"},"officer_summary": {"resigned_count": 13,"officers": [{"officer_role": "corporate-secretary","name": "TEST COMPANY LIMITED","date_of_birth": {"year": 1900,"month": 9},"appointed_on": "2000-03-31"},{"officer_role": "director","date_of_birth": {"year": 1900,"month": 9},"name": "PERSON 1, Test","appointed_on": "2000-03-31"},{"name": "PERSON 2, Test","appointed_on": "2000-12-20","date_of_birth": {"year": 1900,"month": 2},"officer_role": "director"},{"date_of_birth": {"month": 5,"year": 1900},"officer_role": "director","appointed_on": "2000-12-22","name": "PERSON 3, Test"}],"active_count": 4}}';
    public static String OFFICERS_LIST      = '{"active_count":1,"total_results": 17,"start_index": 1,"items_per_page":35,"etag":"ac025c92a30a972ef72b22782244aa99c6c6297f","kind":"officer-list","resigned_count":13,"links": {"self": "/company/12345678/appointments"},"items": [{"officer_role": "director","occupation": "Company Director","address": {"postal_code": "123 7BG","address_line_1": "Test Line 1","address_line_2": "Test Line 2","locality": "Test Locality","country":"Test Country","care_of":"Test Care of","po_box":"123 456","premises":"Test Premises","region":"Test Region"},"name": "PEETT, Edward John", "links": {"officer": {"appointments": "/officers/63pi9RxHCq3C3Lhp4pDRMN8u53g/appointments"} },"resigned_on": "1997-01-01","appointed_on": "1992-04-15","date_of_birth":{"day":1,"month":9,"year":1900},"nationality": "British","country_of_residence":"Test"}]}';
    

    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        
        String assertResp = req.getEndpoint();
        
        
        
        //get insolvency
        if (req.getEndpoint().contains('insolvency')){
            res.setBody(INSOLVENCY_JSON);
            
        //list officers
        }else if (req.getEndpoint().contains('officers')){
            res.setBody(OFFICERS_LIST);
            
        //get office address
        }else if (req.getEndpoint().contains('registered-office-address')){
            res.setBody(ADDRESS_JSON);
            
        //get filing history
        }else if (req.getEndpoint().contains('filing-history/')){
            res.setBody(GET_FILING_JSON);

        //list filing history
        }else if (req.getEndpoint().contains('filing-history')){
            res.setBody(LIST_FILING_JSON);
            
        //get charges
        }else if (req.getEndpoint().contains('charges/')){
            res.setBody(GET_CHARGES_JSON);
            
        //list charges
        }else if (req.getEndpoint().contains('/charges')){    
            res.setBody(LIST_CHARGES_JSON);
            
        //search/companies   (Company By Name)
        }else if (req.getEndpoint().contains('search/companies')){
           res.setBody(SEARCH_COMPANY);

        //get company/   (Company Profile)
        }else {
            res.setBody(COMPANY_PROFILE);
        }
        
        system.assertEquals('GET', req.getMethod());
        system.assert(assertResp.contains('https://api.companieshouse.gov.uk'));
        
        res.setStatusCode(200);
        res.setStatus('OK');
        return res;
    }
}