/**
 * Use this to mock the HTTP response returned in unit tests when the Forms API client calls out.
 * 
 * Author: eliot.stock@methods.co.uk
 */
public with sharing class FormsApiMockBarcode  {

  public class mockSuccess implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
        
        // Every request gets a 200, OK.
        response.setBody('{"barcode":"12344"}');
        response.setStatusCode(200);
        
        return response;
    }
  }

  public class mockSuccessTokenAuth implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
        system.debug('Debug:' + request.getEndpoint());
    HttpResponse response = new HttpResponse();
        if (request.getEndpoint().contains('profile')){
            response.setBody('{"surname": "Carl", "email": "c@c.com", "id": "COWf8p4btb6QmarCN5zb6jrDUdE",  "locale": "en",  "scope": "http://api.companieshouse.gov.uk/company/05448736"}');
        }
        
        // Every request gets a 200, OK.
        else if(request.getEndpoint().contains('verify?'))
        {
          response.setBody('{"application": "COWf8p4btb6QmarCN5zb6jrDUdE",  "expires_in": 3580,  "scope": "http://api.companieshouse.gov.uk/company/05448736",  "user_id": "dNVI1yHNhIx32YfRx4EMzeru7kT9NFTnQ54MABxZ"}');
        }
        else if(request.getEndpoint().contains('05448736'))
        {
          response.setBody('{"undeliverable_registered_office_address": false,"date_of_creation": "1900-01-01","company_status": "active","has_charges": false,"can_file": true,"last_full_members_list_date": "2000-01-01","company_number": "12345678","sic_codes": ["00000"],"jurisdiction": "england-wales","company_name": "TEST COMPANY LIMITED","type": "ltd","has_been_liquidated": false,"has_insolvency_history": false,"etag": "000000000000","date_of_dissolution":"2000-01-01","company_status_detail":"Test Details","registered_office_is_in_dispute":false,"accounts": {"accounting_reference_date": {"month": "03","day": "31"},"next_due": "2000-01-01","overdue": false,"last_accounts": {"made_up_to": "2014-03-31","type": "audit-exemption-subsidiary"},"next_made_up_to": "2015-03-31"},"annual_return": {"next_due": "2016-03-13","last_made_up_to": "2015-02-14","next_made_up_to": "2016-02-14","overdue": false},"registered_office_address": {"locality": "Test Locality","address_line_2": "Test Line 2","region": "Test Region","address_line_1": "Test Line 1","postal_code": "1234 2FN","country":"Test Country","po_box":"1234 567","premises":"Test Premises"},"officer_summary": {"resigned_count": 13,"officers": [{"officer_role": "corporate-secretary","name": "TEST COMPANY LIMITED","date_of_birth": {"year": 1900,"month": 9},"appointed_on": "2000-03-31"},{"officer_role": "director","date_of_birth": {"year": 1900,"month": 9},"name": "PERSON 1, Test","appointed_on": "2000-03-31"},{"name": "PERSON 2, Test","appointed_on": "2000-12-20","date_of_birth": {"year": 1900,"month": 2},"officer_role": "director"},{"date_of_birth": {"month": 5,"year": 1900},"officer_role": "director","appointed_on": "2000-12-22","name": "PERSON 3, Test"}],"active_count": 4}}');
        }
        else
        {
          response.setBody('{"access_token": "COWf8p4btb6QmarCN5zb6jrDUdE",  "expires_in": 3580,  "token_type": "http://api.companieshouse.gov.uk/company/05448736",  "refresh_token": "dNVI1yHNhIx32YfRx4EMzeru7kT9NFTnQ54MABxZ"}');
        }
        response.setStatusCode(200);
        
        return response;
    }
  }

  public class mockSuccessTokenAuthLLP implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
        system.debug('Debug:' + request.getEndpoint());
    HttpResponse response = new HttpResponse();
        if (request.getEndpoint().contains('profile')){
            response.setBody('{"surname": "Carl", "email": "c@c.com", "id": "COWf8p4btb6QmarCN5zb6jrDUdE",  "locale": "en",  "scope": "http://api.companieshouse.gov.uk/company/05448736"}');
        }
        
        // Every request gets a 200, OK.
        else if(request.getEndpoint().contains('verify?'))
        {
          response.setBody('{"application": "COWf8p4btb6QmarCN5zb6jrDUdE",  "expires_in": 3580,  "scope": "http://api.companieshouse.gov.uk/company/05448736",  "user_id": "dNVI1yHNhIx32YfRx4EMzeru7kT9NFTnQ54MABxZ"}');
        }
        else if(request.getEndpoint().contains('05448736'))
        {
          response.setBody('{"undeliverable_registered_office_address": false,"date_of_creation": "1900-01-01","company_status": "active","has_charges": false,"can_file": true,"last_full_members_list_date": "2000-01-01","company_number": "12345678","sic_codes": ["00000"],"jurisdiction": "england-wales","company_name": "TEST COMPANY LIMITED","type": "llp","has_been_liquidated": false,"has_insolvency_history": false,"etag": "000000000000","date_of_dissolution":"2000-01-01","company_status_detail":"Test Details","registered_office_is_in_dispute":false,"accounts": {"accounting_reference_date": {"month": "03","day": "31"},"next_due": "2000-01-01","overdue": false,"last_accounts": {"made_up_to": "2014-03-31","type": "audit-exemption-subsidiary"},"next_made_up_to": "2015-03-31"},"annual_return": {"next_due": "2016-03-13","last_made_up_to": "2015-02-14","next_made_up_to": "2016-02-14","overdue": false},"registered_office_address": {"locality": "Test Locality","address_line_2": "Test Line 2","region": "Test Region","address_line_1": "Test Line 1","postal_code": "1234 2FN","country":"Test Country","po_box":"1234 567","premises":"Test Premises"},"officer_summary": {"resigned_count": 13,"officers": [{"officer_role": "corporate-secretary","name": "TEST COMPANY LIMITED","date_of_birth": {"year": 1900,"month": 9},"appointed_on": "2000-03-31"},{"officer_role": "director","date_of_birth": {"year": 1900,"month": 9},"name": "PERSON 1, Test","appointed_on": "2000-03-31"},{"name": "PERSON 2, Test","appointed_on": "2000-12-20","date_of_birth": {"year": 1900,"month": 2},"officer_role": "director"},{"date_of_birth": {"month": 5,"year": 1900},"officer_role": "director","appointed_on": "2000-12-22","name": "PERSON 3, Test"}],"active_count": 4}}');
        }
        else
        {
          response.setBody('{"access_token": "COWf8p4btb6QmarCN5zb6jrDUdE",  "expires_in": 3580,  "token_type": "http://api.companieshouse.gov.uk/company/05448736",  "refresh_token": "dNVI1yHNhIx32YfRx4EMzeru7kT9NFTnQ54MABxZ"}');
        }
        response.setStatusCode(200);
        
        return response;
    }
  }

  public class mockSuccessTokenAuthERRORCOMPANY implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
        system.debug('Debug:' + request.getEndpoint());
    HttpResponse response = new HttpResponse();
        if (request.getEndpoint().contains('profile')){
            response.setBody('{"surname": "Carl", "email": "c@c.com", "id": "COWf8p4btb6QmarCN5zb6jrDUdE",  "locale": "en",  "scope": "http://api.companieshouse.gov.uk/company/05448736"}');
        }
        
        // Every request gets a 200, OK.
        else if(request.getEndpoint().contains('verify?'))
        {
          response.setBody('{"application": "COWf8p4btb6QmarCN5zb6jrDUdE",  "expires_in": 3580,  "scope": "http://api.companieshouse.gov.uk/company/05448736",  "user_id": "dNVI1yHNhIx32YfRx4EMzeru7kT9NFTnQ54MABxZ"}');
        }
        else if(request.getEndpoint().contains('05448736'))
        {
          response.setBody('{"undeliverable_registered_office_address": false,"date_of_creation": "1900-01-01","company_status": "active","has_charges": false,"can_file": true,"last_full_members_list_date": "2000-01-01","company_number": "12345678","sic_codes": ["00000"],"jurisdiction": "england-wales","company_name": "TEST COMPANY LIMITED","type": "royal-charter","has_been_liquidated": false,"has_insolvency_history": false,"etag": "000000000000","date_of_dissolution":"2000-01-01","company_status_detail":"Test Details","registered_office_is_in_dispute":false,"accounts": {"accounting_reference_date": {"month": "03","day": "31"},"next_due": "2000-01-01","overdue": false,"last_accounts": {"made_up_to": "2014-03-31","type": "audit-exemption-subsidiary"},"next_made_up_to": "2015-03-31"},"annual_return": {"next_due": "2016-03-13","last_made_up_to": "2015-02-14","next_made_up_to": "2016-02-14","overdue": false},"registered_office_address": {"locality": "Test Locality","address_line_2": "Test Line 2","region": "Test Region","address_line_1": "Test Line 1","postal_code": "1234 2FN","country":"Test Country","po_box":"1234 567","premises":"Test Premises"},"officer_summary": {"resigned_count": 13,"officers": [{"officer_role": "corporate-secretary","name": "TEST COMPANY LIMITED","date_of_birth": {"year": 1900,"month": 9},"appointed_on": "2000-03-31"},{"officer_role": "director","date_of_birth": {"year": 1900,"month": 9},"name": "PERSON 1, Test","appointed_on": "2000-03-31"},{"name": "PERSON 2, Test","appointed_on": "2000-12-20","date_of_birth": {"year": 1900,"month": 2},"officer_role": "director"},{"date_of_birth": {"month": 5,"year": 1900},"officer_role": "director","appointed_on": "2000-12-22","name": "PERSON 3, Test"}],"active_count": 4}}');
        }
        else
        {
          response.setBody('{"access_token": "COWf8p4btb6QmarCN5zb6jrDUdE",  "expires_in": 3580,  "token_type": "http://api.companieshouse.gov.uk/company/05448736",  "refresh_token": "dNVI1yHNhIx32YfRx4EMzeru7kT9NFTnQ54MABxZ"}');
        }
        response.setStatusCode(200);
        
        return response;
    }
  }

  public class mockFailTokenAuth implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {

    HttpResponse response = new HttpResponse();
        if (request.getEndpoint().contains('profile')){
            response.setBody('{"surname": "Carl", "email": "c@c.com", "id": "COWf8p4btb6QmarCN5zb6jrDUdE",  "locale": "en",  "scope": "http://api.companieshouse.gov.uk/company/05448736"}');
        }
        
        // Every request gets a 200, OK.
        else if(request.getEndpoint().contains('verify?'))
        {
          response.setBody('{"application": "COWf8p4btb6QmarCN5zb6jrDUdE",  "expires_in": 3580,  "scope": "http://api.companieshouse.gov.uk/company/05448736",  "user_id": "dNVI1yHNhIx32YfRx4EMzeru7kT9NFTnQ54MABxZ"}');
          response.setStatusCode(300);
          return response;
        }
        else if(request.getEndpoint().contains('05448736'))
        {
          response.setBody('{"undeliverable_registered_office_address": false,"date_of_creation": "1900-01-01","company_status": "active","has_charges": false,"can_file": true,"last_full_members_list_date": "2000-01-01","company_number": "12345678","sic_codes": ["00000"],"jurisdiction": "england-wales","company_name": "TEST COMPANY LIMITED","type": "ltd","has_been_liquidated": false,"has_insolvency_history": false,"etag": "000000000000","date_of_dissolution":"2000-01-01","company_status_detail":"Test Details","registered_office_is_in_dispute":false,"accounts": {"accounting_reference_date": {"month": "03","day": "31"},"next_due": "2000-01-01","overdue": false,"last_accounts": {"made_up_to": "2014-03-31","type": "audit-exemption-subsidiary"},"next_made_up_to": "2015-03-31"},"annual_return": {"next_due": "2016-03-13","last_made_up_to": "2015-02-14","next_made_up_to": "2016-02-14","overdue": false},"registered_office_address": {"locality": "Test Locality","address_line_2": "Test Line 2","region": "Test Region","address_line_1": "Test Line 1","postal_code": "1234 2FN","country":"Test Country","po_box":"1234 567","premises":"Test Premises"},"officer_summary": {"resigned_count": 13,"officers": [{"officer_role": "corporate-secretary","name": "TEST COMPANY LIMITED","date_of_birth": {"year": 1900,"month": 9},"appointed_on": "2000-03-31"},{"officer_role": "director","date_of_birth": {"year": 1900,"month": 9},"name": "PERSON 1, Test","appointed_on": "2000-03-31"},{"name": "PERSON 2, Test","appointed_on": "2000-12-20","date_of_birth": {"year": 1900,"month": 2},"officer_role": "director"},{"date_of_birth": {"month": 5,"year": 1900},"officer_role": "director","appointed_on": "2000-12-22","name": "PERSON 3, Test"}],"active_count": 4}}');
        }
        else
        {
          response.setBody('{"access_token": "COWf8p4btb6QmarCN5zb6jrDUdE",  "expires_in": 3580,  "token_type": "http://api.companieshouse.gov.uk/company/05448736",  "refresh_token": "dNVI1yHNhIx32YfRx4EMzeru7kT9NFTnQ54MABxZ"}');
        }
        response.setStatusCode(200);
        
        return response;
    }
  }

  public class mockSuccessToken implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
        
        // Every request gets a 200, OK.
        response.setBody('{"user_id": "COWf8p4btb6QmarCN5zb6jrDUdE",  "expires_in": 3580,  "scope": "http://api.companieshouse.gov.uk/company/05448736",  "application": "dNVI1yHNhIx32YfRx4EMzeru7kT9NFTnQ54MABxZ"}');
        response.setStatusCode(200);
        
        return response;
    }
  }

  public class mockErrorToken implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
        
        // Every request gets a 200, OK.
        response.setBody('{"errors": [    {      "error": "invalid-authorization-header",      "type": "ch:service"    }  ]}');
        response.setStatusCode(401);
        
        return response;
    }
  }

  public class mockError implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
        
        // Every request gets a 200, OK.
        response.setBody('{"barcode":"12344"}');
        response.setStatusCode(400);
        
        return response;
    }
  }

  public class mock202 implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
        
        // Every request gets a 200, OK.
        response.setBody('{"barcode":"12344"}');
        response.setStatusCode(202);
        
        return response;
    }
  }

  public class mock302 implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
        
        // Every request gets a 200, OK.
        response.setBody('{"barcode":"12344"}');
        response.setStatusCode(302);
        
        return response;
    }
  }

  public class mockEmpty implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
        
        // Every request gets a 200, OK.
        response.setBody('');
        response.setStatusCode(200);
        
        return response;
    }
  }
	
  public class mockHTML implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
        
        // Every request gets a 200, OK.
        response.setBody('<!DOCTYPE html>');
        response.setStatusCode(200);
        
        return response;
    }
  }

  public class mock400 implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
        
        // Every request gets a 200, OK.
        response.setBody('<!DOCTYPE html>');
        response.setStatusCode(400);
        
        return response;
    }
  }
}