/**
 * Author: eliot.stock@methodsdigital.co.uk
 */
@IsTest
public class SmartPayNotificationControllerTest {

    /**
     * Go for coverage only until BETA, since we can't even functionally test notificaitons until
     * they're configured in the SmartPay backend. No assertions yet.
     */
    @IsTest
    public static void getCoverage() {
        Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
        insert tx;
        
        Test.startTest();
        PageReference ref = new PageReference('/apex/SmartPayNotification' + SmartPayNotificationController.TEST_QUERY_STRING);
        Test.setCurrentPage(ref);
        
        // Overwrite the merchantReference in the above query string with a valid Transaction ID.
        ApexPages.currentPage().getParameters().put('merchantReference', tx.Id);
        
        SmartPayNotificationController controller = new SmartPayNotificationController();
        controller.init();
        Test.stopTest();
    }
    
}