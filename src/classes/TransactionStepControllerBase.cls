/*
Name:  TransactionStepControllerBase.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Base class for all Transaction Step pages.

Encapsulates :  authentication logic
                state restoration - transaction defintion
                state restoration - submission data

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-05  Initial development.
*/
public virtual class TransactionStepControllerBase {

    // public with sharing class members.
    public Boolean isPageAuthenticated = false;
    public Boolean isPageInitialised = false;
    public Boolean isPageAlreadyValidStep = false;

    public SecurityManager securityMgr;
    public SubmissionManager submissionMgr;    
	public TransactionManager transactionMgr;
	
	public Id stepId;
	public Id submissionId;
	
	// Public properties.
	public Boolean isLastPage { get; set; }
        
    // Constructors.
    public TransactionStepControllerBase() {
        initialise();
    }
    // End Constructors.

    // Initialisation methods.
    private void initialise() {

        System.debug(LoggingLevel.ERROR, 'in initialise');
        try {
            //throw new Form_CustomException('here');

            isPageAuthenticated = false;
            isPageInitialised = false;

            // todo reinstate authorisation.

            // Authorsation state (User and Company).
            //Cookie companyAuthCookie = ApexPages.currentPage().getCookies().get('company_auth');
            //System.debug(LoggingLevel.ERROR,'companyAuthCookie:'+companyAuthCookie);
            //if (companyAuthCookie==null) return;
            //String companyAuthId = SecurityManager.decryptText(companyAuthCookie.getValue());

            //Cookie userAuthCookie = ApexPages.currentPage().getCookies().get('user_auth');
            //System.debug(LoggingLevel.ERROR,'userAuthCookie:'+userAuthCookie);
            //if (userAuthCookie==null) return;
            //String userAuthId = SecurityManager.decryptText(userAuthCookie.getValue());

            //securityMgr = new SecurityManager();
            //if (!securityMgr.validateAuthenticatedState(companyAuthId,userAuthId)) return;
            isPageAuthenticated = true;

            // Transaction context.
            if (!ApexPages.currentPage().getParameters().containsKey('c') ||
                    String.isBlank(ApexPages.currentPage().getParameters().get('c'))) return;

            //Reverse the logic of C parameter for the payment only
            String paramInput = ApexPages.currentPage().getParameters().get('c');
            if (paramInput.contains(' ')) {
                paramInput = paramInput.replace(' ', '+');
            }
            if (paramInput.contains(AppConstants.PERCENTAGE_REPLACEMENT)) {
                paramInput = paramInput.replace( AppConstants.PERCENTAGE_REPLACEMENT, '%');
                paramInput = EncodingUtil.urlDecode(paramInput, 'UTF-8');
            }

            String paramValue = SecurityManager.decryptText(paramInput);

            // Submission state.
            submissionId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];
            if (!SubmissionManager.isValidSubmissionId(submissionId)) return;

            stepId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];
            if (!TransactionManager.isValidTransactionStep(stepId)) return;

            // Finally check that the step Id is valid for the submission
            // todo - merge with submission id check early in context.
            if (!SubmissionManager.isValidSubmissionStepId(submissionId, stepId)) return;

            transactionMgr = new TransactionManager(stepId);
            isLastPage = transactionMgr.isLastPage();

            isPageInitialised = loadStepSubmissionState();

            //We need to detect if the page has been loaded more than 1 time
            String historicalValidStepId = submissionMgr.submission.Historical_Valid_Step_Ids__c;
            String stepIdTXT = stepId;
            if (historicalValidStepId != null)
                if (historicalValidStepId.contains(stepIdTXT)) {
                    //We need to check if the value associated is 0 if not 0 then it is true
                    List<String> histStep = historicalValidStepId.split(AppConstants.DELIM_HISTORICAL_STEP);
                    for (Integer i = 0; i <= histStep.size() - 1; i++) {
                        if (histStep[i] == stepIdTXT) {
                            if (Integer.valueOf(histStep[i + 1]) == 0) {
                                isPageAlreadyValidStep = false;
                                break;
                            } else {
                                isPageAlreadyValidStep = true;
                                break;
                            }
                        }
                    }
                } else
                    isPageAlreadyValidStep = false;
        } catch (Exception e) { return; }
        return;
    }

    public PageReference initialiseAction() {

        return authenticatedSessionLog();
        //return null;
    }

    protected virtual Boolean loadStepSubmissionState() {
        try {
            submissionMgr = new SubmissionManager(submissionId); // default state loading invoked unless overridden by the step controller class.
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    /**
    * This method contains code duplicate in order to prove the authenticatedSession() method which validate the session
    * If the result is not null then this mean either the cookie got deleted or expired or the time saved within the cookie
    * is bigger than 12 minutes. All those informations will be reflect within the log.
    */
    protected PageReference authenticatedSessionLog()
    {
        PageReference resultSession = authenticatedSession();

        String log = null;

        if(resultSession != null)
        {
            Boolean containsCookie = ApexPages.currentPage().getCookies().containsKey(SecurityManager.DEFAULT_SF_CHS_COOKIE_NAME);

            Long milliseconds = 0;
            Long minutes = 0;
            Long timeSavedMilli = 0;
            Long timeNow = Datetime.now().getTime();
            String emailSaved = null;

            if(containsCookie)
            {
                //Get the cookie
                Cookie sessionValidity = ApexPages.currentPage().getCookies().get(SecurityManager.DEFAULT_SF_CHS_COOKIE_NAME);

                //Decrypt the value
                String result = SecurityManager.decryptText(sessionValidity.getValue());

                //Split the result
                String[] valueDecrypt = result.split(AppConstants.ID_DELIM_SPLIT_CHAR);

                emailSaved = valueDecrypt[0];

                timeSavedMilli = Long.valueOf(valueDecrypt[1]);
                milliseconds = timeNow - timeSavedMilli;
                Long seconds = milliseconds / 1000;
                minutes = seconds / 60;
            }
            
            log = '<br/>-----------------------------------------------------------------------------------';
            log += '<br/> Session Expiry Transaction Details: ';
            log += '<br/> Log Time Date Time: ' + System.now();
            log += '<br/> Transaction Id: ' + submissionId;
            log += '<br/> Company Number: ' + submissionMgr.submission.CompanyNumber__c;
            log += '<br/>-----------------------------------------------------------------------------------';
            log += '<br/> Session Expiry Cookie Details: ';
            log += '<br/> Cookie System Existence: ' + containsCookie;
            log += '<br/> Time Millisecond Saved: ' + timeSavedMilli;
            log += '<br/> Time Millisecond Now: ' + timeNow;
            log += '<br/> Time Difference Millisecond: ' + milliseconds;
            log += '<br/> Time Difference Minutes: ' + minutes;
            log += '<br/> Presenter Email Saved: ' + emailSaved;
            log += '<br/> Presenter Email Now: ' + submissionMgr.submission.ContactEmail__c;
            log += '<br/> Step Triggering the expired session: ' + transactionMgr.currentStep.Id + ' Number: ' +transactionMgr.currentStep.Step_Number__c;
            log += '<br/>-----------------------------------------------------------------------------------';
        }

        if(!String.isBlank(log))
        {
            if(String.isBlank(submissionMgr.submission.AmendmentHistory__c))
                submissionMgr.submission.AmendmentHistory__c = log;
            else
                submissionMgr.submission.AmendmentHistory__c += log;

            update submissionMgr.submission;
        }

        return resultSession;
    }

    protected PageReference authenticatedSession(){
        //If Auth sec submissionMgr.submission.ContactEmail__c
        if(submissionMgr != null)
            if(submissionMgr.submission != null)
                return SecurityManager.checkSessionValidityCookie(submissionMgr.submission.ContactEmail__c);
        return null;
    }

    protected Boolean validatePageState() {
        initialise();
        return ( isPageAuthenticated && isPageInitialised );
    }

    // Navigation methods.
    public PageReference nextStep() {
        return transactionMgr == null ? null : transactionMgr.nextStep(submissionId);
    }

    public PageReference previousStep() {


        //The framework has been decomissioned to now redirect to the company details page once you click the link start again
        if((submissionMgr.submission.isDigitalSignatureNeeded__c && !submissionMgr.submission.isSigningFinished__c) || (!submissionMgr.submission.Form_Name__c.contains('DS01'))) 
        {
            if(submissionMgr.submission.Id != null)
            {   
                //update the transaction first
                submissionMgr.submission.Status__c = 'deleteContact';
                //Save the transaction type
                String transactionType = submissionMgr.submission.Transaction_Type__c;
                Id presenterID = submissionMgr.submission.Presenter__c;
                String presenterEmail = submissionMgr.submission.ContactEmail__c;
                Account companyId = submissionMgr.submission.Company__r;
                update submissionMgr.submission;
                delete submissionMgr.submission;
                TransactionManager tr = new TransactionManager(transactionType);
                Id submissionId = submissionMgr.initialise(transactionType, presenterID, presenterEmail, companyId, tr.td);
                return tr == null ? null : tr.firstStep(submissionId);

            }
        }
		return transactionMgr==null ? null : transactionMgr.previousStep(submissionId);
	}
	// End navigation methods.    
}