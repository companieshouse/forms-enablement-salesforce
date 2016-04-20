public with sharing class OfficersQueryAction {
/**
 * This class get active Company Officers from Companies House API. Using CH_SearchControllerByOfficerListClass 
 * with company Number, create Officers records and return a string to show on Flow.
 *
 * Condiction: 
 * - active Officer;
 * - with Director role;
 * 
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/

    @InvocableMethod(label='Get Officer Names' description='This method use CH_SearchControllerByOfficerListClass to get Officers with Director Role.')
    public static List<String> getOfficers(List<String> inputList) {

        String officersString ='';
        String companyNumber;
        String transactionId;
        List<String> officerList = new List<String>();
        List<CompaniesHouse.OfficerDetails> directorDetailsList;
        List<Officer__c> officersToInsert = new List<Officer__c>();

        //get input parameters - recordID
        transactionId = inputList.get(0);
        
        //get company number
        Transaction__c trans = [Select Id, CompanyNumber__c from Transaction__c where Id = :transactionId limit 1];
        companyNumber = trans.CompanyNumber__c;


        //api class to get Officers info from Companies House
        CH_SearchControllerByOfficerListClass req = new CH_SearchControllerByOfficerListClass();
        req.CH_searchTextNumber = companyNumber;
        req.get_CH_Search_functionByOfficerList();

        directorDetailsList = req.itemsToDisplay;


        for(CompaniesHouse.OfficerDetails officer : directorDetailsList){
        	if(officer.officer_role == 'director' && (officer.resigned_on == null || officer.resigned_on > date.today()))
        		officersString += officer.name + '\n';
               
                Officer__c off = new Officer__c();
                off.Name = officer.name;
                off.transaction__c = transactionId;
                officersToInsert.add(off);
        }

        if(!officersToInsert.isEmpty())
            insert officersToInsert;

        //prepare result to return
        officerList.add(officersString);
        
        return officerList;
    }

    //Method to get a list of officers from the API
    public static List<CompaniesHouse.OfficerDetails> getOfficers(String companyNumber) {
        List<CompaniesHouse.OfficerDetails> directorDetailsList;

        //api class to get Officers info from Companies House
        CH_SearchControllerByOfficerListClass req = new CH_SearchControllerByOfficerListClass();
        req.CH_searchTextNumber = companyNumber;
        req.get_CH_Search_functionByOfficerList();

        directorDetailsList = req.itemsToDisplay;

        return directorDetailsList;

    }

}