@isTest
public class DocuSignAPIMockImpl {//implements WebServiceMock {
 /* public void doInvoke(
      Object stub,
      Object request,
      Map<String, Object> response,
      String endpoint,
      String soapAction,
      String requestName,
      String responseNS,
      String responseName,
      String responseType) {
       
    System.debug(LoggingLevel.INFO, 'DocuSignAPIMockImpl.doInvoke() - ' +
      '\n request: ' + request +
      '\n response: ' + response +
      '\n endpoint: ' + endpoint +
      '\n soapAction: ' + soapAction +
      '\n requestName: ' + requestName +
      '\n responseNS: ' + responseNS +
      '\n responseName: ' + responseName +
      '\n responseType: ' + responseType);

    if(request instanceOf DocuSignAPI.AcknowledgeAuthoritativeCopyExport_element) {
      response.put( 'response_x', new DocuSignAPI.AcknowledgeAuthoritativeCopyExportResponse_element());
    }
    else if(request instanceOf DocuSignAPI.CorrectAndResendEnvelope_element) {
      response.put( 'response_x', new DocuSignAPI.CorrectAndResendEnvelopeResponse_element());
    }
    else if(request instanceOf DocuSignAPI.CreateAccountBrands_element) {
      response.put( 'response_x', new DocuSignAPI.CreateAccountBrandsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.CreateAndSendEnvelope_element) {
      response.put( 'response_x', new DocuSignAPI.CreateAndSendEnvelopeResponse_element());
    }
    else if(request instanceOf DocuSignAPI.CreateEnvelope_element) {
      response.put( 'response_x', new DocuSignAPI.CreateEnvelopeResponse_element());
    }
    else if(request instanceOf DocuSignAPI.CreateEnvelopeFromTemplates_element) {
      response.put( 'response_x', new DocuSignAPI.CreateEnvelopeFromTemplatesResponse_element());
    }
    else if(request instanceOf DocuSignAPI.CreateEnvelopeFromTemplatesAndForms_element) {
      response.put( 'response_x', new DocuSignAPI.CreateEnvelopeFromTemplatesAndFormsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.DeleteAccountBrands_element) {
      response.put( 'response_x', new DocuSignAPI.DeleteAccountBrandsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.DeleteCaptiveRecipientsSignatures_element) {
      response.put( 'response_x', new DocuSignAPI.DeleteCaptiveRecipientsSignaturesResponse_element());
    }
    else if(request instanceOf DocuSignAPI.DeleteEnvelopes_element) {
      response.put( 'response_x', new DocuSignAPI.DeleteEnvelopesResponse_element());
    }
    else if(request instanceOf DocuSignAPI.EnvelopeAuditEvents_element) {
      response.put( 'response_x', new DocuSignAPI.EnvelopeAuditEventsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.ExportAuthoritativeCopy_element) {
      response.put( 'response_x', new DocuSignAPI.ExportAuthoritativeCopyResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetAccountBrands_element) {
      response.put( 'response_x', new DocuSignAPI.GetAccountBrandsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetAccountMembershipFeaturesList_element) {
      response.put( 'response_x', new DocuSignAPI.GetAccountMembershipFeaturesListResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetAccountSettingsList_element) {
      response.put( 'response_x', new DocuSignAPI.GetAccountSettingsListResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetAddressBookItems_element) {
      response.put( 'response_x', new DocuSignAPI.GetAddressBookItemsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetAuthenticationToken_element) {
      response.put( 'response_x', new DocuSignAPI.GetAuthenticationTokenResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetConnectFailures_element) {
      response.put( 'response_x', new DocuSignAPI.GetConnectFailuresResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetFolderItems_element) {
      response.put( 'response_x', new DocuSignAPI.GetFolderItemsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetFolderList_element) {
      response.put( 'response_x', new DocuSignAPI.GetFolderListResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetRecipientEsignList_element) {
      response.put( 'response_x', new DocuSignAPI.GetRecipientEsignListResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetRecipientList_element) {
      response.put( 'response_x', new DocuSignAPI.GetRecipientListResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetSharedAccess_element) {
      response.put( 'response_x', new DocuSignAPI.GetSharedAccessResponse_element());
    }
    else if(request instanceOf DocuSignAPI.GetStatusInDocuSignConnectFormat_element) {
      response.put( 'response_x', new DocuSignAPI.GetStatusInDocuSignConnectFormatResponse_element());
    }
    else if(request instanceOf DocuSignAPI.MoveEnvelopes_element) {
      response.put( 'response_x', new DocuSignAPI.MoveEnvelopesResponse_element());
    }
    else if(request instanceOf DocuSignAPI.Ping_element) {
      response.put( 'response_x', new DocuSignAPI.PingResponse_element());
    }
    else if(request instanceOf DocuSignAPI.PublishConnectFailures_element) {
      response.put( 'response_x', new DocuSignAPI.PublishConnectFailuresResponse_element());
    }
    else if(request instanceOf DocuSignAPI.PurgeDocuments_element) {
      response.put( 'response_x', new DocuSignAPI.PurgeDocumentsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.PurgeDocumentsAndMetaData_element) {
      response.put( 'response_x', new DocuSignAPI.PurgeDocumentsAndMetaDataResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RemoveAddressBookItems_element) {
      response.put( 'response_x', new DocuSignAPI.RemoveAddressBookItemsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestCertificate_element) {
      response.put( 'response_x', new DocuSignAPI.RequestCertificateResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestCorrectToken_element) {
      response.put( 'response_x', new DocuSignAPI.RequestCorrectTokenResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestDocumentPDFs_element) {
      response.put( 'response_x', new DocuSignAPI.RequestDocumentPDFsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestDocumentPDFsEx_element) {
      response.put( 'response_x', new DocuSignAPI.RequestDocumentPDFsExResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestDocumentPDFsRecipientsView_element) {
      response.put( 'response_x', new DocuSignAPI.RequestDocumentPDFsRecipientsViewResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestEnvelope_element) {
      response.put( 'response_x', new DocuSignAPI.RequestEnvelopeResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestEnvelopeWithDocumentFields_element) {
      response.put( 'response_x', new DocuSignAPI.RequestEnvelopeWithDocumentFieldsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestPDF_element) {
      response.put( 'response_x', new DocuSignAPI.RequestPDFResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestPDFNoWaterMark_element) {
      response.put( 'response_x', new DocuSignAPI.RequestPDFNoWaterMarkResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestPDFRecipientsView_element) {
      response.put( 'response_x', new DocuSignAPI.RequestPDFRecipientsViewResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestPDFsWithOptions_element) {
      response.put( 'response_x', new DocuSignAPI.RequestPDFsWithOptionsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestPDFWithCert_element) {
      response.put( 'response_x', new DocuSignAPI.RequestPDFWithCertResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestPDFWithOptions_element) {
      response.put( 'response_x', new DocuSignAPI.RequestPDFWithOptionsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestRecipientFaxPDF_element) {
      response.put( 'response_x', new DocuSignAPI.RequestRecipientFaxPDFResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestRecipientFaxToken_element) {
      response.put( 'response_x', new DocuSignAPI.RequestRecipientFaxTokenResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestRecipientToken_element) {
      response.put( 'response_x', new DocuSignAPI.RequestRecipientTokenResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestSenderToken_element) {
      response.put( 'response_x', new DocuSignAPI.RequestSenderTokenResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestStatus_element) {
      response.put( 'response_x', new DocuSignAPI.RequestStatusResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestStatusChanges_element) {
      response.put( 'response_x', new DocuSignAPI.RequestStatusChangesResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestStatusCodes_element) {
      response.put( 'response_x', new DocuSignAPI.RequestStatusCodesResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestStatuses_element) {
      response.put( 'response_x', new DocuSignAPI.RequestStatusesResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestStatusesEx_element) {
      response.put( 'response_x', new DocuSignAPI.RequestStatusesExResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestStatusesWithDocumentFields_element) {
      response.put( 'response_x', new DocuSignAPI.RequestStatusesWithDocumentFieldsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestStatusEx_element) {
      response.put( 'response_x', new DocuSignAPI.RequestStatusExResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestStatusWithDocumentFields_element) {
      response.put( 'response_x', new DocuSignAPI.RequestStatusWithDocumentFieldsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestTemplate_element) {
      response.put( 'response_x', new DocuSignAPI.RequestTemplateResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestTemplateList_element) {
      response.put( 'response_x', new DocuSignAPI.RequestTemplateListResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestTemplateListWithDocumentFields_element) {
      response.put( 'response_x', new DocuSignAPI.RequestTemplateListWithDocumentFieldsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestTemplates_element) {
      response.put( 'response_x', new DocuSignAPI.RequestTemplatesResponse_element());
    }
    else if(request instanceOf DocuSignAPI.RequestTemplateWithDocumentFields_element) {
      response.put( 'response_x', new DocuSignAPI.RequestTemplateWithDocumentFieldsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.SaveTemplate_element) {
      response.put( 'response_x', new DocuSignAPI.SaveTemplateResponse_element());
    }
    else if(request instanceOf DocuSignAPI.SendEnvelope_element) {
      response.put( 'response_x', new DocuSignAPI.SendEnvelopeResponse_element());
    }
    else if(request instanceOf DocuSignAPI.SetSharedAccess_element) {
      response.put( 'response_x', new DocuSignAPI.SetSharedAccessResponse_element());
    }
    else if(request instanceOf DocuSignAPI.SynchEnvelope_element) {
      response.put( 'response_x', new DocuSignAPI.SynchEnvelopeResponse_element());
    }
    else if(request instanceOf DocuSignAPI.TransferEnvelope_element) {
      response.put( 'response_x', new DocuSignAPI.TransferEnvelopeResponse_element());
    }
    else if(request instanceOf DocuSignAPI.UpdateAddressBookItems_element) {
      response.put( 'response_x', new DocuSignAPI.UpdateAddressBookItemsResponse_element());
    }
    else if(request instanceOf DocuSignAPI.UploadTemplate_element) {
      response.put( 'response_x', new DocuSignAPI.UploadTemplateResponse_element());
    }
    else if(request instanceOf DocuSignAPI.VoidEnvelope_element) {
      response.put( 'response_x', new DocuSignAPI.VoidEnvelopeResponse_element());
    }
  }*/
}