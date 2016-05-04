/**
 * Author: eliot.stock@methods.digital.co.uk.
 */
@isTest
public class SmartPayUrlTest {
    
    @isTest
    public static void canBuildUrl() {
        Test.startTest();
        
        Transaction__c tx = new Transaction__c(Amount__c  = 10.0);
        insert tx;
        
        // Going for coverage only until BETA, since all this could change.
        SmartPayUrl url = new SmartPayUrl.Builder()
            	.merchantReference(tx.Id)
            	.paymentAmount(tx.Amount__c)
            	.build();
        String redirectUrl = url.toString();
        
        Test.stopTest();
    }

}