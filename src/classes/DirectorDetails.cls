/*
Name:  DirectorDetails.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Director Details Page
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-06-16  Initial development.
*/
public class DirectorDetails extends TransactionStepControllerBase
{
    public Boolean hasPageErrors
    {
        get;
        set;
    }

    public String companyName
    {
        get;
        set;
    }

    public List < Officer__c > companyDirectors
    {
        get;
        set;
    }

    public List < Officer__c > builtDirectors
    {
        get;
        set;
    }
    public Boolean isLLPCompany
    {
        get;
        set;
    }
    public List < DirectorWrapper > directorWrapper
    {
        get;
        set;
    }
    public String emailErrors
    {
        get;
        set;
    }


    public DirectorDetails()
    {
        super();
        if (isPageInitialised) initialiseStep();

    }


    public void initialiseStep()
    {


        companyName = submissionMgr.submission.CompanyName__c;
        companyDirectors = submissionMgr.submission.Officers__r;
        builtDirectors = new List < Officer__c > ();
        isLLPCompany = submissionMgr.submission.isLLP__c;
        buildDirectorsList();
        return;
    }

    public PageReference checkDirectorStatus()
    {


        if (submissionMgr.submission.Officers__r.size() == 1)
        {
            if (submissionMgr.submission.Officers__r[0].isSignatory__c)
                return nextAction();
        }
        return null;
    }

    public void buildDirectorsList()
    {
        for (Officer__c chosenOfficer: companyDirectors)
        {
            if (chosenOfficer.isSignatory__c == True)
            {
                builtDirectors.add(chosenOfficer);
            }
            else if (chosenOfficer.IsPresenter__c == true)
            {
                if (chosenOfficer.isSignatory__c == true)
                {
                    builtDirectors.add(chosenOfficer);
                }
            }
        }
    }



    private void persistStep()
    {

        submissionMgr.persist();

    }

    public PageReference nextAction()
    {
        if (!validatePageState()) return Page.TransactionException;

        if (submissionMgr.submission.Officers__r.size() == 1)
        {
            if (submissionMgr.submission.Officers__r[0].isSignatory__c)
                return nextStep();
        }

        for (Officer__c off: submissionMgr.submission.Officers__r)
        {
            for (directorWrapper directorstoUPDATE: getWrappedDirectors())
            {
                if (off.Id == directorstoUPDATE.off.Id)
                {
                    if (!emailValidation(directorstoUPDATE.email, directorstoUPDATE.off.Name))
                    {
                        directorstoUPDATE.validationErrors = emailErrors;
                        return null;
                    }
                    if (!emailValidation(directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name))
                    {
                        directorstoUPDATE.validationErrors = emailErrors;
                        return null;
                    }
                    if (!emailComparison(directorstoUPDATE.email, directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name))
                    {
                        directorstoUPDATE.validationErrors = emailErrors;
                        return null;
                    }
                    directorstoUPDATE.validationErrors = '';

                    off.Email__c = directorstoUPDATE.email;
                }
            }
        }

        persistStep();

        return nextStep();
    }

    public PageReference previousAction()
    {
        if (!validatePageState()) return Page.TransactionException;

        return previousStep();
    }

    public with sharing class directorWrapper
    {
        public Officer__c off
        {
            get;
            set;
        }
        public String email
        {
            get;
            set;
        }
        public String confirmationemail
        {
            get;
            set;
        }

        public String validationErrors
        {
            get;
            set;
        }

        public directorWrapper(Officer__c wrappedofficer)
        {
            validationErrors = '';
            off = wrappedofficer;
            email = '';
            confirmationemail = '';
        }
    }

    public Boolean emailValidation(String emailAddress, String username)
    {
        // remove whitespaces
        String email = emailAddress;

        String[] whitespaceFinder = email.split(' ');

        for (String afterstringString: whitespaceFinder)
        {
            email = email + afterstringString;
        }
        if (String.isBlank(email))
        {
            //throw new Form_CustomException(' email is blank  for ' + ' ' + username);

            emailErrors = 'Email Address for' + ' ' + username + ' ' + 'must not be blank';
            hasPageErrors = true;
            return false;
        }
        // check for @
        if (email.contains('@'))
        {
            // check for "."

            if (!email.contains('.'))
            {
                //throw new Form_CustomException(' email error for' + ' ' + username + ' '+  'not containing dot ' + email);

                emailErrors = 'Email Address for' + ' ' + username + ' ' + 'must be valid and contain a proper address (e.g. .com .net .edu .co.uk )';
                hasPageErrors = true;
                return false;
            }
        }
        else
        {
            // throw new Form_CustomException(' email not valid needs @ ' + email);

            emailErrors = 'Email Address for' + ' ' + username + ' ' + ' must be valid and contain an @';
            hasPageErrors = true;
            return false;
        }

        return true;
    }

    public Boolean emailComparison(String email1, String email2, String username)
    {
        // check to make sure the emails are the same  after validation has occurred then call next();
        if (email1 != email2)
        {
            //throw new Form_CustomException(' emails do not match' + email1 + email2 + ' for Member/Director' + username);

            emailErrors = 'Email Addresses' + ' ' + email1 + ' ' + 'does not match' + ' ' + email2 + ' ' + 'for' + ' ' + username;
            hasPageErrors = true;

            return false;
        }


        return true;
    }

    public List < directorWrapper > getWrappedDirectors()
    {
        if (directorWrapper == null)
        {
            directorWrapper = new List < directorWrapper > ();

            for (Officer__c loopedOfficers: builtDirectors)
            {

                directorWrapper happyDirectors = new directorWrapper(loopedOfficers);
                directorWrapper.add(happyDirectors);
            }
        }

        return directorWrapper;
    }

    public Void saveWrappedDirectorsSelection()
    {
        for (Officer__c off: submissionMgr.submission.Officers__r)
        {
            for (directorWrapper directorstoUPDATE: getWrappedDirectors())
            {
                if (off.Id == directorstoUPDATE.off.Id)
                {
                    emailValidation(directorstoUPDATE.email, directorstoUPDATE.off.Name);
                    emailValidation(directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name);
                    emailComparison(directorstoUPDATE.email, directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name);
                    off.Email__c = directorstoUPDATE.email;

                }
            }
        }
    }
}
