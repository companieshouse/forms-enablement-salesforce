/*
Name:  IStepNavigable.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Simple interface that allows StepNavigator classes to be instantiated generically.

Note, PageReference return types were attempted.
Salesforce Unexpected Error thrown.

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-11  Initial development.
*/
public interface IStepNavigable {
	Id getNextStepIdByApex(Id submissionId); 
}