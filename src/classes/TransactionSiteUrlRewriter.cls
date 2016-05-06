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
Ver. Author        	Date        Detail
1.0  Mark Cane&    	2016-04-03  Initial development.
1.0  Antonio Bravo  2016-04-25  Add DocuSign Pages.
*/
global class TransactionSiteUrlRewriter implements Site.UrlRewriter {
  	
	public String START 			= '/start';
	public String COMPANY 			= '/company';
	public String CONFIRMATION 		= '/Confirmation';
	public String DYNAMIC 			= '/dynamic';
	public String DIRECTORS_LIST 	= '/directors';
	public String SUMMARY 			= '/final-confirmation';
	public String CALLBACK 			= '/authcallback';
	public String ERROR 			= '/error';
	public String PAYMENT 			= '/Payment';
	public String REVIEW 			= '/review';
	
	public String VF_PAGE_START 		= '/StartFramework';
	public String VF_PAGE_COMPANY 		= '/Company';
	public String VF_PAGE_CONFIRMATION 	= '/ConfirmationFramework';
	public String VF_PAGE_DYNAMIC	 	= '/DynamicTest';
	public String VF_PAGE_DIRECTORS_LIST = '/DirectorsList';
	public String VF_PAGE_SUMMARY 		= '/Summary';
	public String VF_PAGE_CALLBACK 		= '/AccountsAuthCallback';
	public String VF_PAGE_ERROR 		= '/transactionexception';	
	public String VF_PAGE_DOCUSIGN 		= '/EmbedDocuSign';
	public String VF_PAGE_PDFGENERATION = '/PDFGeneration';	
	public String VF_PAGE_PAYMENT 		= '/Payment';	
	public String VF_PAGE_REVIEW 		= '/Review';

  
    global PageReference mapRequestUrl(PageReference friendlyUrl){
    	// this method translates a requested frendly url to a physical page.
    	System.debug(LoggingLevel.ERROR,'in mapRequestUrl:'+friendlyUrl);
    	
		String url = friendlyUrl.getUrl(); //relative path ignoring domain values e.g. /confirmation
		System.debug(LoggingLevel.ERROR,url);
		
		PageReference pr;

		if(url.startsWith(START))						{ pr = new PageReference(VF_PAGE_START); }
	    else if(url.startsWith(COMPANY))				{ pr = new PageReference(VF_PAGE_COMPANY); }
	    else if(url.startsWith(CONFIRMATION))			{ pr = new PageReference(VF_PAGE_CONFIRMATION); }
	    else if(url.startsWith(DYNAMIC))				{ pr = new  PageReference(VF_PAGE_DYNAMIC); }
	    else if(url.startsWith(DIRECTORS_LIST))			{ pr = new PageReference(VF_PAGE_DIRECTORS_LIST); }
	    else if(url.startsWith(SUMMARY))				{ pr = new PageReference(VF_PAGE_SUMMARY); }
	    else if(url.startsWith(CALLBACK))				{ pr = new PageReference(VF_PAGE_CALLBACK); }
	    else if(url.startsWith(ERROR))					{ pr = new PageReference(VF_PAGE_ERROR); }
	    else if(url.startsWith(VF_PAGE_DOCUSIGN))		{ pr = new PageReference(VF_PAGE_DOCUSIGN); }
		else if(url.startsWith(VF_PAGE_PDFGENERATION))	{ pr = new PageReference(VF_PAGE_PDFGENERATION); }
		else if(url.startsWith(PAYMENT))				{ pr = new PageReference(VF_PAGE_PAYMENT); }
	   	else if(url.startsWith(REVIEW))					{ pr = new PageReference(VF_PAGE_REVIEW); }

		

    	if (pr!=null) pr.getParameters().putAll(friendlyUrl.getParameters());
    	return pr;	    
    }
    
    global PageReference[] generateUrlFor(PageReference[] salesforceUrls){
    	// this method allows translaton of existing page links to pages to their friendly equivalent.    
    	System.debug(LoggingLevel.ERROR,'in generateUrlFor:'+salesforceUrls);
    	
    	List<PageReference> friendlyUrls = new List<PageReference>();
    	PageReference friendlyPageReference;
    	
    	for (PageReference pr : salesforceUrls){
    		
    		String url = pr.getUrl();
			System.debug(LoggingLevel.ERROR,url);
    		
    		friendlyPageReference=null;
    		
    		if(url.startsWith(VF_PAGE_START))				{ friendlyPageReference = new PageReference(START); }
	    	else if(url.startsWith(VF_PAGE_COMPANY))		{ friendlyPageReference = new PageReference(COMPANY); }
	    	else if(url.startsWith(VF_PAGE_CONFIRMATION))	{ friendlyPageReference = new PageReference(CONFIRMATION); }
	    	else if(url.startsWith(VF_PAGE_DYNAMIC))		{ friendlyPageReference = new PageReference(DYNAMIC); }
	    	else if(url.startsWith(VF_PAGE_DIRECTORS_LIST))	{ friendlyPageReference = new PageReference(DIRECTORS_LIST); }
			else if(url.startsWith(VF_PAGE_SUMMARY))		{ friendlyPageReference = new PageReference(SUMMARY); }
			else if(url.startsWith(VF_PAGE_CALLBACK))		{ friendlyPageReference = new PageReference(CALLBACK); }
	    	else if(url.startsWith(VF_PAGE_ERROR))			{ friendlyPageReference = new PageReference(ERROR); }
	    	else if(url.startsWith(VF_PAGE_DOCUSIGN))		{ friendlyPageReference = new PageReference(VF_PAGE_DOCUSIGN); }
	    	else if(url.startsWith(VF_PAGE_PDFGENERATION))	{ friendlyPageReference = new PageReference(VF_PAGE_PDFGENERATION); }
	    	else if(url.startsWith(VF_PAGE_PAYMENT))		{ friendlyPageReference = new PageReference(PAYMENT); }
	        else if(url.startsWith(VF_PAGE_REVIEW))			{ friendlyPageReference = new PageReference(REVIEW); }

	    	if (friendlyPageReference!=null) friendlyPageReference.getParameters().putAll(pr.getParameters());	    	
	    	
	    	friendlyUrls.add(friendlyPageReference);
    	}
    	System.debug(LoggingLevel.ERROR,friendlyUrls);
    	return friendlyUrls;
    }
}