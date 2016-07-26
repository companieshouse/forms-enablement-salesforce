/**
 * Singleton containing various SObjects and Apex class instances suitable for use in test cases.
 * 
 * Getting an instance of this class should *not* do any DML operations, so that we can still call
 * out after getting an instance. If you want stuff on this class persisted, insert it yourself in
 * calling code.
 * 
 * Author: eliot.stock@methodsdigitial.co.uk
 * Update: antonio.bravo@golligo.co.uk
 */
public class CompaniesHouseTestData {

    private static CompaniesHouseTestData instance;
    
    
    public Transaction__c tx {get; private set;}

    public Officer__c off {get; private set;}

    public Officer__c off2 {get; private set;}
    
    public Attachment pdf {get; private set;}

    public dsfs__DocuSign_Status__c dss {get; private set;} //ab

    public Transaction_Type__mdt testForm {get; private set;}

    public Transaction_Type_Step__mdt testStep1 {get; private set;}

    public Transaction_Type_Step__mdt testStep2 {get; private set;}

    public Transaction_Type_Step__mdt testStep3 {get; private set;}

    public Account presenterAccount {get; private set;}

    public Account companyAccount {get; private set;}

    public Contact contact1 {get; private set;}

    public Contact contact2 {get; private set;}
    
    // Prevent construction by making this private. Use getInstance() instead (singleton).  
    private CompaniesHouseTestData() {

        
		tx = new Transaction__c(Status__c = AppConstants.REQUEST_STATUS_DRAFT,
                                Transaction_Type__c = 'DS01',
                                Amount__c = 10, 
                                Barcode__c = '12345', 
                                CompanyName__c = 'Test Company LTD', 
                                CompanyNumber__c = '0987654321', 
                                Form_Name__c = 'DS01',
                                Version_Form__c = '1');


        off = new Officer__c(Forename__c = 'Test',
                            Surname__c = 'Name',
                            Email__c = 'test@test.com',
                            isSignatory__c = true);

        off2 = new Officer__c(Forename__c = 'Test2',
                            Surname__c = 'Name2',
                            Email__c = 'test2@test.com',
                            isSignatory__c = true);
        
        pdf = new Attachment(Name = 'unit test attachment',
				Body = Blob.valueOf('unit test attachment'),
				ParentId = tx.Id);

        //ab
        dss = new dsfs__DocuSign_Status__c ();

        testForm = [Select isMajorityForm__c,Product_Code__c,isPaymentRequired__c,Below_Button_Text__c, Below_Button_Text2__c, Below_Button_Text3__c, Below_Button_Title__c, Id, DeveloperName, Family__c, Fee__c, MasterLabel, Label, Landing_Page_Text__c, Landing_Page_Text2__c, Landing_Page_Text3__c, Landing_Page_Text4__c, Landing_Page_Text5__c, Landing_Page_Text6__c, Landing_Page_Title__c, Language, NamespacePrefix, QualifiedApiName, Serialisation_Class_Name__c, above_button_text__c,isDigitalSignatureNeeded__c from Transaction_Type__mdt Where DeveloperName = 'TestForm'];

        testStep1 = [Select Apex_Class_Name__c, Id, DeveloperName, Display_Text_1__c, Display_Text_2__c, Display_Text_3__c, Document_Template_Name__c, Header_Text_1__c, Is_Active__c, Label, MasterLabel, Language, NamespacePrefix, Persist_FieldSet_1_Name__c, QualifiedApiName, Query_FieldSet_1_Name__c, SObject_Type__c, Step_Number__c, Step_Type__c, Transaction_Type__c, Visualforce_Page_Name__c From Transaction_Type_Step__mdt Where DeveloperName = 'TestStep1'];

        testStep2 = [Select Apex_Class_Name__c, Id, DeveloperName, Display_Text_1__c, Display_Text_2__c, Display_Text_3__c, Document_Template_Name__c, Header_Text_1__c, Is_Active__c, Label, MasterLabel, Language, NamespacePrefix, Persist_FieldSet_1_Name__c, QualifiedApiName, Query_FieldSet_1_Name__c, SObject_Type__c, Step_Number__c, Step_Type__c, Transaction_Type__c, Visualforce_Page_Name__c From Transaction_Type_Step__mdt Where DeveloperName = 'TestStep2'];

        testStep3 = [Select Apex_Class_Name__c, Id, DeveloperName, Display_Text_1__c, Display_Text_2__c, Display_Text_3__c, Document_Template_Name__c, Header_Text_1__c, Is_Active__c, Label, MasterLabel, Language, NamespacePrefix, Persist_FieldSet_1_Name__c, QualifiedApiName, Query_FieldSet_1_Name__c, SObject_Type__c, Step_Number__c, Step_Type__c, Transaction_Type__c, Visualforce_Page_Name__c From Transaction_Type_Step__mdt Where DeveloperName = 'TestStep3'];

        presenterAccount = new Account(Name = 'sylvain.picory@methodsdigitial.co.uk');

        companyAccount = new Account(Name = '05448736');

        contact1 = new Contact(LastName = 'Temp');

        contact2 = new Contact(LastName = 'Temp');
    }

	public static CompaniesHouseTestData getInstance() {
        if (instance == null) {
            instance = new CompaniesHouseTestData();
        }


        return instance;
    }
    
}