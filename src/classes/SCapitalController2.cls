/*
Name:  SCapitalController2.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: SCapitalController2

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoye&    2016-13-07  Initial development.
*/
public with sharing class SCapitalController2 extends TransactionStepControllerBase {
	public String companyName {
		get;
		set;
	}
	public String companyNumber {
		get;
		set;
	}
	public String displayText {
		get;
		set;
	}
	public String displayText2 {
		get;
		set;
	}
	public String displayText3 {
		get;
		set;
	}
	public String displayText4 {
		get;
		set;
	}
	public String displayText5 {
		get;
		set;
	}
	public String displayText6 {
		get;
		set;
	}
	public String headerText1 {
		get;
		set;
	}
	public String headerText2 {
		get;
		set;
	}
	public String headerText3 {
		get;
		set;
	}
	public String continueButtonText {
		get;
		set;
	}
	public String previousButtonText {
		get;
		set;
	}
	public String  currencyHidden {get; set;}
	public String  aggHidden {get; set;}

	public String prescribedParticular {get; set;}
	public String shareClassType {get; set;}
	public String currencyType {get; set;}
	public Decimal numberofshares {get; set;}
	public Decimal nominalvalue {get; set;}
	public Boolean hasPageErrors {get; set;}
	public String currentErrorMessage {get; set;}
	public Decimal aggUnpaid {get; set;}
	public Boolean showCurrency {get; set;}
	public Boolean otherAgg {get; set;}
	public SCapitalController2() {
		super();
		if (isPageInitialised) initialiseStep();
	}
	public void initialiseStep() {
		companyName = submissionMgr.submission.CompanyName__c;
		companyNumber = submissionMgr.submission.CompanyNumber__c;
		displayText = transactionMgr.currentStep.Display_Text_1__c;
		displayText2 = transactionMgr.currentStep.Display_Text_2__c;
		displayText3 = transactionMgr.currentStep.Display_Text_3__c;
		displayText4 = transactionMgr.currentStep.Display_Text_4__c;
		displayText5 = transactionMgr.currentStep.Display_Text_5__c;
		displayText6 = transactionMgr.currentStep.Display_Text_6__c;
		headerText1 = transactionMgr.currentStep.Header_Text_1__c;
		headerText2 = transactionMgr.currentStep.Header_Text_2__c;
		headerText3 = transactionMgr.currentStep.Header_Text_3__c;
		continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
		previousButtonText = transactionMgr.currentStep.PreviousButtonText__c;
		shareClassType = submissionMgr.submission.selectShareType__c;
		prescribedParticular = submissionMgr.submission.prescribedParticular__c;
		currencyHidden = 'js-hidden';
	}
	public PageReference checkstatus () {
		if (submissionMgr.submission.finishedAddingShares__c == true) {
			return nextStep();
		}
		return null;
	}
	public PageReference AddtocurrentShare() {
		submissionMgr.persist();
		return nextStep();
	}
	private void persistStep() {
		submissionMgr.persist();
	}
	public void showOtherAgg() {
		otherAgg = true;
	}
	public void showCurrencyOther() {

		//if (currencyHidden == 'js-hidden') {
		//currencyHidden = '';
		showCurrency = true;

		//} else if (currencyHidden == '') {
		//currencyHidden = 'js-hidden';
		//showCurrency = false;
		//}
	}
	public PageReference addnewShares() {
		if (currencyType == null || currencyType.length() == 0) {
			hasPageErrors = true;
			currentErrorMessage = 'Must add the share currency';
			return null;
		}
		if (numberofshares == 0 || numberofshares == null) {
			hasPageErrors = true;
			currentErrorMessage = 'Must add the number of shares';
			return null;
		}
		//throw new Form_CustomException('agg nominal value is ' + nominalvalue);
		if (nominalvalue == 0 || nominalvalue == null) {
			hasPageErrors = true;
			currentErrorMessage = 'Aggregate nominal value must be greater than 0';
			return null;
		}
		if (aggUnpaid == 0) {
			hasPageErrors = false;
			currentErrorMessage = 'Aggregate unpaid is 0';
		}
		if (shareClassType.length() < 1) {
			hasPageErrors = true;
			currentErrorMessage = 'You are missing the Share Class Type';
			return null;
		}

		List < Shares__c > sharesToAdd = new List < Shares__c > ();
		try {
			sharesToAdd.add(new Shares__c(Total_aggregate_amount_unpaid__c = aggUnpaid, Aggregate_nominal_value__c = nominalvalue, Number_of_Shares__c = numberofshares, Currency__c = currencyType, SHARETYPE__c = 'STATEMENTOFCAPITAL', Prescribed_Particulars__c = prescribedParticular , Name = shareClassType, Transaction__c = submissionMgr.submission.Id, Class_of_Shares__c = shareClassType, ActiveData__c = true));
			insert sharesToAdd;
		} catch (DmlException e) {System.debug('DML error =' + ' ' + e.getMessage());} catch (Exception e) {System.debug('Exception =' + ' ' + e.getMessage());}

		PageReference pg = new PageReference('/SCapital3');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;

	}

	public List<SelectOption> getcurrencies() {
		List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('', ''));
		options.add(new SelectOption('GBP', 'Pound Sterling'));
		options.add(new SelectOption('EUR', 'Euro'));
		options.add(new SelectOption('USD', 'US Dollar'));
		options.add(new SelectOption('JPY', 'Yen'));
		options.add(new SelectOption('CHF', 'Swiss Franc'));
		options.add(new SelectOption('CAD', 'Canadian Dollar'));
		options.add(new SelectOption('AUD', 'Australian Dollar'));
		options.add(new SelectOption('NZD', 'New Zealand Dollar'));
		options.add(new SelectOption('RUB', 'Russian Rouble'));
		options.add(new SelectOption('HKD', 'Hong Kong Dollar'));
		options.add(new SelectOption('SGD', 'Singapore Dollar'));
		options.add(new SelectOption('AED', 'UAE Dirham'));
		options.add(new SelectOption('AFN', 'Afghani'));
		options.add(new SelectOption('ALL', 'Lek'));
		options.add(new SelectOption('AMD', 'Armenian Dram'));
		options.add(new SelectOption('ANG', 'Netherlands Antillian Guilder'));
		options.add(new SelectOption('AOA', 'Kwanza'));
		options.add(new SelectOption('AON', 'Angolan New Kwanza '));
		options.add(new SelectOption('ARS', 'Argentine Peso'));
		options.add(new SelectOption('AWG', 'Aruban Guilder'));
		options.add(new SelectOption('AZN', 'Azerbaijanian New Manat '));
		options.add(new SelectOption('BAM', 'Convertible Marks'));
		options.add(new SelectOption('BBD', 'Barbados Dollar'));
		options.add(new SelectOption('BDT', 'Taka'));
		options.add(new SelectOption('BEF', 'Belgian Franc'));
		options.add(new SelectOption('BGN', 'Bulgarian Lev'));
		options.add(new SelectOption('BHD', 'Bahraini Dinar'));
		options.add(new SelectOption('BIF', 'Burundi Franc'));
		options.add(new SelectOption('BMD', 'Bermuda Dollar'));
		options.add(new SelectOption('BND', 'Brunei Dollar'));
		options.add(new SelectOption('BOV', 'Mvdol'));
		options.add(new SelectOption('BOB', 'Boliviano'));
		options.add(new SelectOption('BRL', 'Brazilian Real'));
		options.add(new SelectOption('BSD', 'Bahamian Dollar'));
		options.add(new SelectOption('BTN', 'Ngultrum'));
		options.add(new SelectOption('BWP', 'Pula'));
		options.add(new SelectOption('BYB', 'Belarussian Ruble'));
		options.add(new SelectOption('BZD', 'Belize Dollar'));
		options.add(new SelectOption('CDF', 'Franc Congolais'));
		options.add(new SelectOption('CHE', 'WIR Euro'));
		options.add(new SelectOption('CHW', 'WIR Franc'));
		options.add(new SelectOption('CLF', 'Unidades de formento'));
		options.add(new SelectOption('CLP', 'Chilean Peso'));
		options.add(new SelectOption('CNY', 'Yuan Renminbi'));
		options.add(new SelectOption('COP', 'Colombian Peso'));
		options.add(new SelectOption('COU', 'Unidad de Valor Real'));
		options.add(new SelectOption('CRC', 'Costa Rican Colon'));
		options.add(new SelectOption('CSD', 'Serbian Dinar'));
		options.add(new SelectOption('CUP', 'Cuban Peso'));
		options.add(new SelectOption('CVE', 'Cape Verde Escudo'));
		options.add(new SelectOption('CYP', 'Cyprus Pound'));
		options.add(new SelectOption('CZK', 'Czech Koruna'));
		options.add(new SelectOption('DJF', 'Djibouti Franc'));
		options.add(new SelectOption('DKK', 'Danish Krone'));
		options.add(new SelectOption('DOP', 'Dominican Peso'));
		options.add(new SelectOption('DZD', 'Algerian Dinar'));
		options.add(new SelectOption('EEK', 'Kroon'));
		options.add(new SelectOption('EGP', 'Egyptian Pound'));
		options.add(new SelectOption('ERN', 'Nakfa'));
		options.add(new SelectOption('ETB', 'Ethiopian Birr'));
		options.add(new SelectOption('FJD', 'Fiji Dollar'));
		options.add(new SelectOption('FKP', 'Falkland Islands Pound'));
		options.add(new SelectOption('GEL', 'Lari'));
		options.add(new SelectOption('GHS', 'Cedi'));
		options.add(new SelectOption('GIP', 'Gibraltar Pound'));
		options.add(new SelectOption('GMD', 'Dalasi'));
		options.add(new SelectOption('GNF', 'Guinea Franc'));
		options.add(new SelectOption('GTQ', 'Quetzal'));
		options.add(new SelectOption('GWP', 'Guinea-Bissau Peso'));
		options.add(new SelectOption('GYD', 'Guyana Dollar'));
		options.add(new SelectOption('HNL', 'Lempira'));
		options.add(new SelectOption('HRK', 'Croatian Kuna'));
		options.add(new SelectOption('HTG', 'Gourde'));
		options.add(new SelectOption('HUF', 'Forint'));
		options.add(new SelectOption('IDR', 'Rupiah'));
		options.add(new SelectOption('ILS', 'New Israeli Sheqel'));
		options.add(new SelectOption('INR', 'Indian Rupee'));
		options.add(new SelectOption('IQD', 'Iraqi Dinar'));
		options.add(new SelectOption('IRR', 'Iranian Rial'));
		options.add(new SelectOption('ISK', 'Iceland Krona'));
		options.add(new SelectOption('JMD', 'Jamaican Dollar'));
		options.add(new SelectOption('JOD', 'Jordanian Dinar'));
		options.add(new SelectOption('KES', 'Kenyan Shilling'));
		options.add(new SelectOption('KGS', 'Som'));
		options.add(new SelectOption('KHR', 'Riel'));
		options.add(new SelectOption('KMF', 'Comoro Franc'));
		options.add(new SelectOption('KPW', 'North Korean Won'));
		options.add(new SelectOption('KRW', 'Won'));
		options.add(new SelectOption('KWD', 'Kuwaiti Dinar'));
		options.add(new SelectOption('KYD', 'Cayman Islands Dollar'));
		options.add(new SelectOption('KZT', 'Tenge'));
		options.add(new SelectOption('LAK', 'Kip'));
		options.add(new SelectOption('LBP', 'Lebanese Pound'));
		options.add(new SelectOption('LKR', 'Sri Lanka Rupee'));
		options.add(new SelectOption('LRD', 'Liberian Dollar'));
		options.add(new SelectOption('LSL', 'Loti'));
		options.add(new SelectOption('LTL', 'Lithuanian Litas'));
		options.add(new SelectOption('LVL', 'Latvian Lats'));
		options.add(new SelectOption('LYD', 'Libyan Dinar'));
		options.add(new SelectOption('MAD', 'Moroccan Dirham'));
		options.add(new SelectOption('MDL', 'Moldovan Leu'));
		options.add(new SelectOption('MGA', 'Malagasy Ariary'));
		options.add(new SelectOption('MKD', 'Denar'));
		options.add(new SelectOption('MMK', 'Kyat'));
		options.add(new SelectOption('MNT', 'Tugrik'));
		options.add(new SelectOption('MOP', 'Pataca'));
		options.add(new SelectOption('MRO', 'Ouguiya'));
		options.add(new SelectOption('MTL', 'Maltese Lira'));
		options.add(new SelectOption('MUR', 'Mauritius Rupee'));
		options.add(new SelectOption('MVR', 'Rufiyaa'));
		options.add(new SelectOption('MWK', 'Kwacha'));
		options.add(new SelectOption('MXN', 'Mexican Peso'));
		options.add(new SelectOption('MXV', 'Mexican Unidad de Inversion (UID)'));
		options.add(new SelectOption('MYR', 'Malaysian Ringgit'));
		options.add(new SelectOption('MZM', 'Merical'));
		options.add(new SelectOption('NAD', 'Namibian Dollar'));
		options.add(new SelectOption('NGN', 'Naira'));
		options.add(new SelectOption('NIO', 'Cordoba Oro'));
		options.add(new SelectOption('NOK', 'Norwegian Krone'));
		options.add(new SelectOption('NPR', 'Nepalese Rupee'));
		options.add(new SelectOption('OMR', 'Rial Omani'));
		options.add(new SelectOption('PAB', 'Balboa'));
		options.add(new SelectOption('PEN', 'Nuevo Sol'));
		options.add(new SelectOption('PGK', 'Kina'));
		options.add(new SelectOption('PHP', 'Philippine Peso'));
		options.add(new SelectOption('PKR', 'Pakistan Rupee'));
		options.add(new SelectOption('PLN', 'Zloty'));
		options.add(new SelectOption('PYG', 'Guarani'));
		options.add(new SelectOption('QAR', 'Qatari Rial'));
		options.add(new SelectOption('RON', 'New Leu'));
		options.add(new SelectOption('RWF', 'Rwanda Franc'));
		options.add(new SelectOption('SAR', 'Saudi Riyal'));
		options.add(new SelectOption('SBD', 'Solomon Islands Dollar'));
		options.add(new SelectOption('SCR', 'Seychelles Rupee'));
		options.add(new SelectOption('SDD', 'Sudanese Dinar'));
		options.add(new SelectOption('SEK', 'Swedish Krona'));
		options.add(new SelectOption('SHP', 'Saint Helena Pound'));
		options.add(new SelectOption('SIT', 'Tolar'));
		options.add(new SelectOption('SKK', 'Slovak Koruna'));
		options.add(new SelectOption('SLL', 'Leone'));
		options.add(new SelectOption('SOS', 'Somali Shilling'));
		options.add(new SelectOption('SRD', 'Surinam Dollar'));
		options.add(new SelectOption('STD', 'Dobra'));
		options.add(new SelectOption('SVC', 'El Salvador Colon'));
		options.add(new SelectOption('SYP', 'Syrian Pound'));
		options.add(new SelectOption('SZL', 'Lilangeni'));
		options.add(new SelectOption('THB', 'Baht'));
		options.add(new SelectOption('TJS', 'Somoni'));
		options.add(new SelectOption('TMM', 'Manat'));
		options.add(new SelectOption('TND', 'Tunisian Dinar'));
		options.add(new SelectOption('TOP', 'Pa\'anga'));
		options.add(new SelectOption('TRY', 'New Turkish Lira'));
		options.add(new SelectOption('TTD', 'Trinidad and Tobago Dollar'));
		options.add(new SelectOption('TWD', 'New Taiwan Dollar'));
		options.add(new SelectOption('TZS', 'Tanzanian Shilling'));
		options.add(new SelectOption('UAH', 'Hryvnia'));
		options.add(new SelectOption('UGX', 'Uganda Shilling'));
		options.add(new SelectOption('UYU', 'Peso Uruguayo'));
		options.add(new SelectOption('UZS', 'Uzbekistan Sum'));
		options.add(new SelectOption('VEB', 'Bolivar'));
		options.add(new SelectOption('VND', 'Dong'));
		options.add(new SelectOption('VUV', 'Vatu'));
		options.add(new SelectOption('WST', 'Tala'));
		options.add(new SelectOption('XAF', 'CFA Franc BEAC'));
		options.add(new SelectOption('XCD', 'East Caribbean Dollar'));
		options.add(new SelectOption('XDR', 'SDR'));
		options.add(new SelectOption('XOF', 'CFA Franc BCEAO'));
		options.add(new SelectOption('XPF', 'CFP Franc'));
		options.add(new SelectOption('YER', 'Yemeni Rial'));
		options.add(new SelectOption('ZAR', 'Rand'));
		options.add(new SelectOption('ZMK', 'Kwacha'));
		options.add(new SelectOption('ZWD', 'Zimbabwe Dollar'));
		options.add(new SelectOption('UKH', 'UKRAINE HRYVNIA'));

		return options;
	}

	public void grabCurrencyType () {
		//currencyHidden = 'js-hidden';
		showCurrency = false;
		//throw new Form_CustomException('here is the currency type'+ currencyType);
	}
	public void grabnumberOfShares () {
		//throw new Form_CustomException('here is the number of shares '+ numberofshares);

	}
	public void grabAggNomValue () {
		//throw new Form_CustomException('here is the nominal value '+ nominalvalue);

	}
	public void grabAggUnpaid () {
		//throw new Form_CustomException(' agg unpaid is ' + aggUnpaid);
		if (aggUnpaid == 0) {
			otherAgg = false;
		} else if (aggUnpaid != 0) {
			otherAgg = true;
		}
		//throw new Form_CustomException('here is the agg unpaid '+ aggUnpaid);

	}

	public PageReference addsameShare() {

		PageReference pg = new PageReference('/SCapital2');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
	public PageReference nextAction() {


		if (!validatePageState()) return Page.TransactionException;
		persistStep();
		return nextStep();
	}
	public PageReference previousAction() {
		if (!validatePageState()) return Page.TransactionException;
		PageReference pg = new PageReference('/SCapital1');
		pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
		pg.setRedirect(true);
		return pg;
	}
}