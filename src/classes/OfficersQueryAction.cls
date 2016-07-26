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