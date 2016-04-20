/**
 * Singleton containing various SObjects and Apex class instances suitable for use in test cases.
 * 
 * Getting an instance of this class should *not* do any DML operations, so that we can still call
 * out after getting an instance. If you want stuff on this class persisted, insert it yourself in
 * calling code.
 * 
 * Author: eliot.stock@methodsdigitial.co.uk
 */
public class CompaniesHouseTestData {

    private static CompaniesHouseTestData instance;
    
    public Form ds01 {get; private set;}
    
    public Transaction__c tx {get; private set;}

    public Officer__c off {get; private set;}
    
    public Attachment pdf {get; private set;}

    public dsfs__DocuSign_Status__c dss {get; private set;} //ab
    
    // Prevent construction by making this private. Use getInstance() instead (singleton).  
    private CompaniesHouseTestData() {
        ds01 = new Form('DS01', 1, '08906750', 'Methods Digital Limited');

        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
        
		tx = new Transaction__c(Amount__c = 10, Barcode__c = '12345', CompanyName__c = 'Test Company LTD', CompanyNumber__c = '0987654321', Form_Name__c = 'DS01', SubmissionId__c = guid);

        off = new Officer__c(Name = 'Test Name',
                            Email__c = 'test@test.com');
        
        pdf = new Attachment(Name = 'unit test attachment',
				Body = Blob.valueOf('unit test attachment'),
				ParentId = tx.Id);

        //ab
        dss = new dsfs__DocuSign_Status__c ();
    }

	public static CompaniesHouseTestData getInstance() {
        if (instance == null) {
            instance = new CompaniesHouseTestData();
            createDocuSignSetting();

        }


        return instance;
    }

    //Create Custom Setting
    static void createDocuSignSetting() {
        DocuSignSetting__c dsSett = new DocuSignSetting__c();
        dsSett.Name = 'Test setting';
        dsSett.AccountId__c = 'AccountId';
        dsSett.IntegratorKey__c = 'Key';
        dsSett.Username__c = 'username';
        dsSett.Password__c = 'password';
        dsSett.URL__c = 'DocuSign';

        Schema.DescribeSObjectResult r = dsfs__DocuSign_Status__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        dsSett.RecordIdPrefix__c = keyPrefix;

        insert dsSett;
    }
    
}