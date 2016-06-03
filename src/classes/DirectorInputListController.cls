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

    public Boolean hasPageErrorsDirector { get; set; }
    public Boolean hasPageErrorsEmail {get; set;}
    public Boolean hasPageErrorsCorrectEmails {get; set;}

    public String companyName {get; set;}
    public String companyNumber {get; set;}
    public List<officerContainer> listOfDirectors {get; set;}
    public Integer nbOfOfficers {get; set;}
    public Integer requiredSignature {get; set;}
    public String emails {get; set;}
    public Id selectedId {get; set;}
    public String selectedStatus {get; set;}
    public Id selectIdStatus {get; set;}
	public Boolean isLLPCompany {get; set;}


    public DirectorInputListController(){
        super();
        if (isPageInitialised) initialiseStep();

    }
    
    public void initialiseStep() {
        
        //Set up the company name
        companyName = submissionMgr.submission.CompanyName__c;
        companyNumber = submissionMgr.submission.CompanyNumber__c;
		isLLPCompany = submissionMgr.submission.isLLP__c;
        requiredSignature = Integer.valueOf(submissionMgr.submission.RequiredOfficerSign__c);
        listOfDirectors = new List<officerContainer>();
        selectedStatus = '';
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
                    off.isDeceased__c = offCont.deceased;
                    off.isCorporateDirector__c = offCont.corp;
                    off.isPowerOfAttorney__c = offCont.poa;
                    off.AuthorizedSigner__c = offCont.authName;
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

    public Boolean hasEmailWithoutSignatory(String email){
        if(!String.isBlank(email))
            return true;
        

        return false;
    }

    public Boolean isEmailCorrectFormat(String email){
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; // source: http://www.regular-expressions.info/email.html
        Pattern MyPattern = Pattern.compile(emailRegex);
        
        Matcher MyMatcher = MyPattern.matcher(email);
        if (!MyMatcher.matches()) 
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
                hasPageErrorsDirector = true;
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
                if(off.isSignatory)
                    off.isSignatory = false;
                else
                    off.isSignatory = true;
                break;
            }
        }
    }

    public Boolean isNameError {get; set;}

    public Boolean isNamePopulated(officerContainer off, String nameAuth){
        if(!off.deceased && !off.corp && !off.poa)
            return true;
        if((off.deceased || off.corp || off.poa) && !String.isBlank(nameAuth))
            return true;
        return false;
    }

    public PageReference updateEmails(){
        hasPageErrorsEmail = false;
        isNameError = false;
        hasPageErrorsDirector = false;
        hasPageErrorsCorrectEmails = false;

        emails = emails.substringAfter('|');
        List<String> firstSplit = emails.split(AppConstants.ID_DELIM_SPLIT_CHAR);

        for(String word :firstSplit)
        {
            List<String> split = word.split(AppConstants.DELIM_HISTORICAL_STEP);
            for(officerContainer off :listOfDirectors)
            {
                if(String.valueOf(off.officer.Id) == split[0])
                {
                    
                    if(off.isSignatory )
                    {
                        if(split.size() != 3)
                        {
                            hasPageErrorsCorrectEmails = true;
                            return null;
                        }
                        if(!isEmailCorrectFormat(split[2]))
                        {
                            hasPageErrorsCorrectEmails = true;
                            return null;
                        }       
                        if(!isNamePopulated(off, split[1]))
                        {
                            isNameError = true;
                            return null;
                        }
                        off.authName = split[1];
                        off.email = split[2];
                    }
                    else
                    {
                        if(split.size()>=2)
                            if(hasEmailWithoutSignatory(split[2]))
                            {
                                hasPageErrorsEmail = true;
                                return null;
                            }
                    }
                }
                    
            }
        }

        return nextAction();
    }

    public void updateStatusBehalf()
    {

        if(selectedStatus == null)
            return;

        if(selectedStatus == '')
            return;

        if(selectIdStatus == null)
            return;

        for(officerContainer off :listOfDirectors)
        {
            if((String.valueOf(off.officer.Id) == selectIdStatus))
            {
                if(selectedStatus == 'Deceased'){
                    off.deceased = true;
                }
                else if(selectedStatus == 'Corporate'){
                    off.corp = true;
                }
                else if(selectedStatus == 'Power of Attorney'){
                    off.poa = true;
                }
                else if(selectedStatus == 'None')
                {
                    off.deceased = false;
                    off.corp = false;
                    off.poa = false;
                }
            }

        }
    }


    public with sharing class officerContainer{

        public Officer__c officer {get; set;}
        public String officerTXT {get; set;}
        public Boolean isPresenter {get; set;}
        public String email {get; set;}
        public Boolean isSignatory {get; set;}
        public String authName {get; set;}
        public Boolean deceased {get; set;}
        public Boolean corp {get; set;}
        public Boolean poa {get; set;}

        public officerContainer(Officer__c off)
        {
            officer = off;
            officerTXT = off.Name;
            email = off.Email__c;
            authName = off.AuthorizedSigner__c;
            deceased = (off.isDeceased__c == null ? false : off.isDeceased__c);
            corp = (off.isCorporateDirector__c == null ? false : off.isCorporateDirector__c);
            poa = (off.isPowerOfAttorney__c == null ? false : off.isPowerOfAttorney__c);
            isPresenter = (off.isPresenter__c == null ? false : off.isPresenter__c);
            isSignatory = (off.isSignatory__c == null ? false : off.isSignatory__c);
        }
    }
}