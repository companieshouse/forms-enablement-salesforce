@isTest
private class AccountsAPIHelperTest {
	
	@isTest static void test1() {
    AccountsAPIHelper accA = new AccountsAPIHelper();

    accA.getReviewStatusRedirectUrl();

    accA.getReviewStatusURL('234242', 'DS01', 'ihih');


    Test.startTest();
        

    Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockError());
    
    try{
       accA.getAccessToken('dawwada'); 
     }
     catch(Exception e)
     {

     }
    
    Test.stopTest();
	}
	
  @isTest static void test2() {
    AccountsAPIHelper accA = new AccountsAPIHelper();

    accA.getReviewStatusRedirectUrl();

    accA.getReviewStatusURL('234242', 'DS01', 'ihih');


    Test.startTest();
        

    Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccess());
    
    try{
       accA.getAccessToken('dawwada'); 
     }
     catch(Exception e)
     {
      
     }
    
    Test.stopTest();
  }

  @isTest static void test3() {
    AccountsAPIHelper accA = new AccountsAPIHelper();

    accA.getReviewStatusRedirectUrl();

    accA.getReviewStatusURL('234242', 'DS01', 'ihih');


    Test.startTest();
        

    Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mock302());
    
    try{
       accA.getAccessToken('dawwada'); 
     }
     catch(Exception e)
     {
      
     }
    
    Test.stopTest();
  }

  @isTest static void test4() {
    AccountsAPIHelper accA = new AccountsAPIHelper();

    accA.getReviewStatusRedirectUrl();

    accA.getReviewStatusURL('234242', 'DS01', 'ihih');


    Test.startTest();
        

    Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockEmpty());
    
    try{
       accA.getAccessToken('dawwada'); 
     }
     catch(Exception e)
     {
      
     }
    
    Test.stopTest();
  }

  @isTest static void test5() {
    AccountsAPIHelper accA = new AccountsAPIHelper();

    accA.getReviewStatusRedirectUrl();

    accA.getReviewStatusURL('234242', 'DS01', 'ihih');


    Test.startTest();
        

    Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockHTML());
    
    try{
       accA.getAccessToken('dawwada'); 
     }
     catch(Exception e)
     {
      
     }
    
    Test.stopTest();
  }

  @isTest static void test6() {
    AccountsAPIHelper accA = new AccountsAPIHelper();

    accA.getReviewStatusRedirectUrl();

    accA.getReviewStatusURL('234242', 'DS01', 'ihih');


    Test.startTest();
        

    Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccess());
    
    try{
       accA.getUserProfile('dawwada'); 
     }
     catch(Exception e)
     {
      
     }
    
    Test.stopTest();
  }

  @isTest static void test7() {
    AccountsAPIHelper accA = new AccountsAPIHelper();

    accA.getReviewStatusRedirectUrl();

    accA.getReviewStatusURL('234242', 'DS01', 'ihih');


    Test.startTest();
        

    Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mock400());
    
    try{
       accA.getUserProfile('dawwada'); 
     }
     catch(Exception e)
     {
      
     }
    
    Test.stopTest();
  }

  @isTest static void verifyTokenSuccess(){
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccessToken());

    AccountsAPIHelper h = new AccountsAPIHelper();
    Boolean f = h.verifyToken('Test', 'Test');
    Boolean f2 = h.verifyToken('Test', '05448736');

    system.assertEquals(f, false);
    system.assertEquals(f2, true);

    Test.stopTest();
  }

  @isTest static void verifyTokenError(){
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockErrorToken());
    AccountsAPIHelper h = new AccountsAPIHelper();
    Boolean f = h.verifyToken('Test', 'Test');

    system.assertEquals(f, false);

    Test.stopTest();
  }
}