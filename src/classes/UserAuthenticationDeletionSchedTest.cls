@isTest
private class UserAuthenticationDeletionSchedTest {
	@isTest static void schedulableTest() {

    String cronExpr = '0 0 0 15 3 ? 2022';

    List<AsyncApexJob> jobsBefore = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob];
    System.assertEquals(0, jobsBefore.size(), 'not expecting any asyncjobs');

    Test.startTest();

    String jobId = System.schedule('UserAuthenticationDeletionSchedulable', cronExpr, new UserAuthenticationDeletionSchedulable());

    Test.stopTest();

    // Check schedulable is in the job list
    List<AsyncApexJob> jobsScheduled = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'ScheduledApex'];
    System.assertEquals(1, jobsScheduled.size(), 'expecting one scheduled job');
    System.assertEquals('UserAuthenticationDeletionSchedulable', jobsScheduled[0].ApexClass.Name, 'expecting specific scheduled job');

  }
}
