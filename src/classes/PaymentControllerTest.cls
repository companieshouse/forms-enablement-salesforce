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

        pay.isAccountSelected = true;
        pay.accountNumber = '02020';
        pay.persistStep();

        pay.isPaypalSelected = true;
        pay.persistStep();

        pay.isCardSelected = true;
        pay.persistStep();

        pay.isSameDaySelected = true;
        pay.persistStep();


    }
    
}