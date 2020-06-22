//Generated DocusignResponsiveAPIMock by FuseIT WSDL2Apex (http://www.fuseit.com/Solutions/SFDC-Explorer/Help-WSDL-Parser.aspx)

@isTest
public class DocusignResponsiveAPIMock implements WebServiceMock {
	public void doInvoke(
			Object stub,
			Object request,
			Map<String, Object> response,
			String endpoint,
			String soapAction,
			String requestName,
			String responseNS,
			String responseName,
			String responseType) {
       
		System.debug(LoggingLevel.INFO, 'DocusignResponsiveAPIMock.doInvoke() - ' +
			'\n request: ' + request +
			'\n response: ' + response +
			'\n endpoint: ' + endpoint +
			'\n soapAction: ' + soapAction +
			'\n requestName: ' + requestName +
			'\n responseNS: ' + responseNS +
			'\n responseName: ' + responseName +
			'\n responseType: ' + responseType);

		if(request instanceOf DocusignResponsiveAPI.AcknowledgeAuthoritativeCopyExport_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.AcknowledgeAuthoritativeCopyExportResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.CompleteAuthoritativeCopyExport_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.CompleteAuthoritativeCopyExportResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.CorrectAndResendEnvelope_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.CorrectAndResendEnvelopeResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.CreateAccountBrands_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.CreateAccountBrandsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.CreateAndSendEnvelope_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.CreateAndSendEnvelopeResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.CreateEnvelope_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.CreateEnvelopeResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.CreateEnvelopeFromTemplates_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.CreateEnvelopeFromTemplatesResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.CreateEnvelopeFromTemplatesAndForms_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.CreateEnvelopeFromTemplatesAndFormsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.DeleteAccountBrands_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.DeleteAccountBrandsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.DeleteCaptiveRecipientsSignatures_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.DeleteCaptiveRecipientsSignaturesResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.DeleteEnvelopes_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.DeleteEnvelopesResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.EnvelopeAuditEvents_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.EnvelopeAuditEventsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.EnvelopeAuditEventsV2_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.EnvelopeAuditEventsV2Response_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.ExportAuthoritativeCopy_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.ExportAuthoritativeCopyResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetAccountBrands_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetAccountBrandsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetAccountMembershipFeaturesList_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetAccountMembershipFeaturesListResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetAccountSettingsList_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetAccountSettingsListResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetAddressBookItems_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetAddressBookItemsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetAuthenticationToken_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetAuthenticationTokenResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetAuthoritativeCopyExportKey_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetAuthoritativeCopyExportKeyResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetConnectFailures_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetConnectFailuresResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetFolderItems_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetFolderItemsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetFolderList_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetFolderListResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetRecipientAuthenticationStatusEx_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetRecipientAuthenticationStatusExResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetRecipientEsignList_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetRecipientEsignListResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetRecipientList_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetRecipientListResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetSharedAccess_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetSharedAccessResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.GetStatusInDocuSignConnectFormat_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.GetStatusInDocuSignConnectFormatResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.MoveEnvelopes_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.MoveEnvelopesResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.Ping_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.PingResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.PublishConnectFailures_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.PublishConnectFailuresResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.PurgeDocuments_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.PurgeDocumentsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.PurgeDocumentsAndMetaData_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.PurgeDocumentsAndMetaDataResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.PurgeDocumentsAndMetaDataAndRedact_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.PurgeDocumentsAndMetaDataAndRedactResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RemoveAddressBookItems_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RemoveAddressBookItemsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestCertificate_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestCertificateResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestCertificateWithCertLanguage_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestCertificateWithCertLanguageResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestCorrectToken_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestCorrectTokenResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestDocumentPDFs_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestDocumentPDFsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestDocumentPDFsEx_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestDocumentPDFsExResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestDocumentPDFsRecipientsView_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestDocumentPDFsRecipientsViewResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestEnvelope_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestEnvelopeResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestEnvelopeHistoryToken_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestEnvelopeHistoryTokenResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestEnvelopeV2_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestEnvelopeV2Response_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestEnvelopeWithDocumentFields_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsV2_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsV2Response_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestPDF_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestPDFResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestPDFNoWaterMark_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestPDFNoWaterMarkResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestPDFRecipientsView_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestPDFRecipientsViewResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestPDFsWithOptions_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestPDFsWithOptionsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestPDFWithCert_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestPDFWithCertResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestPDFWithOptions_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestPDFWithOptionsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestRecipientFaxPDF_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestRecipientFaxPDFResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestRecipientFaxToken_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestRecipientFaxTokenResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestRecipientToken_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestRecipientTokenResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestSenderToken_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestSenderTokenResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestStatus_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestStatusResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestStatusChanges_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestStatusChangesResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestStatusCodes_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestStatusCodesResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestStatuses_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestStatusesResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestStatusesEx_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestStatusesExResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestStatusesWithDocumentFields_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestStatusesWithDocumentFieldsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestStatusEx_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestStatusExResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestStatusWithDocumentFields_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestStatusWithDocumentFieldsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestTemplate_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestTemplateResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestTemplateList_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestTemplateListResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestTemplateListWithDocumentFields_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestTemplateListWithDocumentFieldsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestTemplates_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestTemplatesResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.RequestTemplateWithDocumentFields_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.RequestTemplateWithDocumentFieldsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.SaveTemplate_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.SaveTemplateResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.SendEnvelope_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.SendEnvelopeResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.SetSharedAccess_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.SetSharedAccessResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.SynchEnvelope_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.SynchEnvelopeResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.TransferEnvelope_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.TransferEnvelopeResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.UpdateAddressBookItems_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.UpdateAddressBookItemsResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.UploadTemplate_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.UploadTemplateResponse_element());
		}
		else if(request instanceOf DocusignResponsiveAPI.VoidEnvelope_element) {
			response.put( 'response_x', new DocusignResponsiveAPI.VoidEnvelopeResponse_element());
		}
	}
}