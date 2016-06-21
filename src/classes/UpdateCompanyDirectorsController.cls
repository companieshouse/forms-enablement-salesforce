/*
Name:  UpdateCompanyDirectorsController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: Summary

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Sylvain P     2016-06-16  Initial development.
*/
public with sharing class UpdateCompanyDirectorsController extends TransactionStepControllerBase {  
            
    // Constructors.
    public UpdateCompanyDirectorsController(){
    	super();
    	
    	if (isPageInitialised) initialiseStep();
    }
    // End Constructors.
    
    // Instance methods.
    private void initialiseStep(){
   	
    	return;
    }
    // End Instance methods.
           
}