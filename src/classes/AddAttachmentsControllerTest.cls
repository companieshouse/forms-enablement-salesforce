/*
Name:  AddAttachmentsControllerTest.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

AddAttachmentsControllerTest for the AddAttachmentController

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoy&    2016-06-07  Initial development. NOT WORKING SP
*/
@IsTest
public class AddAttachmentsControllerTest {


    @isTest static void test_method_one() {
        // go forward
        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        // needs mock web callout information here for initialize step test
        insert testPresenter;

        insert testCompany;

        Transaction__c transac = testData.tx;

        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.Form_Name__c = 'CC04';

        insert transac;

        PageReference attachment3TestPage = Page.Attachments;
        attachment3TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(attachment3TestPage);

        AddAttachmentsController test3controller = new AddAttachmentsController();
        test3controller.checkAttachmentStatus();
        test3controller.shimfunction();
        test3controller.goForward();
        test3controller.nextAction();
        test3controller.previousAction();
    }
    @isTest static void test_method_two() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        // needs mock web callout information here for initialize step test
        insert testPresenter;

        insert testCompany;

        Transaction__c transac = testData.tx;

        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = false;
        transac.Form_Name__c = 'SH19';

        insert transac;

        PageReference attachment2TestPage = Page.Attachments;
        attachment2TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(attachment2TestPage);

        AddAttachmentsController test2controller = new AddAttachmentsController();
        test2controller.goForward();

        test2controller.checkAttachmentStatus();

        test2controller.nextAction();

        test2controller.previousAction();

        Blob test2pdfBlob;
        test2pdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment2 = new Attachment();
        testAttachment2.ParentId = transac.Id;
        testAttachment2.Description = 'Solvency statement';
        testAttachment2.Name = 'Solvency statement' + '.pdf';
        testAttachment2.Body = test2pdfBlob;
        insert testAttachment2;
        test2controller.file2 = test2pdfBlob;
        test2controller.upload2();
        test2controller.checkAttachmentStatus();


        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'Resolution';
        testAttachment.Name = 'Resolution' + '.pdf';
        testAttachment.Body = testpdfBlob;
        insert testAttachment;
        test2controller.file1 = testpdfBlob;
        test2controller.upload1();
        test2controller.checkAttachmentStatus();

