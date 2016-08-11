/*
Name:  DocStatusController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Authenticated Document Statuses 
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-05-27  Initial development.
*/
public with sharing class DocStatusController
{

    public String cookiestatus
    {
        get;
        set;
    }
    public String transactionType
    {
        get;
        set;
    }
    public String contactemail
    {
        get;
        set;
    }
    public String transactionID
    {
        get;
        set;
    }
    public String companyNumber
    {
        get;
        set;
    }
    public String companyName
    {
        get;
        set;
    }
    public String directorName
    {
        get;
        set;
    }
    public String directorSigningStatus
    {
        get;
        set;
    }
    public String directorDateofBirth
    {
        get;
        set;
    }
    public String envelopeID
    {
        get;
        set;
    }
    public String docusignobjectsname
    {
        get;
        set;
    }
    public Transaction__c currenttransaction
    {
        get;
        set;
    }

    public Transaction__c tx
    {
        get;
        set;
    }
    public String title
    {
        get;
        private set;
    }
    public Id attachmentId
    {
        get;
        private set;
    }
    public String size
    {
        get;
        private set;
    }
    public dsfs__DocuSign_Status__c docusignrecipientstatus
    {
        get;
        set;
    }

    public dsfs__DocuSign_Status__c txrs
    {
        get;
        set;
    }

    // dynamic set data
    public String companyTypeText {get; set;}
    public String companyStatus {get; set;}
    public String companyDateOfCreation {get; set;}


    // company address information
    public String companyAddress {get; set;}
    public String companyAddress1 {get; set;}
    public String companyAddress2 {get; set;}
    public String companyregion {get; set;}
    public String companypostcode {get; set;}
    public String companyCountry {get; set;}
    public String companyLocality {get; set;}
    public Boolean showprevious {get; set;}

    public Map<String, String> companyType {get; set;}
    public String informationstuff
    {
        get;
        set;
    }
    public List < dsfs__DocuSign_Recipient_Status__c > listofOfficers
    {
        get;
        set;
    }

    public Boolean hasPageErrors
    {
        get;
        set;
    }

    public String statusErrors
    {
        get;
        set;
    }

    private String nonce;
    private Company_Authorisation__c companyAuth;
    private static final String QUERY_STRING_PARAM_NONCE = 'state';

    SecurityManager securityMgr;

    public class DocStatusControllerCallbackException extends Exception
    {}

    public DocStatusController()
    {

    }
    public PageReference initialiseController()
    {

        // initialze controller and set docusign recipient status screen variables in view state

        parseQueryString();

        findCompanyAuthByNonce();

        // parse the query string and search for the company auth by the noncevalue 
        // if null redirect to company search page for auth 
        if (companyAuth != null)
        {

            // get transaction and attachment and set vforcepage
            getDocumentStatusTransaction();
            tx = currenttransaction;

            System.debug('here is your envelopeID' + envelopeID);
            System.debug('here is your transcationId' + transactionID);

            getRecipientSigningStatusInfo();
            System.debug('here is your recipient status' + docusignrecipientstatus);

            txrs = docusignrecipientstatus;

            companyName = tx.CompanyName__c;
            companyNumber = tx.CompanyNumber__c;
            // address information
            companyType = new Map<String, String>();

        
        companyType.put('private-unlimited', 'Private unlimited Company');
        companyType.put('ltd', 'Private limited Company');
        companyType.put('plc', 'Public limited Company');
        companyType.put('old-public-company', 'Old public Company');
        companyType.put('private-limited-guarant-nsc-limited-exemption', 'Private Limited Company by guarantee without share capital, use of \'Limited\'exemption');
        companyType.put('limited-partnership', 'Limited partnership');
        companyType.put('private-limited-guarant-nsc', 'Private limited by guarantee without share capital');
        companyType.put('converted-or-closed', 'Converted / closed');
        companyType.put('private-unlimited-nsc', 'Private unlimited Company without share capital');
        companyType.put('private-limited-shares-section-30-exemption', 'Private Limited Company, use of \'Limited\'exemption');
        companyType.put('assurance-company', 'Assurance Company');
        companyType.put('oversea-company', 'Overseas Company');
        companyType.put('eeig', 'European economic interest grouping (EEIG)');
        companyType.put('icvc-securities', 'Investment Company with variable capital');
        companyType.put('icvc-warrant', 'Investment Company with variable capital');
        companyType.put('icvc-umbrella', 'Investment Company with variable capital');
        companyType.put('industrial-and-provident-society', 'Industrial and provident society');
        companyType.put('northern-ireland', 'Northern Ireland Company');
        companyType.put('northern-ireland-other', 'Credit union (Northern Ireland)');
        companyType.put('llp', 'Limited liability partnership');
        companyType.put('royal-charter', 'Royal charter Company');
        companyType.put('investment-company-with-variable-capital', 'Investment Company with variable capital');
        companyType.put('unregistered-company', 'Unregistered Company');
        companyType.put('other', 'Other Company type');
        companyType.put('european-public-limited-liability-company-se', 'European public limited liability Company (SE)');
        companyType.put('uk-establishment', 'UK establishment Company');

        CompaniesHouse.CompanyProfile compProf = CompanyQueryAction.getCompanyInfo(companyNumber);
        companyAddress1 = compProf.registered_office_address.address_line_1;
        companyAddress2 = compProf.registered_office_address.address_line_2;
        companyregion = compProf.registered_office_address.region;
        companypostcode = compProf.registered_office_address.postal_code ;
        companyCountry = compProf.registered_office_address.country;
        companyLocality = compProf.registered_office_address.locality;
        companyStatus = compProf.company_status.capitalize();
        String[] split = compProf.date_of_creation.split('-');
        Datetime tempDate = Datetime.newInstance(Integer.valueOf(split[0]), Integer.valueOf(split[1]), Integer.valueOf(split[2]));
        companyDateOfCreation = tempDate.format('dd MMMMM yyyy');

        companyName = compProf.company_name;
        companyTypeText = companyType.get(compProf.type);
        showprevious = true;

        companyAddress = (companyAddress1 ==  null ? '' : companyAddress1 + '<br/>')  + (companyAddress2 ==  null ? '' : companyAddress2 + '<br/>')  + (companyLocality ==  null ? '' : companyLocality + '<br/>')  + (companyregion ==  null ? '' : companyregion + '<br/>') + (companypostcode ==  null ? '' : companypostcode + '<br/>')  + (companyCountry ==  null ? '' : companyCountry);

            system.debug('officers list for dsfs recipient status ====' + listofOfficers);
            // companyIncorporationDate = // may need CH api to query this information 
            // Note: (if we are calling this multiple times then we should do an upsert on the initial call to CH and persist
            // this data at least for the length of the transaction)
            // companyAddress = tx.
            //directorName = txrs.Name;

            //directorSigningStatus = txrs.dsfs__Recipient_Status__c;
            // directorDateofBirth = ??
            // statusComplete = txrs.??Status if all complete and envelope is ready to go
            //

            DestroyCookies();

            return null;
        }
        else
        {
            // set the cookiestatus and then redirect to companypage and call SecurityManager.getDownloadAuthRedirect();
            // to be sent back and captured in the above
            securityMgr = new SecurityManager();

            CreateDocumentStatusCookies();
            system.debug('transactiontype= ' + transactionType + 'company number=' + companyNumber);
            // need to check for company number/ parameters and if they don't exist then throw an error to show up on the docstatus page in apex messages

            return securityMgr.getDocumentStatusAuthRedirect(companyNumber, transactionType);
        }
    }

    /*
    private static docusignNamedObject__c getSettings() {

        for (docusignNamedObject__c s: docusignNamedObject__c.getAll().values()) {
            return s;
        }

        System.debug(LoggingLevel.ERROR, 'No active docusign settings in Custom Settings' + 'Can\'t build the system Host URL.');

        return null;
    }*/

    public sObject getRecipientSigningStatusInfo()
    {
        //String transactionID

        Cookie c = ApexPages.currentPage().getCookies().get('d_valueId');


        transactionID = SecurityManager.decryptText(c.getValue());

        //throw new Form_CustomException(' c=====' + transactionID);

        //tx.DocuSign_Status__r[0].dsfs__DocuSign_Envelope_ID__c = envelopeID;

        //System.debug('your envelope ids are '  + envelopeID);

        List < dsfs__DocuSign_Status__c > records = [SELECT dsfs__DocuSign_Envelope_ID__c, dsfs__Envelope_Status__c, Name, Id, (SELECT dsfs__DocuSign_Recipient_Company__c, dsfs__DocuSign_Recipient_Email__c, Name, dsfs__DocuSign_Recipient_Id__c, dsfs__Recipient_Status__c, Id FROM dsfs__R00NS0000000WUO2MAO__r Order by CreatedDate DESC) FROM dsfs__DocuSign_Status__c WHERE Transaction__c = : transactionID Order by CreatedDate DESC]; //and Transaction__r.Name = :'SUB0145'];
        if (records.size() > 0)
        {
            hasPageErrors = false;
            docusignrecipientstatus = records[0];
            listofOfficers = docusignrecipientstatus.dsfs__R00NS0000000WUO2MAO__r;

            System.debug('your records are ' + records[0]);
            return docusignrecipientstatus;
        }
        else{
        hasPageErrors = true;
        statusErrors = 'Please refresh as the application is processing data.';
        }
        return null;

    }

    public String CreateDocumentStatusCookies()
    {

        String dvalueparameter = ApexPages.currentPage().getParameters().get('documentsigningstatus');

        //throw new Form_CustomException(' d value param is ' + '  ' + dvalueparameter);


        if (dvalueparameter.contains(' '))
        {
            dvalueparameter = dvalueparameter.replace(' ', '+');
        }
        
        String paramValue = SecurityManager.decryptText(dvalueparameter);

        transactionType = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];

        contactemail = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];

        transactionID = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[2];

        companyNumber = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[3];

        //envelopeID = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[4];


        cookiestatus = 'setauth';

        Cookie d_valueTType = new Cookie('d_valueTType', SecurityManager.encryptText(transactionType), null, -1, true);

        Cookie d_valueEmail = new Cookie('d_valueEmail', SecurityManager.encryptText(contactemail), null, -1, true);

        Cookie d_valueId = new Cookie('d_valueId', SecurityManager.encryptText(transactionID), null, -1, true);

        Cookie d_valueCookieStatus = new Cookie('d_valueCookieStatus', SecurityManager.encryptText(cookiestatus), null, -1, true);

        //Cookie d_valueEnvelopeId = new Cookie('d_valueEnvelopeId', SecurityManager.encryptText(envelopeID), null, -1, true);

        ApexPages.currentPage().setCookies(new Cookie[]
        {
            d_valueTType,
            d_valueEmail,
            d_valueId,
            d_valueCookieStatus
        });
        //, d_valueEnvelopeId 
        return null;
    }

    public sObject getDocumentStatusTransaction()
    {

        Cookie a = ApexPages.currentPage().getCookies().get('d_valueTType');

        Cookie b = ApexPages.currentPage().getCookies().get('d_valueEmail');

        Cookie c = ApexPages.currentPage().getCookies().get('d_valueId');

        //Cookie d = ApexPages.currentPage().getCookies().get('d_valueEnvelopeId');

        transactiontype = SecurityManager.decryptText(a.getValue());

        contactemail = SecurityManager.decryptText(b.getValue());

        transactionID = SecurityManager.decryptText(c.getValue());

        //envelopeID = SecurityManager.decryptText(d.getValue());

        // retrieve the transaction
        List < Transaction__c > recs = [select Id, Form_Name__c, Presenter__c, Presenter__r.Name, isMajorityRequired__c, PresenterName__c, PresenterPhoneNumber__c, RequiredOfficerSign__c, ContactEmail__c, MultipleDirectors__c, Name, Historical_Valid_Step_Ids__c, CompanyNumber__c, Status__c, CompanyName__c, SubmissionId__c, Amount__c, (SELECT Id, BodyLength, Name FROM Attachments), (Select Id, Name, Email__c, isPresenter__c, isSignatory__c From Officers__r), (SELECT Name, dsfs__DocuSign_Envelope_ID__c, dsfs__Envelope_Link__c, dsfs__Envelope_Status__c, dsfs__Sender__c, dsfs__Sender_Email__c, dsfs__Subject__c FROM DocuSign_Status__r) from Transaction__c where Id = : transactionID];
        if (recs.size() == 1) currenttransaction = recs[0];


        return currenttransaction;
    }


    public String DestroyCookies()
    {

        Cookie d_valueTType = new Cookie('d_valueTType', 'empty', null, 0, true);

        Cookie d_valueEmail = new Cookie('d_valueEmail', 'empty', null, 0, true);

        Cookie d_valueId = new Cookie('d_valueId', 'empty', null, 0, true);

        //Cookie d_valueEnvelopeId = new Cookie('d_valueId', 'empty', null, 0, true);


        return null;
    }

    private void parseQueryString()
    {
        // Expect a nonce on the query string under the param "state".
        nonce = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_NONCE);
        if (String.isBlank(nonce))
        {

            // not authenticated so call authentication

        }
        else
        {
            // apex error message here
            //throw new DocumentControllerCallbackException('A ' + QUERY_STRING_PARAM_NONCE + ' parameter is required.'); }

        }
    }

    private void findCompanyAuthByNonce()
    {
        try
        {

            List < Company_Authorisation__c > companyAuthorisations = [select Id from Company_Authorisation__c where Nonce__c = : nonce];
            if (companyAuthorisations.size() == 1)
            {
                companyAuth = companyAuthorisations[0];
                return;
            }
        }
        catch (QueryException e)
        {
            throw new DocStatusControllerCallbackException('Invalid state ' + nonce);
        }
    }
}