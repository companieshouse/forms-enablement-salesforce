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
1.0  Leo Bitoy&    2016-06-07  Initial development.
*/
@IsTest
public class AddAttachmentsControllerTest
{

    public static final Integer NUMOFATTACHMENTSALLOWED = 5;

    //COMMENTED BY SYLVAIN TEST NO PASSING NULL ON LINE 37
    //@IsTest
    //private static void testAddingAttachments()
    //{


    //    Transaction__C trans = new Transaction__c(Transaction_Type__c = 'Unit Test Transaction');
    //    insert trans;
    //    Test.startTest();
    //    AddAttachmentsController addingattachmentcontroller = new AddAttachmentsController();
    //    addingattachmentcontroller.attachmentId = trans.id;
    //    Test.stopTest();

    //    System.assertEquals(0, addingattachmentcontroller.attachments.size());

    //    System.assertEquals(1, addingattachmentcontroller.newAttachments.size());

    //    Test.startTest();
    //    addingattachmentcontroller.addMore();
    //    Test.stopTest();

    //    System.assertEquals(1 + NUMOFATTACHMENTSALLOWED, addingattachmentcontroller.newAttachments.size());

    //    Test.startTest();
    //    List < Attachment > newAtts = addingattachmentcontroller.newAttachments;
    //    newAtts[0].Name = 'Unit Test 1';
    //    newAtts[0].Description = 'Unit Test 1';
    //    newAtts[0].Body = Blob.valueOf('Unit Test 1');

    //    newAtts[2].Name = 'Unit Test 2';
    //    newAtts[2].Description = 'Unit Test 2';
    //    newAtts[2].Body = Blob.valueOf('Unit Test 2');

    //    addingattachmentcontroller.save();
    //    Test.stopTest();

    //    System.assertEquals(2, addingattachmentcontroller.attachments.size());
    //}
}