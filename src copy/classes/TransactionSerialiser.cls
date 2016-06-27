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

	public class filingDetails{
		public String barcode {get; set;}
		public String receiptDate {get; set;}

		public filingDetails(){}

		public filingDetails(String barcode, String receiptDate)
		{
			this.barcode = barcode;
			this.receiptDate = receiptDate;
		}
	}

	public class corporateBody{
		public String incorporationNumber {get; set;}
		public String corporateBodyName {get; set;}

		public corporateBody(){}

		public corporateBody(String incorporationNumber, String corporateBodyName)
		{
			this.incorporationNumber = incorporationNumber;
			this.corporateBodyName = corporateBodyName;
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

		filingDetails fil = new filingDetails(transact.Barcode__c, system.today().year() + '-' + system.today().month() + '-' + system.today().day());

		corporateBody corp = new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c);

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