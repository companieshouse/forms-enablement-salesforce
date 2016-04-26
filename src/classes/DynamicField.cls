/*
Name:  DynamicField.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Wrapper class for a generic approach to dynamic field inputs.

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class DynamicField {
	
	public String fieldName { get; set; }	
	public String fieldLabel { get; set; }
	public Schema.DisplayType displayType { get; set; }
	public String inputType { get; set; }
	
	public String fieldValue { 
		get {
			System.debug(LoggingLevel.ERROR,'SYLVAIN');
			System.debug(LoggingLevel.ERROR,yearValue);
			if (displayType==Schema.Displaytype.Date){
				return Date.newInstance(yearValue,monthValue,dayValue).format();
			} else return fieldValue;
		}
		set; 
	}
	
	public Integer dayValue { get; set; }
	public Integer MonthValue { get; set; } 
	public Integer yearValue { get; set; }

	public DynamicField(String fieldName, String fieldLabel, String fieldValue, Schema.DisplayType displayType){
		
		System.debug(LoggingLevel.ERROR,fieldName);
		System.debug(LoggingLevel.ERROR,fieldLabel);
		System.debug(LoggingLevel.ERROR,fieldValue);
		System.debug(LoggingLevel.ERROR,displayType);

		this.fieldName=fieldName;
		this.fieldLabel=fieldLabel;
		this.displayType=displayType;
		this.fieldValue=fieldValue;		
		if (displayType==Schema.Displaytype.Date){
			
			if(fieldValue == null)
			{
				Date d = system.today();
				
				dayValue = d.day();
				monthValue = d.month();
				yearValue = d.year();
			}
			else
			{
				Date d = Date.valueOf(fieldValue);
				
				dayValue = d.day();
				monthValue = d.month();
				yearValue = d.year();	
			}
						
			this.inputType='Date';
			
		} else
		{
			this.inputType='Text'; // todo - set input type based on display type for field.	
		} 
	}
}