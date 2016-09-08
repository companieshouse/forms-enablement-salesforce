/*
Name:  TransactionSiteUrlRewriter.cls
Copyright © 2016  MethodsDigital
======================================================
======================================================
Purpose:
-------

Note, this class serves as an example reference.
Mapping of page name to friendly url should be table or setting driven.

======================================================
======================================================
History
-------
Ver. Author         Date        Detail
1.0  Mark Cane&     2016-04-03  Initial development.
1.0  Antonio Bravo  2016-04-25  Add DocuSign Pages.
*/
global class TransactionSiteUrlRewriter implements Site.UrlRewriter {
    public String START = '/start';
    public String COMPANY = '/company';
    public String COMPANYSEARCHED = '/companySearched';
    public String CONFIRMATION = '/Confirmation';
    public String DYNAMIC = '/dynamic';
    public String DIRECTORS_LIST = '/directors';
    public String SUMMARY = '/final-confirmation';
    public String CALLBACK = '/authcallback';
    public String ERROR = '/error';
    public String PAYMENT = '/Payment';
    public String REVIEW = '/review';
    public String PRESENTER = '/presenter';
    public String OFFICERSEMAIL = '/inputEmails';
    public String GUIDANCE = '/guidance';
    public String DETAILSCOMP = '/detailsCompany';
    public String STATUS = '/status';
    public String SUBMISSION = '/submission';
    public String UPDATECPD = '/updateDirectors';
    public String BEHALFDECISION = '/behalfDecision';
    public String SELECTIONBEHALF = '/selectBehalf';
    public String INPUTBEHALF = '/behalfInput';
    public String CHOOSEDIRECTOR = '/choosedirector';
    public String WHICHDIRECTOR = '/whichdirector';
    public String DOCUMENT = '/documents';
    public String OFFICERDETAILS = '/officerdetails';
    public String SHAREBUILDER = '/shareBuilder';
    public String CURRENCYSELECTION = '/currencySelection';
    public String PREPARTICULARRIGHTS = '/preparticularrights';
    public String ADDSHAREBASE = '/addsharesbase';
    public String ATTACHMENTS = '/attachments';
    public String SIGNINGPAGE = '/signingpage';
    public String CANCELLEDSHARES = '/cancelledshares';
    public String SELECTSHARETYPE = '/selectsharetype';
    public String CHANGESHARENAME = '/changeshareclassname';
    public String APPLICATIONDATE = '/applicationdate';
    public String FORMAPPLICATION = '/formapplication';
    public String VARIATION = '/variationofrights';
    public String PROMOTERS = '/promoterstable';
    public String RESOLUTIONCHANGE = '/resolutionchange';
    public String EDITYSHARESBYTYPE = '/editsharesbytype';
    public String CRS = '/crs';
    public String CHANGECRS = '/changecrs';
    public String YOURREVIEWCHANGES = '/yourreviewchanges';
    public String NONPRESCRIBED1 = '/Nonprescribed1';
    public String NONPRESCRIBED2 = '/Nonprescribed2';

    public String SCAP1 = '/SCapital1';
    public String SCAP2 = '/SCapital2';
    public String SCAP3 = '/SCapital3';
    public String SHOWSHARECHANGE = '/showClassChanges';
    public String OBJECTSCOMPANY = '/ObjectsCompany';
    public String WITHDRAWDISSOLUTION = '/withdrawdissolution';
    public String INTEGRATIONERROR = '/intError';
    public String SIGNOUT = '/signout';
    public String SESSIONEXPIRED = '/expired';

    ///// VF Strings
    public String VF_PAGE_START         = '/StartFramework';
    public String VF_PAGE_COMPANYSEARCH       = '/CompanySearched';
    public String VF_PAGE_COMPANY       = '/Company';
    public String VF_PAGE_CONFIRMATION  = '/ConfirmationFramework';
    public String VF_PAGE_DYNAMIC       = '/DynamicTest';
    public String VF_PAGE_DIRECTORS_LIST = '/DirectorsList';
    public String VF_PAGE_SUMMARY       = '/Summary';
    public String VF_PAGE_CALLBACK      = '/AccountsAuthCallback';
    public String VF_PAGE_ERROR         = '/transactionexception';
    public String VF_PAGE_DIGITALSIGNATURE      = '/DigitalSignature';
    public String VF_PAGE_EXTDOCUSIGN      = '/ExternalEmbedDocuSign';
    public String VF_PAGE_PAYMENT       = '/Payment';
    public String VF_PAGE_REVIEW        = '/Review';
    public String VF_PAGE_DOCUMENT = '/Documents';
    public String VF_PAGE_PRESENTER     = '/PresenterDirector';
    public String VF_PAGE_OFFICERSEMAIL = '/DirectorsInputList';
    public String VF_PAGE_GUIDANCE      = '/Guidance';
    public String VF_PAGE_DETAILSCOMP   = '/CompanyDetails';
    public String VF_PAGE_STATUS        = '/Status';
    public String VF_PAGE_SUBMISSION    = '/Submission';
    public String VF_PAGE_UPDATECPD     = '/UpdateCompanyDirectors';
    public String VF_PAGE_BEHALFDECISION = '/BehalfDecision';
    public String VF_PAGE_SELECTIONBEHALF = '/BehalfWhichSignatory';
    public String VF_PAGE_INPUTBEHALF = '/BehalfInputDetails';
    public String VF_PAGE_CHOOSEDIRECTOR = '/chooseDirector';
    public String VF_PAGE_WHICHDIRECTOR = '/whichDirector';
    public String VF_PAGE_OFFICERDETAILS = '/OfficerDetails';
    public String VF_PAGE_SHAREBUILDER = '/ShareBuilder';
    public String VF_PAGE_CURRENCYSELECTION = '/CurrencySelection';
    public String VF_PAGE_PREPARTICULARRIGHTS = '/PreParticularRights';
    public String VF_PAGE_ADDSHARESBASE = '/AddSharesBase';
    public String VF_PAGE_ATTACHMENTS = '/Attachments';
    public String VF_PAGE_SIGNINGPAGE = '/SigningPage';
    public String VF_PAGE_CANCELLEDSHARES = '/CancelledShares';
    public String VF_PAGE_SELECTSHARETYPE = '/selectShareType';
    public String VF_PAGE_CHANGESHARENAME = '/ChangeShareClassName';
    public String VF_PAGE_VARIATION = '/VariationOfRights';
    public String VF_PAGE_APPLICATIONDATE = '/ApplicationDate';
    public String VF_PAGE_FORMAPPLICATION = '/FormApplication';
    public String VF_PAGE_PROMOTERS = '/PromotersTable';
    public String VF_PAGE_RESOLUTIONCHANGE = '/ResolutionChange';
    public String VF_PAGE_EDITYSHARESBYTYPE = '/EditySharesByType';
    public String VF_PAGE_CRS = '/CRS';
    public String VF_PAGE_CHANGECRS = '/ChangeCRS';
    public String VF_PAGE_YOURREVIEWCHANGES = '/YourReviewChanges';
    public String VF_PAGE_FREEFORM = '/FreeForm';
    public String VF_PAGE_SCAP1 = '/SCapital1';
    public String VF_PAGE_SCAP2 = '/SCapital2';
    public String VF_PAGE_SCAP3 = '/SCapital3';
    public String VF_PAGE_SHOWCHANGE = '/ShowClassChanges';
    public String VF_PAGE_OBJECTSCOMPANY = '/ObjectsCompany';
    public String VF_PAGE_WITHDRAWDISSOLUTION = '/WithdrawDissolution';
    public String VF_PAGE_NONPRESCRIBED1 = '/Nonprescribed1';
    public String VF_PAGE_NONPRESCRIBED2 = '/Nonprescribed2';
    public String VF_PAGE_INTEGRATIONERROR = '/IntegrationError';
    public String VF_PAGE_SIGNOUT = '/SignOut';
    public String VF_PAGE_SESSIONEXPIRED = '/SessionExpired';

    global PageReference mapRequestUrl(PageReference friendlyUrl) {
        // this method translates a requested frendly url to a physical page.
        System.debug(LoggingLevel.ERROR, 'in mapRequestUrl:' + friendlyUrl);
        String url = friendlyUrl.getUrl(); //relative path ignoring domain values e.g. /confirmation
        if(url.contains('?'))
            url = url.substringBefore('?');
        System.debug(LoggingLevel.ERROR, url);

        PageReference pr;

        if (url.equals(START))                       { pr = new PageReference(VF_PAGE_START); }
        else if (url.equals(COMPANY))                { pr = new PageReference(VF_PAGE_COMPANY); }
        else if (url.equals(COMPANYSEARCHED))                { pr = new PageReference(VF_PAGE_COMPANYSEARCH); }
        else if (url.equals(CONFIRMATION))           { pr = new PageReference(VF_PAGE_CONFIRMATION); }
        else if (url.equals(DYNAMIC))                { pr = new  PageReference(VF_PAGE_DYNAMIC); }
        else if (url.equals(DIRECTORS_LIST))         { pr = new PageReference(VF_PAGE_DIRECTORS_LIST); }
        else if (url.equals(SUMMARY))                { pr = new PageReference(VF_PAGE_SUMMARY); }
        else if (url.equals(CALLBACK))               { pr = new PageReference(VF_PAGE_CALLBACK); }
        else if (url.equals(ERROR))                  { pr = new PageReference(VF_PAGE_ERROR); }
        else if (url.equals(VF_PAGE_DIGITALSIGNATURE))       { pr = new PageReference(VF_PAGE_DIGITALSIGNATURE); }
        else if (url.equals(VF_PAGE_EXTDOCUSIGN))       { pr = new PageReference(VF_PAGE_EXTDOCUSIGN); }
        else if (url.equals(PAYMENT))                { pr = new PageReference(VF_PAGE_PAYMENT); }
        else if (url.equals(REVIEW))                 { pr = new PageReference(VF_PAGE_REVIEW); }
        else if (url.equals(PRESENTER))              { pr = new PageReference(VF_PAGE_PRESENTER); }
        else if (url.equals(OFFICERSEMAIL))          { pr = new PageReference(VF_PAGE_OFFICERSEMAIL); }
        else if (url.equals(GUIDANCE))               { pr = new PageReference(VF_PAGE_GUIDANCE); }
        else if (url.equals(DETAILSCOMP))            { pr = new PageReference(VF_PAGE_DETAILSCOMP); }
        else if (url.equals(STATUS))                 { pr = new PageReference(VF_PAGE_STATUS); }
        else if (url.equals(SUBMISSION))             { pr = new PageReference(VF_PAGE_SUBMISSION); }
        else if (url.equals(UPDATECPD))              { pr = new PageReference(VF_PAGE_UPDATECPD); }
        else if (url.equals(BEHALFDECISION))         { pr = new PageReference(VF_PAGE_BEHALFDECISION); }
        else if (url.equals(SELECTIONBEHALF))            { pr = new PageReference(VF_PAGE_SELECTIONBEHALF); }
        else if (url.equals(INPUTBEHALF))            { pr = new PageReference(VF_PAGE_INPUTBEHALF); }
        else if (url.equals(CHOOSEDIRECTOR)) { pr = new PageReference(VF_PAGE_CHOOSEDIRECTOR);}
        else if (url.equals(WHICHDIRECTOR)) { pr = new PageReference(VF_PAGE_WHICHDIRECTOR);}
        else if (url.equals(OFFICERDETAILS)) { pr = new PageReference(VF_PAGE_OFFICERDETAILS);}
        else if (url.equals(SHAREBUILDER)) { pr = new PageReference(VF_PAGE_SHAREBUILDER);}
        else if (url.equals(CURRENCYSELECTION)) { pr = new PageReference(VF_PAGE_CURRENCYSELECTION);}
        else if (url.equals(PREPARTICULARRIGHTS)) { pr = new PageReference(VF_PAGE_PREPARTICULARRIGHTS);}
        else if (url.equals(ADDSHAREBASE)) { pr = new PageReference(VF_PAGE_ADDSHARESBASE);}
        else if (url.equals(SIGNINGPAGE)) { pr = new PageReference(VF_PAGE_SIGNINGPAGE);}
        else if (url.equals(ATTACHMENTS)) { pr = new PageReference(VF_PAGE_ATTACHMENTS);}
        else if (url.equals(CANCELLEDSHARES)) { pr = new PageReference(VF_PAGE_CANCELLEDSHARES);}
        else if (url.equals(SELECTSHARETYPE)) { pr = new PageReference(VF_PAGE_SELECTSHARETYPE);}
        else if (url.equals(CHANGESHARENAME)) { pr = new PageReference(VF_PAGE_CHANGESHARENAME);}
        else if (url.equals(VARIATION)) { pr = new PageReference(VF_PAGE_VARIATION);}
        else if (url.equals(APPLICATIONDATE)) { pr = new PageReference(VF_PAGE_APPLICATIONDATE);}
        else if (url.equals(FORMAPPLICATION)) { pr = new PageReference(VF_PAGE_FORMAPPLICATION);}
        else if (url.equals(PROMOTERS)) { pr = new PageReference(VF_PAGE_PROMOTERS);}
        else if (url.equals(RESOLUTIONCHANGE)) { pr = new PageReference(VF_PAGE_RESOLUTIONCHANGE);}
        else if (url.equals(EDITYSHARESBYTYPE)) { pr = new PageReference(VF_PAGE_EDITYSHARESBYTYPE);}
        else if (url.equals(CRS)) { pr = new PageReference(VF_PAGE_CRS);}
        else if (url.equals(CHANGECRS)) { pr = new PageReference(VF_PAGE_CHANGECRS);}
        else if (url.equals(VF_PAGE_YOURREVIEWCHANGES)) { pr = new PageReference(YOURREVIEWCHANGES); }
        else if (url.equals(SCAP1)) { pr = new PageReference(VF_PAGE_SCAP1);}
        else if (url.equals(SCAP2)) { pr = new PageReference(VF_PAGE_SCAP2);}
        else if (url.equals(SCAP3)) { pr = new PageReference(VF_PAGE_SCAP3);}
        else if (url.equals(VF_PAGE_DIGITALSIGNATURE)) { pr = new PageReference(VF_PAGE_DIGITALSIGNATURE); }
        else if (url.equals(VF_PAGE_EXTDOCUSIGN)) { pr = new PageReference(VF_PAGE_EXTDOCUSIGN); }
        else if (url.equals(VF_PAGE_SHOWCHANGE)) { pr = new PageReference(SHOWSHARECHANGE); }
        else if (url.equals(VF_PAGE_OBJECTSCOMPANY)) { pr = new PageReference(OBJECTSCOMPANY); }
        else if (url.equals(VF_PAGE_WITHDRAWDISSOLUTION)) { pr = new PageReference(WITHDRAWDISSOLUTION); }
        else if (url.equals(VF_PAGE_NONPRESCRIBED1)) { pr = new PageReference(NONPRESCRIBED1); }
        else if (url.equals(VF_PAGE_NONPRESCRIBED2)) { pr = new PageReference(NONPRESCRIBED2); }
		else if (url.equals(INTEGRATIONERROR)) { pr = new PageReference(VF_PAGE_INTEGRATIONERROR); }
        else if (url.equals(SIGNOUT)) { pr = new PageReference(VF_PAGE_SIGNOUT); }
        else if (url.equals(SESSIONEXPIRED)) { pr = new PageReference(VF_PAGE_SESSIONEXPIRED); }
        else if (url.equals(DOCUMENT)) { pr = new PageReference(VF_PAGE_DOCUMENT); }

        if (pr != null) pr.getParameters().putAll(friendlyUrl.getParameters());
        return pr;
    }

    global PageReference[] generateUrlFor(PageReference[] salesforceUrls) {
        // this method allows translaton of existing page links to pages to their friendly equivalent.
        System.debug(LoggingLevel.ERROR, 'in generateUrlFor:' + salesforceUrls);
        List<PageReference> friendlyUrls = new List<PageReference>();
        PageReference friendlyPageReference;

        for (PageReference pr : salesforceUrls) {

            String url = pr.getUrl();
            if(url.contains('?'))
                url = url.substringBefore('?');
            System.debug(LoggingLevel.ERROR, url);

            friendlyPageReference = null;

            if (url.equals(VF_PAGE_START))               { friendlyPageReference = new PageReference(START); }
            else if (url.equals(VF_PAGE_DETAILSCOMP))    { friendlyPageReference = new PageReference(DETAILSCOMP); }
            else if (url.equals(VF_PAGE_COMPANY))        { friendlyPageReference = new PageReference(COMPANY); }
            else if (url.equals(VF_PAGE_COMPANYSEARCH))        { friendlyPageReference = new PageReference(COMPANYSEARCHED); }
            else if (url.equals(VF_PAGE_CONFIRMATION))   { friendlyPageReference = new PageReference(CONFIRMATION); }
            else if (url.equals(VF_PAGE_DYNAMIC))        { friendlyPageReference = new PageReference(DYNAMIC); }
            else if (url.equals(VF_PAGE_DIRECTORS_LIST)) { friendlyPageReference = new PageReference(DIRECTORS_LIST); }
            else if (url.equals(VF_PAGE_SUMMARY))        { friendlyPageReference = new PageReference(SUMMARY); }
            else if (url.equals(VF_PAGE_CALLBACK))       { friendlyPageReference = new PageReference(CALLBACK); }
            else if (url.equals(VF_PAGE_ERROR))          { friendlyPageReference = new PageReference(ERROR); }
            else if (url.equals(VF_PAGE_DIGITALSIGNATURE))  { friendlyPageReference = new PageReference(VF_PAGE_DIGITALSIGNATURE); }
            else if (url.equals(VF_PAGE_EXTDOCUSIGN))       { friendlyPageReference = new PageReference(VF_PAGE_EXTDOCUSIGN); }
            else if (url.equals(VF_PAGE_PAYMENT))        { friendlyPageReference = new PageReference(PAYMENT); }
            else if (url.equals(VF_PAGE_REVIEW))         { friendlyPageReference = new PageReference(REVIEW); }
            else if (url.equals(VF_PAGE_PRESENTER))      { friendlyPageReference = new PageReference(PRESENTER); }
            else if (url.equals(VF_PAGE_OFFICERSEMAIL))  { friendlyPageReference = new PageReference(OFFICERSEMAIL); }
            else if (url.equals(VF_PAGE_GUIDANCE))       { friendlyPageReference = new PageReference(GUIDANCE); }
            else if (url.equals(VF_PAGE_STATUS))         { friendlyPageReference = new PageReference(STATUS); }
            else if (url.equals(VF_PAGE_SUBMISSION))     { friendlyPageReference = new PageReference(SUBMISSION); }
            else if (url.equals(VF_PAGE_UPDATECPD))      { friendlyPageReference = new PageReference(UPDATECPD); }
            else if (url.equals(VF_PAGE_BEHALFDECISION))     { friendlyPageReference = new PageReference(BEHALFDECISION); }
            else if (url.equals(VF_PAGE_SELECTIONBEHALF))        { friendlyPageReference = new PageReference(SELECTIONBEHALF); }
            else if (url.equals(VF_PAGE_INPUTBEHALF))        { friendlyPageReference = new PageReference(INPUTBEHALF); }
            else if (url.equals(VF_PAGE_CHOOSEDIRECTOR)) { friendlyPageReference = new PageReference(CHOOSEDIRECTOR); }
            else if (url.equals(VF_PAGE_WHICHDIRECTOR)) { friendlyPageReference = new PageReference(WHICHDIRECTOR); }
            else if (url.equals(VF_PAGE_OFFICERDETAILS)) {friendlyPageReference = new PageReference(OFFICERDETAILS);}
            else if (url.equals(VF_PAGE_SHAREBUILDER)) {friendlyPageReference = new PageReference(SHAREBUILDER);}
            else if (url.equals(VF_PAGE_CURRENCYSELECTION)) {friendlyPageReference = new PageReference(CURRENCYSELECTION);}
            else if (url.equals(VF_PAGE_PREPARTICULARRIGHTS)) {friendlyPageReference = new PageReference(PREPARTICULARRIGHTS);}
            else if (url.equals(VF_PAGE_ADDSHARESBASE)) {friendlyPageReference = new PageReference(ADDSHAREBASE);}
            else if (url.equals(VF_PAGE_SIGNINGPAGE)) {friendlyPageReference = new PageReference(SIGNINGPAGE);}
            else if (url.equals(VF_PAGE_ATTACHMENTS)) {friendlyPageReference = new PageReference(ATTACHMENTS);}
            else if (url.equals(VF_PAGE_CANCELLEDSHARES)) {friendlyPageReference = new PageReference(CANCELLEDSHARES);}
            else if (url.equals(VF_PAGE_SELECTSHARETYPE)) {friendlyPageReference = new PageReference(SELECTSHARETYPE);}
            else if (url.equals(VF_PAGE_CHANGESHARENAME)) {friendlyPageReference = new PageReference(CHANGESHARENAME);}
            else if (url.equals(VF_PAGE_VARIATION)) {friendlyPageReference = new PageReference(VARIATION);}
            else if (url.equals(VF_PAGE_APPLICATIONDATE)) {friendlyPageReference = new PageReference(APPLICATIONDATE);}
            else if (url.equals(VF_PAGE_FORMAPPLICATION)) {friendlyPageReference = new PageReference(FORMAPPLICATION);}
            else if (url.equals(VF_PAGE_PROMOTERS)) {friendlyPageReference = new PageReference(PROMOTERS);}
            else if (url.equals(VF_PAGE_RESOLUTIONCHANGE)) {friendlyPageReference = new PageReference(RESOLUTIONCHANGE);}
            else if (url.equals(VF_PAGE_EDITYSHARESBYTYPE)) {friendlyPageReference = new PageReference(EDITYSHARESBYTYPE);}
            else if (url.equals(VF_PAGE_CHANGECRS)) {friendlyPageReference = new PageReference(CHANGECRS);}
            else if (url.equals(VF_PAGE_CRS)) {friendlyPageReference = new PageReference(CRS);}
            else if (url.equals(VF_PAGE_YOURREVIEWCHANGES)) {friendlyPageReference = new PageReference(YOURREVIEWCHANGES);}
            else if (url.equals(VF_PAGE_SCAP1)) {friendlyPageReference = new PageReference(SCAP1);}
            else if (url.equals(VF_PAGE_SCAP2)) {friendlyPageReference = new PageReference(SCAP2);}
            else if (url.equals(VF_PAGE_SCAP3)) {friendlyPageReference = new PageReference(SCAP3);}
            else if (url.equals(VF_PAGE_OBJECTSCOMPANY)) {friendlyPageReference = new PageReference(OBJECTSCOMPANY);}
            else if (url.equals(VF_PAGE_SHOWCHANGE)) {friendlyPageReference = new PageReference(SHOWSHARECHANGE);}
            else if (url.equals(VF_PAGE_WITHDRAWDISSOLUTION)) {friendlyPageReference = new PageReference(WITHDRAWDISSOLUTION);}
            else if (url.equals(VF_PAGE_NONPRESCRIBED1)) {friendlyPageReference = new PageReference(NONPRESCRIBED1);}
            else if (url.equals(VF_PAGE_NONPRESCRIBED2)) {friendlyPageReference = new PageReference(NONPRESCRIBED2);}
			else if (url.equals(VF_PAGE_INTEGRATIONERROR)) {friendlyPageReference = new PageReference(INTEGRATIONERROR);}
            else if (url.equals(VF_PAGE_SIGNOUT)) {friendlyPageReference = new PageReference(SIGNOUT);}
            else if (url.equals(VF_PAGE_SESSIONEXPIRED)) {friendlyPageReference = new PageReference(SESSIONEXPIRED);}
            else if (url.equals(VF_PAGE_DOCUMENT)) {friendlyPageReference = new PageReference(DOCUMENT);}

            if (friendlyPageReference != null) friendlyPageReference.getParameters().putAll(pr.getParameters());
            friendlyUrls.add(friendlyPageReference);
        }
        System.debug(LoggingLevel.ERROR, friendlyUrls);
        return friendlyUrls;
    }
}