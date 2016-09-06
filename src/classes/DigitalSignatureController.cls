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
public class DigitalSignatureController extends TransactionStepControllerBase {

    public Boolean pendingPage {get; set;}
    public String compName {get; set;}
    public List<wrapperDirector> listOfDirectors {get; set;}
    public String emailPresenter {get; set;}
    public Boolean successSigning {get; set;}
    public Boolean failureSigning {get; set;}
    public Boolean skipPage {get; set;}
    public Boolean presenterSigning {get; set;}
    public Boolean multipleDirectors {get; set;}
    public String pageTitle {get; set;}
    public String pageTitle2 {get; set;}
    public String pageTitle3 {get; set;}
    public String pageTitle4 {get; set;}
    public String pageBody {get; set;}
    public String pageBody2 {get; set;}
    public String pageBodyFailure {get; set;}
    public String pageBodyFailureContact {get; set;}
    public Boolean pollServer {get; set;}
    public Integer waittime {get; set;}
    public Boolean failureEmail {get; set;}

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
        multipleDirectors = false;
        compName = submissionMgr.submission.CompanyName__c;
        Integer i = 0;
        listOfDirectors = new List<wrapperDirector>();

        for (Contact off : submissionMgr.submission.Contacts__r) {
            if (off.isSignatory__c) {
                i++;
                listOfDirectors.add(new wrapperDirector(off.Name, off.Email));
            }
            if (off.IsPresenter__c) {
                presenterSigning = true;
            }
        }
        
        if ((listOfDirectors.size() >= 1 && !presenterSigning) || listOfDirectors.size() > 1) {
            multipleDirectors = true;
        }
        
        pageTitle = (transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c);
        pageTitle2 = (transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c);
        pageTitle3 = (transactionMgr.currentStep.Header_Text_3__c == null ? '' : transactionMgr.currentStep.Header_Text_3__c);
        pageTitle4 = (transactionMgr.currentStep.Header_Text_4__c == null ? '' : transactionMgr.currentStep.Header_Text_4__c);
        
        if (presenterSigning == true) {
            if (listOfDirectors.size() > 1) {
                pageBody = transactionMgr.currentStep.Display_Text_5__c == null ? '' : transactionMgr.currentStep.Display_Text_5__c;
            } else {
                pageBody = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
            }
        } else {
            pageBody = '';
        }
        
        pageBody = pageBody.replace('COMPANYNAME', compName);
        pageBody2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        pageBody2 += transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;
        pageBody2 = pageBody2.replace('COMPANYNAME', compName);
        pageBodyFailure = transactionMgr.currentStep.Display_Text_6__c == null ? '' : transactionMgr.currentStep.Display_Text_6__c;
        pageBodyFailureContact = transactionMgr.currentStep.Display_Text_4__c == null ? '' : transactionMgr.currentStep.Display_Text_4__c;

        pageTitle3 = pageTitle3.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c.capitalize()));

        pageBody = pageBody.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        pageBody2 = pageBody2.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));

        pageBodyFailure = pageBodyFailure.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        pageBodyFailureContact = pageBodyFailureContact.replace('directors', (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c));
        

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
                    listOfDirectors.add(new wrapperDirector(off.Name, off.Email));
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
                return null;
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

        if (listOfDirectors.size() > 1) {
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

        public wrapperDirector(String name, String email) {
            this.name = name;
            this.email = email;
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