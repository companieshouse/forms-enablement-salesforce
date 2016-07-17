//Class used to translate to JSON the transaction
public class TransactionSerialiser {
	public final static String MIMETYPESTRING = 'application/pdf';
	public final static String CATEGORYSTRING = 'FORM IMAGE PDF';

	public class attachmentsWraper {
		public attachments[] attachments;
	}

	public class metadataWraper {
		public metadata metadata;
	}


	public class formdataWraper {
		public formdata formdata;
	}

	public class metadata {
		public String type {get; set;}
		public Integer packageindex {get; set;}
		public String version {get; set;}
		public String submissionReference {get; set;}

		public metadata() {}

		public metadata(String type, Integer packageindex, String version, String submissionReference) {
			this.type = type;
			this.packageindex = packageindex;
			this.version = version;
			this.submissionReference = submissionReference;
		}

	}

	public class payment {
		public String paymentMethod {get; set;}
		public String referenceNumber {get; set;}

		public payment() {}

		public payment(String paymentMethod, String referenceNumber) {
			this.paymentMethod = paymentMethod;
			this.referenceNumber = referenceNumber;
		}
	}

	public class filingDetails {
		public payment payment {get; set;}
		public String barcode {get; set;}
		public String receiptDate {get; set;}

		public filingDetails() {}

		public filingDetails(String barcode, String receiptDate, payment payment) {
			this.barcode = barcode;
			this.receiptDate = receiptDate;
			this.payment = payment;
		}
	}

	public class officer {
		public personName personName {get; set;}
		public String signDate {get; set;}

		public officer() {}

		public officer(personName personName, String signDate) {
			this.personName = personName;
			this.signDate = signDate;
		}
	}

// statement of capital starts here
	public class statementOfCapital {

		public List<shareValues> shareValues {get; set;}
		public List<shareClasses> shareClasses {get; set;}
		public List<latestSOCInd> latestSOCInd {get; set;}
		public List<grandTotals> grandTotals {get; set;}

		public statementOfCapital(List<shareValues> valueofShares, List<shareClasses> classesofShares, List<latestSOCInd> socIND, List<grandTotals> totals) {

			this.shareValues = valueofShares;
			this.shareClasses = classesofShares;
			this.latestSOCInd = socIND;
			this.grandTotals = totals;
		}
	}
	public class shareValues {
		public List<shareValue> shareValue {get; set;}

		public shareValues(List<shareValue> shareValue) {
			this.shareValue = shareValue;
		}
	}
	public class shareClasses {
		public List<shareClass> shareClass {get; set;}

		public shareClasses(List<shareClass> shareClass) {
			this.shareClass = shareClass;
		}
	}
	public class shareValue {
		public String currencyCode {get; set;}
		public Decimal value {get; set;}
		public Decimal totalAmountUnpaid {get; set;}
		public Decimal totalNumberOfShares {get; set;}

		public shareValue(String currencyCode, Decimal value, Decimal totalAmountUnpaid, Decimal totalNumberOfShares ) {
			this.currencyCode = currencyCode;
			this.value = value;
			this.totalAmountUnpaid = totalAmountUnpaid;
			this.totalNumberOfShares = totalNumberOfShares;
		}
	}
	public class shareClass {
		public String currencyCode {get; set;}
		public String suppliedClass {get; set;}
		public String description {get; set;}
		public Decimal sNumber {get; set;}
		// NUmber is a reserved word...
		public Decimal value {get; set;}

		public shareClass(String currencyCode, String suppliedClass, String description, Decimal value, Decimal sNumber ) {
			this.currencyCode = currencyCode;
			this.suppliedClass = suppliedClass;
			this.description = description;
			this.value = value;
			this.sNumber = sNumber;
		}
	}
	public class grandTotals {
		public List<shareValueGrandTotals> shareValueGrandTotals {get; set;}
		public List<shareNumberGrandTotal> shareNumberGrandTotal {get; set;}
		public grandTotals(List<shareNumberGrandTotal> snumbergtotal, List<shareValueGrandTotals> svaluegtotal) {

			this.shareNumberGrandTotal = snumbergtotal;
			this.shareValueGrandTotals = svaluegtotal;
		}
	}

	public class shareValueGrandTotals {
		public List<shareValueGrandTotal> shareValueGrandTotal {get; set;}

		public shareValueGrandTotals(List<shareValueGrandTotal> svaluegtotal) {
			this.shareValueGrandTotal = svaluegtotal;
		}
	}

	public class shareValueGrandTotal {
		public String currencyCode {get; set;}
		public Decimal totalAmountUnpaid {get; set;}
		public Decimal value {get; set;}
		public shareValueGrandTotal(String money, Decimal unpaidAmount, Decimal val) {
			this.currencyCode = money;
			this.totalAmountUnpaid = unpaidAmount;
			this.value = val;
		}
	}

	public class shareNumberGrandTotal {

		public shareNumberGrandTotal() {}
	}

	public class latestSOCInd {
		public String latestSOCInd {get; set;}

		public latestSOCInd(String latestSOCInd) {

			this.latestSOCInd = latestSOCInd;
		}
	}
	// Statement of capital ends here


	public class officerCollection {
		public List<officer> officer {get; set;}

		public officerCollection() {}

