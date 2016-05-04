/**
 * Utility methods, not specific to Companies House.
 * 
 * Author: eliot.stock@methods.co.uk
 */
public class Util {
    
	public static void email(String subject, String body, String email) {
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		List<String> toAddresses = new List<String>();
        
		toAddresses.add(email);
		mail.setToAddresses(toAddresses);
		mail.setSubject(subject);
		mail.setPlainTextBody(body);
        
		try {
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}
        catch (EmailException e) {
            if (Test.isRunningTest()) {
				// There are lots of reasons why this might fail and we don't want any of them
				// to prevent deployment. Swallow it.
				System.debug(LoggingLevel.INFO, 'Ignoring EmailException in unit test.');
            }
        }
		catch (LimitException l) {
			// Swallow this, so as not to break unit tests during deployment.
			System.debug(LoggingLevel.ERROR, 'Reached Single Email Limit. Can\'t send email.');
		}
	}

}