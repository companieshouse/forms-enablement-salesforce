//Class used to translate to JSON the transaction
/*
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-07-04  Initial development.
1.5 Leo Bitoy 2016-07-07 (Packages)
1.5 Leo Bitoy 2016-07-07 (SH02, SH19, SH10, Sh08, Dynamic Elements)
*/

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
		public String type {
			get;
			set;
		}
		public Integer packageindex {
			get;
			set;
		}
		public String version {
			get;
			set;
		}
		public String submissionReference {
			get;
			set;
		}
		public metadata() {}
		public metadata(String type, Integer packageindex, String version, String submissionReference) {
			this.type = type;
			this.packageindex = packageindex;
			this.version = version;
			this.submissionReference = submissionReference;
		}
	}
	public class payment {
		public String paymentMethod {
			get;
			set;
		}
		public String referenceNumber {
			get;
			set;
		}
		public payment() {}
		public payment(String paymentMethod, String referenceNumber) {
			this.paymentMethod = paymentMethod;
			this.referenceNumber = referenceNumber;
		}
	}
	public class shareAssignments {
		public List < shareAssignment > shareAssignments {
			get;
			set;
		}
		public shareAssignments() {}
		public shareAssignments(List < shareAssignment > assignedShares) {
			this.shareAssignments = assignedShares;
		}
	}
	public class shareAssignment {
		public String existingClass {
			get;
			set;
		}
		public String nameOrOtherDesignation {
			get;
			set;
		}
		public shareAssignment() {}
		public shareAssignment(String existingClass, String nameOrOtherDesignation) {
			this.existingClass = existingClass;
			this.nameOrOtherDesignation = nameOrOtherDesignation;
		}
	}
	public class filingDetails {
		public payment payment {
			get;
			set;
		}
		public String barcode {
			get;
			set;
		}
		public String receiptDate {
			get;
			set;
		}
		public String signDate {
			get;
			set;
		}
		public filingDetails() {}
		public filingDetails(String barcode, String dateOutput, payment payment) { //, String signDate
			this.barcode = barcode;
			this.receiptDate = dateOutput;
			this.payment = payment;
			//this.feeStatus = feeStatus;
			this.signDate = dateOutput;
		}
	}
	public class officer {
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
	// statement of capital starts here
	public class statementOfCapital {
		public shareValues shareValues {
			get;
			set;
		}
		public shareClasses shareClasses {
			get;
			set;
		}
		public Boolean latestSOCInd {
			get;
			set;
		}
		public grandTotals grandTotals {
			get;
			set;
		} // todo change back socIND to list List < latestSOCInd > List < latestSOCInd >
		public statementOfCapital() {}
		//public statementOfCapital(List < shareValues > valueofShares, List < shareClasses > classesofShares, String socIND, List < grandTotals > totals) {
		public statementOfCapital(shareValues valueofShares, shareClasses classesofShares, Boolean socIND, grandTotals totals) {
			this.shareValues = valueofShares;
			this.shareClasses = classesofShares;
			this.latestSOCInd = socIND;
			this.grandTotals = totals;
		}
	}
	public class shareValues {
		public List < shareValue > shareValue {
			get;
			set;
		}
		public shareValues(List < shareValue > shareValue) {
			this.shareValue = shareValue;
		}
	}
	public class shareClasses {
		public List < shareClass > shareClass {
			get;
			set;
		}
		public shareClasses(List < shareClass > shareClass) {
			this.shareClass = shareClass;
		}
	}
	public class shareValue {
		public String currencyCode {
			get;
			set;
		}
		public Decimal value {
			get;
			set;
		}
		public Decimal totalAmountUnpaid {
			get;
			set;
		}
		public Decimal totalNumberOfShares {
			get;
			set;
		}
		public shareValue(String currencyCode, Decimal value, Decimal totalAmountUnpaid, Decimal totalNumberOfShares) {
			this.currencyCode = currencyCode;
			this.value = value;
			this.totalAmountUnpaid = totalAmountUnpaid;
			this.totalNumberOfShares = totalNumberOfShares;
		}
	}
	public class shareClass {
		public String currencyCode {
			get;
			set;
		}
		public String suppliedClass {
			get;
			set;
		}
		public String description {
			get;
			set;
		}
		public Decimal sNumber {
			get;
			set;
		}
		// NUmber is a reserved word...
		public Decimal value {
			get;
			set;
		}
		public shareClass(String currencyCode, String suppliedClass, String description, Decimal value, Decimal sNumber) {
			this.currencyCode = currencyCode;
			this.suppliedClass = suppliedClass;
			this.description = description;
			this.value = value;
			this.sNumber = sNumber;
		}
	}
	public class grandTotals {
		//public List < shareValueGrandTotals > shareValueGrandTotals {
		//	get;
		//	set;
		//}
		public Decimal shareNumberGrandTotal {
			get;
			set;
		} //Decimal snumbergtotal,
		//public List < shareNumberGrandTotal > shareNumberGrandTotal {
		//	get;
		//	set;
		//}
		public shareValueGrandTotals shareValueGrandTotals {
			get;
			set;
		}
		//public Decimal snumbergtotal {get; set;}
		public grandTotals() {}
		public grandTotals(Decimal snumbergtotal, shareValueGrandTotals svaluegtotal) {
			this.shareNumberGrandTotal = snumbergtotal;
			this.shareValueGrandTotals = svaluegtotal;
		}
	}
	public class shareValueGrandTotals {
		public List < shareValueGrandTotal > shareValueGrandTotal {
			get;
			set;
		}
		public shareValueGrandTotals() {}
		public shareValueGrandTotals(List < shareValueGrandTotal > svaluegtotal) {
			this.shareValueGrandTotal = svaluegtotal;
		}
	}
	public class shareValueGrandTotal {
		public String currencyCode {
			get;
			set;
		}
		public Decimal totalAmountUnpaid {
			get;
			set;
		}
		public Decimal value {
			get;
			set;
		}
		public shareValueGrandTotal() {}
		public shareValueGrandTotal(String money, Decimal unpaidAmount, Decimal val) {
			this.currencyCode = money;
			this.totalAmountUnpaid = unpaidAmount;
			this.value = val;
		}
	}
	public class shareNumberGrandTotal {
		public Decimal shareNumberGrandTotal {
			get;
			set;
		}
		public shareNumberGrandTotal() {}
		public shareNumberGrandTotal(Decimal sNGT) {
			this.shareNumberGrandTotal = sNGT;
		}
	}
	public class latestSOCInd {
		public String latestSOCInd {
			get;
			set;
		}
		public latestSOCInd(String latestSOCInd) {
			this.latestSOCInd = latestSOCInd;
		}
	}
	// Statement of capital ends here
	public class officerCollection {
		public List < officer > officer {
			get;
			set;
		}
		public officerCollection() {}
		public officerCollection(List < officer > officer) {
			this.officer = officer;
		}
	}
	public class personName {
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
	public class corporateBody {
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
		public statementOfCapital statementOfCapital {
			get;
			set;
		}

		public reconvertedClasses reconvertedClasses {get; set;}
		public redeemedClasses redeemedClasses {get; set;}
		public  subdividedClasses subdividedClasses {get; set;}
		public consolidatedClasses consolidatedClasses {get; set;}
		public shares shares {get; set;}
		public detailsOfVariationOfRights detailsOfVariationOfRights {get; set;}
		public shareAssignments shareAssignments {get; set;}
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
		// SH19
		public corporateBody(String incorporationNumber, String corporateBodyName, statementOfCapital capitalStatement) {
			this.incorporationNumber = incorporationNumber;
			this.corporateBodyName = corporateBodyName;
			this.statementOfCapital = capitalStatement;
		}
		public corporateBody(String incorporationNumber, String corporateBodyName, shareAssignments shareAssignments) {
			this.incorporationNumber = incorporationNumber;
			this.corporateBodyName = corporateBodyName;
			this.shareAssignments = shareAssignments;
		}
		public corporateBody(String incorporationNumber, String corporateBodyName, detailsOfVariationOfRights variationValue) {
			this.incorporationNumber = incorporationNumber;
			this.corporateBodyName = corporateBodyName;
			this.detailsOfVariationOfRights = variationValue;
		}
		public corporateBody(String incorporationNumber, String corporateBodyName, statementOfCapital capitalStatement, shares shares, consolidatedClasses consolidatedClasses, subdividedClasses subdividedClasses, redeemedClasses redeemedClasses, reconvertedClasses reconvertedClasses) {
			this.incorporationNumber = incorporationNumber;
			this.corporateBodyName = corporateBodyName;
			this.statementOfCapital = capitalStatement;
			this.reconvertedClasses = reconvertedClasses;
			this.redeemedClasses = redeemedClasses;
			this.subdividedClasses = subdividedClasses;
			this.consolidatedClasses = consolidatedClasses;
			this.shares = shares;

		}
	}
	public class formdata {
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
	public class attachments { // PDF
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
	public class detailsOfVariationOfRights {
		public String detailsOfVariationOfRights {get; set;}
		public detailsOfVariationOfRights () {}
		public detailsOfVariationOfRights(String detailsOfVariationOfRights) {

			this.detailsOfVariationOfRights = detailsOfVariationOfRights;
		}
	}
	public class shares {
		public Boolean consolidation {get; set;
		                             }
		public Boolean subDivision {get; set;
		                           }
		public Boolean redemptionSelected {get; set;
		                                  }
		public Boolean reconversion {get; set;
		                            }
		public shares() {}
		public shares(Boolean consolidation, Boolean subDivision, Boolean redemptionSelected, Boolean reconversion ) {
			this.consolidation = consolidation;
			this.subDivision = subDivision;
			this.redemptionSelected = redemptionSelected;
			this.reconversion = reconversion;
		}

	}
	public class consolidatedClasses {
		public List<consolidatedClass> consolidatedClass {get; set;}
		public consolidatedClasses() {}
		public consolidatedClasses(List <consolidatedClass> consolidatedClass) {
			this.consolidatedClass = consolidatedClass;
		}

	}
	public class subdividedClasses {
		public List<subdividedClass> subdividedClass {get; set;}
		public subdividedClasses() {}
		public subdividedClasses(List<subdividedClass> subdividedClass) {
			this.subdividedClass = subdividedClass;
		}
	}
	public class redeemedClasses {
		public List<redeemedClass> redeemedClass {get; set;}
		public redeemedClasses() {}
		public redeemedClasses(List<redeemedClass> redeemedClass) {
			this.redeemedClass = redeemedClass;
		}

	}
	public class reconvertedClasses {
		public List<reconvertedClass> reconvertedClass {get; set;}
		public reconvertedClasses() {}
		public reconvertedClasses(List<reconvertedClass> reconvertedClass) {
			this.reconvertedClass = reconvertedClass;
		}
	}




	public class consolidatedClass {
		public String classValue {get; set;}
		public previousStructure previousStructure {get; set;}
		public newStructure newStructure {get; set;}
		public consolidatedClass() {}
		public consolidatedClass(String classValue, previousStructure previousStructure, newStructure newStructure ) {
			this.classValue = classValue;
			this.previousStructure = previousStructure;
			this.newStructure = newStructure;
		}

	}
	public class previousStructure {
		public Decimal snumber {get; set;}
		public Decimal value {get; set;}
		public previousStructure() {}
		public previousStructure(Decimal snumber, Decimal value) {
			this.snumber = snumber;
			this.value = value;
		}

	}



	public class newStructure {
		public Decimal snumber {get; set;}
		public Decimal value {get; set;}
		public  newStructure () {}

		public  newStructure (Decimal snumber, Decimal value) {
			this.snumber = snumber;
			this.value = value;
		}
	}
	public class subdividedClass {
		public String classValue {get; set;}
		public previousStructure previousStructure {get; set;}
		public newStructure newStructure {get; set;}
		public subdividedClass() {}
		public subdividedClass(String classValue, previousStructure previousStructure, newStructure newStructure ) {
			this.classValue = classValue;
			this.previousStructure = previousStructure;
			this.newStructure = newStructure;
		}
	}
	public class redeemedClass {
		public String classValue {get; set;}

		public Decimal snumber {get; set;}
		public Decimal value {get; set;}
		public redeemedClass() {}
		public redeemedClass(Decimal snumber, Decimal value) {
			this.snumber = snumber;
			this.value = value;
		}

	}

	public class reconvertedClass {
		public String classValue {get; set;}
		public Decimal stockValue {get; set;}
		public Decimal snumber {get; set;}
		public Decimal value {get; set;}
		public reconvertedClass() {}
		public reconvertedClass(Decimal snumber, Decimal value) {
			this.snumber = snumber;
			this.value = value;
		}

	}

	// currently DS01 specific
	public static String transactionToJSON(Transaction__c transact) {
		//We need to convert the transaction record to a JSON object
		//
		//List<Transactions__c> transACTIONS
		//if (transACTIONS.size() > 1) {
		//}
		Boolean showRES15 = false;
		Boolean showCappSS = false;
		Boolean showSH20 = false;
		Datetime yourDate = Datetime.now();
		String dateOutput = yourDate.format('yyyy-MM-dd');
		if (transact == null) {
			return JSON.serialize('Argument cannot be null.');
		}
		//Build each object for the JSON
		//
		if (transact.Form_Name__c == 'SH10') {
			// SH10 specific

			String variationString;
			for (Shares__c assignedShares : transact.Shares__r) {
				if (assignedShares.SHARETYPE__c == 'SH10') {
					variationString = assignedShares.varationField__c;
				}
			}

			detailsOfVariationOfRights variationforChips = new detailsOfVariationOfRights(variationString);

			metadata met = new metadata(transact.Form_Name__c, 1, '1', transact.SubmissionId__c);
			payment pay = new payment((transact.isPaymentAccount__c == true ? 'Account' : (transact.isPaymentCard__c == true ? 'Card' : (transact.isPaymentPaypal__c == true ? 'Paypal' : ''))), (transact.isPaymentAccount__c == true ? String.valueOf(transact.AccountNumber__c) : transact.Id));
			filingDetails fil = new filingDetails(transact.Barcode__c, dateOutput, pay); //, system.today().year() + '-' + system.today().month() + '-' + system.today().day(),
			corporateBody corp = new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c, variationforChips);
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
			//if SH10
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
		if (transact.Form_Name__c == 'SH08') {
			// SH08 specific
			List<shareAssignment> shareAssignmentLISTS = new List<shareAssignment>();

			for (Shares__c assignedShares : transact.Shares__r) {
				if (assignedShares.SHARETYPE__c == 'SH08') {
					shareAssignmentLISTS.add(new shareAssignment(assignedShares.Class_of_Shares__c, assignedShares.Class_of_Share_new__c));
				}
			}


			shareAssignments  shareAssignmentsVals = new shareAssignments(shareAssignmentLISTS);

			metadata met = new metadata(transact.Form_Name__c, 1, '1', transact.SubmissionId__c);
			payment pay = new payment((transact.isPaymentAccount__c == true ? 'Account' : (transact.isPaymentCard__c == true ? 'Card' : (transact.isPaymentPaypal__c == true ? 'Paypal' : ''))), (transact.isPaymentAccount__c == true ? String.valueOf(transact.AccountNumber__c) : transact.Id));
			filingDetails fil = new filingDetails(transact.Barcode__c, dateOutput, pay); //, system.today().year() + '-' + system.today().month() + '-' + system.today().day(),
			corporateBody corp = new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c, shareAssignmentsVals);
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
			//if SH08
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
		if (transact.Form_Name__c == 'DS01') {
			// DSO1 specific
			metadata met = new metadata(transact.Form_Name__c, 1, '1', transact.SubmissionId__c);
			payment pay = new payment((transact.isPaymentAccount__c == true ? 'Account' : (transact.isPaymentCard__c == true ? 'Card' : (transact.isPaymentPaypal__c == true ? 'Paypal' : ''))), (transact.isPaymentAccount__c == true ? String.valueOf(transact.AccountNumber__c) : transact.Id));
			filingDetails fil = new filingDetails(transact.Barcode__c, dateOutput, pay); //, system.today().year() + '-' + system.today().month() + '-' + system.today().day(),
			List < Officer__c > lOff = [SELECT Name, Surname__c, Title__c, Middlenames__c, Forename__c, DateSigned__c FROM Officer__c where Transaction__c = : transact.Id];
			List < officer > lOffSerialized = new List < officer > ();
			//At this point we are sure we have the majority and we will send only the officer that has signed
			for (Officer__c off : lOff) {
				if (off.DateSigned__c != null) {
					Datetime dateSigned = off.DateSigned__c;
					lOffSerialized.add(new officer(new personName((off.Title__c == null ? '' : off.Title__c), (off.Forename__c == null ? '' : off.Forename__c), (off.Middlenames__c == null ? '' : off.Middlenames__c), (off.Surname__c == null ? '' : off.Surname__c)), dateOutput));
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

		if (transact.Form_Name__c == 'SH19') {
			List < metadata > packagesmeta = new List < metadata > ();
			List < payment > packagespayment = new List < payment > ();
			List < filingDetails > packagesfil = new List < filingDetails > ();
			List < corporateBody > packagescorp = new List < corporateBody > ();
			List < formdata > packagesform = new List < formdata > ();
			if (transact.containsPackage__c == true) {
				//  BUILD RES15
				packagesmeta.add(new metadata('RES15', 2, '1', transact.SubmissionId__c));
				packagespayment.add(new payment((transact.isPaymentAccount__c == true ? 'Account' : (transact.isPaymentCard__c == true ? 'Card' : (transact.isPaymentPaypal__c == true ? 'Paypal' : ''))), (transact.isPaymentAccount__c == true ? String.valueOf(transact.AccountNumber__c) : transact.Id)));
				packagesfil.add(new filingDetails(transact.Barcode__c, dateOutput, packagespayment[0]));
				packagescorp.add(new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c));
				packagesform.add(new formdata(packagesfil[0], packagescorp[0]));
				//  BUILD CAPSS
				packagesmeta.add(new metadata('CAPSS', 3, '1', transact.SubmissionId__c));
				packagespayment.add(new payment((transact.isPaymentAccount__c == true ? 'Account' : (transact.isPaymentCard__c == true ? 'Card' : (transact.isPaymentPaypal__c == true ? 'Paypal' : ''))), (transact.isPaymentAccount__c == true ? String.valueOf(transact.AccountNumber__c) : transact.Id)));
				packagesfil.add(new filingDetails(transact.Barcode__c, dateOutput, packagespayment[1]));
				packagescorp.add(new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c));
				packagesform.add(new formdata(packagesfil[1], packagescorp[1]));
				//  BUILD SH20
				packagesmeta.add(new metadata('SH20', 4, '1', transact.SubmissionId__c));
				packagespayment.add(new payment((transact.isPaymentAccount__c == true ? 'Account' : (transact.isPaymentCard__c == true ? 'Card' : (transact.isPaymentPaypal__c == true ? 'Paypal' : ''))), (transact.isPaymentAccount__c == true ? String.valueOf(transact.AccountNumber__c) : transact.Id)));
				packagesfil.add(new filingDetails(transact.Barcode__c, dateOutput, packagespayment[2]));
				packagescorp.add(new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c));
				packagesform.add(new formdata(packagesfil[2], packagescorp[2]));
			}
			if (packagesmeta.size() > 0) {
				for (metadata metaContains : packagesmeta) {
					if (metaContains.type == 'CAPSS') {
						showCappSS = true;
					}
					if (metaContains.type == 'SH20') {
						showSH20 = true;
					}
					if (metaContains.type == 'RES15') {
						showRES15 = true;
					}
				}
			}
			//throw new Form_CustomException('here are your tasty little booleans' + 'capss' + '' + showCappSS + ' sh20' + showSH20 + ' res15' + showRES15);
			metadata met = new metadata(transact.Form_Name__c, 1, '1', transact.SubmissionId__c);
			payment pay = new payment((transact.isPaymentAccount__c == true ? 'Account' : (transact.isPaymentCard__c == true ? 'Card' : (transact.isPaymentPaypal__c == true ? 'Paypal' : ''))), (transact.isPaymentAccount__c == true ? String.valueOf(transact.AccountNumber__c) : transact.Id));
			filingDetails fil = new filingDetails(transact.Barcode__c, dateOutput, pay); //, system.today().year() + '-' + system.today().month() + '-' + system.today().day(),
			List < Shares__c > lShares = [SELECT FreeForm__c, OldNominalValue__c, oldNumSharesIssued__c, NewNominalValu__c, newNumSharesIssued__c, valOfStock__c, Aggregate_nominal_value_New__c, AssignmentDate__c, redenominateDate__c, reduceCapitalDate__c, considerationGiven__c, benefitGiven__c, amountPaidUp__c, SHARETYPE__c, Total_aggregate_amount_paid__c, AggValueLessAuthMin__c, PrelimExpense__c, Signatory__c, varationField__c, Class_of_Share_new__c, Date__c, cancelled_shares__c, totalNumAggregate__c, totalNumofShares__c, ActiveData__c, Aggregate_nominal_value__c, Class_of_Shares__c, Company_Name__c, CreatedById, CreatedDate, Currency__c, IsDeleted, Number_of_Shares__c, Prescribed_Particulars__c, Id, Name, Total_aggregate_amount_unpaid__c, Transaction__c FROM Shares__c where Transaction__c = : transact.Id];
			List < shareValue > serialzedSHARE = new List < shareValue > ();
			List < shareClass > serializedCLASS = new List < shareClass > ();
			List < shareValueGrandTotal > serializedGT = new List < shareValueGrandTotal > ();
			for (Shares__c shareValueShares : lShares) {
				if (shareValueShares.SHARETYPE__c == 'STATEMENTOFCAPITAL') {
					serialzedSHARE.add(new shareValue(shareValueShares.Currency__c, shareValueShares.Aggregate_nominal_value__c, shareValueShares.Total_aggregate_amount_unpaid__c, shareValueShares.totalNumofShares__c));
					serializedCLASS.add(new shareClass(shareValueShares.Currency__c, shareValueShares.Class_of_Shares__c, shareValueShares.Prescribed_Particulars__c, shareValueShares.Aggregate_nominal_value__c, shareValueShares.Number_of_Shares__c));
					serializedGT.add(new shareValueGrandTotal(shareValueShares.Currency__c, shareValueShares.Total_aggregate_amount_unpaid__c, shareValueShares.valOfStock__c));
				}
			}
			shareValueGrandTotals gTS = new shareValueGrandTotals(serializedGT);
			Decimal sVGT = 1; // todo transact sValue Grand Total Number of sHares
			shareValues sV = new shareValues(serialzedSHARE);
			shareClasses sC = new shareClasses(serializedCLASS);
			latestSOCInd lS = new latestSOCInd('true');
			grandTotals gT = new grandTotals(sVGT, gTS);
			statementOfCapital sOC = new statementOfCapital(sV, sC, true, gT);
			corporateBody corp = new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c, sOC);
			formdata form = new formdata(fil, corp);

			//Get the attachment into the attachment object
			List < Attachment > attRec = [Select Id, Body from Attachment where parentId = : transact.Id];

			if (attRec == null) {
				return JSON.serialize('Transaction must have a form attached.');
			}
			List < attachments > sh19Att = new List < attachments > ();
			List < attachments > sh20Att = new List < attachments > ();
			List < attachments > res15Att = new List < attachments > ();
			List < attachments > capSSAtt = new List < attachments > ();
			for (Attachment att : attRec) {
				if (att.Name == 'STATEMENTOFCAPITAL') {
					sh19Att.add(new attachments(TransactionSerialiser.MIMETYPESTRING, TransactionSerialiser.CATEGORYSTRING, EncodingUtil.base64Encode(att.Body)));
				} else if (att.Name == 'SH20') {
					sh20Att.add(new attachments(TransactionSerialiser.MIMETYPESTRING, TransactionSerialiser.CATEGORYSTRING, EncodingUtil.base64Encode(att.Body)));
				} else if (att.Name == 'RES15') {
					res15Att.add(new attachments(TransactionSerialiser.MIMETYPESTRING, TransactionSerialiser.CATEGORYSTRING, EncodingUtil.base64Encode(att.Body)));
				} else if (att.Name == 'CAPSS') {
					capSSAtt.add(new attachments(TransactionSerialiser.MIMETYPESTRING, TransactionSerialiser.CATEGORYSTRING, EncodingUtil.base64Encode(att.Body)));
				}
			}
			JSONGenerator gen = JSON.createGenerator(true);
			//if SH19
			gen.writeStartObject();
			gen.writeFieldName('metadata');
			gen.writeObject(met);
			gen.writeFieldName('formdata');
			gen.writeObject(form);
			gen.writeFieldName('attachments');
			gen.writeObject(sh19Att);
			if (showSH20) {
				gen.writeFieldName('metadata');
				gen.writeObject(packagesmeta[0]);
				gen.writeFieldName('formdata');
				gen.writeObject(packagesform[0]);
				gen.writeFieldName('attachments');
				gen.writeObject(sh20Att);
			}
			if (showRES15) {
				gen.writeFieldName('metadata');
				gen.writeObject(packagesmeta[1]);
				gen.writeFieldName('formdata');
				gen.writeObject(packagesform[1]);
				gen.writeFieldName('attachments');
				gen.writeObject(res15Att);
			}
			if (showCappSS) {
				gen.writeFieldName('metadata');
				gen.writeObject(packagesmeta[2]);
				gen.writeFieldName('formdata');
				gen.writeObject(packagesform[2]);
				gen.writeFieldName('attachments');
				gen.writeObject(capSSAtt);
			}
			gen.writeEndObject();
			//gen.replace('"sNumber":', '"number":');
			return gen.getAsString();
		}

		if (transact.Form_Name__c == 'SH02') {
			// Booleans for sharetype changes
			Boolean redeemedShares;
			Boolean consolidatedShares;
			Boolean reconvertedShares;
			Boolean subdividedShares;


			List < consolidatedClass > consolidatedClassSH02 = new List < consolidatedClass > ();
			List < subdividedClass > subdividedClassSH02 = new List < subdividedClass > ();
			List < redeemedClass > redeemedClassSH02 = new List < redeemedClass > ();
			List < reconvertedClass > reconvertedClassSH02 = new List < reconvertedClass > ();
			//  BUILD shares
			for (Shares__c changedShares : transact.Shares__r) {
				if (changedShares.SHARETYPE__c == 'CONSOLIDATION') {
					consolidatedClassSH02.add(new consolidatedClass(changedShares.Class_of_Shares__c, new previousStructure(changedShares.oldNumSharesIssued__c, changedShares.OldNominalValue__c), new newStructure(changedShares.newNumSharesIssued__c, changedShares.NewNominalValu__c)));
				} else if (changedShares.SHARETYPE__c == 'SUBDIVISION') {
					subdividedClassSH02.add(new subdividedClass());
				} else if (changedShares.SHARETYPE__c == 'REDEMPTION') {
					redeemedClassSH02.add(new redeemedClass());
				} else if (changedShares.SHARETYPE__c == 'RECONVERSION') {
					reconvertedClassSH02.add(new reconvertedClass());
				}
			}
			if (consolidatedClassSH02.size() > 0) {consolidatedShares = true;}
			if (subdividedClassSH02.size() > 0) { subdividedShares = true;}
			if (redeemedClassSH02.size() > 0) {redeemedShares = true;}
			if (reconvertedClassSH02.size() > 0) { reconvertedShares = true;}

			consolidatedClasses  submittedConsolidated = new consolidatedClasses(consolidatedClassSH02);
			subdividedClasses  submitSubdivided = new subdividedClasses(subdividedClassSH02);
			redeemedClasses  submitRedeemed = new redeemedClasses(redeemedClassSH02);
			reconvertedClasses  submitReconverted = new reconvertedClasses(reconvertedClassSH02);

			shares sharesSH02 = new shares (redeemedShares, consolidatedShares, reconvertedShares, subdividedShares);

			metadata met = new metadata(transact.Form_Name__c, 1, '1', transact.SubmissionId__c);
			payment pay = new payment((transact.isPaymentAccount__c == true ? 'Account' : (transact.isPaymentCard__c == true ? 'Card' : (transact.isPaymentPaypal__c == true ? 'Paypal' : ''))), (transact.isPaymentAccount__c == true ? String.valueOf(transact.AccountNumber__c) : transact.Id));
			filingDetails fil = new filingDetails(transact.Barcode__c, dateOutput, pay); //, system.today().year() + '-' + system.today().month() + '-' + system.today().day(),
			List < Shares__c > lShares = [SELECT FreeForm__c, OldNominalValue__c, oldNumSharesIssued__c, NewNominalValu__c, newNumSharesIssued__c, valOfStock__c, Aggregate_nominal_value_New__c, AssignmentDate__c, redenominateDate__c, reduceCapitalDate__c, considerationGiven__c, benefitGiven__c, amountPaidUp__c, SHARETYPE__c, Total_aggregate_amount_paid__c, AggValueLessAuthMin__c, PrelimExpense__c, Signatory__c, varationField__c, Class_of_Share_new__c, Date__c, cancelled_shares__c, totalNumAggregate__c, totalNumofShares__c, ActiveData__c, Aggregate_nominal_value__c, Class_of_Shares__c, Company_Name__c, CreatedById, CreatedDate, Currency__c, IsDeleted, Number_of_Shares__c, Prescribed_Particulars__c, Id, Name, Total_aggregate_amount_unpaid__c, Transaction__c FROM Shares__c where Transaction__c = : transact.Id];
			List < shareValue > serialzedSHARE = new List < shareValue > ();
			List < shareClass > serializedCLASS = new List < shareClass > ();
			List < shareValueGrandTotal > serializedGT = new List < shareValueGrandTotal > ();
			for (Shares__c shareValueShares : lShares) {
				if (shareValueShares.SHARETYPE__c == 'STATEMENTOFCAPITAL') {
					serialzedSHARE.add(new shareValue(shareValueShares.Currency__c, shareValueShares.Aggregate_nominal_value__c, shareValueShares.Total_aggregate_amount_unpaid__c, shareValueShares.totalNumofShares__c));
					serializedCLASS.add(new shareClass(shareValueShares.Currency__c, shareValueShares.Class_of_Shares__c, shareValueShares.Prescribed_Particulars__c, shareValueShares.Aggregate_nominal_value__c, shareValueShares.Number_of_Shares__c));
					serializedGT.add(new shareValueGrandTotal(shareValueShares.Currency__c, shareValueShares.Total_aggregate_amount_unpaid__c, shareValueShares.valOfStock__c));
				}
			}
			shareValueGrandTotals gTS = new shareValueGrandTotals(serializedGT);
			Decimal sVGT = 1;
			shareValues sV = new shareValues(serialzedSHARE);
			shareClasses sC = new shareClasses(serializedCLASS);
			latestSOCInd lS = new latestSOCInd('true');
			grandTotals gT = new grandTotals(sVGT, gTS);
			statementOfCapital sOC = new statementOfCapital(sV, sC, true, gT);
			corporateBody corp = new corporateBody(transact.CompanyNumber__c, transact.CompanyName__c, sOC, sharesSH02, submittedConsolidated, submitSubdivided, submitRedeemed , submitReconverted);
			formdata form = new formdata(fil, corp);

			//Get the attachment into the attachment object
			List < Attachment > attRec = [Select Id, Body from Attachment where parentId = : transact.Id];
			if (attRec == null) {
				return JSON.serialize('Transaction must have a form attached.');
			}
			List < attachments > lAtt = new List < attachments > ();
			for (Attachment att : attRec) {
				lAtt.add(new attachments(TransactionSerialiser.MIMETYPESTRING, TransactionSerialiser.CATEGORYSTRING, EncodingUtil.base64Encode(att.Body)));
			}
			JSONGenerator gen = JSON.createGenerator(true);
			//if SH02
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
}