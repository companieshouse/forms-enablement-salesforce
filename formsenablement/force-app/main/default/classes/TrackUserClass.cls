public class TrackUserClass {

    // Public properties.

    public String userEmail;
    public String companySearched;
    //public Cookie t_value { get; set; }
    String tvalueparameter;
    public TrackUserClass() {

    }

    Public String saveUserDocumentInfo() {

        String tvalueparameter = ApexPages.currentPage().getParameters().get('t');

        Cookie t_value = new Cookie('t_value', SecurityManager.encryptText(tvalueparameter), null, 0, true);

        t_value = new Cookie('t_value', SecurityManager.encryptText(tvalueparameter), null, -1, true);

        Cookie d_valueCookieStatus = new Cookie('d_valueCookieStatus', SecurityManager.encryptText('initial'), null, -1, true);
        List<Cookie> col = new List<Cookie>();
        
        
        col.add(t_value);
        col.add(d_valueCookieStatus);
        //system.debug('SYLVAINBEFORE' + ApexPages.currentPage().getCookies());
        ApexPages.currentPage().setCookies(col);
        //system.debug('SYLVAINAFTER' + ApexPages.currentPage().getCookies());
        return tvalueparameter;
    }

    Public Boolean GuidanceAgreeBox() {

        Cookie agreebox = ApexPages.currentPage().getCookies().get('agreebox');

        if (agreebox == null) return false;

        String warningboxvalue = SecurityManager.decryptText(agreebox.getValue());
        return Boolean.valueOf(warningboxvalue);
    }


    Public Boolean setBooleanGuidanceAgreeBox(Boolean warningboxvalue) {
        String warningboxvaluetext = String.valueOf(warningboxvalue);
        // pull agree box value on guidance page
        Cookie agreebox = new Cookie('agreebox', SecurityManager.encryptText(warningboxvaluetext), null, -1, true);

        ApexPages.currentPage().setCookies(new Cookie[] { agreebox });

        return Boolean.valueOf(warningboxvaluetext);
    }

    Public Boolean setStringGuidanceAgreeBox(String warningboxvalue) {
        String warningboxvaluetext = String.valueOf(warningboxvalue);
        // pull agree box value on guidance page
        Cookie agreebox = new Cookie('agreebox', SecurityManager.encryptText(warningboxvaluetext), null, -1, true);

        ApexPages.currentPage().setCookies(new Cookie[] { agreebox });

        return Boolean.valueOf(warningboxvaluetext);
    }

    //Public String setGuidanceAgreeBox(String warningboxvalue) {
    //    //String warningboxvaluetext = String.valueOf(warningboxvalue);
    //            String warningboxvaluetext = warningboxvalue;

    //    // pull agree box value on guidance page
    //    Cookie agreebox = new Cookie('agreebox', SecurityManager.encryptText(warningboxvaluetext), null, -1, true);

    //    ApexPages.currentPage().setCookies(new Cookie[] { agreebox });

    //    return warningboxvaluetext;
    //}



    Public String getUserDocument() {
        //system.debug('SYLVAINBEFORE' + ApexPages.currentPage().getCookies());

        Cookie cookiet_value = ApexPages.currentPage().getCookies().get('t_value');

        return SecurityManager.decryptText(cookiet_value.getValue());
        return tvalueparameter;

    }

    Public String getSearchedCompany(String companyNumber) {

        Cookie searched_company = ApexPages.currentPage().getCookies().get('searched_company');

        // note remove if/else statement and uncomment cookie reset parameter

        //if (searched_company == null) {
        Account acc = new Account();
        //Do an API call to get the company name
        if (Test.isRunningTest()) {
            companyNumber = '12345678';
            acc.Name = 'testName';
        } else {
            CompaniesHouse.CompanyProfile compProf = CompanyQueryAction.getCompanyInfo(companyNumber);
            acc.Name = compProf.company_name;
        }
        acc.AccountNumber = companyNumber;
        acc.CompanyNumber__c = companyNumber;
        Schema.SObjectField f = Account.Fields.CompanyNumber__c;
        Database.UpsertResult cr = Database.upsert(acc, f, false);
        // for testing
        //companyNumber = null;
        // this will be initialized on  the company controller
        String companysearchparameter = companyNumber; // this should be the searched company//ApexPages.currentPage().getParameters().get('t');

        // searched_company = new Cookie('searched_company', SecurityManager.encryptText(companysearchparameter), null, 1, true);

        searched_company = new Cookie('searched_company', SecurityManager.encryptText(companysearchparameter), null, -1, true);
        // set time to 0 instead of -1 to remove cookie

        ApexPages.currentPage().setCookies(new Cookie[] { searched_company });

        System.debug('your newly created searched company is is' + searched_company);

        //} else {
        // perhaps validate the value before returning cookie

        System.debug('your searched_company from your cookie is' + searched_company);

        // increment time of cookie from -1 to 600s seconds/etc.
        // }

        String s = SecurityManager.decryptText(searched_company.getValue());

        return s;
    }

    Public Sobject returnCurrentCompanyObject() {
        Cookie current_searchedCompany = ApexPages.currentPage().getCookies().get('searched_company');
        String searchedCompany = SecurityManager.decryptText(current_searchedCompany.getValue());
        List < Account > recs = [select Id, Name, AccountNumber, CompanyNumber__c from Account where CompanyNumber__c = : searchedCompany];

        return recs[0];

    }

    Public SObject returnCurrentUser() {
        System.debug(LoggingLevel.ERROR, 'Get current user');
        Cookie current_userEmail = ApexPages.currentPage().getCookies().get('user_Email');
        System.debug(LoggingLevel.ERROR, 'User EMAIL:' + current_userEmail);
        //   throw new AccountsAuthCallbackException('presenter info' + presenterInfo);

        String userNameEmail = SecurityManager.decryptText(current_userEmail.getValue());
        List < Account > recs = [select Id, Name, PersonEmail from Account where PersonEmail = : userNameEmail];

        return recs[0];
    }

    Public String getCurrentUser(String userEmail) {

        Cookie current_userEmail = ApexPages.currentPage().getCookies().get('user_Email');

        // if (current_userEmail == null) {

        //  pass userprofile information
        String usersearchparameter = userEmail; // this should be the user email from the apiresponse.email method

        current_userEmail = new Cookie('user_Email', SecurityManager.encryptText(usersearchparameter), null, -1, true);
        // set time to 0 instead of -1 to remove cookie

        ApexPages.currentPage().setCookies(new Cookie[] { current_userEmail });

        System.debug('your newly created user email  is' + current_userEmail);

        //  } else {

        // perhaps validate the value before returning cookie
        System.debug('your useremail from your cookie is' + current_userEmail);

        // increment time of cookie from -1 to 600s seconds/etc.
        // }

        String currentuservalue = SecurityManager.decryptText(current_userEmail.getValue());


        return currentuservalue;
    }

    // pass userEmail and searched company  and encrypt/decrypt as neeeded.
    //Public Cookie MasterTrackerCookie(String tValue, String userEmail, String searchedcompany) {
    //    // this will be called instead of the previous cookie method classes

    //    // step 1 create master cookie when initially called and concatenate all the relevant fields
    //    // e.g. (current user information/ searched companies/submission and transaction information)
    //    // encrypt and decrypt on the fly
    //    // erase this cookie on the final step if user exits or timesout
    //    Cookie chmastercookie = ApexPages.currentPage().getCookies().get('chmastercookie');
    //    if (chmastercookie == null) {
    //        // if cookie doesn't exist create it and pass in the appropriate values and encrypt/decrypt
    //        // check against what is being passed in and mark null if not needed
    //        // e.g. searched company will not be available upon first oauth check so make null
    //        // e.g. if (paramaters.contains(start)) { assign user email from oauth and the rest null}
    //        //  else if (parameters.containst(other strings, etc) {assign variables as needed}
    //        // etc.

    //        // current_userEmail = new Cookie('user_Email', SecurityManager.encryptText(usersearchparameter), null, -1, true);

    //        chmastercookie = new Cookie('chmastercookie', SecurityManager.encryptText(tValue + AppConstants.ID_DELIM_CHAR + userEmail + AppConstants.ID_DELIM_CHAR + searchedcompany + AppConstants.ID_DELIM_CHAR), null, -1, true);
    //    } else {

    //        if (String.isBlank(ApexPages.currentPage().getCookies().get('chmastercookie').getValue())) return null;
    //        // cookies is blank...shouldn't have been called ?

    //        String mastercookieValues = SecurityManager.decryptText(ApexPages.currentPage().getCookies().get('chmastercookie').getvalue());

    //        // get value of chmastercookie and loop through it stopping at delimitters and assigning them their appropriate key values
    //        // check against database if need be -- run past mark to see if this is efficient otherwise don't use dbase

    //        // 1 tvalue test....may not be needed
    //        //tValue = mastercookieValues.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];
    //        //if (!isValidTValue(tValue)) return null;

    //        //2  user information
    //        userEmail = mastercookieValues.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];
    //        if (!isValidUser(userEmail)) return null;

    //        // 3 company searched
    //        companySearched = mastercookieValues.split(AppConstants.ID_DELIM_SPLIT_CHAR)[2];
    //        if (!isValidCompanySearched(companySearched)) return null;

    //        //3 transactioninformation

    //        //4 submissioninformation

    //        //5 step information?

    //        //6 whatever else the team deems important to track

    //    }
    //    // get string fallues from list and then see if they contain the aforementioned values in step 1
    //    //  current.cookies.contains(getCurrentUser.getValue());
    //    // note we only need to check for one of the variables preferably currentuser as that is the first oauth

    //    //if (current_cookies)


    //    return null;
    //}

    // Begin static Methods

    //public static Boolean isValidTValue(String tValue){ return ([select count() from "TODO TVALUE DATA TYPES" where tvalue=:tvalue]>0); }

    public static Boolean isValidUser(String userEmail) {
        return ([select count() from Company_Authorisation__c where userEmail__c = : userEmail] > 0);
    }
    public static Boolean isValidCompanySearched(String companySearched) {
        return ([select count() from Company_Authorisation__c where Company_Number__c = : companySearched] > 0);
    }
    // company_searched__c doesn't exist yet perhaps Company_Number__c
    // set as needed any other validation for future cookies

    // End Static Methods
}