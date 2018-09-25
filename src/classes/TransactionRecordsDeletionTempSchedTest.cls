/*
Name:  TransactionRecordsDeletionSchedulerTest.cls
Copyright © 2017  Ribbonfish LTD
======================================================
======================================================
Purpose:
-------

Test class for TransactionRecordsDeletionScheduler.cls


======================================================
======================================================
History
------- 
Ver. Author            Date        Detail
1.0  Sylvain Picory    2017-05-26  Initial draft of code.
*/
@isTest
private class TransactionRecordsDeletionTempSchedTest {

  @isTest static void schedulableTest() {

    String cronExpr = '0 0 0 15 3 ? 2022';

    List<AsyncApexJob> jobsBefore = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob];
    System.assertEquals(0, jobsBefore.size(), 'not expecting any asyncjobs');

    Test.startTest();

    String jobId = System.schedule('TransactionRecordsDeletionScheduler', cronExpr, new TransactionRecordsDeletionTempScheduler());

    Test.stopTest();

    // Check schedulable is in the job list
    List<AsyncApexJob> jobsScheduled = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'ScheduledApex'];
    System.assertEquals(1, jobsScheduled.size(), 'expecting one scheduled job');
    System.assertEquals('TransactionRecordsDeletionTempScheduler', jobsScheduled[0].ApexClass.Name, 'expecting specific scheduled job');
 
  }
}