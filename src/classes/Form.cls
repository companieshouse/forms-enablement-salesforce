/**
 * This class acts as a namespace for structs that we use for generating JSON to send to
 * the Forms API service. To generate JSON, use an instance of this class and call
 * JSON.serialize().
 * 
 * TODO: Rename this to FormDS so as to be clear that it applies to the DS family of forms.
 * Future forms not in this family will require a new Apex class.
 * 
 * Author: eliot.stock@methodsdigitial.co.uk
 */
public class Form {
    
    public String type;
    public Integer id;
    public Integer groupId;
    public Integer version;
    public String imageVersion;
	public String debugRule;
    public List<Attachment> attachments;
    public List<Image> images;
    public CorporateBody corporateBody;
    public FilingDetails filingDetails;
    
    public Form(String formType, Integer formId, String incorporationNumber, String corporateBodyName) {
        type = formType;
        id = formId;
        
        corporateBody = new CorporateBody();
        corporateBody.incorporationNumber = incorporationNumber;
        corporateBody.corporateBodyName = corporateBodyName;
    }
    
    public class Attachment {
		public String data;
		public String mimeType;
		public String category;
    }
    
    public class Image {
		public String data;
		public String mimeType;
    }
    
    public class PersonName {
		public String forename;
		public String middlenames;
		public String surname;
    }
        
    public class Address {
		public String address;
		public String postCode;
		public String country;
		public String region;
		public String postTown;
		public String area;
		public String street;
		public String houseNameNum;
		public String careOfCompany;
		public String poBox;
		public String careOf;
    }
    
    public class AuthenticationPair {
		public String authenticationData;
		public String authenticationItem;
    }
    
    public class PersonalAuthentication {
        public String authenticationStatus;
        public AuthenticationPair authenticationPair1;
        public AuthenticationPair authenticationPair2;
        public AuthenticationPair authenticationPair3;
    }
    
    public class Officer {
        public PersonalAuthentication personalAuthentication;
        public Date birthDate;
        public PersonName personName;
    }
    
    public class CorporateBody {
        public String incorporationNumber;
        public String corporateBodyName;
        public List<Officer> officers;
    }
    
    public class Dissolution {
        public Address address;
    }
    
    public class Payment {
		public String referenceNumber;
		public String cardNumber;
		public String accountNumber;
		public String paymentMethod;
    }
    
    public class PresenterDetails {
		public String presenterAddressPostCode;
		public String presenterAddressCountry;
		public String presenterAddressCounty;
		public String presenterAddressPostTown;
		public String presenterAddressLine2;
		public String presenterAddressLine1;
		public String presenterEmailOut;
		public String presenterEmailIn;
		public String presenterAccountNumber;
		public String presenterName;
    }
    
    public class ContactDetails {
		public String dxExchange1;
		public String dxNumber1;
		public String phoneNumber1;
		public String email1;
		public String contactName;
    }
    
    public class Authentication {
        public String code;
        public String status;
    }
    
    public class FilingDetails {
        public String commsLanguage;
        public Boolean welshDocument;
        public Payment payment;
        public PresenterDetails presenterDetails;
        public ContactDetails contactDetails;
        public String authoriser;
        public Authentication authentication;
        public Date signDate;
		public String barcode;
		public String presenterDocumentReference;
		public Date receiptDate;
		public String feeStatus;
		public String method;
    }
    
}