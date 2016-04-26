/*
Name:  DS01Serialiser.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Defines a single method that returns a serialised JSON 
representation of the submission data.

Serialisation code will work as outline below.

String serialisationClassName = transactionManager.getSerialisationClass('DS01'); // reads field value from Transaction_Type__mdt
Type t = Type.forName(serialisationClassName); // all serialisation class must implement the ISerialisable interface

ISerialisable transactionSerialisationImpl = (ISerialisable)t.newInstance(); // as such we can cast as the interface type and call an interface method.
submissionManager.addToQueue(transactionSerialisationImpl.serialise());

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-04  Initial development.
*/
public with sharing class DS01Serialiser implements ISerialisable {
    
    public String serialise(){
    	return null;
    }
    
}