        test2controller.attachmentId = testAttachment.id;
        test2controller.DeleteAttachments();

    }

    @isTest static void test_method_three() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        // needs mock web callout information here for initialize step test
        insert testPresenter;

        insert testCompany;

        Transaction__c transac = testData.tx;

        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = false;
        transac.Form_Name__c = 'CC04';

        insert transac;



        PageReference attachment2TestPage = Page.Attachments;
        attachment2TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(attachment2TestPage);



        AddAttachmentsController test2controller = new AddAttachmentsController();
        test2controller.goForward();

        test2controller.checkAttachmentStatus();


        test2controller.nextAction();

        test2controller.previousAction();


        Blob test2pdfBlob;
        test2pdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment2 = new Attachment();
        testAttachment2.ParentId = transac.Id;
        testAttachment2.Description = 'Revised Articles';
        testAttachment2.Name = 'Revised Articles' + '.pdf';
        testAttachment2.Body = test2pdfBlob;
        insert testAttachment2;
        test2controller.file2 = test2pdfBlob;
        test2controller.upload2();

        test2controller.checkAttachmentStatus();


        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'Resolution agreeing change';
        testAttachment.Name = 'Resolution agreeing change' + '.pdf';
        testAttachment.Body = testpdfBlob;
        insert testAttachment;
        test2controller.file1 = testpdfBlob;
        test2controller.upload1();

        test2controller.checkAttachmentStatus();


        test2controller.deleteattachmentId = testAttachment.id;
        test2controller.DeleteAttachments();
    }

    @isTest static void test_method_five() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        // needs mock web callout information here for initialize step test
        insert testPresenter;

        insert testCompany;

        Transaction__c transac = testData.tx;

        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = false;
        transac.Form_Name__c = 'CC04';

        insert transac;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'Resolution agreeing change';
        testAttachment.Name = 'Resolution agreeing change' + '.pdf';
        testAttachment.Body = testpdfBlob;
        insert testAttachment;

        Blob test2pdfBlob;
        test2pdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment2 = new Attachment();
        testAttachment2.ParentId = transac.Id;
        testAttachment2.Description = 'Revised Articles';
        testAttachment2.Name = 'Revised Articles' + '.pdf';
        testAttachment2.Body = test2pdfBlob;
        insert testAttachment2;

        PageReference attachment2TestPage = Page.Attachments;
        attachment2TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(attachment2TestPage);
        AddAttachmentsController test2controller = new AddAttachmentsController();
        test2controller.goForward();
        test2controller.checkAttachmentStatus();
        test2controller.nextAction();
        test2controller.previousAction();
        test2controller.file1 = testpdfBlob;
        test2controller.file2 = test2pdfBlob;
        test2controller.upload1();
        test2controller.upload2();
        test2controller.deleteattachmentId = testAttachment.id;
        test2controller.DeleteAttachments();
    }

    @isTest static void test_method_four() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        // needs mock web callout information here for initialize step test
        insert testPresenter;

        insert testCompany;

        Transaction__c transac = testData.tx;

        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = false;
        transac.Form_Name__c = 'CC04';

        insert transac;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'Resolution agreeing change';
        testAttachment.Name = 'Resolution agreeing change' + '.pdf';
        testAttachment.Body = testpdfBlob;
        insert testAttachment;

        //Blob test2pdfBlob;
        //test2pdfBlob = Blob.valueOf('This is a test');
        //Attachment testAttachment2 = new Attachment();
        //testAttachment2.ParentId = transac.Id;
        //testAttachment2.Description = 'Revised Articles';
        //testAttachment2.Name = 'Revised Articles' + '.pdf';
        //testAttachment2.Body = test2pdfBlob;
        //insert testAttachment2;

        PageReference attachment2TestPage = Page.Attachments;
        attachment2TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(attachment2TestPage);
        AddAttachmentsController test2controller = new AddAttachmentsController();
        test2controller.goForward();
        test2controller.checkAttachmentStatus();
        test2controller.nextAction();
        test2controller.previousAction();
        test2controller.file1 = testpdfBlob;
        //test2controller.file2 = test2pdfBlob;
        test2controller.upload1();
        //test2controller.upload2();
        test2controller.deleteattachmentId = testAttachment.id;
        test2controller.DeleteAttachments();
    }


    @isTest static void test_method_six() {

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        // needs mock web callout information here for initialize step test
        insert testPresenter;

        insert testCompany;

        Transaction__c transac = testData.tx;

        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = false;
        transac.Form_Name__c = 'SH19';

        insert transac;

        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        Attachment testAttachment = new Attachment();
        testAttachment.ParentId = transac.Id;
        testAttachment.Description = 'Resolution agreeing change';
        testAttachment.Name = 'Resolution agreeing change' + '.pdf';
        testAttachment.Body = testpdfBlob;
        insert testAttachment;

        //Blob test2pdfBlob;
        //test2pdfBlob = Blob.valueOf('This is a test');
        //Attachment testAttachment2 = new Attachment();
        //testAttachment2.ParentId = transac.Id;
        //testAttachment2.Description = 'Revised Articles';
        //testAttachment2.Name = 'Revised Articles' + '.pdf';
        //testAttachment2.Body = test2pdfBlob;
        //insert testAttachment2;

        PageReference attachment2TestPage = Page.Attachments;
        attachment2TestPage.getParameters().put('c', SecurityManager.encryptText(transac.Id + AppConstants.ID_DELIM_CHAR + testStep1.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(attachment2TestPage);
        AddAttachmentsController test2controller = new AddAttachmentsController();
        test2controller.goForward();
        test2controller.checkAttachmentStatus();
        test2controller.nextAction();
        test2controller.previousAction();
        test2controller.file1 = testpdfBlob;
        //test2controller.file2 = test2pdfBlob;
        test2controller.upload1();
        //test2controller.upload2();
        test2controller.deleteattachmentId = testAttachment.id;
        test2controller.DeleteAttachments();
    }
}