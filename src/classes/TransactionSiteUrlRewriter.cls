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
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-03  Initial development.
*/
global class TransactionSiteUrlRewriter implements Site.UrlRewriter {
  	
	public String START = '/start';
	public String COMPANY = '/company';
	public String CONFIRMATION = '/confirmation';
	public String DYNAMIC_TEST = '/dynamic';
	public String DIRECTORS_LIST = '/directors';
	public String SUMMARY = '/final-confirmation';
	public String CALLBACK = '/authcallback';
	public String ERROR = '/error';
	public String SYLVAINTEST = '/Payment';
	
	public String VF_PAGE_START = '/StartFramework';
	public String VF_PAGE_COMPANY = '/Company';
	public String VF_PAGE_CONFIRMATION = '/ConfirmationFramework';
	public String VF_PAGE_DYNAMIC_TEST = '/DynamicTest';
	public String VF_PAGE_DIRECTORS_LIST = '/DirectorsList';
	public String VF_PAGE_SUMMARY = '/Summary';
	public String VF_PAGE_CALLBACK = '/AccountsAuthCallback';
	public String VF_PAGE_ERROR = '/transactionexception';	
	public String VF_PAGE_SYLVAINTEST = '/Payment';

  
    global PageReference mapRequestUrl(PageReference friendlyUrl){
    	// this method translates a requested frendly url to a physical page.
    	System.debug(LoggingLevel.ERROR,'in mapRequestUrl:'+friendlyUrl);
    	
		String url = friendlyUrl.getUrl(); //relative path ignoring domain values e.g. /confirmation
		System.debug(LoggingLevel.ERROR,url);
		
		PageReference pr;

		if(url.startsWith(START)){ pr = new PageReference(VF_PAGE_START); }
	    else if(url.startsWith(COMPANY)){ pr = new PageReference(VF_PAGE_COMPANY); }
	    else if(url.startsWith(CONFIRMATION)){ pr = new PageReference(VF_PAGE_CONFIRMATION); }
	    else if(url.startsWith(DYNAMIC_TEST)){ pr = new  PageReference(VF_PAGE_DYNAMIC_TEST); }
	    else if(url.startsWith(DIRECTORS_LIST)){ pr = new PageReference(VF_PAGE_DIRECTORS_LIST); }
	    else if(url.startsWith(SUMMARY)){ pr = new PageReference(VF_PAGE_SUMMARY); }
	    else if(url.startsWith(CALLBACK)){ pr = new PageReference(VF_PAGE_CALLBACK); }
	    else if(url.startsWith(ERROR)){ pr = new PageReference(VF_PAGE_ERROR); }
	   	else if(url.startsWith(SYLVAINTEST)){ pr = new PageReference(VF_PAGE_SYLVAINTEST); }
	   		
    
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
    		
    		if(url.startsWith(VF_PAGE_START)){ friendlyPageReference = new PageReference(START); }
	    	else if(url.startsWith(VF_PAGE_COMPANY)){ friendlyPageReference = new PageReference(COMPANY); }
	    	else if(url.startsWith(VF_PAGE_CONFIRMATION)){ friendlyPageReference = new PageReference(CONFIRMATION); }
	    	else if(url.startsWith(VF_PAGE_DYNAMIC_TEST)){ friendlyPageReference = new PageReference(DYNAMIC_TEST); }
	    	else if(url.startsWith(VF_PAGE_DIRECTORS_LIST)){ friendlyPageReference = new PageReference(DIRECTORS_LIST); }
			else if(url.startsWith(VF_PAGE_SUMMARY)){ friendlyPageReference = new PageReference(SUMMARY); }
			else if(url.startsWith(VF_PAGE_CALLBACK)){ friendlyPageReference = new PageReference(CALLBACK); }
	    	else if(url.startsWith(VF_PAGE_ERROR)){ friendlyPageReference = new PageReference(ERROR); }
	    	else if(url.startsWith(VF_PAGE_SYLVAINTEST)){ friendlyPageReference = new PageReference(SYLVAINTEST); }
	    	
	    	if (friendlyPageReference!=null) friendlyPageReference.getParameters().putAll(pr.getParameters());	    	
	    	
	    	friendlyUrls.add(friendlyPageReference);
    	}
    	System.debug(LoggingLevel.ERROR,friendlyUrls);
    	return friendlyUrls;
    }
}