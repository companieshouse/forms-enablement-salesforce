/*
Name:  TransactionRecordsDeletionBatchTest.cls
Copyright © 2017  Ribbonfish LTD
======================================================
======================================================
Purpose:
-------

Test class for TransactionRecordsDeletionBatch.cls


======================================================
======================================================
History
------- 
Ver. Author            Date        Detail
1.0  Sylvain Picory    2017-05-26  Initial draft of code.
*/
@isTest
private class TransactionRecordsDeletionBatchTest {
	@isTest static void batchTest() {
        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testDS01 = CompaniesHouseTestData.getInstance().testDS01;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        Contact testContact = CompaniesHouseTestData.getInstance().contact1;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.Transaction_Type__c = 'SH10';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = false;
        transac.isMajorityRequired__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        transac.isBehalfSignatoryEnable__c = true;
        transac.OfficerCount__c = 1;
        transac.CreatedDateUnitTest__c = system.today().addMonths(-13);
        insert transac;

        Attachment testAttachment = new Attachment();
        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        testAttachment.parentId = transac.id;
        testAttachment.description = 'testDescription';
        testAttachment.Name = 'SH10';
        testAttachment.body = testpdfBlob;
        insert testAttachment;

        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.name = 'testfirstname';
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = false;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatoryBehalf__c = true;
        testoff.isSignatory__c = true;
        insert testoff;

        dsfs__DocuSign_Status__c testDoc = new dsfs__DocuSign_Status__c();
        testDoc.Transaction__c = transac.Id;
        insert testDoc;

        Test.startTest();

        Database.executeBatch(new TransactionRecordsDeletionBatch());

        Test.stopTest();

        Decimal count = (Decimal)[Select count(Id) total From Transaction__c ][0].get('total');

        system.assertEquals(0, count);

        count = (Decimal)[Select count(Id) total From dsfs__DocuSign_Status__c ][0].get('total');

        system.assertEquals(0, count);

        count = (Decimal)[Select count(Id) total From Attachment ][0].get('total');

        system.assertEquals(0, count);

        count = (Decimal)[Select count(Id) total From Contact ][0].get('total');

        system.assertEquals(0, count);

        count = (Decimal)[Select count(Id) total From Account ][0].get('total');

        system.assertEquals(0, count);

    }

    @isTest static void batchTest2() {
        RetentionSettings__c testCustomSetting = new RetentionSettings__c();
        testCustomSetting.RetentionPeriodMonths__c = 4;

        insert testCustomSetting;

        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testDS01 = CompaniesHouseTestData.getInstance().testDS01;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        Contact testContact = CompaniesHouseTestData.getInstance().contact1;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.Transaction_Type__c = 'SH10';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = false;
        transac.isMajorityRequired__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        transac.isBehalfSignatoryEnable__c = true;
        transac.OfficerCount__c = 1;
        transac.CreatedDateUnitTest__c = system.today().addMonths(-13);
        insert transac;

        Attachment testAttachment = new Attachment();
        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        testAttachment.parentId = transac.id;
        testAttachment.description = 'testDescription';
        testAttachment.Name = 'SH10';
        testAttachment.body = testpdfBlob;
        insert testAttachment;

        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.name = 'testfirstname';
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = false;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatoryBehalf__c = true;
        testoff.isSignatory__c = true;
        insert testoff;

        dsfs__DocuSign_Status__c testDoc = new dsfs__DocuSign_Status__c();
        testDoc.Transaction__c = transac.Id;
        insert testDoc;

        Test.startTest();

        Database.executeBatch(new TransactionRecordsDeletionBatch());

        Test.stopTest();

        Decimal count = (Decimal)[Select count(Id) total From Transaction__c ][0].get('total');

        system.assertEquals(0, count);

        count = (Decimal)[Select count(Id) total From dsfs__DocuSign_Status__c ][0].get('total');

        system.assertEquals(0, count);

        count = (Decimal)[Select count(Id) total From Attachment ][0].get('total');

        system.assertEquals(0, count);

        count = (Decimal)[Select count(Id) total From Contact ][0].get('total');

        system.assertEquals(0, count);

        count = (Decimal)[Select count(Id) total From Account ][0].get('total');

        system.assertEquals(0, count);

    }

    @isTest static void batchTest3() {
        RetentionSettings__c testCustomSetting = new RetentionSettings__c();
        testCustomSetting.RetentionPeriodMonths__c = 4;

        insert testCustomSetting;
        
        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testDS01 = CompaniesHouseTestData.getInstance().testDS01;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;
        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        Contact testContact = CompaniesHouseTestData.getInstance().contact1;
        insert testPresenter;

        insert testCompany;
        Transaction__c transac = testData.tx;
        transac.Transaction_Type__c = 'SH10';
        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;
        transac.CompanyNumber__c = '05448736';
        transac.finishedAttachments__c = true;
        transac.finishedAddingShares__c = true;
        transac.isDigitalSignatureNeeded__c = true;
        transac.isSigningFinished__c = false;
        transac.SoleDirectorPresenter__c = false;
        transac.isMajorityRequired__c = true;
        transac.isPresenterMultipleDirectors__c = true;
        transac.isBehalfSignatoryEnable__c = true;
        transac.OfficerCount__c = 1;
        transac.CreatedDateUnitTest__c = system.today().addMonths(-2);
        insert transac;

        Attachment testAttachment = new Attachment();
        Blob testpdfBlob;
        testpdfBlob = Blob.valueOf('This is a test');
        testAttachment.parentId = transac.id;
        testAttachment.description = 'testDescription';
        testAttachment.Name = 'SH10';
        testAttachment.body = testpdfBlob;
        insert testAttachment;

        testContact.Transaction__c = transac.id;
        insert testContact;
        Officer__c testoff = new Officer__c();
        testoff.name = 'testfirstname';
        testoff.Surname__c = 'testsurname';
        testoff.Forename__c = 'testforename';
        testoff.Middlenames__c = 'testmiddlename';
        testoff.Email__c = 'testEmail@testemail.com';
        testoff.IsPresenter__c = false;
        testoff.Transaction__c = transac.Id;
        testoff.Contact__c = testContact.id;
        testoff.isSignatoryBehalf__c = true;
        testoff.isSignatory__c = true;
        insert testoff;

        dsfs__DocuSign_Status__c testDoc = new dsfs__DocuSign_Status__c();
        testDoc.Transaction__c = transac.Id;
        insert testDoc;

        Test.startTest();

        Database.executeBatch(new TransactionRecordsDeletionBatch());

        Test.stopTest();

        Decimal count = (Decimal)[Select count(Id) total From Transaction__c ][0].get('total');

        system.assertEquals(1, count);

        count = (Decimal)[Select count(Id) total From dsfs__DocuSign_Status__c ][0].get('total');

        system.assertEquals(1, count);

        count = (Decimal)[Select count(Id) total From Attachment ][0].get('total');

        system.assertEquals(1, count);

        count = (Decimal)[Select count(Id) total From Contact ][0].get('total');

        system.assertEquals(1, count);

        count = (Decimal)[Select count(Id) total From Account ][0].get('total');

        system.assertEquals(1, count);

    }
}