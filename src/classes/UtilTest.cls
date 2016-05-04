/**
 * Utility methods, not specific to Companies House.
 * 
 * Author: eliot.stock@methods.co.uk
 */
@IsTest
public class UtilTest {
    
    @IsTest
    public static void canSendEmail() {
        Util.email('unit test subject', 'unit test body', 'eliot.stock@methodsdigital.co.uk');
    }

}