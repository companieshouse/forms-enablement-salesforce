/**
 * Custom controller used to manipulate the Form
 *
 * Author: sylvain.picory@methodsdigital.co.uk
 */
public with sharing class Form_DS0Controller{

    //This control the flow between starting point and end point
    public Integer nbOfPages {get; set;}
    public Integer currentPage {get; set;}

    //Boolean as checkbox in the page
    public Boolean warningAgreeBox {get; set;}
    public Integer directorsValidationBox {get; set;}

    public List<String> listOfDirectors {get; set;}

    public Map<String, String> mapURLParameters {get; set;}

    public Transaction__c currentTransaction {get; set;}

    //Constructor of the page
    public Form_DS0Controller() {
        

    }

    public void extractURLParameters(){

        //Method used to extract paramaters from the URL
        //
        PageReference currentP =  ApexPages.currentPage();
        //currentP.getParameters().put('tid', 'a034E000000pfLL');


        //As soon as we start we need to save the record if no transaction id found or get the current transaction
        //
        if(currentP.getParameters().get('tid') == null)
        {
            currentTransaction = new Transaction__c();
            Id transactionID  = this.saveTransaction();
            currentTransaction.Id = transactionID;
        }   
        else
        {
            currentTransaction = getTransaction(currentP.getParameters().get('tid'));
        }


        mapURLParameters = new Map<String, String>();
        

        //Code logic for Page 0
        if(currentP.getParameters().get('currentPage') == null)
        {
            //Init for page 0
            currentPage = 0;
            nbOfPages = 3;
            warningAgreeBox = false;
            directorsValidationBox = 0;

            //Current page when loaded
            currentTransaction.CompanyNumber__c = currentP.getParameters().get('companynumber');
            
            //Prepare environment for next page
            mapURLParameters.put('currentPage', '0');
            mapURLParameters.put('tid', currentTransaction.Id);
            mapURLParameters.put('NextPage', 'Form_DS0Page1');
            mapURLParameters.put('PreviousPage', null);
            mapURLParameters.put('nbOfPages', '3');
            mapURLParameters.put('warningAgreeBox', 'false');
            mapURLParameters.put('directorsValidationBox', '0');

        }
        else
        {
            //Current page when loaded
            String extractedCurrentPage = currentP.getParameters().get('currentPage');

            //Max number of pages
            String extractedNbOfPages = currentP.getParameters().get('nbOfPages');

            //Warning agreement box
            String extractedWarningAgreeBox = currentP.getParameters().get('warningAgreeBox');

            //Directors lst is correct
            String extractedDirectorsValidationBox = currentP.getParameters().get('directorsValidationBox');

            //Checks if null values and convert if needed
            if(extractedCurrentPage != null)
            {
                currentPage = Integer.valueOf(extractedCurrentPage);

            }

            if(extractedNbOfPages != null)
            {
                nbOfPages = Integer.valueOf(extractedNbOfPages);

            }

            if(extractedWarningAgreeBox != null)
            {
                warningAgreeBox = Boolean.valueOf(extractedWarningAgreeBox);

            }
            
            if(extractedDirectorsValidationBox != null)
            {
                directorsValidationBox = Integer.valueOf(extractedDirectorsValidationBox);

            }

            //Set THE MAP FOR THE NEXT ITERATION IF THE PAGE LOAD = IF NEXT PRESSED
            if(currentPage == 1)
            {
                //Prepare environment for next page
                mapURLParameters.put('currentPage', '1'); //can t set the value yet as we have next and previous
                mapURLParameters.put('NextPage', 'Form_DS0Page2');
                mapURLParameters.put('PreviousPage', 'Form_DS0Page1');
                mapURLParameters.put('nbOfPages', '3');
                mapURLParameters.put('warningAgreeBox', 'false');
                mapURLParameters.put('directorsValidationBox', '0');
                mapURLParameters.put('tid', currentTransaction.Id);


            }

            if(currentPage == 2)
            {
                listOfDirectors = new List<String>();
                
                //Make the call to the list of directors
                List<CompaniesHouse.OfficerDetails> directorDetailsList = OfficersQueryAction.getOfficers(currentTransaction.CompanyNumber__c);

                List<Officer__c> officerList = new List<Officer__c>();

                //We want only director that haven't resign and or will resign in futur 
                for(CompaniesHouse.OfficerDetails officer : directorDetailsList){
                    if(officer.officer_role == 'director' && (officer.resigned_on == null || officer.resigned_on > date.today()))
                    {
                        listOfDirectors.add(officer.name);
                        //Temporary save an address email against each officer and save officer to the transaction
                        officerList.add(new Officer__c(Name= officer.name, Email__c = 'sylvain.picory@methodsdigital.co.uk' , Transaction__c =currentTransaction.Id ));

                    }
                }

                //Insert the officer
                insert officerList;



                //listOfDirectors.add('BASTIAN, Edward Herman');
                //listOfDirectors.add('BRANSON, Richard Charles Nicholas, Sir');
                //listOfDirectors.add('HAUENSTEIN, Glen William');
                //listOfDirectors.add('JAMES, Dwight Lamar');
                //listOfDirectors.add('KREEGER, Craig Stuart');
                //listOfDirectors.add('MCCALLUM, Gordon Douglas');
                //listOfDirectors.add('NORRIS, Peter Michael Russell');
                //listOfDirectors.add('PIEPER, Nathaniel Joseph Wenzil');
                //listOfDirectors.add('WEISS, Shai Joseph');
                //listOfDirectors.add('WOODS, Ian Philip');
                
                //Prepare environment for next page
                mapURLParameters.put('currentPage', '2'); //can t set the value yet as we have next and previous
                mapURLParameters.put('NextPage', 'EmbedDocuSign');
                mapURLParameters.put('PreviousPage', 'Form_DS0Page1');
                mapURLParameters.put('nbOfPages', '3');
                mapURLParameters.put('warningAgreeBox', 'false');
                mapURLParameters.put('directorsValidationBox', '0');
                mapURLParameters.put('tid', currentTransaction.Id);


            }

            if(currentPage == 3)
            {
                
                //Prepare environment for next page
                mapURLParameters.put('currentPage', '3'); //can t set the value yet as we have next and previous
                mapURLParameters.put('NextPage', 'Form_DS0Page0');
                mapURLParameters.put('PreviousPage', 'Form_DS0Page2');
                mapURLParameters.put('nbOfPages', '3');
                mapURLParameters.put('warningAgreeBox', 'false');
                mapURLParameters.put('directorsValidationBox', '1');
                mapURLParameters.put('tid', currentTransaction.Id);

            }

        }

        
    }

    //Save or next do the same
    public PageReference save(){

        String agreeBox = 'warningAgreeBox=false';

        //Extra param
        //
        String extraParam = '';
        
        if(mapURLParameters.get('currentPage') == '0')
        {
            //Make the API call for the company name
            CompaniesHouse.CompanyProfile compProf = CompanyQueryAction.getCompanyInfo(currentTransaction.CompanyNumber__c);

            currentTransaction.CompanyName__c = compProf.company_name;

            mapURLParameters.put('currentPage', '1'); //We set the next current page 
        }

        
        else if(mapURLParameters.get('currentPage') == '1')
        {
            if(!warningAgreeBox )
            {
                return previousPage();
                
            }
            else
            {
                mapURLParameters.put('currentPage', '2'); //We set the next current page 
                agreeBox = 'warningAgreeBox=true';

            }
        }


        else if(mapURLParameters.get('currentPage') == '2')
        {
            if(directorsValidationBox == 1)
            {
                return previousPage();
            }
            else if(directorsValidationBox == 2)
            {

                extraParam += '&Id=' + mapURLParameters.get('tid');
                 
            }
        }

        //Extract the URL and return it
        String retURL = '/apex/' + mapURLParameters.get('NextPage') + '?' + 'currentPage=' +mapURLParameters.get('currentPage') + '&';

        
        retURL += agreeBox;
        

        retURL += '&nbOfPages=' + mapURLParameters.get('nbOfPages');
        retURL += '&directorsValidationBox=' + mapURLParameters.get('directorsValidationBox');         
        retURL += '&tid=' + mapURLParameters.get('tid');         
        retURL += extraParam;


        PageReference pg =  new PageReference(retURL);
        pg.setRedirect(true);

        this.updateTransaction();
        return pg;

    }


    public PageReference previousPage(){

        String agreeBox = 'warningAgreeBox=false';
        String directorsBox = '&directorsValidationBox=' + mapURLParameters.get('directorsValidationBox'); 

        if(mapURLParameters.get('currentPage') == '0')
        {
            mapURLParameters.put('currentPage', '1'); //We set the next current page 
        }
        
        else if(mapURLParameters.get('currentPage') == '1')
        {
            
            mapURLParameters.put('currentPage', '1'); //We set the next current page 
            
        }

        else if(mapURLParameters.get('currentPage') == '2')
        {
            mapURLParameters.put('currentPage', '3'); //We set the next current page
            directorsBox = '&directorsValidationBox=' + directorsValidationBox; 
        }

        else if(mapURLParameters.get('currentPage') == '3')
        {
            directorsBox = '&directorsValidationBox=' + directorsValidationBox;
            mapURLParameters.put('currentPage', '2');

        }
        //Extract the URL and return it
        String retURL = '/apex/' + mapURLParameters.get('PreviousPage') + '?' + 'currentPage=' +mapURLParameters.get('currentPage') + '&';

        
        retURL += agreeBox;
        retURL += '&nbOfPages=' + mapURLParameters.get('nbOfPages');
        retURL += directorsBox;         
        retURL += '&tid=' + mapURLParameters.get('tid');         

        PageReference pg =  new PageReference(retURL);
        pg.setRedirect(true);
        this.updateTransaction();

        return pg;
    }

    public void clickBox()
    {
        if(!warningAgreeBox)
            warningAgreeBox = true;
        else
            warningAgreeBox = false;
    }

    public void updateController(){
    }

    public Id saveTransaction()
    {
        currentTransaction.Amount__c = 10;
        currentTransaction.Status__c = 'In Progress';
        currentTransaction.Form_Name__c = 'DS01';
        insert currentTransaction;
        return currentTransaction.Id;
    }

    public void updateTransaction()
    {
        update currentTransaction;
    }

    public Transaction__c getTransaction(Id transactionId)
    {
        return [Select Id, Amount__c, CompanyName__c, CompanyNumber__c, Status__c, SubmissionId__c From Transaction__c Where Id = :transactionId];
    }

}