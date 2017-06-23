/**
 * Author: Sameer
 * Reviewer: eliot.stock@methodsdigital.co.uk
 */
@isTest(SeeAllData=false)
public with sharing class CH_ChargeController_Test {
    
    public static testMethod void testmethod_CH_GetChargeController(){     
        CH_ChargeController cc = new CH_ChargeController();
        
        cc.searchParam = '05155348';
        cc.chargeParam = 'YSCqL0sPuI2EOFJ4iwBuq-Ukp34';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());
        PageReference pageRef = cc.doCallout();
        Test.stopTest();
        
        System.assertEquals(cc.classData, 'ChargeDetails:[acquired_on=2000-01-01 00:00:00, assets_ceased_released=Test, charge_code=Test Code, charge_number=1, classification=Classification:[description=Test Description, type=charge-description], covering_instrument_date=2000-01-01 00:00:00, created_on=2000-01-01 00:00:00, delivered_on=2000-01-01 00:00:00, etag=23j4g234jhg23j4hg3, insolvency_cases=(chCase:[case_number=123, chNumber=null, dates=null, links=Links:[chCase=Test Case, charge=null, document_metadata=null, filing=null, insolvency_case=null, officer=null, self=null], notes=null, practitioners=null, transaction_id=123456, type=null]), links=Links:[chCase=null, charge=null, document_metadata=null, filing=null, insolvency_case=null, officer=null, self=/company/12345678/charges/Charge12345], more_than_four_persons_entitled=true, particulars=Particulars:[chargor_acting_as_bare_trustee=true, contains_fixed_charge=true, contains_floating_charge=true, contains_negative_pledge=false, description=Test Description, floating_charge_covers_all=true, type=short-particulars], persons_entitled=(PersonsEntitled:[name=Test Name]), resolved_on=2000-01-01 00:00:00, satisfied_on=2000-01-01 00:00:00, scottish_alterations=ScottishAlterations:[has_alterations_to_order=true, has_alterations_to_prohibitions=false, has_restricting_provisions=false], secured_details=SecuredDetails:[description=Test Description, type=amount-secured], status=fully-satisfied, transactions=(Transactions:[delivered_on=2000-01-01 00:00:00, filing_type=create-charge-pre-2006-companies-act, insolvency_case_number=12345, links=Links:[chCase=null, charge=null, document_metadata=null, filing=/company/12345678/filing-history/12345, insolvency_case=Test Case, officer=null, self=null], transaction_id=1234])]');
    }
    
    public static testMethod void testmethod_CH_ListChargeController(){
        CH_ChargeController cc = new CH_ChargeController();
        
        cc.searchParam = '05155348';
        cc.chargeParam = '';
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ChApiMock());  
        
        PageReference pr = cc.doCallout();
        
        Test.stopTest();
        System.assertEquals(cc.classData, 'ChargeList:[etag=6fce842af6wewrwerwehjhkhebf2beb0, items=(ChargeDetails:[acquired_on=2000-01-01 00:00:00, assets_ceased_released=Test, charge_code=aa12seflkj3, charge_number=1, classification=Classification:[description=Test Description, type=charge-description], covering_instrument_date=2000-01-01 00:00:00, created_on=2005-11-03 00:00:00, delivered_on=2005-11-04 00:00:00, etag=6fce842af6wewrwerwehjhkhebf2beb0, insolvency_cases=null, links=Links:[chCase=null, charge=null, document_metadata=null, filing=null, insolvency_case=null, officer=null, self=/company/12345678/charges/CHARGE001], more_than_four_persons_entitled=false, particulars=Particulars:[chargor_acting_as_bare_trustee=true, contains_fixed_charge=false, contains_floating_charge=true, contains_negative_pledge=true, description=Test Description., floating_charge_covers_all=false, type=short-particulars], persons_entitled=(PersonsEntitled:[name=Test Bank PLC]), resolved_on=2000-01-01 00:00:00, satisfied_on=2011-02-16 00:00:00, scottish_alterations=ScottishAlterations:[has_alterations_to_order=true, has_alterations_to_prohibitions=false, has_restricting_provisions=true], secured_details=SecuredDetails:[description=Test Description, type=amount-secured], status=fully-satisfied, transactions=(Transactions:[delivered_on=2005-11-04 00:00:00, filing_type=create-charge-pre-2006-companies-act, insolvency_case_number=null, links=Links:[chCase=null, charge=null, document_metadata=null, filing=/company/12345678/filing-history/0001, insolvency_case=null, officer=null, self=null], transaction_id=null], Transactions:[delivered_on=2011-02-16 00:00:00, filing_type=charge-satisfaction-pre-april-1900, insolvency_case_number=null, links=Links:[chCase=null, charge=null, document_metadata=null, filing=/company/12345678/filing-history/0000, insolvency_case=null, officer=null, self=null], transaction_id=null])]), part_satisfied_count=0, satisfied_count=1, total_count=1, unfiltered_count=1]');
    }
    
    public static testMethod void testmethod_CH_ShowDateChargeController(){        
        CH_ChargeController cc = new CH_ChargeController();
        
        Test.startTest();
        PageReference pr = cc.showDate();
        
        Test.stopTest();
        
        System.assert(pr == null);
    }
    
}