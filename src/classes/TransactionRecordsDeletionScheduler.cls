/*
Name:  TransactionRecordsDeletionScheduler.cls
Copyright © 2017  Ribbonfish LTD
======================================================
======================================================
Purpose:
-------

Scheduler associated with the batch TransactionRecordsDeletionBatch


======================================================
======================================================
History
------- 
Ver. Author            Date        Detail
1.0  Sylvain Picory    2017-05-26  Initial draft of code.
*/
public with sharing class TransactionRecordsDeletionScheduler implements Schedulable {
	public void execute(SchedulableContext sc) {
        TransactionRecordsDeletionBatch b = new TransactionRecordsDeletionBatch();
        database.executebatch(b);
    }
}