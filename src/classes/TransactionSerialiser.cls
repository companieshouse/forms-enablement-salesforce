//Class used to translate to JSON the transaction
/*
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-07-04  Initial development.
1.5 Leo Bitoy 2016-07-07 (Packages)
1.5 Leo Bitoy 2016-07-07 (SH02, SH19, SH10, Sh08, Dynamic Elements)
*/

public with sharing class TransactionSerialiser {
	public final static String MIMETYPESTRING = 'application/pdf';
	public final static String CATEGORYSTRING = 'FORM IMAGE PDF';
	public with sharing class attachmentsWraper {
		public attachments[] attachments;
	}
	public with sharing class metadataWraper {
		public metadata metadata;
	}
	public with sharing class formdataWraper {
		public formdata formdata;
	}
	public with sharing class metadata {
		public String type {
			get;
			set;
		}
		public Integer packageindex {
			get;
			set;
		}
		public Integer version {
			get;
			set;
		}
		public String submissionReference {
			get;
			set;
		}
		public metadata() {}
		public metadata(String type, Integer packageindex, Integer version, String submissionReference) {
			this.type = type;
			this.packageindex = packageindex;
			this.version = version;
			this.submissionReference = submissionReference;
		}
	}
	public with sharing class payment {
		public String paymentMethod {
			get;
			set;
		}
		public String referenceNumber {
			get;
			set;
		}
		public String accountNumber {
			get;
			set;
		}

		public payment() {}
		public payment(String paymentMethod, String referenceNumber, String accountNumber) {
			this.paymentMethod = paymentMethod;
			this.referenceNumber = referenceNumber;
			this.accountNumber = accountNumber;

		}
	}

	public with sharing class presenterDetails {
		public String presenterEmailIn {get; set;}
		public String presenterEmailOut {get; set;}

		public presenterDetails() {}

		public presenterDetails(String presenterEmailIn, String presenterEmailOut) {
			this.presenterEmailIn = presenterEmailIn;
			this.presenterEmailOut = presenterEmailOut;
		}
	}

	public with sharing class filingDetails { // changes
		public payment payment {get; set;}
		public String barcode {get; set;}
		public String receiptDate {get; set;}
		public presenterDetails presenterDetails {get; set;}
		public String presenterDocumentReference {get; set;}
		public String signDate {get; set;}

		//Signed date

		public filingDetails() {}

		public filingDetails(String barcode, String receiptDate, payment payment, presenterDetails presenterDetails, String presenterDocumentReference, String signDate) {
			this.barcode = barcode;
			this.receiptDate = receiptDate;
			this.payment = payment;
			this.presenterDetails = presenterDetails;
			this.presenterDocumentReference = presenterDocumentReference;
			this.signDate = signDate;
		}
	}
	public with sharing class officer {
		public personName personName {
			get;
			set;
		}
		public String signDate {
			get;
			set;
		}
		public officer() {}
		public officer(personName personName, String signDate) {
			this.personName = personName;
			this.signDate = signDate;
		}
	}
	
	public with sharing class officerCollection {
		public List < officer > officer {
			get;
			set;
		}
		public officerCollection() {}
		public officerCollection(List < officer > officer) {
			this.officer = officer;
		}
	}
	public with sharing class personName {
		String titleOther {
			get;
			set;
		}
		String forename {
			get;
			set;
		}
		String middlenames {
			get;
			set;
		}
		String surname {
			get;
			set;
		}
		public personName() {}
		public personName(String titleOther, String forename, String middlenames, String surname) {
			this.titleOther = titleOther;
			this.forename = forename;
			this.middlenames = middlenames;
			this.surname = surname;
		}
	}
	public with sharing class corporateBody {
		public String incorporationNumber {
			get;
			set;
		}
		public String corporateBodyName {
			get;
			set;
		}
		public officerCollection officers {
			get;
			set;
		}
		
		public corporateBody() {}

		public corporateBody(String incorporationNumber, String corporateBodyName) {
			this.incorporationNumber = incorporationNumber;
			this.corporateBodyName = corporateBodyName;
		}// DS01
		public corporateBody(String incorporationNumber, String corporateBodyName, officerCollection officers) {
			this.incorporationNumber = incorporationNumber;
			this.corporateBodyName = corporateBodyName;
			this.officers = officers;
		}
		
	}
	public with sharing class formdata {
		public filingDetails filingDetails {
			get;
			set;
		}
		public corporateBody corporateBody {
			get;
			set;
		}
		public formdata() {}
		public formdata(filingDetails filingDetails, corporateBody corporateBody) {
			this.filingDetails = filingDetails;
			this.corporateBody = corporateBody;
		}
	}
	public with sharing class attachments { // PDF
		public String mimetype {
			get;
			set;
		}
		public String category {
			get;
			set;
		}
		public String data {
			get;
			set;
		}
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

	public static String getPaymentBody(Transaction__c transact)
	{
		if (transact == null) {
			return JSON.serialize('Argument cannot be null.');
		}

		if (transact.Form_Name__c.contains('DS01')) {
			payment pay = new payment();

			pay = new payment((transact.isPaymentAccount__c == true ? 'account' : (transact.isPaymentCard__c == true ? 'creditcard' : (transact.isPaymentPaypal__c == true ? 'creditcard' : '')) ), (transact.isPaymentAccount__c == true ? '' : transact.paymentReference__c), (transact.isPaymentAccount__c == true ? transact.AccountNumber__c : ''));

			JSONGenerator gen = JSON.createGenerator(true);
			gen.writeStartObject();
			gen.writeFieldName('packageIdentifier');
			gen.writeObject(String.isBlank(transact.SubmissionId__c) ? '' : transact.SubmissionId__c);
			gen.writeFieldName('payment');
			gen.writeObject(pay);
			gen.writeEndObject();
			return gen.getAsString();
		}
		String valtoReturn = 'NoFormtoSerializeFound';
		return valtoReturn;
	}

	public static String transactionToJSON(Transaction__c transact) {
		//We need to convert the transaction record to a JSON object

		if (transact == null) {
			return JSON.serialize('Argument cannot be null.');
		}
		//Build each object for the JSON
		if (transact.Form_Name__c.contains('DS01')) {

			metadata met = new metadata(transact.Form_Name__c, 1, Integer.valueOf(transact.Version_Form__c), transact.SubmissionId__c);

			payment pay = new payment();

			if (transact.isPaymentRequired__c)
			{
				//LINE DISABLE, WILL BE USED FOR THE NEW INTEGRATION
				//pay = new payment((transact.isPaymentAccount__c == true ? 'account' : (transact.isPaymentCard__c == true ? 'creditcard' : (transact.isPaymentPaypal__c == true ? 'creditcard' : '')) ), (transact.isPaymentAccount__c == true ? '' : transact.paymentReference__c), (transact.isPaymentAccount__c == true ? transact.AccountNumber__c : ''));
				pay = new payment('account', '', '');
			}

			presenterDetails pDetails = new presenterDetails(transact.ContactEmail__c, transact.ContactEmail__c);
			// change contsrutct
			filingDetails fil = new filingDetails(transact.Barcode__c, getFormatedDate(date.today()), pay, pDetails, transact.SubmissionId__c, getFormatedDate(system.today()));
			List<Contact> lOff = [SELECT Name, LastName, Title, Middlenames__c, FirstName, DateSigned__c FROM Contact where Transaction__c = :transact.Id];
			List<officer> lOffSerialized = new List<officer>();

			for (Contact off : lOff) {
				if (off.DateSigned__c != null) {
					Datetime dateSigned = off.DateSigned__c;

					lOffSerialized.add(new officer(new personName((off.Title == null ? '' : off.Title), (off.FirstName == null ? '' : off.FirstName), (off.Middlenames__c == null ? '' : off.Middlenames__c), (off.LastName == null ? '' : off.LastName)), getFormatedDate(date.today()) ));
				}
			}

			officerCollection officerCollection = new officerCollection(lOffSerialized);

			corporateBody corp = new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c, officerCollection);

			formdata form = new formdata(fil, corp);
			//Get the attachment into the attachment object
			//
			List < Attachment > attRec = [Select Id, Body from Attachment where parentId = : transact.Id Order by CreatedDate DESC ];
			if (attRec == null) {
				return JSON.serialize('Transaction must have a form attached.');
			}
			if(attRec.isEmpty())
			{
				return JSON.serialize('Transaction must have a form attached.');
			}
			List < attachments > lAtt = new List < attachments > ();
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
		if (transact.Form_Name__c.contains('DS02')) {

			metadata met = new metadata(transact.Form_Name__c, 1, Integer.valueOf(transact.Version_Form__c), transact.SubmissionId__c);

			payment pay = new payment();

			if (transact.isPaymentRequired__c)
			{pay = new payment((transact.isPaymentAccount__c == true ? 'account' : (transact.isPaymentCard__c == true ? 'creditcard' : (transact.isPaymentPaypal__c == true ? 'creditcard' : '')) ), (transact.isPaymentAccount__c == true ? '' : transact.paymentReference__c), (transact.isPaymentAccount__c == true ? transact.AccountNumber__c : ''));}

			presenterDetails pDetails = new presenterDetails(transact.ContactEmail__c, transact.ContactEmail__c);

			filingDetails fil = new filingDetails(transact.Barcode__c, getFormatedDate(date.today()), pay, pDetails, transact.SubmissionId__c,getFormatedDate(system.today()));
			List<Contact> lOff = [SELECT Name, LastName, Title, Middlenames__c, FirstName, DateSigned__c FROM Contact where Transaction__c = :transact.Id];
			List<officer> lOffSerialized = new List<officer>();
			for (Contact off : lOff) {
				if (off.DateSigned__c != null) {
					// change
					Datetime dateSigned = off.DateSigned__c;

					lOffSerialized.add(new officer(new personName((off.Title == null ? '' : off.Title), (off.FirstName == null ? '' : off.FirstName), (off.Middlenames__c == null ? '' : off.Middlenames__c), (off.LastName == null ? '' : off.LastName)), getFormatedDate(date.today()) ));
				}
			}

			officerCollection officerCollection = new officerCollection(lOffSerialized);

			corporateBody corp = new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c, officerCollection);

			formdata form = new formdata(fil, corp);
			//Get the attachment into the attachment object
			//
			List < Attachment > attRec = [Select Id, Body from Attachment where parentId = : transact.Id];
			if (attRec == null) {
				return JSON.serialize('Transaction must have a form attached.');
			}
			List < attachments > lAtt = new List < attachments > ();
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
		String valtoReturn = 'NoFormtoSerializeFound';
		return valtoReturn;
	}

	public static String getFormatedDate(Datetime dateToFormat) {
		return dateToFormat.format('yyyy-MM-dd');
	}
}