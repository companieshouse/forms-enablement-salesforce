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
    // dynamic set data
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
    public String reviewpagebutton {
        get;
        set;
    }
    public Boolean custompanelView {
        get;
        set;
    }
    public String customPanelHTML {
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
    public List < Shares__c > shareReviewer {
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
    public Map < Integer, String > viewkeys {
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
    public Set < String > requiresStatementofC {
        get;
        set;
    }
    public Set < String > requiresParticulars {
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
    public ReviewController() {
        super();
        if (isPageInitialised) initialiseStep();
    }
    public void initialiseStep() {
        shareReviewer = new List < Shares__c > ();
        displayText1 = transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c;
        standardPanelView = transactionMgr.currentstep.StandardView__c;
        custompanelView = transactionMgr.currentstep.CustomView__c;
        customPanelHTML = CustomViews.SH19_REVIEW_PAGE;
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.Name;
        presenterName = submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c;
        reviewpagebutton = transactionMgr.currentStep.ContinueButtonText__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        shareCurrencyMap = new map < String, Shares__c > ();
        viewmap = new Map < Integer, List < Shares__c >> ();
        matchedShares = new List < Shares__c > ();
        viewkeys = new Map < Integer, String > ();
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
        requiresStatementofC = new Set < String > {
            'SH19',
            'SH05_6_7'
        };
        requiresParticulars = new Set < String > {
            'SH09'
        };
        showCurrency = true;
        if (submissionMgr.submission.Officers__r.size() > 1) {
            showprevious = false;
        }
        buildReviewShares();
        buildOtherShares();
        buildlabels();
        if (submissionMgr.submission.Shares__r.size() > 0) {
            preParticulars = sharesforBuilding;
        }
        if (submissionMgr.submission.Attachments.size() > 0) {
            reviewAttachments = submissionMgr.submission.Attachments;
            // note need to loop through by currency and build it dynamically
        }
        return;
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
        if (variationNotice == true) {}
    }
    public void buildOtherShares() {
        for (Shares__c deadShares: submissionMgr.submission.Shares__r) {
            if (deadShares.cancelled_shares__c == true) {
                sharesforCancelling.add(deadShares);
            }
        }
        if (sharesforCancelling.size() > 0) {
            showCancelledShares = true;
            dateText = 'Cancellation Date';
            reviewTitle = 'Shares to cancel';
        }
        for (Shares__c liveShares: submissionMgr.submission.Shares__r) {
            if (liveShares.cancelled_shares__c == false) {
                sharesforEditing.add(liveShares);
            }
        }
        if (sharesforEditing.size() > 0) {
            showCancelledShares = true;
            dateText = 'Date(s) shares were sold or transferred';
            reviewTitle = 'Treasury shares sold or transferred';
        }
    }
    public void buildReviewShares() {
        for (Shares__c safeShares: submissionMgr.submission.Shares__r) {
            if (safeShares.cancelled_shares__c == false) {
                sharesforBuilding.add(safeShares);
            }
        }
        if (sharesforBuilding.size() > 0) {
            for (Shares__c sharecurrencylimiter: sharesforBuilding) {
                shareCurrencyMap.put(sharecurrencylimiter.Currency__c, sharecurrencylimiter);
            }
            List < String > listKeys = new List < String > (shareCurrencyMap.keyset());
            for (Integer i = 0; i < listKeys.size(); i++) {
                matchedShares = new List < Shares__c > ();
                for (Shares__c buildShares: sharesforBuilding) {
                    if (buildShares.Currency__c == listKeys.get(i)) {
                        matchedShares.add(buildShares);
                        viewmap.put(i, matchedShares);
                        viewkeys.put(i, buildShares.Currency__c);
                    }
                }
            }
        } else {
            //throw new Form_CustomException('You have no shares to iterate over');
        }
        if (requiresStatementofC.contains(submissionMgr.submission.Form_Name__c)) {
            showStatementofCapital = true;
        }
        if (requiresParticulars.contains(submissionMgr.submission.Form_Name__c)) {
            showParticulars = true;
            showCurrency = false;
        }
    }
    private void persistStep() {
            submissionMgr.persist();
        }
        // End Instance methods.    
        // Action methods.     
    public PageReference nextAction() {
        if (!validatePageState()) return Page.TransactionException;
        persistStep();
        return nextStep();
    }
    public PageReference previousAction() {
            if (!validatePageState()) return Page.TransactionException;
            return previousStep();
        }
        // End Action methods.    
}