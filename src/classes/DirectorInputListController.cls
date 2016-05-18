/*
Name:  DirectorsInputListController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: DirectorsInputList

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-02-04  Initial development.
*/
public with sharing class DirectorInputListController extends TransactionStepControllerBase {

    public Boolean hasPageErrors { get; set; }

    public String companyName {get; set;}
    public String companyNumber {get; set;}
    public List<officerContainer> listOfDirectors {get; set;}
    public Integer nbOfOfficers {get; set;}
    public Integer requiredSignature {get; set;}
    public String emails {get; set;}
    public Id selectedId {get; set;}


    public DirectorInputListController(){
        super();
        if (isPageInitialised) initialiseStep();

    }
    
    public void initialiseStep() {
        
        //Set up the company name
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        requiredSignature = Integer.valueOf(submissionMgr.submission.RequiredOfficerSign__c);
        listOfDirectors = new List<officerContainer>();
        emails = '';
        return;
       
    }

    private void persistStep(){
        for(Officer__c off :submissionMgr.submission.Officers__r)
        {
            for(officerContainer offCont :listOfDirectors)
            {
                if(off.Id == offCont.officer.Id)
                {
                    off.Email__c = offCont.email;
                    off.isSignatory__c = offCont.isSignatory;
                }
            }
        }
        submissionMgr.persist();    
    }
    // End Instance methods.    
    
    public Boolean isSignatureNumberOK()
    {   
        Integer i = 0;

        for(Officer__c off :submissionMgr.submission.Officers__r)
        {
            if(off.isPresenter__c)
            {
                if(off.isSignatory__c)
                {
                    i++;
                }
            }
        }

        for(officerContainer offCont  :listOfDirectors ) 
        {
            if(offCont.isSignatory)
                i++;
        }

        if(requiredSignature > i)
            return false;

        return true;
    }

    // Action methods.     
    public PageReference nextAction(){

        
        if (!validatePageState()) return Page.TransactionException;

        if(submissionMgr.submission.isMajorityRequired__c)
        {

            if(!isSignatureNumberOK())
            {
                //TODO :show and error
                return null;
            }

            
        }
        
        persistStep();

        return nextStep();      
    }
    
    public PageReference previousAction(){
        if (!validatePageState()) return Page.TransactionException;
                
        return previousStep();
    }

    public PageReference populateDirectorList(){
        initialiseAction();
        
        //Get the list officer already created
        if(submissionMgr.submission.Officers__r != null)
        {
            if(submissionMgr.submission.Officers__r.size() > 0)
            {
                for(Officer__c off :submissionMgr.submission.Officers__r)
                {
                    if(!off.isPresenter__c)
                        listOfDirectors.add(new officerContainer(off));
                }
            }
        }
        //If my list is empty there is only on director so we shoudn't call this page...
        if(listOfDirectors.isEmpty())
        {
            return nextAction();
        }

        return null;
    }

    

    public void updateSignatory()
    {
        if(selectedId == null)
            return;

        for(officerContainer off :listOfDirectors)
        {
            if(off.officer.Id == selectedId)
            {
                off.isSignatory = true;
                break;
            }
        }
    }

    public PageReference updateEmails(){

        if(emails == null)
            return null;

        if(emails == '')
            return null;
        emails = emails.substringAfter('|');
        List<String> firstSplit = emails.split(AppConstants.ID_DELIM_SPLIT_CHAR);

        for(String word :firstSplit)
        {
            List<String> split = word.split(AppConstants.DELIM_HISTORICAL_STEP);

            for(officerContainer off :listOfDirectors)
            {
                if(off.isSignatory && (String.valueOf(off.officer.Id) == split[0]))
                {
                    off.email = split[1];
                }
            }
        }
        return nextAction();
    }

    public with sharing class officerContainer{

        public Officer__c officer {get; set;}
        public String officerTXT {get; set;}
        public Boolean isPresenter {get; set;}
        public String email {get; set;}
        public Boolean isSignatory {get; set;}

        public officerContainer(Officer__c off)
        {
            officer = off;
            officerTXT = off.Name;
            email = off.Email__c;
            isPresenter = (off.isPresenter__c == null ? false : off.isPresenter__c);
            isSignatory = (off.isSignatory__c == null ? false : off.isSignatory__c);
        }
    }
}