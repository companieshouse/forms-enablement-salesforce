/**
 * Author: eliot.stock@methodsdigital.co.uk
 */
@IsTest
public with sharing class ReviewControllerTest {
    
    /**
     * Go for coverage only until the controllers earlier in the process are further
     * along. No assertions yet.
     */
    @IsTest(SeeAllData = true)
    static void getCoverage() {
        Transaction__c tx = CompaniesHouseTestData.getInstance().tx;
        insert tx;
        Attachment pdf = CompaniesHouseTestData.getInstance().pdf;
        
        ReviewController testRvController = new ReviewController();        

        PageReference pageRef = Page.Review;
        pageRef.getParameters().put('tid', String.valueOf(tx.Id));
        Test.setCurrentPage(pageRef);

        testRvController.init();
        testRvController.submit();
        testRvController.startOver();
    }
    
}