/*
Name:  DigitalSignatureController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------
Controller class for the Visualforce Page: DigitalSignature
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-07-04  Initial development.
*/
public with sharing class DigitalSignatureController extends TransactionStepControllerBase {

    public Boolean pendingPage {get; set;}
    public String compName {get; set;}
    public List<wrapperDirector> listOfDirectors {get; set;}
    public String emailPresenter {get; set;}
    public Boolean successSigning {get; set;}
    public Boolean failureSigning {get; set;}
    public Boolean skipPage {get; set;}
    public Boolean presenterSigning {get; set;}
    public Boolean pollServer {get; set;}
    public Integer waittime {get; set;}
    public Boolean failureEmail {get; set;}
    public Boolean singlePresentorSigningDirector{get; set;}
    public String pageTitleSinglePresentorSigningDirector {get; set;}
    public String pageBodySinglePresentorSigningDirector {get; set;}

    public Boolean singleDirectorNotPresentorWaitingSigning {get; set;}
    public String pageTitleSingleNotPresentorSigningDirector {get; set;}
    public String pageBodySingleNotPresentorSigningDirector {get; set;}

    public Boolean multipleDirectorWaitingSigning {get; set;}
    public String pageTitlemultipleDirectorWaitingSigning {get; set;}
    public String pageBodymultipleDirectorWaitingSigning {get; set;}

    public String pageTitleFailureEmail {get; set;}
    public String pageBodyFailureEmail {get; set;}
    public String pageTitleFailureSigning {get; set;}
    public String pageBodyFailureSigning {get; set;}

    public DigitalSignatureController() {
        super();

        initialiseStep();
    }

    public void initialiseStep() {
        pendingPage = false;
        waittime = 0;
        successSigning = false;
        failureSigning = false;
        failureEmail = false;
        pollServer =true;
        skipPage = false;
        presenterSigning = false;
        compName = submissionMgr.submission.CompanyName__c;
        Integer i = 0;
        listOfDirectors = new List<wrapperDirector>();
        String offName = '';
        for (Contact off : submissionMgr.submission.Contacts__r) {
            if (off.isSignatory__c && !off.IsPresenter__c) {
                i++;
                listOfDirectors.add(new wrapperDirector(off.Name, off.Email, off.RecipientStatus__c));
            }
            if (off.IsPresenter__c) {
                presenterSigning = true;
            }
        }

        if(submissionMgr.submission.Contacts__r.size() == 2)
        {
            if(submissionMgr.submission.Contacts__r[0].IsPresenter__c)
            {
                offName = submissionMgr.submission.Contacts__r[1].Name;
            }
            else{
                offName = submissionMgr.submission.Contacts__r[0].Name;
            }
        }

        multipleDirectorWaitingSigning = false;
        singleDirectorNotPresentorWaitingSigning = false;
        singlePresentorSigningDirector = false;

        //Cover each screen case
        //There are more than 1 directors
        if(submissionMgr.submission.Contacts__r.size() > 1)
        {
            //2 or more director without presenter => multiple screen
            if(!presenterSigning)
            {
                multipleDirectorWaitingSigning = true;
            }
            else{
                //If there are 2 directors we go on single not presenter
                if(submissionMgr.submission.Contacts__r.size() == 2)
                {
                    singleDirectorNotPresentorWaitingSigning = true;
                }
                else if(submissionMgr.submission.Contacts__r.size() == 3 && submissionMgr.submission.isPresenterMultipleDirectors__c)
                {
                    Integer indexCounter = 0;

                    for(Officer__c ct :submissionMgr.submission.Officers__r)
                    {
                        if(ct.isSignatory__c && !ct.IsPresenter__c)
                        {
                            indexCounter++;
                            offName = ct.Name;
                        }
                    }

                    if(indexCounter == 1)
                    {
                        singleDirectorNotPresentorWaitingSigning = true;
                    }
                    else{
                        multipleDirectorWaitingSigning = true;
                    }

                }
                else{
                    multipleDirectorWaitingSigning = true;
                }
            }
            
        }        
        else{
            offName = submissionMgr.submission.Contacts__r[0].Name;
            if(presenterSigning)
            {
                singlePresentorSigningDirector = true;
            }
            else{
                singleDirectorNotPresentorWaitingSigning = true;
            }
        }
        //Load the text

        //Title to separate
        String headerText3 = (transactionMgr.currentStep.Header_Text_3__c == null ? '' : transactionMgr.currentStep.Header_Text_3__c);
        String[] splitedHeaderText3 = headerText3.split('SEPARATOR');

        pageTitleFailureSigning = (String.isBlank(splitedHeaderText3[0]) ? '' : splitedHeaderText3[0]);
        pageTitleFailureSigning = pageTitleFailureSigning.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c.capitalize()));
        pageTitleFailureEmail = (splitedHeaderText3.size() > 1 ? splitedHeaderText3[1] : '');
        pageTitleSinglePresentorSigningDirector = (splitedHeaderText3.size() > 2 ? splitedHeaderText3[2] : '');
        pageBodySinglePresentorSigningDirector = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;

        pageTitleSingleNotPresentorSigningDirector = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        pageBodySingleNotPresentorSigningDirector = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        pageTitleSingleNotPresentorSigningDirector = pageTitleSingleNotPresentorSigningDirector.replace('NAME', offName);
        pageBodySingleNotPresentorSigningDirector = pageBodySingleNotPresentorSigningDirector.replace('NAME', offName);

        pageTitlemultipleDirectorWaitingSigning = (transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c);
        pageBodymultipleDirectorWaitingSigning = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;

        pageBodyFailureEmail = transactionMgr.currentStep.Display_Text_4__c == null ? '' : transactionMgr.currentStep.Display_Text_4__c;
        pageBodyFailureSigning = transactionMgr.currentStep.Display_Text_5__c == null ? '' : transactionMgr.currentStep.Display_Text_5__c;
        emailPresenter = submissionMgr.submission.Presenter__r.PersonEmail;

    }

    public PageReference resetTransaction(){
        //The framework has been decomissioned to now redirect to the company details page once you click the link start again

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

            return null;
    }

    public PageReference initSignature() {
        PageReference res = initialiseAction();

        if(res != null)
            return res;

        if (!ApexPages.currentPage().getParameters().containsKey('c') ||
                String.isBlank(ApexPages.currentPage().getParameters().get('c'))) return null;

        String paramInput = ApexPages.currentPage().getParameters().get('c');

        if (paramInput.contains(' ')) {
            paramInput = paramInput.replace(' ', '+');

            ApexPages.currentPage().getParameters().put('c', paramInput);

            ApexPages.currentPage().setRedirect(true);

            return ApexPages.currentPage();
        }

        if (!submissionMgr.submission.isDigitalSignatureNeeded__c ) {
            skipPage = true;
            return nextAction();
        }

        if(submissionMgr.submission.Status__c == 'Contact email Error')
        {
            //Get the contact in the list and display the list of error
            listOfDirectors.clear();

            for (Contact off : submissionMgr.submission.Contacts__r) {
                if(off.RecipientStatus__c == 'AutoResponded')
                {
                    listOfDirectors.add(new wrapperDirector(off.Name, off.Email, off.RecipientStatus__c));
                }
            }

            pollServer = false;
            failureEmail = true;
            return null;
        }


        if (submissionMgr.submission.isSigningStarted__c || !presenterSigning) {
            //Determine if it has been declined or not
            if (submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_SIGNED) {
                pollServer = false;
                successSigning = true;

                //Change to skip success screen after polling
                return nextAction();
            } else if (submissionMgr.submission.Status__c == AppConstants.DOCUSIGN_STATUS_REJECTED) {
                pollServer = false;
                failureSigning = true;
                return null;
            }



            //Send to docusign as no presenter don t load the external embed page
            if (!submissionMgr.submission.isSigningStarted__c) {
                if(!Test.isRunningTest())
                    ExternalEmbedDocuSignController.docusignSignature(submissionMgr, transactionMgr);
                persistStep();
            }
            pendingPage = true;

            return null;
        }

        return nextAction();

    }

    public PageReference pollMethods(){
        List<Contact> lCont = [Select Id,DateSigned__c,RecipientStatus__c,Email, isPresenter__c  From Contact Where Transaction__c = :submissionMgr.submission.Id];

        Boolean hasSigned = false;
        Boolean hasWrongEmail = false;

        for(Contact off :lCont)
        {
            if(off.isPresenter__c)
            {
                if(off.DateSigned__c != null){
                    hasSigned = true;
                }
            }
            if(off.RecipientStatus__c == 'AutoResponded')
            {
                hasWrongEmail = true;
            }
        }

        if(hasWrongEmail)
        {
            submissionMgr.submission.Status__c = 'Contact email Error';
            update submissionMgr.submission;

            PageReference pg = new PageReference('/DigitalSignature');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }

        if(presenterSigning)
            if(hasSigned)
            {
                if(lCont.size() == 1)
                {
                    submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_SIGNED;
                    update submissionMgr.submission;

                    PageReference pg = new PageReference('/DigitalSignature');
                    pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
                    pg.setRedirect(true);
                    return pg;

                }
                else{
                    if(submissionMgr.submission.Status__c == AppConstants.DOCUSIGN_STATUS_REJECTED) {
                        PageReference pg = new PageReference('/DigitalSignature');
                        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
                        pg.setRedirect(true);
                        return pg;
                    }
                    else if(submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_SIGNED)
                    {
                        PageReference pg = new PageReference('/DigitalSignature');
                        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
                        pg.setRedirect(true);
                        return pg;
                    }

                    pendingPage = true;
                    pollServer = false;

                }
            }
            else
            {
                if(lCont.size() == 1)
                {
                    if(submissionMgr.submission.Status__c == AppConstants.DOCUSIGN_STATUS_REJECTED) {
                        PageReference pg = new PageReference('/DigitalSignature');
                        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
                        pg.setRedirect(true);
                        return pg;
                    }

                    waittime++;
                    pollServer = true;
                }
                else{
                    waittime++;
                    pollServer = true;
                }
            }

        if(waittime == 8)
        {
            if(presenterSigning)
                if(lCont.size() == 1)
                {
                    if(submissionMgr.submission.Status__c == AppConstants.DOCUSIGN_STATUS_REJECTED) {
                        PageReference pg = new PageReference('/DigitalSignature');
                        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
                        pg.setRedirect(true);
                        return pg;
                    }
                    else if(submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_SIGNED)
                    {
                        PageReference pg = new PageReference('/DigitalSignature');
                        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
                        pg.setRedirect(true);
                        return pg;
                    }

                    pollServer = false;
                    return this.restartPresenterSigning();
                }
                else{
                    if(submissionMgr.submission.Status__c == AppConstants.DOCUSIGN_STATUS_REJECTED) {
                        PageReference pg = new PageReference('/DigitalSignature');
                        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
                        pg.setRedirect(true);
                        return pg;
                    }
                    pollServer = false;
                    return this.restartPresenterSigning();

                }
            if(!presenterSigning)
            {
                if(hasWrongEmail)
                {
                    submissionMgr.submission.Status__c = 'Contact email Error';
                    update submissionMgr.submission;

                    PageReference pg = new PageReference('/DigitalSignature');
                    pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
                    pg.setRedirect(true);
                    return pg;
                }
                pollServer = false;
                return null;
            }
        }
        else{
            if(!presenterSigning)
                waittime++;
        }
        return null;

    }

    public PageReference restartPresenterSigning() {
        if (submissionMgr.submission.isSigningStarted__c && presenterSigning && submissionMgr.submission.Status__c != AppConstants.REQUEST_STATUS_SIGNED) {
            PageReference pg = new PageReference('/ExternalEmbedDocuSign');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);

            return pg;
        }

        return null;
    }

    private void persistStep() {

        if (!pendingPage && !successSigning && !failureSigning && !skipPage) {
            submissionMgr.submission.isSigningStarted__c = true;
            submissionMgr.submission.Status__c = AppConstants.REQUEST_STATUS_PENDING_SIGNATURES;
            if (!presenterSigning) {
                submissionMgr.submission.MultipleDirectors__c = true;
            }
        }

        if (successSigning || failureSigning) {
            submissionMgr.submission.isSigningFinished__c = true;
        }

        if (submissionMgr.submission.Contacts__r.size() > 1) {
            submissionMgr.submission.MultipleDirectors__c = true;
        }

        submissionMgr.persist();
    }
    // End Instance methods.

    // Action methods.
    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;

        persistStep();

        if (!pendingPage && !successSigning && !failureSigning && !skipPage && presenterSigning) {
            PageReference pg = new PageReference('/ExternalEmbedDocuSign');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);

            return pg;
        }

        return nextStep();

    }

    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }

    public with sharing class wrapperDirector {
        public String name {get; set;}
        public String email {get; set;}
        public String status {get; set;}

        public wrapperDirector(String name, String email, String status) {
            this.name = name;
            this.email = email;
            this.status = status;
        }
    }

    public PageReference signoutAction(){

        //Build the signout page
        PageReference pg = new PageReference('/SignOut');
        pg.setRedirect(true);
        return pg;
    }    
    // End Action methods.
}