/**
 * Author: eliot.stock@methodsdigital.co.uk
 */
@IsTest
public with sharing class PaymentControllerTest {

    @IsTest
    public static void testPayment(){
        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;

        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        insert testPresenter;

        insert testCompany;

        Transaction__c transac = testData.tx;

        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;

        insert transac;

        

        PageReference pg = Page.Payment;
        pg.getParameters().put('c', SecurityManager.encryptText(transac.Id+AppConstants.ID_DELIM_CHAR+testStep1.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(pg);
        Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('test@test.com'+AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 120, true);

        pg.setCookies(new Cookie[]{sessionValidity});

        PaymentController pay = new PaymentController();

        pay.checkPaymentResult();

        transac.isPaymentRequired__c = true;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        transac.hasPaid__c = true;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        transac.hasPaid__c = false;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        pay.submit();

        pay.valuePaymentUI = 1;
        pay.updatePayment();

        pay.valuePaymentUI = 2;
        pay.updatePayment();

        pay.valuePaymentUI = 3;
        pay.updatePayment();
        

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'AUTHORISED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'REFUSED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'CANCELLED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'PENDING');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'ERROR');

        pay.parseQueryString();

        pay.updateLink();

        pay.isSameDayPayment = true;
        pay.persistStep();

        pay.isAccountSelected = true;
        pay.accountNumber = '02020';
        pay.persistStep();

        pay.isPaypalSelected = true;
        pay.persistStep();

        pay.isCardSelected = true;
        pay.persistStep();

        pay.isSameDaySelected = true;
        pay.persistStep();

        pay.previousClicked = true;
        pay.persistStep();

        pay.previousClicked = false;
        pay.hasPaymentSuccess = true;
        pay.persistStep();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = null;
        pay.accountSuccess = false;
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = '';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = 'aojdowaj';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = '24082402';
        pay.accountAuthCode = '';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = true;
        pay.isPageInitialised = false;
        pay.nextAction();

        pay.isAccountSelected = true;
        pay.nextAction();

        pay.isCardSelected = true;
        pay.isAccountSelected = false;
        pay.nextAction();

        pay.isCardSelected = false;
        pay.isPaypalSelected = false;
        pay.accountAuthCode = 'aiwhdjiawh';
        pay.submissionMgr.submission.hasPaid__c = false;
        pay.nextAction();

        pay.previousAction();
        pay.submissionMgr.submission.isPaymentAccount__c = true;
        pay.isAccountSelected = true;
        pay.isPaypalSelected = false;
        pay.isCardSelected = false;
        pay.previousAction();


        pay.resetTransaction();

        pay.submissionMgr.submission.Id = null;

        pay.resetTransaction();

        pay.updateSameDay();

        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockError());
        pay.submissionMgr.submission.isPaymentAccount__c = true;
        pay.submissionMgr.submission.AccountNumber__c = '29472947';
        pay.submissionMgr.submission.AccountAuthorisationCode__c = 'odaowaduo';
        pay.parseQueryString();
        Test.stopTest();

    }
    @IsTest
    public static void testPayment4(){
        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;

        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        insert testPresenter;

        insert testCompany;

        Transaction__c transac = testData.tx;

        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;

        insert transac;

        

        PageReference pg = Page.Payment;
        pg.getParameters().put('c', SecurityManager.encryptText(transac.Id+AppConstants.ID_DELIM_CHAR+testStep1.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(pg);
        Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('test@test.com'+AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 120, true);

        pg.setCookies(new Cookie[]{sessionValidity});

        PaymentController pay = new PaymentController();

        pay.checkPaymentResult();

        transac.isPaymentRequired__c = true;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        transac.hasPaid__c = true;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        transac.hasPaid__c = false;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        pay.submit();

        pay.valuePaymentUI = 1;
        pay.updatePayment();

        pay.valuePaymentUI = 2;
        pay.updatePayment();

        pay.valuePaymentUI = 3;
        pay.updatePayment();
        

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'AUTHORISED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'REFUSED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'CANCELLED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'PENDING');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'ERROR');

        pay.parseQueryString();

        pay.updateLink();

        pay.isSameDayPayment = true;
        pay.persistStep();

        pay.isAccountSelected = true;
        pay.accountNumber = '02020';
        pay.persistStep();

        pay.isPaypalSelected = true;
        pay.persistStep();

        pay.isCardSelected = true;
        pay.persistStep();

        pay.isSameDaySelected = true;
        pay.persistStep();

        pay.previousClicked = true;
        pay.persistStep();

        pay.previousClicked = false;
        pay.hasPaymentSuccess = true;
        pay.persistStep();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = null;
        pay.accountSuccess = false;
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = '';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = 'aojdowaj';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = '24082402';
        pay.accountAuthCode = '';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = true;
        pay.isPageInitialised = false;
        pay.nextAction();

        pay.isAccountSelected = true;
        pay.nextAction();

        pay.isCardSelected = true;
        pay.isAccountSelected = false;
        pay.nextAction();

        pay.isCardSelected = false;
        pay.isPaypalSelected = false;
        pay.accountAuthCode = 'aiwhdjiawh';
        pay.submissionMgr.submission.hasPaid__c = false;
        pay.nextAction();

        pay.previousAction();
        pay.submissionMgr.submission.isPaymentAccount__c = true;
        pay.isAccountSelected = true;
        pay.isPaypalSelected = false;
        pay.isCardSelected = false;
        pay.previousAction();


        pay.resetTransaction();

        pay.submissionMgr.submission.Id = null;

        pay.resetTransaction();

        pay.updateSameDay();
        

        pay.merchantReference = null;
        pay.submissionMgr.submission.isPaymentAccount__c = false;
        pay.authResult = PaymentController.AUTH_RESULT_AUTHORISED;
        pay.parseQueryString();

        pay.authResult = PaymentController.AUTH_RESULT_REFUSED;
        pay.parseQueryString();

        pay.authResult = PaymentController.AUTH_RESULT_PENDING;
        pay.parseQueryString();

        pay.authResult = PaymentController.AUTH_RESULT_CANCELLED;
        pay.parseQueryString();

        pay.authResult = PaymentController.AUTH_RESULT_ERROR;
        pay.parseQueryString();
    }
    @IsTest
    public static void testPayment3(){
        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm = CompaniesHouseTestData.getInstance().testForm;

        Transaction_Type_Step__mdt testStep1 = CompaniesHouseTestData.getInstance().testStep1;

        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        insert testPresenter;

        insert testCompany;

        Transaction__c transac = testData.tx;

        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep1.Id;

        insert transac;

        

        PageReference pg = Page.Payment;
        pg.getParameters().put('c', SecurityManager.encryptText(transac.Id+AppConstants.ID_DELIM_CHAR+testStep1.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(pg);
        Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('test@test.com'+AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 120, true);

        pg.setCookies(new Cookie[]{sessionValidity});

        PaymentController pay = new PaymentController();

        pay.checkPaymentResult();

        transac.isPaymentRequired__c = true;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        transac.hasPaid__c = true;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        transac.hasPaid__c = false;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        pay.submit();

        pay.valuePaymentUI = 1;
        pay.updatePayment();

        pay.valuePaymentUI = 2;
        pay.updatePayment();

        pay.valuePaymentUI = 3;
        pay.updatePayment();
        

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'AUTHORISED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'REFUSED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'CANCELLED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'PENDING');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'ERROR');

        pay.parseQueryString();

        pay.updateLink();

        pay.isSameDayPayment = true;
        pay.persistStep();

        pay.isAccountSelected = true;
        pay.accountNumber = '02020';
        pay.persistStep();

        pay.isPaypalSelected = true;
        pay.persistStep();

        pay.isCardSelected = true;
        pay.persistStep();

        pay.isSameDaySelected = true;
        pay.persistStep();

        pay.previousClicked = true;
        pay.persistStep();

        pay.previousClicked = false;
        pay.hasPaymentSuccess = true;
        pay.persistStep();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = null;
        pay.accountSuccess = false;
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = '';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = 'aojdowaj';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = '24082402';
        pay.accountAuthCode = '';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = true;
        pay.isPageInitialised = false;
        pay.nextAction();

        pay.isAccountSelected = true;
        pay.nextAction();

        pay.isCardSelected = true;
        pay.isAccountSelected = false;
        pay.nextAction();

        pay.isCardSelected = false;
        pay.isPaypalSelected = false;
        pay.accountAuthCode = 'aiwhdjiawh';
        pay.submissionMgr.submission.hasPaid__c = false;
        pay.nextAction();

        pay.previousAction();
        pay.submissionMgr.submission.isPaymentAccount__c = true;
        pay.isAccountSelected = true;
        pay.isPaypalSelected = false;
        pay.isCardSelected = false;
        pay.previousAction();


        pay.resetTransaction();

        pay.submissionMgr.submission.Id = null;

        pay.resetTransaction();

        pay.updateSameDay();

        Test.startTest();
        
        // Unit tests shouldn't call out. Use a mock to give them an HTTP response.
        Test.setMock(HttpCalloutMock.class, new FormsApiMockBarcode.mockSuccess());
        pay.submissionMgr.submission.isPaymentAccount__c = true;
        pay.submissionMgr.submission.AccountNumber__c = '29472947';
        pay.submissionMgr.submission.AccountAuthorisationCode__c = 'odaowaduo';
        pay.parseQueryString();
        Test.stopTest();

    }

    @IsTest
    public static void testPayment2(){
        CompaniesHouseTestData testData = CompaniesHouseTestData.getInstance();

        Transaction_Type__mdt testForm2 = CompaniesHouseTestData.getInstance().testForm2;

        Transaction_Type_Step__mdt testStep4 = CompaniesHouseTestData.getInstance().testStep4;

        Account testPresenter = CompaniesHouseTestData.getInstance().presenterAccount;

        Account testCompany = CompaniesHouseTestData.getInstance().companyAccount;

        insert testPresenter;

        insert testCompany;

        Transaction__c transac = testData.tx;

        transac.Company__c = testCompany.Id;
        transac.Valid_Step_Ids__c = testStep4.Id;

        insert transac;

        

        PageReference pg = Page.Payment;
        pg.getParameters().put('c', SecurityManager.encryptText(transac.Id+AppConstants.ID_DELIM_CHAR+testStep4.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));
        Test.setCurrentPage(pg);
        Cookie sessionValidity = new Cookie('SFCHS', SecurityManager.encryptText('test@test.com'+AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 120, true);

        pg.setCookies(new Cookie[]{sessionValidity});

        PaymentController pay = new PaymentController();

        transac.isPaymentRequired__c = true;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        transac.hasPaid__c = true;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        transac.hasPaid__c = false;
        update transac;

        pay = new PaymentController();
        pay.checkPaymentResult();

        pay.submit();

        pay.valuePaymentUI = 1;
        pay.updatePayment();

        pay.valuePaymentUI = 2;
        pay.updatePayment();

        pay.valuePaymentUI = 3;
        pay.updatePayment();
        

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'AUTHORISED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'REFUSED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'CANCELLED');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'PENDING');

        pay.parseQueryString();

        pg.getParameters().put('authResult', 'AUTHORISED');
        pg.getParameters().put('merchantReference', 'ERROR');

        pay.parseQueryString();

        pay.updateLink();

        pay.isSameDayPayment = true;
        pay.isSameDaySelected = true;
        pay.persistStep();

        pay.isAccountSelected = true;
        pay.accountNumber = '02020';
        pay.persistStep();

        pay.isPaypalSelected = true;
        pay.persistStep();

        pay.isCardSelected = true;
        pay.persistStep();

        pay.isSameDaySelected = true;
        pay.persistStep();

        pay.previousClicked = true;
        pay.persistStep();

        pay.previousClicked = false;
        pay.hasPaymentSuccess = true;
        pay.persistStep();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = null;
        pay.accountSuccess = false;
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = '';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = 'aojdowaj';
        pay.nextAction();

        pay.submissionMgr.submission.hasPaid__c = false;
        pay.valuePaymentUI = 2;
        pay.accountSuccess = false;
        pay.accountNumber = '24082402';
        pay.accountAuthCode = '';
        pay.nextAction();

        pay.valuePaymentUI = 1;
        pay.isSameDaySelected = null;
        pay.nextAction();


    }
    
}