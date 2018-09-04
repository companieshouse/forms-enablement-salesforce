global with sharing class UserAuthenticationDeletionSchedulable implements Schedulable {
	public void execute(SchedulableContext sc) {
        UserAuthenticationDeletionBatch b = new UserAuthenticationDeletionBatch();
        database.executebatch(b);
    }
}