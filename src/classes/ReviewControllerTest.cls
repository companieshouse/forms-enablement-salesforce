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

        Blob testpdfBlob;
		testpdfBlob = Blob.valueOf('This is a test');
		Attachment testAttachment = new Attachment();
		testAttachment.ParentId = transac.Id;
		testAttachment.Description = 'testdescription';
		testAttachment.Name = 'DS01';
		testAttachment.Body = testpdfBlob;

        insert testAttachment;

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

        PageReference reviewTestPage = Page.Review;
        reviewTestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(reviewTestPage);
        Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('test@test.com'+AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 120, true);

        reviewTestPage.setCookies(new Cookie[]{sessionValidity});
        ReviewController test1controller = new ReviewController();

        test1controller.buildPDF();
        test1controller.nextAction();
        test1controller.previousAction();
        test1controller.startReviewProcesses();
        test1controller.nextAction();
        test1controller.resetTransaction();

        Cookie sessionValidity2 = new Cookie('auth', SecurityManager.encryptText('test@test.com'+AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 120, true);
        Cookie sessionValidity3 = new Cookie('c', SecurityManager.encryptText('test@test.com'+AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 120, true);
        reviewTestPage.setCookies(new Cookie[]{sessionValidity});
        reviewTestPage.setCookies(new Cookie[]{sessionValidity2});
        reviewTestPage.setCookies(new Cookie[]{sessionValidity3});
        test1controller.parseQueryString();
        test1controller.findCompanyAuthByNonce();
        test1controller.startReviewProcesses();
    }
}