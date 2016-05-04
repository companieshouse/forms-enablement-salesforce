/**
 * Author: eliot.stock@methodsdigital.co.uk
 */
@IsTest
public class PaymentControllerTest {

    /**
     * Go for coverage only until BETA, since we can't even functionally test notificaitons until
     * they're configured in the SmartPay backend. No assertions yet.
     */
    @IsTest
    public static void getCoverageForNewPayment() {
        Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
        insert tx;
        
        Test.startTest();
        PageReference ref = new PageReference('/apex/Payment');
        Test.setCurrentPage(ref);
        
        ApexPages.currentPage().getParameters().put('txId', tx.Id);
        
        PaymentController controller = new PaymentController();
        controller.init();
        controller.submit();
        Test.stopTest();
    }

    /**
     * Go for coverage only until BETA, since we can't even functionally test notificaitons until
     * they're configured in the SmartPay backend. No assertions yet.
     */
    @IsTest
    public static void getCoverageForPaid() {
        Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
        insert tx;
        
        Test.startTest();
        PageReference ref = new PageReference('/apex/Payment');
        Test.setCurrentPage(ref);

        ApexPages.currentPage().getParameters().put('merchantReference', tx.Id);
        ApexPages.currentPage().getParameters().put('authResult', 'AUTHORISED');
        ApexPages.currentPage().getParameters().put('merchantSig', 'unit_test_sig');
        
        PaymentController controller = new PaymentController();
        controller.init();
        Test.stopTest();
    }
    
}