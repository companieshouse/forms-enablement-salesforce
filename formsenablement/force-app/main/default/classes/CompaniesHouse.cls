global with sharing class CompaniesHouse {

    //Wrapper Class - variable that holds top level information from JSON

    global class CompanySearchList{
        
        public String kind {get; set;}
        public Integer start_index {get; set;}
        public Integer page_number {get; set;}
        public List<CompanySearchDetails> items {get; set;}
        public Integer items_per_page {get; set;}
        public Integer total_results {get; set;}
        public String etag{get;set;}
    }

    global class CompanySearchDetails{
    	
        public List<String> description_identifier {get;set;}
        public String description {get;set;}
        public String date_of_creation {get;set;}
        public String title {get;set;}
        public String snippet {get;set;}
        public String kind {get;set;}
        public String url {get;set;}
        public String markdown_title {get;set;}
        public String company_number{get;set;}
        public String company_type{get;set;}
        public String company_status{get;set;}
        public Date markdown_description {get;set;}
    //    public DescriptionValues description_values {get;set;}
        public RegisteredOfficeAddress address{get;set;}
    }


   
    global class OfficerDetails{
        
        public String country_of_residence {get;set;}
        public Links links {get;set;}
        public String name {get;set;}
        public String appointed_on {get;set;}
        public String officer_role {get;set;}
        public String occupation {get;set;}
        public RegisteredOfficeAddress address {get;set;}
        public String nationality {get;set;}
        public DateOfBirth date_of_birth {get;set;}
        Public Date resigned_on {get;set;}
        
    }
    

   
   global class Annotation{
   		public String annotation {get;set;}
   		public Date chDate {get;set;}
   		public String description {get;set;}
   }

   global class FilingHistoryList{

   		public List<FilingHistoryDetails> items {get;set;}
   		public String etag {get;set;}
   		public String filing_history_status{get;set;}
   		public Integer items_per_page {get;set;}
   		public String kind {get;set;}
   		public Integer start_index{get;set;}
   		public Integer total_count {get;set;}

  } 

    global class FilingHistoryDetails{
    	//Fields below are for Filing History
      
        public String type{get;set;}
        public String category{get;set;}
        public String subcategory{get;set;}
        public String description{get;set;}
        public Date chDate {get;set;}

        public Integer pages{get;set;}
        public Boolean paper_filed{get;set;}
        public String barcode{get;set;}
        public String transaction_id{get;set;}
      //  public DescriptionValues description_values;
        public List<Resolution> resolutions{get;set;}
        public String action_date{get;set;}
        public List<AssociatedFiling> associated_filings{get;set;}
        public Links links {get;set;}
        public List<Annotation> annotations {get;set;}
    }
   
    //Wrapper Class - variable that holds details of company from JSON
    global class DescriptionValues {
        
          
        //fields below for Filing History API Call
        public String form_attached;
   
    } 
    
    /* Search Company by Number */
    
    global class CompanyProfile{
        
        public Boolean undeliverable_registered_office_address {get;set;}
        public String date_of_creation {get;set;}
        public List<String> sic_codes {get;set;}
        
        //last_full_members_list_date is a Boolean type but returning back a String.
        public String last_full_members_list_date  {get;set;}
        
        public String company_number {get;set;}
        public String jurisdiction {get;set;}
        public String company_name {get; set;}
        public String type {get;set;}
        public Boolean has_been_liquidated {get;set;}
        public Boolean has_insolvency_history {get;set;}
        public String etag {get;set;} 
        public String company_status {get;set;}
        public Boolean has_charges {get;set;}
        public Boolean can_file {get;set;}
        
        public String company_status_detail{get;set;}
        public date date_of_dissolution{get;set;}
        public Boolean registered_office_is_in_dispute{get;set;}
        
        
        public AnnualReturn annual_return  {get;set;}
        public RegisteredOfficeAddress registered_office_address  {get;set;}
        public Account accounts {get;set;}
        public OfficerSummary officer_summary {get;set;}
        
    }

    global class Account {
        public LastAccounts last_accounts {get;set;}
        public Boolean overdue {get; set;}
        public AccountingReferenceDate accounting_reference_date {get;set;}
        public String next_made_up_to {get; set;}
        public String next_due {get; set;}
    }

    global class AnnualReturn {
        public String last_made_up_to {get;set;}
        public String next_made_up_to {get;set;}
        public Boolean overdue {get;set;}
        public String next_due {get;set;}
    }

    global class Officers {
        public String officer_role {get;set;}
        public String name {get;set;}
        public DateOfBirth date_of_birth {get;set;}
        public String appointed_on {get;set;}
        public String appointments{get;set;}
    }

    global class DateOfBirth {
        Public Integer Day{get;set;}
        Public Integer Month{get;set;}
        Public Integer Year{get;set;}
        
    }
    global class AccountingReferenceDate {
        public String day {get;set;}
        public String month {get;set;}
    }

    global class OfficerSummary {
        public Integer active_count {get;set;}
        public List<Officers> officers {get;set;}
        public Integer resigned_count {get;set;}
    }

    global class LastAccounts {
        public String type {get;set;}
        public String made_up_to {get;set;}
    }

    
    
    /* Registered Address API   */
    
    global class RegisteredOfficeAddress{
        public String region {get;set;}
        public String postal_code {get;set;}
        public String locality {get;set;}
        public String address_line_1 {get;set;}
        public String address_line_2 {get;set;}
        public String country {get;set;}
        public String etag {get;set;}
        public String po_box {get;set;}
        public String premises {get;set;}
        public String care_of {get;set;}
      //  public Errors errors{get;set;}
	}

    global class ErrorList{
    	public List<Error> errors {get;set;}
    }

	global class Error{
		public String error {get;set;}
		public String location {get;set;}
		public String location_type {get;set;}
		public String type {get;set;}

	}

	global class ErrorValue{
		/*
	"error_values" : [
        {
           "<argument>" : "<value>"
        }
     ],*/
}

/* Officer List API */
        global class OfficerList{
            public Integer resigned_count{get;set;}
            public List<OfficerDetails> items{get;set;}
            public Integer items_per_page{get;set;}
            public Integer active_count{get;set;}
            public String etag{get;set;}
            public Links links{get;set;}
            public String kind{get;set;}
            public Integer total_results{get;set;}
            public Integer start_index{get;set;}
    }
    
    global class Links {
        public Officers officer{get;set;}
        public String charge{get;set;}
        
        //fields below for Filing History API Call
        public String document_metadata{get;set;}
        public String self{get;set;}

        //charges API Call
        public String chCase {get;set;}
        public String filing {get;set;}
        public String insolvency_case {get;set;}
    }    
   /* 
public with sharing class OfficerZ {
    public String appointments{get;set;}
}
*/
  /* Insolvency API */
    
    global class CompanyInsolvency{
        
        public List<chCase> cases{get;set;}
        public List<String> status{get;set;}
        public String etag{get;set;}
    }



    global class chCase {
        public List<Practitioners> practitioners{get;set;}
        public String type{get;set;}
        public String chNumber{get;set;}
        public List<Dates> dates{get;set;}
        public Integer case_number {get;set;}
        public Integer transaction_id {get;set;}
        public Links links {get;set;}
        public List<String> notes{get;set;}
    }

    
    global class Practitioners {
        public String name{get;set;}
        public String ceased_to_act_on{get;set;}
        public String appointed_on{get;set;}
        public String role{get;set;}
        public RegisteredOfficeAddress address{get;set;}
    }

    global class Dates {
        public String type{get;set;}
        public String chDate{get;set;}
    }

   
	global class Data {
    }

    global class Resolution {
        public String category{get;set;}
        public String type{get;set;}
        public String description{get;set;}
        public List<String> subcategory{get;set;}
        public String document_id{get;set;}
        public Date receive_date {get;set;}
    
    }

    global class AssociatedFiling {

        public String description{get;set;}
        public String chDate {get;set;}
        public String type{get;set;}
   
    }

    global class ChargeList{
        public List<ChargeDetails> items {get;set;}
        public String etag {get;set;}
        public Integer part_satisfied_count {get;set;}
        public Integer satisfied_count {get;set;}
        public Integer total_count {get;set;}
        public Integer unfiltered_count {get;set;}
    }

    global class ChargeDetails{

        public Date acquired_on {get;set;}
        public String assets_ceased_released {get;set;}
        public String charge_code {get;set;}
        public Integer charge_number {get;set;}
        public classification classification {get;set;}
        public Date covering_instrument_date {get;set;}
        public Date created_on {get;set;}
        public Date delivered_on {get;set;}
        public String etag {get;set;}
        public List<chCase> insolvency_cases {get;set;}
        public Links links {get;set;}

        public boolean more_than_four_persons_entitled {get;set;}
        public Particulars particulars {get;set;}
        public List<PersonsEntitled> persons_entitled {get;set;}

        public Date resolved_on {get;set;}
        public Date satisfied_on {get;set;}
        public ScottishAlterations scottish_alterations {get;set;}
        public SecuredDetails secured_details {get;set;}

        public String status {get;set;}
        public List<Transactions> transactions {get;set;}
    }

      //new classes for Charges

    global class Classification{
        public string description {get;set;}
        public string type {get;set;}
    }

    global class Particulars{
        public boolean chargor_acting_as_bare_trustee {get;set;}
        public boolean contains_fixed_charge {get;set;}
        public boolean contains_floating_charge {get;set;}
        public boolean contains_negative_pledge {get;set;}
        public string description {get;set;}
        public boolean floating_charge_covers_all {get;set;}
        public string type{get;set;}
    }

    global class PersonsEntitled{
        public string name{get;set;}
    }
    
    global class ScottishAlterations{
        public boolean has_alterations_to_order {get;set;}
        public boolean has_alterations_to_prohibitions {get;set;}
        public boolean has_restricting_provisions {get;set;}
    }

    global class SecuredDetails{
        public String description {get;set;}
        public String type {get;set;}
    }
 
    global class Transactions{
        public Date delivered_on {get;set;}
        public String filing_type {get;set;}
        public Integer insolvency_case_number {get;set;}
        public Links links {get;set;}
        public Integer transaction_id {get;set;}
    }
}