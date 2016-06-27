/*
Name:  AddAttachments.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: AddAttachment

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy&    2016-06-07  Initial development.
note: attachment size limited to 5MB
*/
public class AddAttachmentsController extends TransactionStepControllerBase
{

    public Boolean hasPageErrors
    {
        get;
        set;
    }

    public Boolean showTable
    {
        get;
        set;
    }

    public List < Attachment > attachments
    {
        get;
        set;
    }
    public List < Attachment > newAttachments
    {
        get;
        set;
    }


    public String companyName
    {
        get;
        set;
    }
    public String companyNumber
    {
        get;
        set;
    }
    public String presenterEmail
    {
        get;
        set;
    }
    public String presenterName
    {
        get;
        set;
    }
    public String presenterPhone
    {
        get;
        set;
    }
    public String attachmentDescription
    {
        get;
        set;
    }
    public Id attachmentId
    {
        get;
        set;
    }
    public String attachmentName
    {
        get;
        set;
    }
    public String currentErrors
    {
        get;
        set;
    }

    public static final Integer NUMOFATTACHMENTSALLOWED = 1;


    public AddAttachmentsController()
        {

            super();
            if (isPageInitialised) initialiseStep();
        }

    private void initialiseStep()
    {

        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.Name;
        presenterName = submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c;
        //attachments = submissionMgr.submission.Attachments;
        attachmentId = submissionMgr.submission.Id;
        //if(submissionMgr.submission.Attachments.size() > 0){
        attachments = submissionMgr.submission.Attachments;
        //}
        newAttachments = new List < Attachment >
        {
            new Attachment()
        }; 

        return;
    }

    public void addMore()
    {
        for (Integer idx = 0; idx < NUMOFATTACHMENTSALLOWED; idx++)
        {
            newAttachments.add(new Attachment());
        }
    }

    public void remove()
    {

        newAttachments.remove(0);
    }

    public void DeleteAttachments(){

        
    }

    public PageReference save()
    {
        List < Attachment > toInsert = new List < Attachment > ();
        for (Attachment newAtt: newAttachments)
        {
            if (newAtt.Body != null)
            {
                newAtt.parentId = attachmentId;
                toInsert.add(newAtt);
            }
        }

        insert toInsert;
        newAttachments.clear();
        newAttachments.add(new Attachment());

        attachments = null;

        PageReference pg = new PageReference('/Attachments');
        pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
        pg.setRedirect(true);

        
        return pg;
    }

    

    private void persistStep()
    {
        submissionMgr.persist();
    }


    public PageReference nextAction()
    {

        if (!validatePageState()) return Page.TransactionException;

        persistStep();

        return nextStep();
    }

    public PageReference previousAction()
    {

        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }


}