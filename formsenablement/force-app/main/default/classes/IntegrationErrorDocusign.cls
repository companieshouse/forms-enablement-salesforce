/*
Name:  IntegrationErrorDocusign.cls
Copyright © 2019  Ribbonfish
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: IntegrationErrorDocusign

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Sylvain P     2019-11-21  Initial development.
*/
public with sharing class IntegrationErrorDocusign extends TransactionStepControllerBase {

    public String title {get; set;}
    public String body {get; set;}
    public String link {get; set;}
   
    // Constructors.
    public IntegrationErrorDocusign() {
        super();

        if (isPageInitialised) initialiseStep();
    }
    // End Constructors.

    // Instance methods.
    private void initialiseStep() {
        title = 'Sorry, we\'re experiencing technical problems.';
        body = 'ErrorCode: Docusign Error. <br/><br/> <a class="govuk-link" href="https://www.gov.uk/contact-companies-house" >Call the helpdesk for further assistance mentioning the error code</a>.';

     
        return;
    }

    private void persistStep() {
        submissionMgr.persist();
    }

    
    // End Instance methods.

}