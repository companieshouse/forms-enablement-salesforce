public with sharing class TrackUserClass {

    // Public properties.

    public String userEmail;
    public String companySearched;

    public TrackUserClass() {

    }

    // cookie methods
    //lb notes
    // note we want to keep track of the users following information and encrypt
    //note: pass a null value as the parameter to reinitialize tvalue and companysearch
    // access token - cannot fully  test until whitelisted
    // t value and/or the form we are using - done
    // c value and/or the transaction information
    // company search information (e.g. company number) - done 
    // any other profile information (e.g. email, etc.)
    //
    // after we are done with our transaction we will delete this information or it will timeout
    // note currently we will have multiple cookies for these values, but we will be 
    // using the delimiter values in the future and concatenate the information into one value.
    // also question to pose to team ...should we encrypt the key and the value?
    // note may want to pass back the actual getvalue() text instead of the cookie consult with team on the value of this

    Public String getUserDocument() {
        //LB  Before user auth we should check for a cookie. If one doesn't exist
        // we create one and insert the Transactiontype so that we can pull this information
        // back when we have our redirect from CH's oauth servers (note: we may not be able to pass parameters in a valid redirect URI)
        // note code going forward will be put into the security manager as a cookie manager method/class
        // this is the initial cookie setter, so no incrementing shall be done

        // method will be accessible throughout the application to reset, set the t value if needed for different forms 
        // method will also be accessible to change the company number dynamically.

        Cookie t_value = ApexPages.currentPage().getCookies().get('t_value');
        // note this is subject to change during the journey and is only used to keep partial state.

        if (t_value == null) {
            // note may need to test for a newly passed t_value and compare to old one. if new is different set this as the value
            // so that users can go back and forth and pass and change documents themselves
            // note this may not be necessary if we pass encryption through the form type.
            String tvalueparameter = ApexPages.currentPage().getParameters().get('t');
            // note may use session cookie:-1 value unless specific time is given, also must test whether this is for https: only 
            // also encrypt
            t_value = new Cookie('t_value', SecurityManager.encryptText(tvalueparameter), null, -1, true);
            // set time to 0 instead of -1 to remove cookie

            ApexPages.currentPage().setCookies(new Cookie[] { t_value });

            System.debug('your newly created tvalue is' + t_value + ' should say DS01');

        } else {


            System.debug('your tvalue from your cookie is' + t_value + ' should say DS01');

            // increment time of cookie from -1 to 600s seconds/etc. 
        }


        // always decrypt

        String t = SecurityManager.decryptText(t_value.getValue());
        /// end cookie manager testing

        return t;
    }

    Public String getSearchedCompany(String companyNumber) {

        Cookie searched_company = ApexPages.currentPage().getCookies().get('searched_company');

        if (searched_company == null) {

            insert new Account(Name=companyNumber);

            // for testing
             //companyNumber = null;
            // this will be initialized on  the company controller
            String companysearchparameter = companyNumber; // this should be the searched company//ApexPages.currentPage().getParameters().get('t');

            searched_company = new Cookie('searched_company', SecurityManager.encryptText(companysearchparameter), null, -1, true);
            // set time to 0 instead of -1 to remove cookie

            ApexPages.currentPage().setCookies(new Cookie[] { searched_company });

            System.debug('your newly created searched company is is' + searched_company);

        } else {
            // perhaps validate the value before returning cookie

            System.debug('your searched_company from your cookie is' + searched_company);

            // increment time of cookie from -1 to 600s seconds/etc. 
        }

        String s = SecurityManager.decryptText(searched_company.getValue());

        return s;
    }

    Public Id returnCurrentCompany(){
        Cookie current_searchedCompany = ApexPages.currentPage().getCookies().get('searched_company');
        String searchedCompany = SecurityManager.decryptText(current_searchedCompany.getValue());
        List < Account > recs = [select Id, Name from Account where Name = : searchedCompany];

        return recs[0].Id;

    }
    
    Public SObject returnCurrentCompanyObject(){
        Cookie current_searchedCompany = ApexPages.currentPage().getCookies().get('searched_company');
        String searchedCompany = SecurityManager.decryptText(current_searchedCompany.getValue());
        List < Account > recs = [select Id, Name from Account where Name = : searchedCompany];

        return recs[0];

    }

    Public Id returnCurrentUser() {
        Cookie current_userEmail = ApexPages.currentPage().getCookies().get('user_Email');
        String userNameEmail = SecurityManager.decryptText(current_userEmail.getValue());
        List < Account > recs = [select Id, Name from Account where Name = : userNameEmail];

        return recs[0].Id;
    }

    Public String getCurrentUser(String userEmail) {

        Cookie current_userEmail = ApexPages.currentPage().getCookies().get('user_Email');

        if (current_userEmail == null) {

            //  pass userprofile information
            String usersearchparameter = userEmail; // this should be the user email from the apiresponse.email method

            current_userEmail = new Cookie('user_Email', SecurityManager.encryptText(usersearchparameter), null, -1, true);
            // set time to 0 instead of -1 to remove cookie

            ApexPages.currentPage().setCookies(new Cookie[] { current_userEmail });

            System.debug('your newly created user email  is' + current_userEmail);

        } else {

            // perhaps validate the value before returning cookie
            System.debug('your useremail from your cookie is' + current_userEmail);

            // increment time of cookie from -1 to 600s seconds/etc. 
        }

        String currentuservalue = SecurityManager.decryptText(current_userEmail.getValue());


        return currentuservalue;
    }

    // pass userEmail and searched company  and encrypt/decrypt as neeeded.
    Public Cookie MasterTrackerCookie(String tValue, String userEmail, String searchedcompany) {
        // this will be called instead of the previous cookie method classes

        // step 1 create master cookie when initially called and concatenate all the relevant fields 
        // e.g. (current user information/ searched companies/submission and transaction information)
        // encrypt and decrypt on the fly
        // erase this cookie on the final step if user exits or timesout            
        Cookie chmastercookie = ApexPages.currentPage().getCookies().get('chmastercookie');
        if (chmastercookie == null) {
            // if cookie doesn't exist create it and pass in the appropriate values and encrypt/decrypt
            // check against what is being passed in and mark null if not needed
            // e.g. searched company will not be available upon first oauth check so make null
            // e.g. if (paramaters.contains(start)) { assign user email from oauth and the rest null}
            //  else if (parameters.containst(other strings, etc) {assign variables as needed}
            // etc. 

            // current_userEmail = new Cookie('user_Email', SecurityManager.encryptText(usersearchparameter), null, -1, true);

            chmastercookie = new Cookie('chmastercookie', SecurityManager.encryptText(tValue + AppConstants.ID_DELIM_CHAR + userEmail + AppConstants.ID_DELIM_CHAR + searchedcompany + AppConstants.ID_DELIM_CHAR), null, -1, true);
        } else {

            if (String.isBlank(ApexPages.currentPage().getCookies().get('chmastercookie').getValue())) return null;
            // cookies is blank...shouldn't have been called ?

            String mastercookieValues = SecurityManager.decryptText(ApexPages.currentPage().getCookies().get('chmastercookie').getvalue());

            // get value of chmastercookie and loop through it stopping at delimitters and assigning them their appropriate key values
            // check against database if need be -- run past mark to see if this is efficient otherwise don't use dbase

            // 1 tvalue test....may not be needed
            //tValue = mastercookieValues.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];
            //if (!isValidTValue(tValue)) return null;

            //2  user information
            userEmail = mastercookieValues.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];
            if (!isValidUser(userEmail)) return null;

            // 3 company searched 
            companySearched = mastercookieValues.split(AppConstants.ID_DELIM_SPLIT_CHAR)[2];
            if (!isValidCompanySearched(companySearched)) return null;

            //3 transactioninformation

            //4 submissioninformation

            //5 step information?

            //6 whatever else the team deems important to track

        }
        // get string fallues from list and then see if they contain the aforementioned values in step 1
        //  current.cookies.contains(getCurrentUser.getValue());
        // note we only need to check for one of the variables preferably currentuser as that is the first oauth

        //if (current_cookies)


        return null;
    }

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