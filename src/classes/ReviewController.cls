/**
 * Controller for the transaction review page on which the user arrives after signing
 * the PDF on Docusign. Presents the user with an inline rendering of the PDF and a submit
 * button that takes them to the payment page at SmartPay.
 * 
 * Author: eliot.stock@methods.co.uk
 */
public class ReviewController extends TransactionStepControllerBase{
    
// Public properties.
    public Boolean hasPageErrors { get; set; }

<<<<<<< HEAD
    public String displayText1 {get; set;}
    public String displayText2 {get; set;}
    public String displayText3 {get; set;}
    

=======
    // MetaData
    public String displayText1 {get; set;}
    public String displayText2 {get; set;}
    public String displayText3 {get; set;}
    public String headerText1 {get; set;}

    // dynamic data
    public String directorName {get; set;}
    public String companyName {get; set;}
    public String companyNumber {get; set;}
    public String presenterEmail {get; set;}
    public String presenterName {get; set;}
    public String presenterPhone {get; set;}

    public List<Officer__c> companyDirectors {get; set;}
   // public CompaniesHouse.registered_office_address companyaddress {get; set;}

    // company address information
    public String companyAddress1 {get;set;}
    public String companyAddress2 {get;set;}
    public String companyregion {get;set;}
    public String companypostcode {get;set;}
    public String companyCountry {get;set;}
    public String companyLocality {get;set;}
    public Boolean showprevious {get; set;}
>>>>>>> 09ed56bb0e63161e32a7e3f35b1bbb7c65bbb4b2
    public ReviewController() {
        super();
        if (isPageInitialised) initialiseStep();

    }
    
    public void initialiseStep() {
        displayText1 = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
<<<<<<< HEAD
        return;
        
=======
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.Name;
        presenterName =  submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c;

        companyDirectors = submissionMgr.submission.Officers__r;

        CompaniesHouse.CompanyProfile compProf = CompanyQueryAction.getCompanyInfo(companyNumber);
        companyAddress1 = compProf.registered_office_address.address_line_1;
        companyAddress2 = compProf.registered_office_address.address_line_2;
        companyregion = compProf.registered_office_address.region;
        companypostcode = compProf.registered_office_address.postal_code;
        companyCountry = compProf.registered_office_address.country;
        companyLocality = compProf.registered_office_address.locality;
        System.debug(' company profile is ' + compProf.registered_office_address);
        showprevious = true;
        if(submissionMgr.submission.Officers__r.size() > 1) {showprevious=false;}

        return;
>>>>>>> 09ed56bb0e63161e32a7e3f35b1bbb7c65bbb4b2
    }

    private void persistStep(){
        submissionMgr.persist();    
    }
    // End Instance methods.    
    
    // Action methods.     
    public PageReference nextAction(){ 
        if (!validatePageState()) return Page.TransactionException;
        
        persistStep();      

        return nextStep();      
    }
    
    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }
    // End Action methods.    
    
}