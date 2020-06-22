/**
 * Mock WebService to generate a response base on the request. 
 * Mock used for test class SendToDocuSignTest
 *
 * Response type:
 * - Create and Send Envelope
 * - Request Recipient Token
 * 
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/
@isTest
global class MockWebServiceResponseGenerator implements WebServiceMock {
  
  private static String TOKEN_URL = 'https://demo.docusign.net/Signing/xxxx';
  private static String SUCCESS_STATUS = 'Success';
  private static String ERROR_STATUS = 'Error';

  // Public variables to be set on SendToDocuSignTest for checking Authorized Recipient signing on behalf of
  public static boolean isSigningOnBehalf = false; //default value is false
  public static String authorizedSignerName;

  // Implement this interface method  
  global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {

    // Create response element for each request depending on Request Name
    system.debug('MockWebServiceResponseGenerator requestName: ' + requestName);
    

    //////////////////////////////////////
    // Create and Send Envelope Mock 
    //////////////////////////////////////
    if(requestName == 'CreateAndSendEnvelope'){
      String responseStatus;
      
      //Get Recipient Name
      DocusignResponsiveAPI.CreateAndSendEnvelope_element element = (DocusignResponsiveAPI.CreateAndSendEnvelope_element)request;
      DocusignResponsiveAPI.Envelope envelope = element.Envelope;
      DocusignResponsiveAPI.Recipient recipient = envelope.Recipients.Recipient[0];
      String recipientName = recipient.UserName;

      system.debug('MockWebServiceResponseGenerator isSigningOnBehalf: ' + isSigningOnBehalf);
      if(isSigningOnBehalf){

        if(authorizedSignerName == recipientName)
          responseStatus = SUCCESS_STATUS;
        else
          responseStatus = ERROR_STATUS;

      } else {
        responseStatus = SUCCESS_STATUS;
      }

      //create envelopeStatus
      DocusignResponsiveAPI.EnvelopeStatus envStatus = new DocusignResponsiveAPI.EnvelopeStatus();
      envStatus.EnvelopeID = responseStatus;
      
      //create element and add envelope status to response
      DocusignResponsiveAPI.CreateAndSendEnvelopeResponse_element cseresp = new DocusignResponsiveAPI.CreateAndSendEnvelopeResponse_element();
      cseresp.CreateAndSendEnvelopeResult = envStatus;
      response.put('response_x', cseresp); 


    //////////////////////////////////////
    // Request Recipient Token Response
    //////////////////////////////////////
    } else if(requestName == 'RequestRecipientToken') {      
      DocusignResponsiveAPI.RequestRecipientTokenResponse_element rrtre = new DocusignResponsiveAPI.RequestRecipientTokenResponse_element();
      rrtre.RequestRecipientTokenResult = TOKEN_URL;
      response.put('response_x', rrtre); 

    }
    
  }

}