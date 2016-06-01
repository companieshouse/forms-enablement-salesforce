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
1.0  Mark Cane&    2016-04-11  Initial development.
1.1  Antonio Bravo 2016-04-26  Update Constants
1.2  Sylvain P 	   2016-05-26  Update Constants
*/
public with sharing class AppConstants {
	
	//Request Status
	public final static String REQUEST_STATUS_DRAFT = 'Draft';
	public final static String REQUEST_STATUS_PENDING_SIGNATURES = 'Pending Signatures';
	public static final String REQUEST_STATUS_SIGNED = 'Signed';
	public static final String REQUEST_STATUS_PENDING_SUBMISSION = 'Submission pending';
	public static final String REQUEST_STATUS_SUBMITTED = 'Submitted';
	public static final String REQUEST_STATUS_ERROR = 'Error';
	
	//DocuSign Status
    public static final String DOCUSIGN_STATUS_COMPLETED = 'Completed';   
    public static final String DOCUSIGN_STATUS_REJECTED = 'Declined';   
	public static final String DOCUSIGN_STATUS_DECLINED_SIG = 'DeclinedSig';   

	public final static String TRANSACTION_TYPE_VISUALFORCE_PAGE = 'VF Page';
	public final static String TRANSACTION_TYPE_APEX_CODE = 'Apex Code';
	
    public final static String ID_DELIM_CHAR = '|';
    public final static String ID_DELIM_SPLIT_CHAR = '\\|';	
	
	public final static String DELIM_HISTORICAL_STEP = '_-_';
	public final static String PERCENTAGE_REPLACEMENT = 'jnxzxrwfus';
}