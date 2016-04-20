@isTest
global class MockWebServiceResponseGenerator implements WebServiceMock {
  
  private static String TOKEN_URL = SendToDocuSignControllerTest.TOKEN_URL;

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
    // Populate response element
    system.debug('ab requestName: ' + requestName);
    

    if(requestName == 'CreateAndSendEnvelope'){
      //Create and Send Envelope Mock  

      DocuSignAPI.CreateAndSendEnvelopeResponse_element cseresp = new DocuSignAPI.CreateAndSendEnvelopeResponse_element();
      cseresp.CreateAndSendEnvelopeResult = new DocuSignAPI.EnvelopeStatus();
      response.put('response_x', cseresp); 


    } else if(requestName == 'RequestRecipientToken') {
      //Request Recipient Token Response
      
      DocuSignAPI.RequestRecipientTokenResponse_element rrtre = new DocuSignAPI.RequestRecipientTokenResponse_element();
      rrtre.RequestRecipientTokenResult = TOKEN_URL;
      response.put('response_x', rrtre); 

    }

  }

}