//Class used to translate to JSON the transaction 
public class TransactionSerialiser {
	public final static String MIMETYPESTRING = 'application/pdf';
	public final static String CATEGORYSTRING = 'FORM IMAGE PDF';

    public class attachmentsWraper{
    	public attachments[] attachments;
    }

    public class metadataWraper{
    	public metadata metadata;
    }


    public class formdataWraper{
    	public formdata formdata;
    }

	public class metadata{
		public String type {get; set;}
		public Integer packageindex {get; set;}
		public String version {get; set;}
		public String submissionReference {get; set;}

		public metadata(){}

		public metadata(String type, Integer packageindex, String version, String submissionReference)
		{
			this.type = type;
			this.packageindex = packageindex;
			this.version = version;
			this.submissionReference = submissionReference;
		}

	}

	public class payment{
		public String paymentMethod {get; set;}
		public String referenceNumber {get; set;}

		public payment(){}

		public payment(String paymentMethod, String referenceNumber)
		{
			this.paymentMethod = paymentMethod;
			this.referenceNumber = referenceNumber;
		}
	}

	public class filingDetails{
		public payment payment {get; set;}
		public String barcode {get; set;}
		public String receiptDate {get; set;}
		//Signed date

		public filingDetails(){}

		public filingDetails(String barcode, String receiptDate, payment payment)
		{
			this.barcode = barcode;
			this.receiptDate = receiptDate;
			this.payment = payment;
		}
	}

	public class officer{
		public personName personName {get; set;}
		public String signDate {get; set;}

		public officer(){}

		public officer(personName personName, String signDate)
		{
			this.personName = personName;
			this.signDate = signDate;
		}
	}

	public class officerCollection{
		public List<officer> officer {get; set;}

		public officerCollection(){}

		public officerCollection(List<officer> officer)
		{
			this.officer = officer;
		}
	}

	public class personName{
		String titleOther {get; set;}
		String forename {get; set;}
		String middlenames {get; set;}
		String surname {get; set;}

		public personName(){}

		public personName(String titleOther, String forename, String middlenames, String surname){
			this.titleOther = titleOther;
			this.forename = forename;
			this.middlenames = middlenames;
			this.surname = surname;
		}
	}

	public class corporateBody{
		public String incorporationNumber {get; set;}
		public String corporateBodyName {get; set;}
		public officerCollection officers {get; set;}

		public corporateBody(){}

		public corporateBody(String incorporationNumber, String corporateBodyName, officerCollection officers)
		{
			this.incorporationNumber = incorporationNumber;
			this.corporateBodyName = corporateBodyName;
			this.officers = officers;
		}
	}

	public class formdata{
		public filingDetails filingDetails {get; set;}
		public corporateBody corporateBody {get; set;}

		public formdata(){}

		public formdata(filingDetails filingDetails, corporateBody corporateBody)
		{
			this.filingDetails = filingDetails;
			this.corporateBody = corporateBody;
		}
	}

	public class attachments{
		public String mimetype {get; set;}
		public String category {get; set;}
		public String data {get; set;}

		public attachments(){}

		public attachments(String mimetype, String category, String data)
		{
			this.mimetype = mimetype;
			this.category = category;
			this.data = data;
		} 
	}

	public static String transactionToJSON(Transaction__c transact)
	{
		//We need to convert the transaction record to a JSON object
		//
		if(transact == null)
		{
			return  JSON.serialize('Argument cannot be null.');

		}

		//Build each object for the JSON
		//
		metadata met = new metadata(transact.Form_Name__c, 1, transact.Version_Form__c, transact.SubmissionId__c);

		payment pay = new payment();

		if(transact.isPaymentRequired__c)
			pay = new payment((transact.isPaymentAccount__c == true ? 'account' : (transact.isPaymentCard__c == true ? 'creditcard' : (transact.isPaymentPaypal__c == true ? 'creditcard' : '')) ), (transact.isPaymentAccount__c == true ? String.valueOf(transact.AccountNumber__c) : transact.Id));

		filingDetails fil = new filingDetails(transact.Barcode__c, system.today().year() + '-' + system.today().month() + '-' + system.today().day(),pay);

		List<Officer__c> lOff = [SELECT Name,Surname__c,Title__c,Middlenames__c,Forename__c, DateSigned__c FROM Officer__c where Transaction__c = :transact.Id];
		List<officer> lOffSerialized = new List<officer>();

		//At this point we are sure we have the majority and we will send only the officer that has signed
		for(Officer__c off:lOff)
		{
			if(off.DateSigned__c != null)
			{
				Datetime dateSigned = off.DateSigned__c;

				lOffSerialized.add(new officer(new personName((off.Title__c == null ? '' : off.Title__c), (off.Forename__c == null ? '' : off.Forename__c), (off.Middlenames__c == null ? '' :off.Middlenames__c), (off.Surname__c == null ? '' : off.Surname__c)),dateSigned.year() + '-' + dateSigned.month() + '-' + dateSigned.day() ));
			}
		}

		officerCollection officerCollection = new officerCollection(lOffSerialized);

		corporateBody corp = new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c, officerCollection);

		formdata form = new formdata(fil, corp);

		//Get the attachment into the attachment object
		//
		List<Attachment> attRec = [Select Id, Body from Attachment where parentId = :transact.Id];

		if(attRec == null)
		{
			return  JSON.serialize('Transaction must have a form attached.');
		}

		List<attachments> lAtt = new List<attachments>();

		for(Attachment att :attRec)
		{
			lAtt.add(new attachments(TransactionSerialiser.MIMETYPESTRING, TransactionSerialiser.CATEGORYSTRING, EncodingUtil.base64Encode(att.Body)));	
		}
		
		JSONGenerator gen = JSON.createGenerator(true);

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