		public officerCollection(List<officer> officer) {
			this.officer = officer;
		}
	}

	public class personName {
		String titleOther {get; set;}
		String forename {get; set;}
		String middlenames {get; set;}
		String surname {get; set;}

		public personName() {}

		public personName(String titleOther, String forename, String middlenames, String surname) {
			this.titleOther = titleOther;
			this.forename = forename;
			this.middlenames = middlenames;
			this.surname = surname;
		}
	}

	public class corporateBody {
		public String incorporationNumber {get; set;}
		public String corporateBodyName {get; set;}
		public officerCollection officers {get; set;}
		public statementOfCapital statementOfCapital {get; set;}
		public corporateBody() {}

		// DS01
		public corporateBody(String incorporationNumber, String corporateBodyName, officerCollection officers) {
			this.incorporationNumber = incorporationNumber;
			this.corporateBodyName = corporateBodyName;
			this.officers = officers;
		}
		// SH19
		public corporateBody(String incorporationNumber, String corporateBodyName, statementOfCapital capitalStatement) {
			this.incorporationNumber = incorporationNumber;
			this.corporateBodyName = corporateBodyName;
			this.statementOfCapital = capitalStatement;
		}
	}

	public class formdata {
		public filingDetails filingDetails {get; set;}
		public corporateBody corporateBody {get; set;}

		public formdata() {}

		public formdata(filingDetails filingDetails, corporateBody corporateBody) {
			this.filingDetails = filingDetails;
			this.corporateBody = corporateBody;
		}

	}

	public class attachments { // PDF
		public String mimetype {get; set;}
		public String category {get; set;}
		public String data {get; set;}
		// Public String Name {get;set;}
		// public String Description  {get;set;}
		public attachments() {}

		public attachments(String mimetype, String category, String data) {
			// String name, String description
			this.mimetype = mimetype;
			this.category = category;
			this.data = data;
			//this.name = name;
			//this.description = description;
		}
	}
	// DS01 specific
	public static String transactionToJSON(Transaction__c transact) {
		//We need to convert the transaction record to a JSON object
		//
		if (transact == null) {
			return  JSON.serialize('Argument cannot be null.');

		}

		//Build each object for the JSON
		//
		metadata met = new metadata(transact.Form_Name__c, 1, transact.Version_Form__c, transact.SubmissionId__c);

		payment pay = new payment((transact.isPaymentAccount__c == true ? 'Account' : (transact.isPaymentCard__c == true ? 'Card' : (transact.isPaymentPaypal__c == true ? 'Paypal' : '')) ), (transact.isPaymentAccount__c == true ? String.valueOf(transact.AccountNumber__c) : transact.Id));

		filingDetails fil = new filingDetails(transact.Barcode__c, system.today().year() + '-' + system.today().month() + '-' + system.today().day(), pay);


		// DSO1 specific if(tx.Form_Name__c == 'DS01'){include officers, etc.}
		List<Officer__c> lOff = [SELECT Name, Surname__c, Title__c, Middlenames__c, Forename__c, DateSigned__c FROM Officer__c where Transaction__c = :transact.Id];
		List<officer> lOffSerialized = new List<officer>();

		// if (tx.Form_Name__c = 'SH19', etc.) { include share family. note may have to instantiate a new transaction for other transactions}
		// SH specific select currencycode/suppliedclass/description/number/value for shareclass
		//List<Shares__c> lShares = [SELECT Name,Surname__c,Title__c,Middlenames__c,Forename__c, DateSigned__c FROM Shares__c where Transaction__c = :transact.Id];

		//At this point we are sure we have the majority and we will send only the officer that has signed
		for (Officer__c off : lOff) {
			if (off.DateSigned__c != null) {
				Datetime dateSigned = off.DateSigned__c;

				lOffSerialized.add(new officer(new personName((off.Title__c == null ? '' : off.Title__c), (off.Forename__c == null ? '' : off.Forename__c), (off.Middlenames__c == null ? '' : off.Middlenames__c), (off.Surname__c == null ? '' : off.Surname__c)), dateSigned.year() + '-' + dateSigned.month() + '-' + dateSigned.day() ));
			}
		}

		officerCollection officerCollection = new officerCollection(lOffSerialized);

		corporateBody corp = new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c, officerCollection);

		formdata form = new formdata(fil, corp);

		//Get the attachment into the attachment object
		//
		List<Attachment> attRec = [Select Id, Body from Attachment where parentId = :transact.Id];

		if (attRec == null) {
			return  JSON.serialize('Transaction must have a form attached.');
		}

		List<attachments> lAtt = new List<attachments>();

		for (Attachment att : attRec) {
			lAtt.add(new attachments(TransactionSerialiser.MIMETYPESTRING, TransactionSerialiser.CATEGORYSTRING, EncodingUtil.base64Encode(att.Body)));
		}

		JSONGenerator gen = JSON.createGenerator(true);

		//if DSO1
		gen.writeStartObject();

		gen.writeFieldName('metadata');

		gen.writeObject(met);

		gen.writeFieldName('formdata');

		gen.writeObject(form);

		gen.writeFieldName('attachments');

		gen.writeObject(lAtt);

		gen.writeEndObject();

		return gen.getAsString();
	}

}