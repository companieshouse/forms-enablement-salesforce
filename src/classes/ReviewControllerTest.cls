
@IsTest
public with sharing class ReviewControllerTest {
    @isTest static void test_method_DS01() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
        Contact testContact = CompaniesHouseTestData.getInstance().contact1;

        Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.OfficerCount__c = 2;
        transac.Transaction_Type__c = 'DS01';
        transac.Form_Name__c = 'DS01';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        insert transac;
        testContact2.Transaction__c = transac.id;
        insert testContact2;
        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = true;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatory__c = true;

        insert testoff;

        Officer__c testoff2 = new Officer__c();
        testoff2.Surname__c = 'testsurname2';
        testoff2.Forename__c = 'testforename2';
        testoff2.Middlenames__c = 'testmiddlename2';
        testoff2.Email__c = 'testEmail2@testemail2.com';
        testoff2.IsPresenter__c = false;
        testoff2.Transaction__c = transac.Id;
        testoff2.Contact__c = testContact2.id;
        testoff2.isSignatory__c = true;

        insert testoff2;

        List<String> shareNames = new List<String>();
        shareNames.add('COMPANYOBJECTS');
        shareNames.add('STATEMENTOFCAPITAL');
        shareNames.add('CANCELLEDSHARES');
        shareNames.add('PARTICULARS');
        shareNames.add('VARIATIONS');
        shareNames.add('RECONVERSION');
        shareNames.add('REDEMPTION');
        shareNames.add('CONSOLIDATION');
        shareNames.add('SUBDIVISION');
        shareNames.add('SH08');
        shareNames.add('PROMOTER');
        shareNames.add('TRANSFERRED');

        List<Shares__c> reviewSharesList = new List<Shares__c>();
        for (integer i = 0; i < sharenames.size(); i++) {
            Shares__c addedShare = new Shares__c(activeData__c = true, sharetype__c = sharenames[i], currency__c = 'GBP', transaction__c = transac.Id, Class_of_Shares__c = 'testClassofShare' );
            reviewSharesList.add(addedShare);
        }
        insert reviewSharesList;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'testdescription';
        testAttachment.Name = 'Resolution';
        testAttachment.Body = testpdfBlob;

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        ReviewController test1controller = new ReviewController();

        test1controller.nextAction();
        test1controller.previousAction();
        test1controller.shareID = reviewSharesList[0].id;
        test1controller.deleteShare();
        test1controller.shareID = reviewSharesList[1].id;
        test1controller.removeSH08();
        test1controller.shareID = reviewSharesList[2].id;
        test1controller.deleteSH02Share();
        test1controller.shareID = reviewSharesList[3].id;
        test1controller.changeAttachments();
        test1controller.startReviewProcesses();
        test1controller.confirmReviewPage();
        test1controller.buildAttachments();
        test1controller.resetTransaction();

    }
    @isTest static void test_method_one() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
        Contact testContact = CompaniesHouseTestData.getInstance().contact1;

        Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.OfficerCount__c = 2;
        transac.Transaction_Type__c = 'SH05_6_7';
        transac.Form_Name__c = 'SH05_6_7';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        insert transac;

        testContact2.Transaction__c = transac.id;
        insert testContact2;

        testContact.Transaction__c = transac.id;
        insert testContact;

        Officer__c testoff = new Officer__c();
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = true;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatory__c = true;

        insert testoff;

        Officer__c testoff2 = new Officer__c();
        testoff2.Surname__c = 'testsurname2';
        testoff2.Forename__c = 'testforename2';
        testoff2.Middlenames__c = 'testmiddlename2';
        testoff2.Email__c = 'testEmail2@testemail2.com';
        testoff2.IsPresenter__c = false;
        testoff2.Transaction__c = transac.Id;
        testoff2.Contact__c = testContact2.id;
        testoff2.isSignatory__c = true;

        insert testoff2;

        List<String> shareNames = new List<String>();
        shareNames.add('COMPANYOBJECTS');
        shareNames.add('STATEMENTOFCAPITAL');
        shareNames.add('CANCELLEDSHARES');
        shareNames.add('PARTICULARS');
        shareNames.add('VARIATIONS');
        shareNames.add('RECONVERSION');
        shareNames.add('REDEMPTION');
        shareNames.add('CONSOLIDATION');
        shareNames.add('SUBDIVISION');
        shareNames.add('SH08');
        shareNames.add('PROMOTER');
        shareNames.add('TRANSFERRED');

        List<Shares__c> reviewSharesList = new List<Shares__c>();
        for (integer i = 0; i < sharenames.size(); i++) {
            Shares__c addedShare = new Shares__c(activeData__c = true, sharetype__c = sharenames[i], currency__c = 'GBP', transaction__c = transac.Id, Class_of_Shares__c = 'testClassofShare' );
            reviewSharesList.add(addedShare);
        }
        insert reviewSharesList;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'testdescription';
        testAttachment.Name = 'Resolution';
        testAttachment.Body = testpdfBlob;
        insert testAttachment;

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        ReviewController test1controller = new ReviewController();

        test1controller.nextAction();
        test1controller.previousAction();
        test1controller.shareID = reviewSharesList[0].id;
        test1controller.deleteShare();
        test1controller.shareID = reviewSharesList[1].id;
        test1controller.removeSH08();
        test1controller.shareID = reviewSharesList[2].id;
        test1controller.deleteSH02Share();
        test1controller.shareID = reviewSharesList[3].id;
        test1controller.changeAttachments();
        test1controller.startReviewProcesses();
        test1controller.confirmReviewPage();
        test1controller.buildAttachments();
        test1controller.resetTransaction();

    }


    @isTest static void test_method_two() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
        Contact testContact = CompaniesHouseTestData.getInstance().contact1;

        Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.OfficerCount__c = 2;
        transac.Transaction_Type__c = 'SH10';
        transac.Form_Name__c = 'SH10';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        insert transac;
        testContact2.Transaction__c = transac.id;
        insert testContact2;
        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = true;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatory__c = true;

        insert testoff;

        Officer__c testoff2 = new Officer__c();
        testoff2.Surname__c = 'testsurname2';
        testoff2.Forename__c = 'testforename2';
        testoff2.Middlenames__c = 'testmiddlename2';
        testoff2.Email__c = 'testEmail2@testemail2.com';
        testoff2.IsPresenter__c = false;
        testoff2.Transaction__c = transac.Id;
        testoff2.Contact__c = testContact2.id;
        testoff2.isSignatory__c = true;

        insert testoff2;

        List<String> shareNames = new List<String>();
        shareNames.add('COMPANYOBJECTS');
        shareNames.add('STATEMENTOFCAPITAL');
        shareNames.add('CANCELLEDSHARES');
        shareNames.add('PARTICULARS');
        shareNames.add('VARIATIONS');
        shareNames.add('RECONVERSION');
        shareNames.add('REDEMPTION');
        shareNames.add('CONSOLIDATION');
        shareNames.add('SUBDIVISION');
        shareNames.add('SH08');
        shareNames.add('PROMOTER');
        shareNames.add('TRANSFERRED');

        List<Shares__c> reviewSharesList = new List<Shares__c>();
        for (integer i = 0; i < sharenames.size(); i++) {
            Shares__c addedShare = new Shares__c(activeData__c = true, sharetype__c = sharenames[i], currency__c = 'GBP', transaction__c = transac.Id, Class_of_Shares__c = 'testClassofShare' );
            reviewSharesList.add(addedShare);
        }
        insert reviewSharesList;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'testdescription';
        testAttachment.Name = 'Resolution';
        testAttachment.Body = testpdfBlob;

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        ReviewController test1controller = new ReviewController();

        test1controller.nextAction();
        test1controller.previousAction();
    }


    @isTest static void test_method_three() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
        Contact testContact = CompaniesHouseTestData.getInstance().contact1;

        Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.OfficerCount__c = 2;
        transac.Transaction_Type__c = 'SH11';
        transac.Form_Name__c = 'SH11';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        insert transac;
        testContact2.Transaction__c = transac.id;
        insert testContact2;
        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = true;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatory__c = true;

        insert testoff;

        Officer__c testoff2 = new Officer__c();
        testoff2.Surname__c = 'testsurname2';
        testoff2.Forename__c = 'testforename2';
        testoff2.Middlenames__c = 'testmiddlename2';
        testoff2.Email__c = 'testEmail2@testemail2.com';
        testoff2.IsPresenter__c = false;
        testoff2.Transaction__c = transac.Id;
        testoff2.Contact__c = testContact2.id;
        testoff2.isSignatory__c = true;

        insert testoff2;

        List<String> shareNames = new List<String>();
        shareNames.add('COMPANYOBJECTS');
        shareNames.add('STATEMENTOFCAPITAL');
        shareNames.add('CANCELLEDSHARES');
        shareNames.add('PARTICULARS');
        shareNames.add('VARIATIONS');
        shareNames.add('RECONVERSION');
        shareNames.add('REDEMPTION');
        shareNames.add('CONSOLIDATION');
        shareNames.add('SUBDIVISION');
        shareNames.add('SH08');
        shareNames.add('PROMOTER');
        shareNames.add('TRANSFERRED');

        List<Shares__c> reviewSharesList = new List<Shares__c>();
        for (integer i = 0; i < sharenames.size(); i++) {
            Shares__c addedShare = new Shares__c(activeData__c = true, sharetype__c = sharenames[i], currency__c = 'GBP', transaction__c = transac.Id, Class_of_Shares__c = 'testClassofShare' );
            reviewSharesList.add(addedShare);
        }
        insert reviewSharesList;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'testdescription';
        testAttachment.Name = 'Resolution';
        testAttachment.Body = testpdfBlob;

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        ReviewController test1controller = new ReviewController();
        test1controller.confirmationVal = true;
        test1controller.nextAction();
        test1controller.previousAction();
    }


    @isTest static void test_method_nine() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
        Contact testContact = CompaniesHouseTestData.getInstance().contact1;

        Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.OfficerCount__c = 2;
        transac.Transaction_Type__c = 'SH12';
        transac.Form_Name__c = 'SH12';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        insert transac;
        testContact2.Transaction__c = transac.id;
        insert testContact2;
        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = true;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatory__c = true;

        insert testoff;

        Officer__c testoff2 = new Officer__c();
        testoff2.Surname__c = 'testsurname2';
        testoff2.Forename__c = 'testforename2';
        testoff2.Middlenames__c = 'testmiddlename2';
        testoff2.Email__c = 'testEmail2@testemail2.com';
        testoff2.IsPresenter__c = false;
        testoff2.Transaction__c = transac.Id;
        testoff2.Contact__c = testContact2.id;
        testoff2.isSignatory__c = true;

        insert testoff2;

        List<String> shareNames = new List<String>();
        shareNames.add('COMPANYOBJECTS');
        shareNames.add('STATEMENTOFCAPITAL');
        shareNames.add('CANCELLEDSHARES');
        shareNames.add('PARTICULARS');
        shareNames.add('VARIATIONS');
        shareNames.add('RECONVERSION');
        shareNames.add('REDEMPTION');
        shareNames.add('CONSOLIDATION');
        shareNames.add('SUBDIVISION');
        shareNames.add('SH08');
        shareNames.add('PROMOTER');
        shareNames.add('TRANSFERRED');

        List<Shares__c> reviewSharesList = new List<Shares__c>();
        for (integer i = 0; i < sharenames.size(); i++) {
            Shares__c addedShare = new Shares__c(activeData__c = true, sharetype__c = sharenames[i], currency__c = 'GBP', transaction__c = transac.Id, Class_of_Shares__c = 'testClassofShare' );
            reviewSharesList.add(addedShare);
        }
        insert reviewSharesList;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'testdescription';
        testAttachment.Name = 'Resolution';
        testAttachment.Body = testpdfBlob;

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        ReviewController test1controller = new ReviewController();

        test1controller.nextAction();
        test1controller.previousAction();
    }

    @isTest static void test_method_four() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
        Contact testContact = CompaniesHouseTestData.getInstance().contact1;

        Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.OfficerCount__c = 2;
        transac.Transaction_Type__c = 'SH19';
        transac.Form_Name__c = 'SH19';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        insert transac;
        testContact2.Transaction__c = transac.id;
        insert testContact2;
        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = true;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatory__c = true;

        insert testoff;

        Officer__c testoff2 = new Officer__c();
        testoff2.Surname__c = 'testsurname2';
        testoff2.Forename__c = 'testforename2';
        testoff2.Middlenames__c = 'testmiddlename2';
        testoff2.Email__c = 'testEmail2@testemail2.com';
        testoff2.IsPresenter__c = false;
        testoff2.Transaction__c = transac.Id;
        testoff2.Contact__c = testContact2.id;
        testoff2.isSignatory__c = true;

        insert testoff2;

        List<String> shareNames = new List<String>();
        shareNames.add('COMPANYOBJECTS');
        shareNames.add('STATEMENTOFCAPITAL');
        shareNames.add('CANCELLEDSHARES');
        shareNames.add('PARTICULARS');
        shareNames.add('VARIATIONS');
        shareNames.add('RECONVERSION');
        shareNames.add('REDEMPTION');
        shareNames.add('CONSOLIDATION');
        shareNames.add('SUBDIVISION');
        shareNames.add('SH08');
        shareNames.add('PROMOTER');
        shareNames.add('TRANSFERRED');

        List<Shares__c> reviewSharesList = new List<Shares__c>();
        for (integer i = 0; i < sharenames.size(); i++) {
            Shares__c addedShare = new Shares__c(activeData__c = true, sharetype__c = sharenames[i], currency__c = 'GBP', transaction__c = transac.Id, Class_of_Shares__c = 'testClassofShare' );
            reviewSharesList.add(addedShare);
        }
        insert reviewSharesList;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'testdescription';
        testAttachment.Name = 'Resolution';
        testAttachment.Body = testpdfBlob;

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        ReviewController test1controller = new ReviewController();

        test1controller.nextAction();
        test1controller.previousAction();
    }

    @isTest static void test_method_five() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
        Contact testContact = CompaniesHouseTestData.getInstance().contact1;

        Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.OfficerCount__c = 2;
        transac.Transaction_Type__c = 'SH08';
        transac.Form_Name__c = 'SH08';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        insert transac;
        testContact2.Transaction__c = transac.id;
        insert testContact2;
        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = true;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatory__c = true;

        insert testoff;

        Officer__c testoff2 = new Officer__c();
        testoff2.Surname__c = 'testsurname2';
        testoff2.Forename__c = 'testforename2';
        testoff2.Middlenames__c = 'testmiddlename2';
        testoff2.Email__c = 'testEmail2@testemail2.com';
        testoff2.IsPresenter__c = false;
        testoff2.Transaction__c = transac.Id;
        testoff2.Contact__c = testContact2.id;
        testoff2.isSignatory__c = true;

        insert testoff2;

        List<String> shareNames = new List<String>();
        shareNames.add('COMPANYOBJECTS');
        shareNames.add('STATEMENTOFCAPITAL');
        shareNames.add('CANCELLEDSHARES');
        shareNames.add('PARTICULARS');
        shareNames.add('VARIATIONS');
        shareNames.add('RECONVERSION');
        shareNames.add('REDEMPTION');
        shareNames.add('CONSOLIDATION');
        shareNames.add('SUBDIVISION');
        shareNames.add('SH08');
        shareNames.add('PROMOTER');
        shareNames.add('TRANSFERRED');

        List<Shares__c> reviewSharesList = new List<Shares__c>();
        for (integer i = 0; i < sharenames.size(); i++) {
            Shares__c addedShare = new Shares__c(activeData__c = true, sharetype__c = sharenames[i], currency__c = 'GBP', transaction__c = transac.Id, Class_of_Shares__c = 'testClassofShare' );
            reviewSharesList.add(addedShare);
        }
        insert reviewSharesList;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'testdescription';
        testAttachment.Name = 'Resolution';
        testAttachment.Body = testpdfBlob;

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        ReviewController test1controller = new ReviewController();

        test1controller.nextAction();
        test1controller.previousAction();
    }

    @isTest static void test_method_six() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
        Contact testContact = CompaniesHouseTestData.getInstance().contact1;

        Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.OfficerCount__c = 2;
        transac.Transaction_Type__c = 'CC04';
        transac.Form_Name__c = 'CC04';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        insert transac;
        testContact2.Transaction__c = transac.id;
        insert testContact2;
        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = true;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatory__c = true;

        insert testoff;

        Officer__c testoff2 = new Officer__c();
        testoff2.Surname__c = 'testsurname2';
        testoff2.Forename__c = 'testforename2';
        testoff2.Middlenames__c = 'testmiddlename2';
        testoff2.Email__c = 'testEmail2@testemail2.com';
        testoff2.IsPresenter__c = false;
        testoff2.Transaction__c = transac.Id;
        testoff2.Contact__c = testContact2.id;
        testoff2.isSignatory__c = true;

        insert testoff2;

        List<String> shareNames = new List<String>();
        shareNames.add('COMPANYOBJECTS');
        shareNames.add('STATEMENTOFCAPITAL');
        shareNames.add('CANCELLEDSHARES');
        shareNames.add('PARTICULARS');
        shareNames.add('VARIATIONS');
        shareNames.add('RECONVERSION');
        shareNames.add('REDEMPTION');
        shareNames.add('CONSOLIDATION');
        shareNames.add('SUBDIVISION');
        shareNames.add('SH08');
        shareNames.add('PROMOTER');
        shareNames.add('TRANSFERRED');

        List<Shares__c> reviewSharesList = new List<Shares__c>();
        for (integer i = 0; i < sharenames.size(); i++) {
            Shares__c addedShare = new Shares__c(activeData__c = true, sharetype__c = sharenames[i], currency__c = 'GBP', transaction__c = transac.Id, Class_of_Shares__c = 'testClassofShare' );
            reviewSharesList.add(addedShare);
        }
        insert reviewSharesList;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'testdescription';
        testAttachment.Name = 'Resolution';
        testAttachment.Body = testpdfBlob;

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        ReviewController test1controller = new ReviewController();

        test1controller.nextAction();
        test1controller.previousAction();
    }

    @isTest static void test_method_seven() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
        Contact testContact = CompaniesHouseTestData.getInstance().contact1;

        Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.OfficerCount__c = 2;
        transac.Transaction_Type__c = 'SH02';
        transac.Form_Name__c = 'SH02';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        insert transac;
        testContact2.Transaction__c = transac.id;
        insert testContact2;
        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = true;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatory__c = true;

        insert testoff;

        Officer__c testoff2 = new Officer__c();
        testoff2.Surname__c = 'testsurname2';
        testoff2.Forename__c = 'testforename2';
        testoff2.Middlenames__c = 'testmiddlename2';
        testoff2.Email__c = 'testEmail2@testemail2.com';
        testoff2.IsPresenter__c = false;
        testoff2.Transaction__c = transac.Id;
        testoff2.Contact__c = testContact2.id;
        testoff2.isSignatory__c = true;

        insert testoff2;

        List<String> shareNames = new List<String>();
        shareNames.add('COMPANYOBJECTS');
        shareNames.add('STATEMENTOFCAPITAL');
        shareNames.add('CANCELLEDSHARES');
        shareNames.add('PARTICULARS');
        shareNames.add('VARIATIONS');
        shareNames.add('RECONVERSION');
        shareNames.add('REDEMPTION');
        shareNames.add('CONSOLIDATION');
        shareNames.add('SUBDIVISION');
        shareNames.add('SH08');
        shareNames.add('PROMOTER');
        shareNames.add('TRANSFERRED');

        List<Shares__c> reviewSharesList = new List<Shares__c>();
        for (integer i = 0; i < sharenames.size(); i++) {
            Shares__c addedShare = new Shares__c(activeData__c = true, sharetype__c = sharenames[i], currency__c = 'GBP', transaction__c = transac.Id, Class_of_Shares__c = 'testClassofShare' );
            reviewSharesList.add(addedShare);
        }
        insert reviewSharesList;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'testdescription';
        testAttachment.Name = 'Resolution';
        testAttachment.Body = testpdfBlob;

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        ReviewController test1controller = new ReviewController();

        test1controller.nextAction();
        test1controller.previousAction();
    }

    @isTest static void test_method_eight() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;
        Contact testContact = CompaniesHouseTestData.getInstance().contact1;

        Contact testContact2 = CompaniesHouseTestData.getInstance().contact2;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.OfficerCount__c = 2;
        transac.Transaction_Type__c = 'SH10';
        transac.Form_Name__c = 'SH10';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        insert transac;
        testContact2.Transaction__c = transac.id;
        insert testContact2;
        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = true;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatory__c = true;

        insert testoff;

        Officer__c testoff2 = new Officer__c();
        testoff2.Surname__c = 'testsurname2';
        testoff2.Forename__c = 'testforename2';
        testoff2.Middlenames__c = 'testmiddlename2';
        testoff2.Email__c = 'testEmail2@testemail2.com';
        testoff2.IsPresenter__c = false;
        testoff2.Transaction__c = transac.Id;
        testoff2.Contact__c = testContact2.id;
        testoff2.isSignatory__c = true;

        insert testoff2;

        List<String> shareNames = new List<String>();
        shareNames.add('COMPANYOBJECTS');
        shareNames.add('STATEMENTOFCAPITAL');
        // build only transfered shares
        //shareNames.add('CANCELLEDSHARES');
        shareNames.add('PARTICULARS');
        shareNames.add('VARIATIONS');
        shareNames.add('RECONVERSION');
        shareNames.add('REDEMPTION');
        shareNames.add('CONSOLIDATION');
        shareNames.add('SUBDIVISION');
        shareNames.add('SH08');
        shareNames.add('PROMOTER');
        shareNames.add('TRANSFERRED');

        List<Shares__c> reviewSharesList = new List<Shares__c>();
        for (integer i = 0; i < sharenames.size(); i++) {
            Shares__c addedShare = new Shares__c(activeData__c = true, sharetype__c = sharenames[i], currency__c = 'GBP', transaction__c = transac.Id, Class_of_Shares__c = 'testClassofShare' );
            reviewSharesList.add(addedShare);
        }
        insert reviewSharesList;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'testdescription';
        testAttachment.Name = 'Resolution';
        testAttachment.Body = testpdfBlob;

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        ReviewController test1controller = new ReviewController();

        test1controller.nextAction();
        test1controller.previousAction();
        test1controller.confirmationVal = true;

    }
}