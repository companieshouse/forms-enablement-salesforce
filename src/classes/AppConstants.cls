/*
Name:  AppConstants.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Application Constant Declarations.
(Picklist values, RT Developer Names etc.)

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-11-04  Initial development.
*/
public with sharing class AppConstants {
	
	public final static String SUBMISSION_STATUS_PENDING = 'Pending';    
	
	public final static String TRANSACTION_TYPE_VISUALFORCE_PAGE = 'VF Page';
	public final static String TRANSACTION_TYPE_APEX_CODE = 'Apex Code';
	
    public final static String ID_DELIM_CHAR = '|';
    public final static String ID_DELIM_SPLIT_CHAR = '\\|';	
	
}