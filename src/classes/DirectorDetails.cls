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

    public Boolean showErrors
    {
        get;
        set;
    }

    public String currentErrortop
    {
        get;
        set;
    }
    public String currentErrorbottom
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
        currentErrortop = '<div class="form-group error">';
        currentErrorbottom = '</div>';
        buildDirectorsList();
        showErrors = false;
        //checkDirectorStatus();
        return;
    }

    public PageReference checkDirectorStatus()
    {


        if (submissionMgr.submission.Officers__r.size() == 1)
        {
            if (submissionMgr.submission.Officers__r[0].isSignatory__c)

                return nextAction();
        }

        // must test better against on behalf multiple director flow.
        if (submissionMgr.submission.Officers__r.size() >= 1)
        {
            Integer baseline = 0;
            Integer myinteger = 0;
            for (Officer__c officerstoCount: submissionMgr.submission.Officers__r)
            {
                if (officerstoCount.isSignatory__c == true)
                {
                    baseline++;
                    if (officerstoCount.Email__c != null)
                    {
                        myinteger++;
                    }
                }
            }

            if (baseline == myinteger)
            {
                // all signature emails have been acquired. call next action
                return nextAction();
            }
        }

        return null;
    }

    public void buildDirectorsList()
    {
        for (Officer__c chosenOfficer: companyDirectors)
        {
            if (chosenOfficer.isSignatory__c && !chosenOfficer.hasInputBehalfDetails__c && !chosenOfficer.IsPresenter__c)
            {
                builtDirectors.add(chosenOfficer);
            }
        }
    }



    private void persistStep()
    {

        submissionMgr.persist();
    }

    public PageReference nextAction()
    {
        // skip if officer is presenter
        if (!validatePageState()) return Page.TransactionException;

        if (submissionMgr.submission.Officers__r.size() == 1)
        {
            if (submissionMgr.submission.Officers__r[0].IsPresenter__c)

                return nextStep();
        }

        // skip if all officers have an email address already

        /*
        if (submissionMgr.submission.Officers__r.size() >= 1)
        {
            for (Officer__c officerstoCount: submissionMgr.submission.Officers__r)
                if (officerstoCount.isSignatory__c == true)
                {
                    if (officerstoCount.IsPresenter__c == false)
                    {
                        if (officerstoCount.Email__c != null)
                        {
                            return nextStep();
                        }
                    }
                }
        }
        */

        for (Officer__c off: submissionMgr.submission.Officers__r)
        {
            for (directorWrapper directorstoUPDATE: getWrappedDirectors())
            {
                if (off.Id == directorstoUPDATE.off.Id)
                {
                    if (!emailValidation(directorstoUPDATE.email, directorstoUPDATE.off.Name))
                    {
                        directorstoUPDATE.validationErrors = emailErrors;
                        directorstoUPDATE.privateErrors = showErrors;
                        directorstoUPDATE.topErrors = currentErrortop;
                        directorstoUPDATE.bottomErrors = currentErrorbottom;
                        directorstoUPDATE.confirmationerrorTop = '';
                        directorstoUPDATE.confirmationerrorBottom = '';
                        return null;
                    }
                    if (!emailValidation(directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name))
                    {
                        directorstoUPDATE.confirmationErrors = emailErrors;
                        directorstoUPDATE.validationErrors = ' ';
                        directorstoUPDATE.privateErrors = showErrors;
                        directorstoUPDATE.topErrors = '';
                        directorstoUPDATE.bottomErrors = '';
                        directorstoUPDATE.confirmationerrorTop = currentErrortop;
                        directorstoUPDATE.confirmationerrorBottom = currentErrorbottom;
                        return null;
                    }
                    if (!emailComparison(directorstoUPDATE.email, directorstoUPDATE.confirmationemail, directorstoUPDATE.off.Name))
                    {
                        directorstoUPDATE.validationErrors = emailErrors;
                        directorstoUPDATE.privateErrors = showErrors;
                        directorstoUPDATE.topErrors = currentErrortop;
                        directorstoUPDATE.bottomErrors = currentErrorbottom;
                        directorstoUPDATE.confirmationerrorTop = currentErrortop;
                        directorstoUPDATE.confirmationerrorBottom = currentErrorbottom;
                        return null;
                    }
                    directorstoUPDATE.validationErrors = '';
                    directorstoUPDATE.confirmationErrors = '';
                    directorstoUPDATE.privateErrors = false;
                    directorstoUPDATE.topErrors = '';
                    directorstoUPDATE.bottomErrors = '';
                    directorstoUPDATE.topErrors = '';
                    directorstoUPDATE.bottomErrors = '';
                    directorstoUPDATE.confirmationerrorTop = '';
                    directorstoUPDATE.confirmationerrorBottom = '';

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

        public Boolean privateErrors
        {
            get;
            set;
        }
        public String topErrors
        {
            get;
            set;
        }
        public String bottomErrors
        {
            get;
            set;
        }

        public String confirmationErrors
        {
            get;
            set;
        }

        public String confirmationerrorTop
        {
            get;
            set;
        }
        public String confirmationerrorBottom
        {
            get;
            set;
        }

        public directorWrapper(Officer__c wrappedofficer)
        {
            confirmationerrorBottom = '';
            confirmationerrorTop = '';
            confirmationErrors = '';
            privateErrors = false;
            validationErrors = '';
            off = wrappedofficer;
            email = '';
            confirmationemail = '';
            topErrors = '';
            bottomErrors = '';
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
            showErrors = true;
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
                showErrors = true;

                return false;
            }
        }
        else
        {
            // throw new Form_CustomException(' email not valid needs @ ' + email);

            emailErrors = 'Email Address for' + ' ' + username + ' ' + ' must be valid and contain an @';
            hasPageErrors = true;
            showErrors = true;

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
            showErrors = true;


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