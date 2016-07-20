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
    public List<String> listOfDirectors {get; set;}
    public String emailPresenter {get; set;}
    public Boolean successSigning {get; set;}
    public Boolean failureSigning {get; set;}
    public Boolean skipPage {get; set;}
    public Boolean presenterSigning {get; set;}
    public Boolean multipleDirectors {get; set;}

    public DigitalSignatureController() {
        super();

        initialiseStep();
    }

    public void initialiseStep() {
        pendingPage = false;
        successSigning = false;
        failureSigning = false;
        skipPage = false;
        presenterSigning = false;
        multipleDirectors = false;
        compName = submissionMgr.submission.CompanyName__c;
        //throw new Form_CustomException('compName is   _____' + compName);

        Integer i = 0;
        listOfDirectors = new List<String>();
        for (Officer__c off : submissionMgr.submission.Officers__r) {
            if (off.isSignatory__c) {
                i++;
                listOfDirectors.add(off.Name);
            }
            if (off.IsPresenter__c) {
                presenterSigning = true;
            }
        }

        if (i > 1  || (i == 1 && !presenterSigning)) {
            multipleDirectors = true;
        }

        emailPresenter = submissionMgr.submission.Presenter__r.Name;
    }

    public PageReference initSignature() {
        initialiseAction();

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

        if (submissionMgr.submission.isSigningStarted__c || !presenterSigning) {
            //Determine if it has been declined or not
            if (submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_SIGNED && !multipleDirectors) {
                successSigning = true;
                return null;
            } else if (submissionMgr.submission.Status__c == AppConstants.DOCUSIGN_STATUS_REJECTED && !multipleDirectors) {
                failureSigning = true;
                return null;
            }

            //Send to docusign as no presenter don t load the external embed page
            if (!submissionMgr.submission.isSigningStarted__c) {
                ExternalEmbedDocuSignController.docusignSignature(submissionMgr, transactionMgr);
                persistStep();
            }
            pendingPage = true;

            return null;
        }



        return nextAction();

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
    // End Action methods.
}