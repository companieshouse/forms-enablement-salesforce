/*
Name:  Review.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Transaction Review Page
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-05-19  Initial development.
*/
public class ReviewController extends TransactionStepControllerBase {
    public Boolean hasPageErrors {
        get;
        set;
    }
    public String currentErrorMessage {
        get;
        set;
    }
    public String displayText1 {
        get;
        set;
    }
    public Integer total {
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
    public String headerText1 {
        get;
        set;
    }
    public String directorName {
        get;
        set;
    }
    public String companyName {
        get;
        set;
    }
    public String companyNumber {
        get;
        set;
    }
    public String presenterEmail {
        get;
        set;
    }
    public String presenterName {
        get;
        set;
    }
    public String presenterPhone {
        get;
        set;
    }
    public List < Officer__c > companyDirectors {
        get;
        set;
    }
    public List < Shares__c > preParticulars {
        get;
        set;
    }
    public String companyAddress {
        get;
        set;
    }
    public String companyAddress1 {
        get;
        set;
    }
    public String companyAddress2 {
        get;
        set;
    }
    public String companyregion {
        get;
        set;
    }
    public String companypostcode {
        get;
        set;
    }
    public String companyCountry {
        get;
        set;
    }
    public String companyLocality {
        get;
        set;
    }
    public Boolean showprevious {
        get;
        set;
    }
    public String continueButtonText {
        get;
        set;
    }
    public Boolean custompanelView {
        get;
        set;
    }
    public Boolean standardPanelView {
        get;
        set;
    }
    public Map < String, Shares__c > shareCurrencyMap {
        get;
        set;
    }
    public Map < String, Shares__c > shareClassMap {
        get;
        set;
    }
    public Map < Id, List < Shares__c >> viewlist {
        get;
        set;
    }
    public List < Attachment > reviewAttachments {
        get;
        set;
    }
    public Map < Integer, List < Shares__c >> viewmap {
        get;
        set;
    }
    public List < Shares__c > matchedShares {
        get;
        set;
    }
    public List < Shares__c > matchedShares2 {
        get;
        set;
    }
    public Map < Integer, String > viewkeys {
        get;
        set;
    }
    public Map < Integer, String > viewkeys2 {
        get;
        set;
    }
    public Map < Integer, List < Shares__c >> viewmap2 {
        get;
        set;
    }
    public List < Shares__c > sharesforBuilding {
        get;
        set;
    }
    public List < Shares__c > sharesforEditing {
        get;
        set;
    }
    public List < Shares__c > sharesforCancelling {
        get;
        set;
    }
    public List < Shares__c > variations {
        get;
        set;
    }
    public Boolean showStatementofCapital {
        get;
        set;
    }
    public Boolean showParticulars {
        get;
        set;
    }
    public Boolean showCancelledShares {
        get;
        set;
    }
    public String labelText {
        get;
        set;
    }
    public String reviewTitle {
        get;
        set;
    }
    public String dateQuestionText {
        get;
        set;
    }
    public String variationText {
        get;
        set;
    }
    public Boolean showCurrency {
        get;
        set;
    }
    public String rewviewTitle {
        get;
        set;
    }
    public String dateText {
        get;
        set;
    }
    public Date dateField {
        get;
        set;
    }
    public Boolean variationNotice {
        get;
        set;
    }
    public Boolean showreConversion {
        get;
        set;
    }
    public Boolean showRedemption {
        get;
        set;
    }
    public Boolean showConsolidation {
        get;
        set;
    }
    public Boolean showSubdivision {
        get;
        set;
    }
    public List < Shares__c > rECONVERSION {
        get;
        set;
    }
    public List < Shares__c > rEDEMPTION {
        get;
        set;
    }
    public List < Shares__c > cONSOLIDATION {
        get;
        set;
    }
    public List < Shares__c > sUBDIVISION {
        get;
        set;
    }
    public List < Shares__c > sh08Family {
        get;
        set;
    }
    public List < Shares__c > promoters {
        get;
        set;
    }
    public String sh08HelperText {
        get;
        set;
    }
    public Boolean showSh08 {
        get;
        set;
    }
    public Boolean shownewstructure {
        get;
        set;
    }
    public Boolean showValueField {
        get;
        set;
    }
    public String subdivisiontableHelperText {
        get;
        set;
    }
    public String consolidationtableHelperText {
        get;
        set;
    }
    public String redemptiontableHelperText {
        get;
        set;
    }
    public String reconversiontableHelperText {
        get;
        set;
    }
    public Boolean showPromoters {
        get;
        set;
    }
    public String previousButtonText {
        get;
        set;
    }
    public Boolean confirmationVal {
        get;
        set;
    }
    public String showError {
        get;
        set;
    }
    public String headerText2 {
        get;
        set;
    }
    public Boolean confiramtion {
        get;
        set;
    }
    public Boolean showAttachments {
        get;
        set;
    }
    public Id shareID {
        get;
        set;
    }
    public String officerTerm {
        get;
        set;
    }
    public List<Shares__c> dummyShares {get; set;}
    public ReviewController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void initialiseStep() {
        displayText1 = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c;
        headerText2 = transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c;
        standardPanelView = transactionMgr.currentstep.StandardView__c;
        custompanelView = transactionMgr.currentstep.CustomView__c;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.PersonEmail;
        presenterName = submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        previousButtonText = transactionMgr.currentStep.PreviousButtonText__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        shareCurrencyMap = new map < String, Shares__c > ();
        viewmap = new Map < Integer, List < Shares__c >> ();
        matchedShares = new List < Shares__c > ();
        viewkeys = new Map < Integer, String > ();
        shareClassMap = new map < String, Shares__c > ();
        viewmap2 = new Map < Integer, List < Shares__c >> ();
        matchedShares2 = new List < Shares__c > ();
        viewkeys2 = new Map < Integer, String > ();
        officerTerm = (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c);
        companyAddress1 = submissionMgr.submission.CompanyAddress1__c;
        companyAddress2 = submissionMgr.submission.CompanyAddress2__c;
        companyregion = submissionMgr.submission.CompanyRegion__c;
        companypostcode = submissionMgr.submission.CompanyPostCode__c;
        companyCountry = submissionMgr.submission.CompanyCountry__c;
        companyLocality = submissionMgr.submission.CompanyLocality__c;
        companyAddress = (companyAddress1 == null ? '' : companyAddress1 + '<br/>') + (companyAddress2 == null ? '' : companyAddress2 + '<br/>') + (companyregion == null ? '' : companyregion + '<br/>') + (companyLocality == null ? '' : companyLocality + '<br/>') + (companypostcode == null ? '' : companypostcode + '<br/>') + (companyCountry == null ? '' : companyCountry);
        showprevious = true;
        dateField = submissionMgr.submission.ApplicationDate__c;
        sharesforBuilding = new List < Shares__c > ();
        sharesforEditing = new List < Shares__c > ();
        sharesforCancelling = new List < Shares__c > ();
        preParticulars = new List < Shares__c > ();
        variations = new List < Shares__c > ();
        rECONVERSION = new List < Shares__c > ();
        rEDEMPTION = new List < Shares__c > ();
        cONSOLIDATION = new List < Shares__c > ();
        sUBDIVISION = new List < Shares__c > ();
        sh08Family = new List < Shares__c > ();
        promoters = new List < Shares__c > ();
        showCurrency = true;
        if (submissionMgr.submission.Officers__r.size() > 1) {
            showprevious = true;
        }
        dummyShares = submissionMgr.submission.Shares__r;
        buildVal();
        shareRouter();
        return;
    }
    public void buildAttachments() {}
    public void confirmReviewPage() {}
    public void buildVal() {
        if (submissionMgr.submission.Form_Name__c == 'DS01') {
            confirmationVal = true;
        } else {
            confirmationVal = false;
        }
    }
    public void buildLABELS() {
        if (submissionMgr.submission.Form_Name__c.contains('SH10')) {
            labelText = 'Notice of particulars of variation of rights attached to shares';
            dateQuestionText = 'Date of variation of rights';
            variationText = 'Details of variation of rights';
            variationNotice = true;
        } else if (submissionMgr.submission.Form_Name__c.contains('SH11')) {
            labelText = 'Notice of new class of members';
            dateQuestionText = 'Date of creation of new class of members';
            variationText = 'Rights attached to class of members';
            variationNotice = true;
        } else if (submissionMgr.submission.Form_Name__c.contains('SH12')) {
            labelText = 'Notice of particulars of variation of class rights';
            dateQuestionText = 'Date of variation of class rights';
            variationText = 'Variation in the rights of the class of members';
            variationNotice = true;
        }
    }
    public void shareRouter() {
        for (Shares__c totalShares : submissionMgr.submission.Shares__r) {
            if (totalShares.SHARETYPE__c == 'STATEMENTOFCAPITAL') {
                sharesforBuilding.add(totalShares);
            } else if (totalShares.SHARETYPE__c == 'CANCELLEDSHARES') {
                sharesforCancelling.add(totalShares);
            } else if (totalShares.SHARETYPE__c == 'PARTICULARS') {
                preParticulars.add(totalShares);
            } else if (totalShares.SHARETYPE__c == 'VARIATIONS') {
                variations.add(totalShares);
            } else if (totalShares.SHARETYPE__c == 'RECONVERSION') {
                rECONVERSION.add(totalShares);
            } else if (totalShares.SHARETYPE__c == 'REDEMPTION') {
                rEDEMPTION.add(totalShares);
            } else if (totalShares.SHARETYPE__c == 'CONSOLIDATION') {
                cONSOLIDATION.add(totalShares);
            } else if (totalShares.SHARETYPE__c == 'SUBDIVISION') {
                sUBDIVISION.add(totalShares);
            } else if (totalShares.SHARETYPE__c == 'SH08') {
                sh08Family.add(totalShares);
                //this should never happen as we have shares with no type
            } else if (totalShares.SHARETYPE__c == 'PROMOTER') {
                promoters.add(totalShares);
                //this should never happen as we have shares with no type
            } else if (totalShares.SHARETYPE__c == 'TRANSFERRED') {
                sharesforCancelling.add(totalShares);
                //this should never happen as we have shares with no type
            }
        }
        if (sharesforBuilding.size() > 0) {
            buildInverseCapitalMap();
            totalAmountUnpaid();
            showStatementofCapital = true;
        }
        if (preParticulars.size() > 0) {

            //showParticulars = true;
            //showCurrency = false;
        }
        if (promoters.size() > 0) {
            //showCurrency = false;
            showPromoters = true;
        }
        if (sharesforCancelling.size() > 0 && sharesforCancelling[0].SHARETYPE__c == 'CANCELLEDSHARES') {
            showCancelledShares = true;
            dateText = 'Cancellation Date';
            reviewTitle = 'Shares to cancel';
        }
        if (sharesforCancelling.size() > 0 && sharesforCancelling[0].SHARETYPE__c == 'TRANSFERRED') {
            showCancelledShares = true;
            dateText = 'Date(s) shares were sold or transferred';
            reviewTitle = 'Number of shares sold or transferred';
        }
        if (sharesforEditing.size() > 0) {
            showCancelledShares = true;
            dateText = 'Date(s) shares were sold or transferred';
            reviewTitle = 'Treasury shares sold or transferred';
        }
        if (sUBDIVISION.size() > 0) {
            showSubdivision = true;
            subdivisiontableHelperText = 'Sub-division';
            shownewstructure = true;
        }
        if (sh08Family.size() > 0) {
            showSh08 = true;
            sh08HelperText = 'Class(es) of shares';
        }
        if (cONSOLIDATION.size() > 0) {
            showConsolidation = true;
            consolidationtableHelperText = 'Consolidation';
            shownewstructure = true;
        }
        if (rECONVERSION.size() > 0) {
            showreConversion = true;
            reconversiontableHelperText = 'Reconversion';
            showValueField = true;
        }
        if (rEDEMPTION.size() > 0) {
            showRedemption = true;
            redemptiontableHelperText = 'Redemption';
        }
        if (variations.size() > 0) {
            buildLABELS();
        }
        //lastly build attachments
        if (submissionMgr.submission.Attachments.size() > 0) {
            if (submissionMgr.submission.Attachments[0].Name != submissionMgr.submission.Form_Name__c) {
                reviewAttachments = submissionMgr.submission.Attachments;
                showAttachments = true;
            }
        } else if (submissionMgr.submission.Attachments.size() == 0 || submissionMgr.submission.Attachments[0].Name == submissionMgr.submission.Form_Name__c) {
            showAttachments = false;
        }
        // change company name
        if (displayText1.contains('COMPANYNAME')) {
            displayText1 = displayText1.replace('COMPANYNAME', companyName);
        }
    }

    public void totalAmountUnpaid() {
        if (sharesforBuilding.size() > 0) {
            for (Shares__c sharecurrencylimiter : sharesforBuilding) {
                shareCurrencyMap.put(sharecurrencylimiter.Currency__c, sharecurrencylimiter);
            }
            List < String > listKeys = new List < String > (shareCurrencyMap.keyset());
            for (Integer i = 0; i < listKeys.size(); i++) {
                matchedShares2 = new List < Shares__c > ();
                for (Shares__c buildShares : sharesforBuilding) {
                    if (buildShares.Currency__c == listKeys.get(i)) {
                        matchedShares2.add(buildShares);
                        viewmap2.put(i, matchedShares2);
                        viewkeys2.put(i, buildShares.Currency__c);
                    }
                }
            }
        } else {
            System.debug('you have no statement of capital to iterate over');
        }
    }

    public void buildInverseCapitalMap() {
        if (sharesforBuilding.size() > 0) {
            for (Shares__c shareclasslimiter : sharesforBuilding) {
                shareClassMap.put(shareclasslimiter.Class_of_Shares__c, shareclasslimiter);
            }
            List < String > listKeys2 = new List < String > (shareClassMap.keyset());
            for (Integer i = 0; i < listKeys2.size(); i++) {
                matchedShares = new List < Shares__c > ();
                for (Shares__c buildShares : sharesforBuilding) {
                    if (buildShares.Class_of_Shares__c == listKeys2.get(i)) {
                        matchedShares.add(buildShares);
                        viewmap.put(i, matchedShares);
                        viewkeys.put(i, buildShares.Class_of_Shares__c);
                    }
                }
            }
        } else {
            System.debug('you have no statement of capital to iterate over');
        }
    }
    private void persistStep() {
        submissionMgr.submission.finishedAddingShares__c = false;

        submissionMgr.persist();
    }
    public PageReference deleteShare() {

        if (shareID != null) {
            persistStep();

            try {
                List < Shares__c > deletedrecord = [SELECT Id, Name, Currency__c From Shares__c where ID = : shareID];
                //throw new Form_CustomException('record you are deleting is' + deletedrecord);
                delete deletedrecord[0];
            } catch (DmlException e) {
                System.debug('DML Error with ' + e.getMessage());
            } catch (Exception e) {
                System.debug('DML Error with ' + e.getMessage());
            }

            PageReference pg = new PageReference('/SCapital1');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }
        return null;
    }
    private void attachmentpersistStep() {
        submissionMgr.submission.finishedAddingShares__c = false;
        //FIELD COMMENTED CAUSE NOT IN OBJECT
        //submissionMgr.submission.finishedAttachments__c = true;

        submissionMgr.persist();
    }
    public PageReference changeAttachments() {
        if (!validatePageState()) return Page.TransactionException;
        attachmentpersistStep();

        return previousStep();
    }
    public PageReference nextAction() {
        if (!confirmationVal) {
            showError = 'error';
            hasPageErrors = true;
            currentErrorMessage = 'You must confirm to continue';
            return null;
        }
        if (!validatePageState()) return Page.TransactionException;
        persistStep();

        return nextStep();
    }
    public PageReference previousAction() {
        if (!validatePageState()) return Page.TransactionException;
        return previousStep();
    }
}