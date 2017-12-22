/*
Name:  SignOutController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: SignOut

======================================================
======================================================
History
-------
Ver. Author             Date        Detail
1.0  Jake Metherell     2016-08-30  Initial development.
*/
public with sharing class SignOutController extends TransactionStepControllerBase {

    // Public properties.


    // Constructors.
    public SignOutController() {
        super();
    }
    // End Constructors.

    public PageReference signOut() {

        //Remove session cookie
        SecurityManager.removeSessionValidityCookie(submissionMgr.submission, transactionMgr, 'Signing out', false);

        return null;
    }

    // End Action methods.
}