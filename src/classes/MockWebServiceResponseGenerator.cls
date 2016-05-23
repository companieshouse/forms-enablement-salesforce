@isTest
global class MockWebServiceResponseGenerator implements WebServiceMock {
  
  private static String TOKEN_URL = SendToDocuSignTest.TOKEN_URL;
  private static String ENVELOPESTATUS = SendToDocuSignTest.ENVELOPESTATUS;

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
    system.debug('MockWebServiceResponseGenerator requestName: ' + requestName);
    
    //Create and Send Envelope Mock 
    if(requestName == 'CreateAndSendEnvelope'){
      //create envelopeStatus
      DocuSignAPI.EnvelopeStatus envStatus = new DocuSignAPI.EnvelopeStatus();
      envStatus.EnvelopeID = ENVELOPESTATUS;
      
      //create element and add envelope status to response
      DocuSignAPI.CreateAndSendEnvelopeResponse_element cseresp = new DocuSignAPI.CreateAndSendEnvelopeResponse_element();
      cseresp.CreateAndSendEnvelopeResult = envStatus;
      response.put('response_x', cseresp); 


    //Request Recipient Token Response
    } else if(requestName == 'RequestRecipientToken') {      
      DocuSignAPI.RequestRecipientTokenResponse_element rrtre = new DocuSignAPI.RequestRecipientTokenResponse_element();
      rrtre.RequestRecipientTokenResult = TOKEN_URL;
      response.put('response_x', rrtre); 

    }

  }

}