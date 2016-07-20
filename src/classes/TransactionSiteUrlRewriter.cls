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
    public String SELECTIONBEHALF = '/selectBDi';
    public String INPUTBEHALF = '/randomI';
    public String CHOOSEDIRECTOR = '/choosedirector';
    public String WHICHDIRECTOR = '/whichdirector';
    public String OFFICERDETAILS = '/officerdetails';
    public String SHAREBUILDER = '/shareBuilder';
    public String CURRENCYSELECTION = '/currencySelection';
    public String PREPARTICULARRIGHTS = '/preparticularrights';
    public String ADDSHAREBASE = '/addsharesbase';
    public String TABULARDATA = '/tabulardata';
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
    public String FREEFORM = '/freeform';
    public String SCAP1 = '/SCapital1';
    public String SCAP2 = '/SCapital2';
    public String SCAP3 = '/SCapital3';

    // // // // //
    public String VF_PAGE_START = '/StartFramework';
    public String VF_PAGE_COMPANY = '/Company';
    public String VF_PAGE_CONFIRMATION = '/ConfirmationFramework';
    public String VF_PAGE_DYNAMIC = '/DynamicTest';
    public String VF_PAGE_DIRECTORS_LIST = '/DirectorsList';
    public String VF_PAGE_SUMMARY = '/Summary';
    public String VF_PAGE_CALLBACK = '/AccountsAuthCallback';
    public String VF_PAGE_ERROR = '/transactionexception';
    public String VF_PAGE_DIGITALSIGNATURE      = '/DigitalSignature';
    public String VF_PAGE_EXTDOCUSIGN      = '/ExternalEmbedDocuSign';
    public String VF_PAGE_DOCUSIGN = '/EmbedDocuSign';
    public String VF_PAGE_PDFGENERATION = '/PDFGeneration';
    public String VF_PAGE_PAYMENT = '/Payment';
    public String VF_PAGE_REVIEW = '/Review';
    public String VF_PAGE_PRESENTER = '/PresenterDirector';
    public String VF_PAGE_OFFICERSEMAIL = '/DirectorsInputList';
    public String VF_PAGE_GUIDANCE = '/Guidance';
    public String VF_PAGE_DETAILSCOMP = '/CompanyDetails';
    public String VF_PAGE_STATUS = '/Status';
    public String VF_PAGE_SUBMISSION = '/Submission';
    public String VF_PAGE_UPDATECPD = '/UpdateCompanyDirectors';
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
    public String VF_PAGE_TABULARDATA = '/TabularData';
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
    public String VF_PAGE_FREEFORM = '/FreeForm';
    public String VF_PAGE_SCAP1 = '/SCapital1';
    public String VF_PAGE_SCAP2 = '/SCapital2';
    public String VF_PAGE_SCAP3 = '/SCapital3';

    global PageReference mapRequestUrl(PageReference friendlyUrl) {
        // this method translates a requested frendly url to a physical page.
        System.debug(LoggingLevel.ERROR, 'in mapRequestUrl:' + friendlyUrl);
        String url = friendlyUrl.getUrl(); //relative path ignoring domain values e.g. /confirmation
        System.debug(LoggingLevel.ERROR, url);
        PageReference pr;
        if (url.startsWith(START)) {
            pr = new PageReference(VF_PAGE_START);
        } else if (url.startsWith(COMPANY)) {
            pr = new PageReference(VF_PAGE_COMPANY);
        } else if (url.startsWith(CONFIRMATION)) {
            pr = new PageReference(VF_PAGE_CONFIRMATION);
        } else if (url.startsWith(DYNAMIC)) {
            pr = new PageReference(VF_PAGE_DYNAMIC);
        } else if (url.startsWith(DIRECTORS_LIST)) {
            pr = new PageReference(VF_PAGE_DIRECTORS_LIST);
        } else if (url.startsWith(SUMMARY)) {
            pr = new PageReference(VF_PAGE_SUMMARY);
        } else if (url.startsWith(CALLBACK)) {
            pr = new PageReference(VF_PAGE_CALLBACK);
        } else if (url.startsWith(ERROR)) {
            pr = new PageReference(VF_PAGE_ERROR);
        } else if (url.startsWith(VF_PAGE_DOCUSIGN)) {
            pr = new PageReference(VF_PAGE_DOCUSIGN);
        } else if (url.startsWith(VF_PAGE_PDFGENERATION)) {
            pr = new PageReference(VF_PAGE_PDFGENERATION);
        } else if (url.startsWith(PAYMENT)) {
            pr = new PageReference(VF_PAGE_PAYMENT);
        } else if (url.startsWith(REVIEW)) {
            pr = new PageReference(VF_PAGE_REVIEW);
        } else if (url.startsWith(PRESENTER)) {
            pr = new PageReference(VF_PAGE_PRESENTER);
        } else if (url.startsWith(OFFICERSEMAIL)) {
            pr = new PageReference(VF_PAGE_OFFICERSEMAIL);
        } else if (url.startsWith(GUIDANCE)) {
            pr = new PageReference(VF_PAGE_GUIDANCE);
        } else if (url.startsWith(DETAILSCOMP)) {
            pr = new PageReference(VF_PAGE_DETAILSCOMP);
        } else if (url.startsWith(STATUS)) {
            pr = new PageReference(VF_PAGE_STATUS);
        } else if (url.startsWith(SUBMISSION)) {
            pr = new PageReference(VF_PAGE_SUBMISSION);
        } else if (url.startsWith(UPDATECPD)) {
            pr = new PageReference(VF_PAGE_UPDATECPD);
        } else if (url.startsWith(BEHALFDECISION)) {
            pr = new PageReference(VF_PAGE_BEHALFDECISION);
        } else if (url.startsWith(SELECTIONBEHALF)) {
            pr = new PageReference(VF_PAGE_SELECTIONBEHALF);
        } else if (url.startsWith(INPUTBEHALF)) {
            pr = new PageReference(VF_PAGE_INPUTBEHALF);
        } else if (url.startsWith(CHOOSEDIRECTOR)) {
            pr = new PageReference(VF_PAGE_CHOOSEDIRECTOR);
        } else if (url.startsWith(WHICHDIRECTOR)) {
            pr = new PageReference(VF_PAGE_WHICHDIRECTOR);
        } else if (url.startsWith(OFFICERDETAILS)) {
            pr = new PageReference(VF_PAGE_OFFICERDETAILS);
        } else if (url.startsWith(SHAREBUILDER)) {
            pr = new PageReference(VF_PAGE_SHAREBUILDER);
        } else if (url.startsWith(CURRENCYSELECTION)) {
            pr = new PageReference(VF_PAGE_CURRENCYSELECTION);
        } else if (url.startsWith(PREPARTICULARRIGHTS)) {
            pr = new PageReference(VF_PAGE_PREPARTICULARRIGHTS);
        } else if (url.startsWith(ADDSHAREBASE)) {
            pr = new PageReference(VF_PAGE_ADDSHARESBASE);
        } else if (url.startsWith(TABULARDATA)) {
            pr = new PageReference(VF_PAGE_TABULARDATA);
        } else if (url.startsWith(SIGNINGPAGE)) {
            pr = new PageReference(VF_PAGE_SIGNINGPAGE);
        } else if (url.startsWith(ATTACHMENTS)) {
            pr = new PageReference(VF_PAGE_ATTACHMENTS);
        } else if (url.startsWith(CANCELLEDSHARES)) {
            pr = new PageReference(VF_PAGE_CANCELLEDSHARES);
        } else if (url.startsWith(SELECTSHARETYPE)) {
            pr = new PageReference(VF_PAGE_SELECTSHARETYPE);
        } else if (url.startsWith(CHANGESHARENAME)) {
            pr = new PageReference(VF_PAGE_CHANGESHARENAME);
        } else if (url.startsWith(VARIATION)) {
            pr = new PageReference(VF_PAGE_VARIATION);
        } else if (url.startsWith(APPLICATIONDATE)) {
            pr = new PageReference(VF_PAGE_APPLICATIONDATE);
        } else if (url.startsWith(FORMAPPLICATION)) {
            pr = new PageReference(VF_PAGE_FORMAPPLICATION);
        } else if (url.startsWith(PROMOTERS)) {
            pr = new PageReference(VF_PAGE_PROMOTERS);
        } else if (url.startsWith(RESOLUTIONCHANGE)) {
            pr = new PageReference(VF_PAGE_RESOLUTIONCHANGE);
        } else if (url.startsWith(EDITYSHARESBYTYPE)) {
            pr = new PageReference(VF_PAGE_EDITYSHARESBYTYPE);
        } else if (url.startsWith(CRS)) {
            pr = new PageReference(VF_PAGE_CRS);
        } else if (url.startsWith(CHANGECRS)) {
            pr = new PageReference(VF_PAGE_CHANGECRS);
        } else if (url.startsWith(FREEFORM)) {
            pr = new PageReference(VF_PAGE_FREEFORM);
        } else if (url.startsWith(SCAP1)) {
            pr = new PageReference(VF_PAGE_SCAP1);
        } else if (url.startsWith(SCAP2)) {
            pr = new PageReference(VF_PAGE_SCAP2);
        } else if (url.startsWith(SCAP3)) {
            pr = new PageReference(VF_PAGE_SCAP3);
        } else if (url.startsWith(VF_PAGE_DIGITALSIGNATURE))     { pr = new PageReference(VF_PAGE_DIGITALSIGNATURE); }
        else if (url.startsWith(VF_PAGE_EXTDOCUSIGN))       { pr = new PageReference(VF_PAGE_EXTDOCUSIGN); }

        if (pr != null) pr.getParameters().putAll(friendlyUrl.getParameters());
        return pr;
    }
    global PageReference[] generateUrlFor(PageReference[] salesforceUrls) {
        // this method allows translaton of existing page links to pages to their friendly equivalent.
        System.debug(LoggingLevel.ERROR, 'in generateUrlFor:' + salesforceUrls);
        List < PageReference > friendlyUrls = new List < PageReference > ();
        PageReference friendlyPageReference;
        for (PageReference pr : salesforceUrls) {
            String url = pr.getUrl();
            System.debug(LoggingLevel.ERROR, url);
            friendlyPageReference = null;
            if (url.startsWith(VF_PAGE_START)) {
                friendlyPageReference = new PageReference(START);
            } else if (url.startsWith(VF_PAGE_DETAILSCOMP)) {
                friendlyPageReference = new PageReference(DETAILSCOMP);
            } else if (url.startsWith(VF_PAGE_COMPANY)) {
                friendlyPageReference = new PageReference(COMPANY);
            } else if (url.startsWith(VF_PAGE_CONFIRMATION)) {
                friendlyPageReference = new PageReference(CONFIRMATION);
            } else if (url.startsWith(VF_PAGE_DYNAMIC)) {
                friendlyPageReference = new PageReference(DYNAMIC);
            } else if (url.startsWith(VF_PAGE_DIRECTORS_LIST)) {
                friendlyPageReference = new PageReference(DIRECTORS_LIST);
            } else if (url.startsWith(VF_PAGE_SUMMARY)) {
                friendlyPageReference = new PageReference(SUMMARY);
            } else if (url.startsWith(VF_PAGE_CALLBACK)) {
                friendlyPageReference = new PageReference(CALLBACK);
            } else if (url.startsWith(VF_PAGE_ERROR)) {
                friendlyPageReference = new PageReference(ERROR);
            } else if (url.startsWith(VF_PAGE_DOCUSIGN)) {
                friendlyPageReference = new PageReference(VF_PAGE_DOCUSIGN);
            } else if (url.startsWith(VF_PAGE_PDFGENERATION)) {
                friendlyPageReference = new PageReference(VF_PAGE_PDFGENERATION);
            } else if (url.startsWith(VF_PAGE_PAYMENT)) {
                friendlyPageReference = new PageReference(PAYMENT);
            } else if (url.startsWith(VF_PAGE_REVIEW)) {
                friendlyPageReference = new PageReference(REVIEW);
            } else if (url.startsWith(VF_PAGE_PRESENTER)) {
                friendlyPageReference = new PageReference(PRESENTER);
            } else if (url.startsWith(VF_PAGE_OFFICERSEMAIL)) {
                friendlyPageReference = new PageReference(OFFICERSEMAIL);
            } else if (url.startsWith(VF_PAGE_GUIDANCE)) {
                friendlyPageReference = new PageReference(GUIDANCE);
            } else if (url.startsWith(VF_PAGE_STATUS)) {
                friendlyPageReference = new PageReference(STATUS);
            } else if (url.startsWith(VF_PAGE_SUBMISSION)) {
                friendlyPageReference = new PageReference(SUBMISSION);
            } else if (url.startsWith(VF_PAGE_UPDATECPD)) {
                friendlyPageReference = new PageReference(UPDATECPD);
            } else if (url.startsWith(VF_PAGE_BEHALFDECISION)) {
                friendlyPageReference = new PageReference(BEHALFDECISION);
            } else if (url.startsWith(VF_PAGE_SELECTIONBEHALF)) {
                friendlyPageReference = new PageReference(SELECTIONBEHALF);
            } else if (url.startsWith(VF_PAGE_INPUTBEHALF)) {
                friendlyPageReference = new PageReference(INPUTBEHALF);
            } else if (url.startsWith(VF_PAGE_CHOOSEDIRECTOR)) {
                friendlyPageReference = new PageReference(CHOOSEDIRECTOR);
            } else if (url.startsWith(VF_PAGE_WHICHDIRECTOR)) {
                friendlyPageReference = new PageReference(WHICHDIRECTOR);
            } else if (url.startsWith(VF_PAGE_OFFICERDETAILS)) {
                friendlyPageReference = new PageReference(OFFICERDETAILS);
            } else if (url.startsWith(VF_PAGE_SHAREBUILDER)) {
                friendlyPageReference = new PageReference(SHAREBUILDER);
            } else if (url.startsWith(VF_PAGE_CURRENCYSELECTION)) {
                friendlyPageReference = new PageReference(CURRENCYSELECTION);
            } else if (url.startsWith(VF_PAGE_PREPARTICULARRIGHTS)) {
                friendlyPageReference = new PageReference(PREPARTICULARRIGHTS);
            } else if (url.startsWith(VF_PAGE_ADDSHARESBASE)) {
                friendlyPageReference = new PageReference(ADDSHAREBASE);
            } else if (url.startsWith(VF_PAGE_TABULARDATA)) {
                friendlyPageReference = new PageReference(TABULARDATA);
            } else if (url.startsWith(VF_PAGE_SIGNINGPAGE)) {
                friendlyPageReference = new PageReference(SIGNINGPAGE);
            } else if (url.startsWith(VF_PAGE_ATTACHMENTS)) {
                friendlyPageReference = new PageReference(ATTACHMENTS);
            } else if (url.startsWith(VF_PAGE_CANCELLEDSHARES)) {
                friendlyPageReference = new PageReference(CANCELLEDSHARES);
            } else if (url.startsWith(VF_PAGE_SELECTSHARETYPE)) {
                friendlyPageReference = new PageReference(SELECTSHARETYPE);
            } else if (url.startsWith(VF_PAGE_CHANGESHARENAME)) {
                friendlyPageReference = new PageReference(CHANGESHARENAME);
            } else if (url.startsWith(VF_PAGE_VARIATION)) {
                friendlyPageReference = new PageReference(VARIATION);
            } else if (url.startsWith(VF_PAGE_APPLICATIONDATE)) {
                friendlyPageReference = new PageReference(APPLICATIONDATE);
            } else if (url.startsWith(VF_PAGE_FORMAPPLICATION)) {
                friendlyPageReference = new PageReference(FORMAPPLICATION);
            } else if (url.startsWith(VF_PAGE_PROMOTERS)) {
                friendlyPageReference = new PageReference(PROMOTERS);
            } else if (url.startsWith(VF_PAGE_RESOLUTIONCHANGE)) {
                friendlyPageReference = new PageReference(RESOLUTIONCHANGE);
            } else if (url.startsWith(VF_PAGE_EDITYSHARESBYTYPE)) {
                friendlyPageReference = new PageReference(EDITYSHARESBYTYPE);
            } else if (url.startsWith(VF_PAGE_CHANGECRS)) {
                friendlyPageReference = new PageReference(CHANGECRS);
            } else if (url.startsWith(VF_PAGE_CRS)) {
                friendlyPageReference = new PageReference(CRS);
            } else if (url.startsWith(VF_PAGE_FREEFORM)) {
                friendlyPageReference = new PageReference(FREEFORM);
            } else if (url.startsWith(VF_PAGE_SCAP1)) {
                friendlyPageReference = new PageReference(SCAP1);
            } else if (url.startsWith(VF_PAGE_SCAP2)) {
                friendlyPageReference = new PageReference(SCAP2);
            } else if (url.startsWith(VF_PAGE_SCAP3)) {
                friendlyPageReference = new PageReference(SCAP3);
            } else if (url.startsWith(VF_PAGE_DIGITALSIGNATURE))  { friendlyPageReference = new PageReference(VF_PAGE_DIGITALSIGNATURE); }
            else if (url.startsWith(VF_PAGE_EXTDOCUSIGN))       { friendlyPageReference = new PageReference(VF_PAGE_EXTDOCUSIGN); }
            if (friendlyPageReference != null) friendlyPageReference.getParameters().putAll(pr.getParameters());
            friendlyUrls.add(friendlyPageReference);
        }
        System.debug(LoggingLevel.ERROR, friendlyUrls);
        return friendlyUrls;
    }
}