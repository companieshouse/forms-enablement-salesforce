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
1.3  Leo B. 	   2016-05-29  Update constants
1.4  Antonio Bravo 2016-06-02  Update Constants
*/
public with sharing class AppConstants {
	
	//Request Status
	public final static String REQUEST_STATUS_DRAFT = 'Draft';
	public final static String REQUEST_STATUS_PENDING_SIGNATURES = 'Pending Signatures';
	public static final String REQUEST_STATUS_SIGNED = 'Signed';
	public static final String REQUEST_STATUS_PENDING_SUBMISSION = 'Submission pending';
	public static final String REQUEST_STATUS_SUBMITTED = 'Submitted';
	public static final String REQUEST_STATUS_ERROR = 'Error';
	
	//Request Status to set after CHIPS call
	public static final String REQUEST_STATUS_APPROVED = 'Approved';
	public static final String REQUEST_STATUS_REJECTED = 'Rejected';

	//DocuSign Status
    public static final String DOCUSIGN_STATUS_COMPLETED = 'Completed';   
    public static final String DOCUSIGN_STATUS_REJECTED = 'Declined';   

	//Webservice from CHIPS
	public static final String CHIPS_APPROVED = '0';
    public static final String CHIPS_REJECTED = '1';
	
	//Webservice StatusReply (use to CHIPS)
	public static final String SUCCESS_STATUS = 'Success';
	public static final String ERROR_STATUS = 'Error';

	//Framework
	public final static String TRANSACTION_TYPE_VISUALFORCE_PAGE = 'VF Page';
	public final static String TRANSACTION_TYPE_APEX_CODE = 'Apex Code';
	
    public final static String ID_DELIM_CHAR = '|';
    public final static String ID_DELIM_SPLIT_CHAR = '\\|';	
	
	public final static String DELIM_HISTORICAL_STEP = '_-_';
	public final static String PERCENTAGE_REPLACEMENT = 'jnxzxrwfus';

	//Company type in use in SF => Company, if value ERROR not in use
	public final static Map<String, String> validCompanyType = new Map<String, String>{'private-unlimited'=>'Company','ltd'=>'Company','plc'=>'Company','old-public-company'=>'Company','private-limited-guarant-nsc-limited-exemption'=>'Company','limited-partnership'=>'ERROR','private-limited-guarant-nsc'=>'Company','converted-or-closed'=>'ERROR','private-unlimited-nsc'=>'Company','private-limited-shares-section-30-exemption'=>'Company','assurance-company'=>'ERROR','oversea-company'=>'ERROR','eeig'=>'ERROR' ,'icvc-securities'=>'ERROR','icvc-warrant'=>'ERROR','icvc-umbrella'=>'ERROR','industrial-and-provident-society'=>'ERROR','northern-ireland'=>'Company','northern-ireland-other'=>'Company','llp'=>'LLP','royal-charter'=>'ERROR','investment-company-with-variable-capital'=>'ERROR','unregistered-company'=>'ERROR','other'=>'ERROR','european-public-limited-liability-company-se'=>'ERROR','uk-establishment'=>'ERROR','registered-society-non-jurisdictional'=>'ERROR'};
	
	//Company type in use with their corresponding type formated
	public final static Map<String, String> formatedCompanyType = new Map<String, String>{'private-unlimited'=>'Private Unlimited Company','ltd'=>'Private Limited Company','plc'=>'Public Limited Company','old-public-company'=>'Old Public Company','private-limited-guarant-nsc-limited-exemption'=>'Private Limited Company by guarantee without share capital=>use of \'Limited\'exemption','limited-partnership'=>'Limited Partnership','private-limited-guarant-nsc'=>'Private Limited by guarantee without share capital','converted-or-closed'=>'Converted / Closed','private-unlimited-nsc'=>'Private Unlimited Company without share capital','private-limited-shares-section-30-exemption'=>'Private Limited Company=>use of \'Limited\'exemption','assurance-company'=>'Assurance Company','oversea-company'=>'Overseas Company','eeig'=>'European Economic Interest Grouping (EEIG)' ,'icvc-securities'=>'Investment Company with variable capital','icvc-warrant'=>'Investment Company with variable capital','icvc-umbrella'=>'Investment Company with variable capital','industrial-and-provident-society'=>'Industrial and provident society','northern-ireland'=>'Northern Ireland Company','northern-ireland-other'=>'Credit Union (Northern Ireland)','llp'=>'Limited Liability Partnership','royal-charter'=>'Royal Charter Company','investment-company-with-variable-capital'=>'Investment Company with variable capital','unregistered-company'=>'Unregistered Company','other'=>'Other Company type','european-public-limited-liability-company-se'=>'European Public Limited Liability Company (SE)','uk-establishment'=>'UK Establishment Company'};
}