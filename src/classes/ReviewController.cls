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
    public Map < String, Shares__c > shareClassMapSH02 {
        get;
        set;
    }
    public List < Shares__c > matchedSharesSH02 {
        get;
        set;
    }
    public Map < Integer, List < Shares__c >> viewmapSH02 {
        get;
        set;
    }
    public Map < Integer, String > viewkeysSH02 {
        get;
        set;
    }
    public Map < String, Shares__c > shareClassMapREd {
        get;
        set;
    }
    public List < Shares__c > matchedSharesREd {
        get;
        set;
    }
    public Map < Integer, List < Shares__c >> viewmapREd {
        get;
        set;
    }
    public Map < Integer, String > viewkeysREd {
        get;
        set;
    }
    public Map < String, Shares__c > shareClassMapCon {
        get;
        set;
    }
    public List < Shares__c > matchedSharesCon {
        get;
        set;
    }
    public Map < Integer, List < Shares__c >> viewmapCon {
        get;
        set;
    }
    public Map < Integer, String > viewkeysCon {
        get;
        set;
    }
    public Map < String, Shares__c > shareClassMapSUB {
        get;
        set;
    }
    public List < Shares__c > matchedSharesSUB {
        get;
        set;
    }
    public Map < Integer, List < Shares__c >> viewmapSUB {
        get;
        set;
    }
    public Map < Integer, String > viewkeysSUB {
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
    //public Boolean showParticulars {
    //    get;
    //    set;
    //}
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
    public List < Shares__c > cC04 {
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
    public String cc04HelperText {
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
    public Boolean showAttachments {
        get;
        set;
    }
    public Boolean showCC04 {
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
    public Boolean showTable {
        get;
        set;
    }
    public Boolean showtotalunpaid {
        get;
        set;
    }
    public List < Shares__c > viewSHares {
        get;
        set;
    }
    public Boolean showMasterHeader {
        get;
        set;
    }
    public String confirmationTextPanel {
        get;
        set;
    }
    public Boolean showSH02 {
        get;
        set;
    }
    public Id attID {get; set;}
    public String attName {get; set;}
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
        headerText1 = headerText1.replace('COMPANYNAME', companyName);
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.PersonEmail;
        presenterName = submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        previousButtonText = transactionMgr.currentStep.PreviousButtonText__c;
        companyDirectors = new List<Officer__c>();
        for (Officer__c off : submissionMgr.submission.Officers__r) {
            if (off.isSignatory__c) {
                companyDirectors.add(off);
            }
        }
        shareCurrencyMap = new map < String, Shares__c > ();
        viewmap = new Map < Integer, List < Shares__c >> ();
        matchedShares = new List < Shares__c > ();
        viewkeys = new Map < Integer, String > ();
        shareClassMap = new map < String, Shares__c > ();
        shareClassMapSH02 = new map < String, Shares__c > ();
        matchedSharesSH02 = new List < Shares__c > ();
        viewmapSH02 = new Map < Integer, List < Shares__c >> ();
        viewkeysSH02 = new Map < Integer, String > ();
        shareClassMapSUB = new map < String, Shares__c > ();
        matchedSharesSUB = new List < Shares__c > ();
        viewmapSUB = new Map < Integer, List < Shares__c >> ();
        viewkeysSUB = new Map < Integer, String > ();
        shareClassMapCon = new map < String, Shares__c > ();
        matchedSharesCon = new List < Shares__c > ();
        viewmapCon = new Map < Integer, List < Shares__c >> ();
        viewkeysCon = new Map < Integer, String > ();
        shareClassMapREd = new map < String, Shares__c > ();
        matchedSharesREd = new List < Shares__c > ();
        viewmapREd = new Map < Integer, List < Shares__c >> ();
        viewkeysREd = new Map < Integer, String > ();
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
        sharesforCancelling = new List < Shares__c > ();
        preParticulars = new List < Shares__c > ();
        variations = new List < Shares__c > ();
        rECONVERSION = new List < Shares__c > ();
        rEDEMPTION = new List < Shares__c > ();
        cONSOLIDATION = new List < Shares__c > ();
        sUBDIVISION = new List < Shares__c > ();
        sh08Family = new List < Shares__c > ();
        promoters = new List < Shares__c > ();
        cC04 = new List < Shares__c > ();
        showCurrency = true;
        if (submissionMgr.submission.Officers__r.size() > 1) {
            showprevious = true;
        }
        viewSHares = submissionMgr.submission.Shares__r;
        buildVal();
        shareRouter();
        return;
    }
    public void startReviewProcesses() {
        if (submissionMgr.submission.Form_Name__c != 'DS01') {
            buildPDF();
        }
    }
    public void buildPDF() {

        Attachment pdfAttachment = new Attachment();
        Blob pdfBlob;
        String pageName;
        if (submissionMgr.submission.Form_Name__c == 'SH05_6_7') {pageName = 'SH06';}
        else {pageName = submissionMgr.submission.Form_Name__c; }
        if (submissionMgr.submission.Attachments.size() > 0) {
            try {
                Delete[Select id, name from Attachment where ParentId = :submissionMgr.submission.id and Name = :pageName + '.pdf'];
            } catch (DmlException e) {
                System.debug('DML Error in deleting' + pageName + 'Error Details are' + ' ' + e.getMessage());
            } catch (Exception e) {
                System.debug('General Error in deleting' + pageName + 'Error Details are' + ' ' + e.getMessage());
            }
        }
        PageReference pageRef = new PageReference('/apex/' + pageName);
        pageRef.getParameters().put('id', submissionMgr.submission.Id);
        if (Test.IsRunningTest()) pdfBlob = Blob.valueOf('This is a test');
        else pdfBlob = pageRef.getContent();
        pdfAttachment.ParentId = submissionMgr.submission.Id;
        pdfAttachment.Name = pageName + '.pdf';
        pdfAttachment.Description = pageName;
        pdfAttachment.Body = pdfBlob;
        try {
            insert pdfAttachment;
        } catch (DmlException e) {
            System.debug('DML Error in inserting' + pageName + 'Error Details are' + ' ' + e.getMessage());
        } catch (Exception e) {
            System.debug('General Error in inserting' + pageName + 'Error Details are' + ' ' + e.getMessage());
        }
    }
    public void buildsubdivisionCapitalMap() {
        if (sUBDIVISION.size() > 0) {
            for (Shares__c shareclasslimiter : sUBDIVISION) {
                shareClassMapSUB.put(shareclasslimiter.SHARETYPE__c, shareclasslimiter);
            }
            List < String > listKeys2 = new List < String > (shareClassMapSUB.keyset());
            for (Integer i = 0; i < listKeys2.size(); i++) {
                matchedSharesSUB = new List < Shares__c > ();
                for (Shares__c buildShares : sUBDIVISION) {
                    if (buildShares.SHARETYPE__c == listKeys2.get(i)) {
                        matchedSharesSUB.add(buildShares);
                        viewmapSUB.put(i, matchedSharesSUB);
                        viewkeysSUB.put(i, buildShares.SHARETYPE__c);
                    }
                }
            }
            if (matchedSharesSUB.size() > 0) {
                showTable = true;
            }
        } else {
            System.debug('you have no statement of capital to iterate over');
        }
    }
    public void buildConversionCapitalMap() {
        if (rECONVERSION.size() > 0) {
            for (Shares__c shareclasslimiter : rECONVERSION) {
                shareClassMapCon.put(shareclasslimiter.SHARETYPE__c, shareclasslimiter);
            }
            List < String > listKeys2 = new List < String > (shareClassMapCon.keyset());
            for (Integer i = 0; i < listKeys2.size(); i++) {
                matchedSharesCon = new List < Shares__c > ();
                for (Shares__c buildShares : rECONVERSION) {
                    if (buildShares.SHARETYPE__c == listKeys2.get(i)) {
                        matchedSharesCon.add(buildShares);
                        viewmapCon.put(i, matchedSharesCon);
                        viewkeysCon.put(i, buildShares.SHARETYPE__c);
                    }
                }
            }
            if (matchedSharesCon.size() > 0) {
                showTable = true;
            }
        } else {
            System.debug('you have no statement of capital to iterate over');
        }
    }
    public void buildRedemptionCapitalMap() {
        if (rEDEMPTION.size() > 0) {
            for (Shares__c shareclasslimiter : rEDEMPTION) {
                shareClassMapREd.put(shareclasslimiter.SHARETYPE__c, shareclasslimiter);
            }
            List < String > listKeys2 = new List < String > (shareClassMapREd.keyset());
            for (Integer i = 0; i < listKeys2.size(); i++) {
                matchedSharesREd = new List < Shares__c > ();
                for (Shares__c buildShares : rEDEMPTION) {
                    if (buildShares.SHARETYPE__c == listKeys2.get(i)) {
                        matchedSharesREd.add(buildShares);
                        viewmapREd.put(i, matchedSharesREd);
                        viewkeysREd.put(i, buildShares.SHARETYPE__c);
                    }
                }
            }
            if (matchedSharesREd.size() > 0) {
                showTable = true;
            }
        } else {
            System.debug('you have no statement of capital to iterate over');
        }
    }
    public void buildConsolidationCapitalMap() {
        if (cONSOLIDATION.size() > 0) {
            for (Shares__c shareclasslimiter : cONSOLIDATION) {
                shareClassMapSH02.put(shareclasslimiter.SHARETYPE__c, shareclasslimiter);
            }
            List < String > listKeys2 = new List < String > (shareClassMapSH02.keyset());
            for (Integer i = 0; i < listKeys2.size(); i++) {
                matchedSharesSH02 = new List < Shares__c > ();
                for (Shares__c buildShares : cONSOLIDATION) {
                    if (buildShares.SHARETYPE__c == listKeys2.get(i)) {
                        matchedSharesSH02.add(buildShares);
                        viewmapSH02.put(i, matchedSharesSH02);
                        viewkeysSH02.put(i, buildShares.SHARETYPE__c);
                    }
                }
            }
            if (matchedSharesSH02.size() > 0) {
                showTable = true;
            }
        } else {
            System.debug('you have no statement of capital to iterate over');
        }
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
            } else if (totalShares.SHARETYPE__c == 'COMPANYOBJECTS') {
                cC04.add(totalShares);
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
            } else if (totalShares.SHARETYPE__c == 'PROMOTER') {
                promoters.add(totalShares);
            } else if (totalShares.SHARETYPE__c == 'TRANSFERRED') {
                sharesforCancelling.add(totalShares);
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
        if (sUBDIVISION.size() > 0) {
            buildsubdivisionCapitalMap();
            showSH02 = true;
            showSubdivision = true;
            subdivisiontableHelperText = 'Sub-division';
            shownewstructure = true;
        }
        if (sh08Family.size() > 0) {
            showSh08 = true;
            sh08HelperText = 'Class(es) of shares';
        }
        if (cONSOLIDATION.size() > 0) {
            buildConsolidationCapitalMap();
            showSH02 = true;
            showConsolidation = true;
            consolidationtableHelperText = 'Consolidation';
            shownewstructure = true;
        }
        if (rECONVERSION.size() > 0) {
            buildConversionCapitalMap();
            showSH02 = true;
            showreConversion = true;
            reconversiontableHelperText = 'Reconversion';
            showValueField = true;
        }
        if (rEDEMPTION.size() > 0) {
            showSH02 = true;
            buildRedemptionCapitalMap();
            showRedemption = true;
            redemptiontableHelperText = 'Redemption';
        }
        if (cC04.size() > 0) {
            showCC04 = true;
            cc04HelperText = 'Company\'s objects';
        }
        if (variations.size() > 0) {
            buildLABELS();
        }
        if (submissionMgr.submission.Form_Name__c == 'SH19') {
            showtotalunpaid = true;
            confirmationTextPanel = 'I confirm that the information above is correct and this is the latest statement of capital';
        }
        if (submissionMgr.submission.Form_Name__c == 'SH08') {
            showMasterHeader = false;
            confirmationTextPanel = 'I confirm that the information above is correct';
        }
        if (submissionMgr.submission.Form_Name__c == 'SH05_6_7') {
            //showMasterHeader = false;
            confirmationTextPanel = 'I confirm that the information above is correct and this is the latest statement of capital';
        }
        if (submissionMgr.submission.Form_Name__c == 'SH10') {
            //showMasterHeader = false;
            confirmationTextPanel = 'I confirm that the information above is correct';
        }
        if (submissionMgr.submission.Form_Name__c == 'CC04') {
            //showMasterHeader = false;
            confirmationTextPanel = 'I confirm that the information above is correct';
        }
        if (submissionMgr.submission.Form_Name__c == 'SH02') {
            //showMasterHeader = false;
            confirmationTextPanel = 'I confirm that the information above is correct';
        }
        //lastly build attachments
        if (submissionMgr.submission.Attachments.size() > 0) {
            reviewAttachments = new List < Attachment > ();
            for (Attachment reviewpageattachments : submissionMgr.submission.Attachments) {
                if (reviewpageattachments.Name != submissionMgr.submission.Form_Name__c + '.pdf') {
                    reviewAttachments.add(reviewpageattachments);
                }
            }
            if (reviewAttachments.size() > 0) {
                showAttachments = true;
            }
        } else if (submissionMgr.submission.Attachments.size() == 0) {
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

        submissionMgr.persist();

    }
    public PageReference deleteShare() {
        // delete/change share methods for Statement of capital
        // returns user to Scapital journey to create a new sharecapital
        if (shareID != null) {
            //persistStep();
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

    public PageReference removeSH08() {
        // delete/change share methods for Statement of capital
        // returns user to Scapital journey to create a new sharecapital
        if (shareID != null) {
            attachmentpersistStep();
            // persistStep();

            try {
                List < Shares__c > deletedrecord = [SELECT Id, Name From Shares__c where ID = :shareID];
                //throw new Form_CustomException('record you are deleting is' + deletedrecord);
                delete deletedrecord[0];
            } catch (DmlException e) {
                System.debug('DML Error with ' + e.getMessage());
            } catch (Exception e) {
                System.debug('DML Error with ' + e.getMessage());
            }
            PageReference pg = new PageReference('/ChangeShareClassName');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }
        return null;
    }
    public PageReference deleteSH02Share() {
        // delete/change share methods for SH02
        // returns user to Scapital journey to create a new sharecapital for the 3 types of SH02 (Conversion, subdivision, consolidation, redemption)
        if (shareID != null) {
            submissionMgr.submission.finishedpart1__c = false;
            submissionMgr.submission.finishedAddingShares__c = false;
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
            PageReference pg = new PageReference('/CRS');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }
        return null;
    }
    private void attachmentpersistStep() {
        submissionMgr.submission.finishedAddingShares__c = false;
        submissionMgr.submission.finishedAttachments__c = true;
        submissionMgr.submission.finishedpart1__c = false;
        submissionMgr.persist();
    }
    public PageReference changeAttachments() {

        //throw new Form_CustomException('ATTID is ' + ' ' + attID + ' ' + 'ATTNAME is ' + ' ' + attName);
        // delete/change share methods for SH02
        // returns user to Scapital journey to create a new sharecapital for the 3 types of SH02 (Conversion, subdivision, consolidation, redemption)
        if (shareID != null) {
            submissionMgr.submission.finishedpart1__c = false;
            submissionMgr.submission.finishedAddingShares__c = false;
            submissionMgr.submission.finishedAttachments__c = false;
            persistStep();
            String realfilename;
            realfilename = attName + '.pdf';
            try {
                List < Attachment > deletedrecord = [SELECT Id, Name From Attachment where ID = : attID and Name = :realfilename];
                //throw new Form_CustomException('record you are deleting is' + deletedrecord);
                delete deletedrecord[0];
            } catch (DmlException e) {
                System.debug('DML Error with ' + e.getMessage());
            } catch (Exception e) {
                System.debug('DML Error with ' + e.getMessage());
            }
            PageReference pg = new PageReference('/attachments');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }
        return null;
    }
    public PageReference nextAction() {
        if (!confirmationVal) {
            showError = 'error';
            hasPageErrors = true;
            currentErrorMessage = 'You must confirm to continue';
            return null;
        }
        if (Test.IsRunningTest()) {
            system.debug('Test is running');

        } else {
            if (!validatePageState()) return Page.TransactionException;
        }
        persistStep();
        if (submissionMgr.submission.Form_Name__c == 'DS01' || submissionMgr.submission.Form_Name__c == 'DS02') {
            return nextStep();
        } else if (submissionMgr.submission.Form_Name__c != 'DS01' || submissionMgr.submission.Form_Name__c != 'DS02') {
            PageReference pg = new PageReference('/ConfirmationFramework');
            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            return pg;
        }
        return null;
    }

    public PageReference resetTransaction() {
        //The framework has been decomissioned to now redirect to the company details page once you click the link start again

        if (submissionMgr.submission.Id != null) {
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
    public PageReference previousAction() {
        if (Test.IsRunningTest()) {
            system.debug('Test is running');

        } else {
            if (!validatePageState()) return Page.TransactionException;

            return previousStep();
        }
        return null;
    }
}