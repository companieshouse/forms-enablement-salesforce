public with sharing class CompanyQueryAction {
	//Method to get a company information from the API
    public static CompaniesHouse.CompanyProfile getCompanyInfo(String companyNumber) {

    	CompaniesHouse.CompanyProfile compProf;


        //api class to get company info info from Companies House
        CH_SearchControllerByNumberClass req = new CH_SearchControllerByNumberClass();
        req.CH_searchTextNumber = companyNumber;
        req.CH_Search_functionByNumber();

        compProf = req.CH_companydetails;

        return compProf;

    }
}