/**
 * Author: Sameer
 * Reviewer: eliot.stock@methodsdigital.co.uk
 */
@isTest(SeeAllData = true)
public with sharing class CompaniesHouseCalloutsResponseTest {
    
    public String resultDisplay; 
   
    // Search Company by Name API Test Method
    public static testMethod void webservicecall_CompanyByName() {
        
        // TODO: create custom setting with endpoint and token
        
        API_Org_Settings__c cs = new API_Org_Settings__c();
        cs.Name='Org_Settings';
        cs.CH_Endpoint__c = 'https://api.test.gov.uk/search/companies';
        cs.CH_Authentication_Token__c = '1234567890';
        
        insert cs;
        
        CompaniesHouse.CompanySearchList psec = new CompaniesHouse.CompanySearchList();
        CompaniesHouseCalloutsResponse wr = new CompaniesHouseCalloutsResponse();
        
        String CH_search='test company';
        Test.startTest();
        
        // Deserialize JSON string
        psec = wr.getResponseCompanySearchList(ChApiMock.SEARCH_COMPANY);
        
        Test.stopTest();
        
        System.assert(psec != null);
        
        system.assertNotEquals(null, psec.etag);
        system.assertNotEquals(null, psec.items_per_page);
        system.assertNotEquals(null, psec.kind);
        system.assertNotEquals(null, psec.start_index);
        system.assertNotEquals(null, psec.page_number);
        system.assertNotEquals(null, psec.total_results);
        
        system.assertNotEquals(null, psec.items.get(0).date_of_creation);
        system.assertNotEquals(null, psec.items.get(0).description);
        system.assertNotEquals(null, psec.items.get(0).description_identifier.get(0));
        system.assertNotEquals(null, psec.items.get(0).company_type);
        system.assertNotEquals(null, psec.items.get(0).company_number);
        system.assertNotEquals(null, psec.items.get(0).company_status);
        system.assertNotEquals(null, psec.items.get(0).kind);
        system.assertNotEquals(null, psec.items.get(0).markdown_description);
        system.assertNotEquals(null, psec.items.get(0).markdown_title);
        system.assertNotEquals(null, psec.items.get(0).snippet);
        system.assertNotEquals(null, psec.items.get(0).title);
        system.assertNotEquals(null, psec.items.get(0).url);    
        system.assertNotEquals(null, psec.items.get(0).address.address_line_1);
        system.assertNotEquals(null, psec.items.get(0).address.address_line_2);
        system.assertNotEquals(null, psec.items.get(0).address.postal_code);
        system.assertNotEquals(null, psec.items.get(0).address.locality);
        system.assertNotEquals(null, psec.items.get(0).address.region);
    }
    
    // Search Company Profile API Test Methods
    public static testMethod void webservicecall_CompanyByNumber(){
        //TODO create custom setting with endpoint and token
        
        API_Org_Settings__c cs = new API_Org_Settings__c();
        cs.Name='Org_Settings';
        cs.CH_Endpoint_cNum_URL__c = 'https://api.test.gov.uk/company';
        cs.CH_Authentication_Token__c = '1234567890';
        
        insert cs;
        
        CompaniesHouse.CompanyProfile psec = new CompaniesHouse.CompanyProfile();

        CompaniesHouseCalloutsResponse wr = new CompaniesHouseCalloutsResponse ();
        
        String CH_search  = '02358749';
        Test.startTest();
        
        // deserialize JSON string
        psec = wr.getResponseCompanyProfile(ChApiMock.COMPANY_PROFILE);
        
        Test.stopTest();
        
        System.assert(psec != null);
        system.assertNotEquals(null, psec.last_full_members_list_date);
        system.assertNotEquals(null, psec.company_name);
        system.assertNotEquals(null, psec.jurisdiction);
        system.assertNotEquals(null, psec.date_of_creation);
        system.assertNotEquals(null, psec.undeliverable_registered_office_address);
        system.assertNotEquals(null, psec.sic_codes);
        system.assertNotEquals(null, psec.has_been_liquidated);
        system.assertNotEquals(null, psec.company_number);
        system.assertNotEquals(null, psec.type);
        system.assertNotEquals(null, psec.etag);
        system.assertNotEquals(null, psec.company_status);
        system.assertNotEquals(null, psec.has_insolvency_history);
        system.assertNotEquals(null, psec.has_charges);
        system.assertNotEquals(null, psec.can_file);
        system.assertNotEquals(null, psec.date_of_dissolution);
        system.assertNotEquals(null, psec.company_status_detail);
        system.assertNotEquals(null, psec.registered_office_is_in_dispute);
        
        system.assertNotEquals(null, psec.accounts.next_due);
        system.assertNotEquals(null, psec.accounts.next_made_up_to);
        system.assertNotEquals(null, psec.accounts.overdue);
        
        system.assertNotEquals(null, psec.accounts.accounting_reference_date.day);
        system.assertNotEquals(null, psec.accounts.accounting_reference_date.month);
        
        system.assertNotEquals(null, psec.accounts.last_accounts.made_up_to);
        system.assertNotEquals(null, psec.accounts.last_accounts.type);
        
        system.assertNotEquals(null, psec.registered_office_address.address_line_1);
        system.assertNotEquals(null, psec.registered_office_address.address_line_2);
        system.assertNotEquals(null, psec.registered_office_address.country);
        system.assertNotEquals(null, psec.registered_office_address.locality);
        system.assertNotEquals(null, psec.registered_office_address.po_box);
        system.assertNotEquals(null, psec.registered_office_address.postal_code);
        system.assertNotEquals(null, psec.registered_office_address.premises);
        system.assertNotEquals(null, psec.registered_office_address.region);
        
        system.assertNotEquals(null, psec.annual_return.next_due);
        system.assertNotEquals(null, psec.annual_return.last_made_up_to);
        system.assertNotEquals(null, psec.annual_return.next_made_up_to);
        system.assertNotEquals(null, psec.annual_return.overdue);
        
        system.assertNotEquals(null , psec.officer_summary.active_count);
        system.assertNotEquals(null , psec.officer_summary.resigned_count);
        system.assertNotEquals(null , psec.officer_summary.officers.get(0).appointed_on);
        system.assertNotEquals(null , psec.officer_summary.officers.get(0).date_of_birth);
        system.assertNotEquals(null , psec.officer_summary.officers.get(0).name);
        system.assertNotEquals(null , psec.officer_summary.officers.get(0).officer_role);
    }
    
    public static testMethod void webservicecall_CompanyByRegAddress(){
        //TODO create custom setting with endpoint and token
        
        API_Org_Settings__c cs = new API_Org_Settings__c();
        cs.Name='Org_Settings';
        cs.CH_Endpoint_cNum_URL__c = 'https://api.test.gov.uk/registered-office-address';
        cs.CH_Authentication_Token__c = '1234567890';
        
        insert cs;
        
        CompaniesHouse.RegisteredOfficeAddress psec = new CompaniesHouse.RegisteredOfficeAddress();
        CompaniesHouseCalloutsResponse wr = new CompaniesHouseCalloutsResponse ();
        
        Test.startTest();
        
        //deserialize JSON string
        psec = wr.getResponseRegisteredOfficeAddress(ChApiMock.ADDRESS_JSON);
        system.assertNotEquals(null, psec.postal_code);
        system.assertNotEquals(null, psec.address_line_1);
        system.assertNotEquals(null, psec.locality);
        system.assertNotEquals(null, psec.etag);
        system.assertNotEquals(null, psec.address_line_2);
        system.assertNotEquals(null, psec.country);
        system.assertNotEquals(null, psec.po_box);
        system.assertNotEquals(null, psec.premises);
        system.assertNotEquals(null, psec.region);

        Test.stopTest();
    }
    
    public static testMethod void webservicecall_CompanyByOffList(){
        //TODO create custom setting with endpoint and token
        
        API_Org_Settings__c cs = new API_Org_Settings__c();
        cs.Name='Org_Settings';
        cs.CH_Endpoint__c = 'https://api.test.gov.uk/company/09416515/officers';
        cs.CH_Authentication_Token__c = '1234567890';
        
        insert cs;
        
        CompaniesHouse.OfficerList psec = new CompaniesHouse.OfficerList();
        CompaniesHouseCalloutsResponse wr = new CompaniesHouseCalloutsResponse();
   
        String CH_search= '45286515';
        
        Test.startTest();

        // deserialize JSON string
        psec = wr.getResponseOfficerList(ChApiMock.OFFICERS_LIST);
        
        Test.stopTest();
        
        System.assert(psec != null);
        System.assertNotEquals(null, psec.active_count);
        System.assertNotEquals(null, psec.etag);
        System.assertNotEquals(null, psec.items_per_page);
        System.assertNotEquals(null, psec.kind);
        System.assertNotEquals(null, psec.resigned_count);
        System.assertNotEquals(null, psec.start_index);
        System.assertNotEquals(null, psec.total_results);
       
        System.assertNotEquals(null, psec.items.get(0).appointed_on);
        System.assertNotEquals(null, psec.items.get(0).country_of_residence);
        System.assertNotEquals(null, psec.items.get(0).date_of_birth);
        System.assertNotEquals(null, psec.items.get(0).name);
        System.assertNotEquals(null, psec.items.get(0).nationality);
        System.assertNotEquals(null, psec.items.get(0).occupation);
        System.assertNotEquals(null, psec.items.get(0).officer_role);
        System.assertNotEquals(null, psec.items.get(0).resigned_on);
        
        System.assertNotEquals(null, psec.items.get(0).links.officer.appointments);
        
        System.assertNotEquals(null, psec.items.get(0).address.address_line_1);
        System.assertNotEquals(null, psec.items.get(0).address.address_line_2);
        System.assertNotEquals(null, psec.items.get(0).address.care_of);
        System.assertNotEquals(null, psec.items.get(0).address.country);
        System.assertNotEquals(null, psec.items.get(0).address.locality);
        System.assertNotEquals(null, psec.items.get(0).address.po_box);
        System.assertNotEquals(null, psec.items.get(0).address.postal_code);
        System.assertNotEquals(null, psec.items.get(0).address.premises);
        System.assertNotEquals(null, psec.items.get(0).address.region);

        System.assertNotEquals(null, psec.items.get(0).date_of_birth.day);        
        System.assertNotEquals(null, psec.items.get(0).date_of_birth.month);
        System.assertNotEquals(null, psec.items.get(0).date_of_birth.year);
    }
    
    public static testMethod void webservicecall_CompanyByInsolvency(){
        // TODO: Create custom setting with endpoint and token
        API_Org_Settings__c cs = new API_Org_Settings__c();
        cs.Name='Org_Settings';
        cs.CH_Endpoint__c = 'https://api.test.gov.uk/insolvency';
        cs.CH_Authentication_Token__c = '1234567890';
        
        insert cs;
        
        CompaniesHouse.CompanyInsolvency psec = new CompaniesHouse.CompanyInsolvency();
        CompaniesHouseCalloutsResponse wr = new CompaniesHouseCalloutsResponse();
        
        Test.startTest();
        
        psec = wr.getResponseCompanyInsolvency(ChApiMock.INSOLVENCY_JSON);
        
        system.assertNotEquals(null, psec.status.get(0));
        system.assertNotEquals(null, psec.etag);
        
        system.assertNotEquals(null, psec.cases.get(0).type);
        system.assertNotEquals(null, psec.cases.get(0).chNumber);
        
        system.assertNotEquals(null, psec.cases.get(0).dates.get(0).type);
        system.assertNotEquals(null, psec.cases.get(0).dates.get(0).chDate);
        
        system.assertNotEquals(null, psec.cases.get(0).links.charge);
        system.assertNotEquals(null, psec.cases.get(0).notes.get(0));
        
        system.assertNotEquals(null, psec.cases.get(0).practitioners.get(0).name);
        system.assertNotEquals(null, psec.cases.get(0).practitioners.get(0).ceased_to_act_on);
        system.assertNotEquals(null, psec.cases.get(0).practitioners.get(0).appointed_on);
        system.assertNotEquals(null, psec.cases.get(0).practitioners.get(0).role);
        
        system.assertNotEquals(null, psec.cases.get(0).practitioners.get(0).address.address_line_1);
        system.assertNotEquals(null, psec.cases.get(0).practitioners.get(0).address.address_line_1);      
        system.assertNotEquals(null, psec.cases.get(0).practitioners.get(0).address.locality);
        system.assertNotEquals(null, psec.cases.get(0).practitioners.get(0).address.postal_code);
        system.assertNotEquals(null, psec.cases.get(0).practitioners.get(0).address.locality);      
        system.assertNotEquals(null, psec.cases.get(0).practitioners.get(0).address.locality);
       
        Test.stopTest();
    }

    public static testMethod void webservicecall_CompanyByFilingHistory(){
          //TODO create custom setting with endpoint and token
        
        API_Org_Settings__c cs = new API_Org_Settings__c();
        cs.Name='Org_Settings';
        cs.CH_Endpoint__c = 'https://api.test.gov.uk/filing-history';
        cs.CH_Authentication_Token__c = '1234567890';
        
        insert cs;
        
        CompaniesHouse.FilingHistoryList psec = new CompaniesHouse.FilingHistoryList();
        CompaniesHouseCalloutsResponse wr = new CompaniesHouseCalloutsResponse();
        Test.startTest();
        
        //deserialize JSON string
        psec = wr.getResponseFilingHistoryList(ChApiMock.LIST_FILING_JSON);
        
        system.assertNotEquals(null, psec.total_count);
        system.assertNotEquals(null, psec.start_index);
        system.assertNotEquals(null, psec.kind);
        system.assertNotEquals(null, psec.items_per_page);
        system.assertNotEquals(null, psec.filing_history_status);
        system.assertNotEquals(null, psec.etag);
        
        
        system.assertNotEquals(null, psec.items.get(0).barcode);
        system.assertNotEquals(null, psec.items.get(0).category);
        system.assertNotEquals(null, psec.items.get(0).chDate);
        system.assertNotEquals(null, psec.items.get(0).description);
        system.assertNotEquals(null, psec.items.get(0).pages);
        system.assertNotEquals(null, psec.items.get(0).paper_filed);
        system.assertNotEquals(null, psec.items.get(0).subcategory);
        system.assertNotEquals(null, psec.items.get(0).transaction_id);
        system.assertNotEquals(null, psec.items.get(0).type);
        
        Test.stopTest();  
    }
    
    public static testMethod void webservicecall_CompanyByGetFilingHistory(){
          //TODO create custom setting with endpoint and token
        
        API_Org_Settings__c cs = new API_Org_Settings__c();
        cs.Name='Org_Settings';
        cs.CH_Endpoint__c = 'https://api.test.gov.uk/filing-history/';
        cs.CH_Authentication_Token__c = '1234567890';
        
        insert cs;
        
        CompaniesHouse.FilingHistoryDetails psec = new CompaniesHouse.FilingHistoryDetails();
        CompaniesHouseCalloutsResponse wr = new CompaniesHouseCalloutsResponse();
        
        Test.startTest();
        
        //deserialize JSON string
        psec = wr.getResponseFilingHistoryDetails(ChApiMock.GET_FILING_JSON);
        
        system.assertNotEquals(null, psec.description);
        system.assertNotEquals(null, psec.type);
        system.assertNotEquals(null, psec.category);
        system.assertNotEquals(null, psec.subcategory);
        system.assertNotEquals(null, psec.chDate);
        system.assertNotEquals(null, psec.links.document_metadata);
        system.assertNotEquals(null, psec.links.self);
        system.assertNotEquals(null, psec.pages);
        system.assertNotEquals(null, psec.paper_filed);
        system.assertNotEquals(null, psec.barcode);
        system.assertNotEquals(null, psec.transaction_id);
        
        system.assertNotEquals(null, psec.annotations.get(0).annotation);
        system.assertNotEquals(null, psec.annotations.get(0).chDate);
        system.assertNotEquals(null, psec.annotations.get(0).description);
        
        system.assertNotEquals(null, psec.resolutions.get(0).category);
        system.assertNotEquals(null, psec.resolutions.get(0).description);
        system.assertNotEquals(null, psec.resolutions.get(0).document_id);
        system.assertNotEquals(null, psec.resolutions.get(0).receive_date);
        system.assertNotEquals(null, psec.resolutions.get(0).type);
        
        system.assertNotEquals(null, psec.associated_filings.get(0).chDate);
        system.assertNotEquals(null, psec.associated_filings.get(0).description);
        system.assertNotEquals(null, psec.associated_filings.get(0).type);
        
        Test.stopTest();
        
        System.assert(psec != null);
    }
    
    public static testMethod void webservicecall_CompanyByGetSingleChargeHistory(){
         //TODO create custom setting with endpoint and token
        
        API_Org_Settings__c cs = new API_Org_Settings__c();
        cs.Name='Org_Settings';
        cs.CH_Endpoint__c = 'https://api.test.gov.uk/charges/';
        cs.CH_Authentication_Token__c = '1234567890';
        
        insert cs;
        
        CompaniesHouse.ChargeDetails psec = new CompaniesHouse.ChargeDetails();
        CompaniesHouseCalloutsResponse wr = new CompaniesHouseCalloutsResponse();
        Test.startTest();
        
        //deserialize JSON string
        psec = wr.getResponseChargeDetails(ChApiMock.GET_CHARGES_JSON);
        
        Test.stopTest();
        
        system.assertNotEquals(null, psec.etag);
        system.assertNotEquals(null, psec.status);
        system.assertNotEquals(null, psec.charge_number);
        system.assertNotEquals(null, psec.created_on);
        system.assertNotEquals(null, psec.delivered_on);
        system.assertNotEquals(null, psec.satisfied_on);
        system.assertNotEquals(null, psec.acquired_on);
        system.assertNotEquals(null, psec.charge_code);
        system.assertNotEquals(null, psec.assets_ceased_released);
        system.assertNotEquals(null, psec.covering_instrument_date);
        system.assertNotEquals(null, psec.more_than_four_persons_entitled);
        system.assertNotEquals(null, psec.resolved_on);
        
        system.assertNotEquals(null, psec.classification.type);
        system.assertNotEquals(null, psec.classification.description);
     
        system.assertNotEquals(null, psec.insolvency_cases.get(0).case_number);
        system.assertNotEquals(null, psec.insolvency_cases.get(0).transaction_id);
        system.assertNotEquals(null, psec.insolvency_cases.get(0).links.chCase);
        
        system.assertNotEquals(null, psec.particulars.type);
        system.assertNotEquals(null, psec.particulars.description);
        system.assertNotEquals(null, psec.particulars.chargor_acting_as_bare_trustee);
        system.assertNotEquals(null, psec.particulars.contains_fixed_charge);
        system.assertNotEquals(null, psec.particulars.contains_floating_charge);
        system.assertNotEquals(null, psec.particulars.contains_negative_pledge);
        system.assertNotEquals(null, psec.particulars.floating_charge_covers_all);
         
        system.assertNotEquals(null, psec.links.self);        
      
        system.assertNotEquals(null, psec.persons_entitled.get(0).name);
         
        system.assertNotEquals(null, psec.scottish_alterations.has_alterations_to_order);
        system.assertNotEquals(null, psec.scottish_alterations.has_alterations_to_prohibitions);
        system.assertNotEquals(null, psec.scottish_alterations.has_restricting_provisions);
       
        system.assertNotEquals(null, psec.secured_details.description);
        system.assertNotEquals(null, psec.secured_details.type);
       
        system.assertNotEquals(null, psec.transactions.get(0).delivered_on);
        system.assertNotEquals(null, psec.transactions.get(0).filing_type);
        system.assertNotEquals(null, psec.transactions.get(0).insolvency_case_number);
        system.assertNotEquals(null, psec.transactions.get(0).transaction_id);
        
        system.assertNotEquals(null, psec.transactions.get(0).links.filing);
        system.assertNotEquals(null, psec.transactions.get(0).links.insolvency_case);
    }
    
    public static testMethod void webservicecall_CompanyByListChargeHistory(){
        //TODO create custom setting with endpoint and token
        
        API_Org_Settings__c cs = new API_Org_Settings__c();
        cs.Name='Org_Settings';
        cs.CH_Endpoint__c = 'https://api.test.gov.uk/charges';
        cs.CH_Authentication_Token__c = '1234567890';
        
        insert cs;
        
        CompaniesHouseCalloutsResponse wr = new CompaniesHouseCalloutsResponse();
        CompaniesHouse.ChargeList psec;
        
        Test.startTest();
        //deserialize JSON string
        psec = wr.getResponseChargeList(ChApiMock.LIST_CHARGES_JSON);
        
        System.assert(psec != null);
        
        System.assertNotEquals(null, psec.satisfied_count);
        System.assertNotEquals(null, psec.etag);
        System.assertNotEquals(null, psec.part_satisfied_count);
        System.assertNotEquals(null, psec.total_count);
        System.assertNotEquals(null, psec.unfiltered_count);
        
        system.assertNotEquals(null, psec.items.get(0).etag);
        system.assertNotEquals(null, psec.items.get(0).links.self);
        system.assertNotEquals(null, psec.items.get(0).delivered_on);
        system.assertNotEquals(null, psec.items.get(0).status);
        system.assertNotEquals(null, psec.items.get(0).charge_number);
        system.assertNotEquals(null, psec.items.get(0).satisfied_on);
        system.assertNotEquals(null, psec.items.get(0).created_on);
        system.assertNotEquals(null, psec.items.get(0).resolved_on);
        
        system.assertNotEquals(null, psec.items.get(0).more_than_four_persons_entitled);
        system.assertNotEquals(null, psec.items.get(0).covering_instrument_date);
        system.assertNotEquals(null, psec.items.get(0).charge_code);
        system.assertNotEquals(null, psec.items.get(0).assets_ceased_released);
        system.assertNotEquals(null, psec.items.get(0).acquired_on);
        
        system.assertNotEquals(null, psec.items.get(0).classification.type);
        system.assertNotEquals(null, psec.items.get(0).classification.description);
        
        system.assertNotEquals(null, psec.items.get(0).particulars.type);
        system.assertNotEquals(null, psec.items.get(0).particulars.description);
        system.assertNotEquals(null, psec.items.get(0).particulars.chargor_acting_as_bare_trustee);
        system.assertNotEquals(null, psec.items.get(0).particulars.contains_fixed_charge);
        system.assertNotEquals(null, psec.items.get(0).particulars.contains_floating_charge);
        system.assertNotEquals(null, psec.items.get(0).particulars.contains_negative_pledge);
        system.assertNotEquals(null, psec.items.get(0).particulars.floating_charge_covers_all);
        
        system.assertNotEquals(null, psec.items.get(0).scottish_alterations.has_alterations_to_order);
        system.assertNotEquals(null, psec.items.get(0).scottish_alterations.has_alterations_to_prohibitions);
        system.assertNotEquals(null, psec.items.get(0).scottish_alterations.has_restricting_provisions);
        
        system.assertNotEquals(null, psec.items.get(0).transactions.get(0).delivered_on);
        system.assertNotEquals(null, psec.items.get(0).transactions.get(0).links);
        
        system.assertNotEquals(null, psec.items.get(0).persons_entitled.get(0).name);
        
        system.assertNotEquals(null, psec.items.get(0).secured_details.description);
        system.assertNotEquals(null, psec.items.get(0).secured_details.type);

        Test.stopTest();
    }
   
}