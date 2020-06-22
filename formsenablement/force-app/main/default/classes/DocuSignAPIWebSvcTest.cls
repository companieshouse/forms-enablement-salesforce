@isTest
private class DocuSignAPIWebSvcTest {
  /*
  @isTest static void coverGeneratedCodeTypes() {
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI parentObject = new DocuSignAPI();
    new DocuSignAPI.AccountMembershipFeaturesList();
    new DocuSignAPI.AccountSetting();
    new DocuSignAPI.AccountSettingsList();
    new DocuSignAPI.AcknowledgeAuthoritativeCopyExport_element();
    new DocuSignAPI.AcknowledgeAuthoritativeCopyExportResponse_element();
    new DocuSignAPI.AddressBookItem();
    new DocuSignAPI.AddressBookPhoneNumber();
    new DocuSignAPI.AddressBookRemoveItem();
    new DocuSignAPI.AddressInformation();
    new DocuSignAPI.AddressInformationInput();
    new DocuSignAPI.AnchorTab();
    new DocuSignAPI.ArrayOfAddressBookItem();
    new DocuSignAPI.ArrayOfAddressBookItem1();
    new DocuSignAPI.ArrayOfAddressBookRemoveItem();
    new DocuSignAPI.ArrayOfAttachment();
    new DocuSignAPI.ArrayOfBCCEmailAddress();
    new DocuSignAPI.ArrayOfBrandRequestItem();
    new DocuSignAPI.ArrayOfBrandResultItem();
    new DocuSignAPI.ArrayOfCaptiveRecipient();
    new DocuSignAPI.ArrayOfCaptiveRecipient1();
    new DocuSignAPI.ArrayOfCompositeTemplate();
    new DocuSignAPI.ArrayOfConnectFailure();
    new DocuSignAPI.ArrayOfCustomField();
    new DocuSignAPI.ArrayOfDocument();
    new DocuSignAPI.ArrayOfDocumentField();
    new DocuSignAPI.ArrayOfDocumentPDF();
    new DocuSignAPI.ArrayOfDocumentStatus();
    new DocuSignAPI.ArrayOfEnvelopeEvent();
    new DocuSignAPI.ArrayOfEnvelopeStatus();
    new DocuSignAPI.ArrayOfEnvelopeStatusChange();
    new DocuSignAPI.ArrayOfEnvelopeStatusCode();
    new DocuSignAPI.ArrayOfEnvelopeTemplate();
    new DocuSignAPI.ArrayOfFolder();
    new DocuSignAPI.ArrayOfFolderItem();
    new DocuSignAPI.ArrayOfFormDataXfdfField();
    new DocuSignAPI.ArrayOfInlineTemplate();
    new DocuSignAPI.ArrayOfMatchBox();
    new DocuSignAPI.ArrayOfPositiveInteger();
    new DocuSignAPI.ArrayOfPublishConnectFailuresResult();
    new DocuSignAPI.ArrayOfRecipient();
    new DocuSignAPI.ArrayOfRecipient1();
    new DocuSignAPI.ArrayOfRecipientCorrection();
    new DocuSignAPI.ArrayOfRecipientCorrectionStatus();
    new DocuSignAPI.ArrayOfRecipientEsign();
    new DocuSignAPI.ArrayOfRecipientEvent();
    new DocuSignAPI.ArrayOfRecipientStatus();
    new DocuSignAPI.ArrayOfSAMLAttribute();
    new DocuSignAPI.ArrayOfServerTemplate();
    new DocuSignAPI.ArrayOfString();
    new DocuSignAPI.ArrayOfString1();
    new DocuSignAPI.ArrayOfString2();
    new DocuSignAPI.ArrayOfString3();
    new DocuSignAPI.ArrayOfString4();
    new DocuSignAPI.ArrayOfString5();
    new DocuSignAPI.ArrayOfString6();
    new DocuSignAPI.ArrayOfTab();
    new DocuSignAPI.ArrayOfTabStatus();
    new DocuSignAPI.ArrayOfTemplateReference();
    new DocuSignAPI.ArrayOfTemplateReferenceFieldDataDataValue();
    new DocuSignAPI.ArrayOfTemplateReferenceRoleAssignment();
    new DocuSignAPI.Attachment();
    new DocuSignAPI.AuthenticationStatus();
    new DocuSignAPI.AuthoritativeCopyExportDocuments();
    new DocuSignAPI.AuthoritativeCopyExportStatus();
    new DocuSignAPI.AvailableFolders();
    new DocuSignAPI.BCCEmailAddress();
    new DocuSignAPI.BrandDefinitions();
    new DocuSignAPI.BrandDeleteRequest();
    new DocuSignAPI.BrandRequestItem();
    new DocuSignAPI.BrandResultItem();
    new DocuSignAPI.BrandResults();
    new DocuSignAPI.CaptiveRecipient();
    new DocuSignAPI.CaptiveRecipientResults();
    new DocuSignAPI.CompositeTemplate();
    new DocuSignAPI.ConnectFailure();
    new DocuSignAPI.ConnectFailuresFilter();
    new DocuSignAPI.CorrectAndResendEnvelope_element();
    new DocuSignAPI.CorrectAndResendEnvelopeResponse_element();
    new DocuSignAPI.Correction();
    new DocuSignAPI.CorrectionStatus();
    new DocuSignAPI.CreateAccountBrands_element();
    new DocuSignAPI.CreateAccountBrandsResponse_element();
    new DocuSignAPI.CreateAndSendEnvelope_element();
    new DocuSignAPI.CreateAndSendEnvelopeResponse_element();
    new DocuSignAPI.CreateEnvelope_element();
    new DocuSignAPI.CreateEnvelopeFromTemplates_element();
    new DocuSignAPI.CreateEnvelopeFromTemplatesAndForms_element();
    new DocuSignAPI.CreateEnvelopeFromTemplatesAndFormsResponse_element();
    new DocuSignAPI.CreateEnvelopeFromTemplatesResponse_element();
    new DocuSignAPI.CreateEnvelopeResponse_element();
    new DocuSignAPI.CustomField();
    new DocuSignAPI.DeleteAccountBrands_element();
    new DocuSignAPI.DeleteAccountBrandsResponse_element();
    new DocuSignAPI.DeleteCaptiveRecipientsSignatures_element();
    new DocuSignAPI.DeleteCaptiveRecipientsSignaturesArg();
    new DocuSignAPI.DeleteCaptiveRecipientsSignaturesResponse_element();
    new DocuSignAPI.DeleteEnvelopes_element();
    new DocuSignAPI.DeleteEnvelopesArg();
    new DocuSignAPI.DeleteEnvelopesResponse_element();
    new DocuSignAPI.DOBInformation();
    new DocuSignAPI.DOBInformationInput();
    new DocuSignAPI.Document();
    new DocuSignAPI.DocumentField();
    new DocuSignAPI.DocumentPDF();
    new DocuSignAPI.DocumentPDFs();
    new DocuSignAPI.DocumentStatus();
    new DocuSignAPI.DocuSignEnvelopeInformation();
    new DocuSignAPI.EmailSettings();
    new DocuSignAPI.Envelope();
    new DocuSignAPI.EnvelopeAuditEvents_element();
    new DocuSignAPI.EnvelopeAuditEventsResponse_element();
    new DocuSignAPI.EnvelopeAuditEventsResponse_EnvelopeAuditEventsResult_element();
    new DocuSignAPI.EnvelopeEvent();
    new DocuSignAPI.EnvelopeInformation();
    new DocuSignAPI.EnvelopePDF();
    new DocuSignAPI.EnvelopeSettings();
    new DocuSignAPI.EnvelopeStatus();
    new DocuSignAPI.EnvelopeStatusChange();
    new DocuSignAPI.EnvelopeStatusChangeFilter();
    new DocuSignAPI.EnvelopeStatusFilter();
    new DocuSignAPI.EnvelopeStatusFilterBeginDateTime();
    new DocuSignAPI.EnvelopeTemplate();
    new DocuSignAPI.EnvelopeTemplateDefinition();
    new DocuSignAPI.EnvelopeTemplates();
    new DocuSignAPI.ErrorDetails();
    new DocuSignAPI.EventNotification();
    new DocuSignAPI.EventResult();
    new DocuSignAPI.Expirations();
    new DocuSignAPI.ExportAuthoritativeCopy_element();
    new DocuSignAPI.ExportAuthoritativeCopyResponse_element();
    new DocuSignAPI.FilteredEnvelopeStatusChanges();
    new DocuSignAPI.FilteredEnvelopeStatuses();
    new DocuSignAPI.Folder();
    new DocuSignAPI.FolderFilter();
    new DocuSignAPI.FolderItem();
    new DocuSignAPI.FolderResults();
    new DocuSignAPI.FoldersFilter();
    new DocuSignAPI.FolderTypeInfo();
    new DocuSignAPI.FormData();
    new DocuSignAPI.FormDataXfdf();
    new DocuSignAPI.FormDataXfdfField();
    new DocuSignAPI.GetAccountBrands_element();
    new DocuSignAPI.GetAccountBrandsResponse_element();
    new DocuSignAPI.GetAccountMembershipFeaturesList_element();
    new DocuSignAPI.GetAccountMembershipFeaturesListResponse_element();
    new DocuSignAPI.GetAccountSettingsList_element();
    new DocuSignAPI.GetAccountSettingsListResponse_element();
    new DocuSignAPI.GetAddressBookItems_element();
    new DocuSignAPI.GetAddressBookItemsResponse_element();
    new DocuSignAPI.GetAuthenticationToken_element();
    new DocuSignAPI.GetAuthenticationTokenResponse_element();
    new DocuSignAPI.GetConnectFailures_element();
    new DocuSignAPI.GetConnectFailuresResponse_element();
    new DocuSignAPI.GetFolderItems_element();
    new DocuSignAPI.GetFolderItemsResponse_element();
    new DocuSignAPI.GetFolderList_element();
    new DocuSignAPI.GetFolderListResponse_element();
    new DocuSignAPI.GetRecipientEsignList_element();
    new DocuSignAPI.GetRecipientEsignListResponse_element();
    new DocuSignAPI.GetRecipientList_element();
    new DocuSignAPI.GetRecipientListResponse_element();
    new DocuSignAPI.GetSharedAccess_element();
    new DocuSignAPI.GetSharedAccessResponse_element();
    new DocuSignAPI.GetSharedAccessResult();
    new DocuSignAPI.GetStatusInDocuSignConnectFormat_element();
    new DocuSignAPI.GetStatusInDocuSignConnectFormatResponse_element();
    new DocuSignAPI.IDCheckInformation();
    new DocuSignAPI.IDCheckInformationInput();
    new DocuSignAPI.InlineTemplate();
    new DocuSignAPI.MatchBox();
    new DocuSignAPI.MoveEnvelopes_element();
    new DocuSignAPI.MoveEnvelopesArg();
    new DocuSignAPI.MoveEnvelopesResponse_element();
    new DocuSignAPI.Notification();
    new DocuSignAPI.PDFMetaDataTemplate();
    new DocuSignAPI.PDFOptions();
    new DocuSignAPI.PDFsOptions();
    new DocuSignAPI.Ping_element();
    new DocuSignAPI.PingResponse_element();
    new DocuSignAPI.PublishConnectFailures_element();
    new DocuSignAPI.PublishConnectFailuresFilter();
    new DocuSignAPI.PublishConnectFailuresResponse_element();
    new DocuSignAPI.PublishConnectFailuresResult();
    new DocuSignAPI.PurgeDocuments_element();
    new DocuSignAPI.PurgeDocumentsAndMetaData_element();
    new DocuSignAPI.PurgeDocumentsAndMetaDataResponse_element();
    new DocuSignAPI.PurgeDocumentsResponse_element();
    new DocuSignAPI.PurgeDocumentStatus();
    new DocuSignAPI.Recipient();
    new DocuSignAPI.RecipientCaptiveInfo();
    new DocuSignAPI.RecipientCorrection();
    new DocuSignAPI.RecipientCorrectionCorrectedCaptiveInfo();
    new DocuSignAPI.RecipientCorrectionStatus();
    new DocuSignAPI.RecipientEmailNotification();
    new DocuSignAPI.RecipientEsign();
    new DocuSignAPI.RecipientEsignList();
    new DocuSignAPI.RecipientEvent();
    new DocuSignAPI.RecipientList();
    new DocuSignAPI.RecipientPhoneAuthentication();
    new DocuSignAPI.RecipientSAMLAuthentication();
    new DocuSignAPI.RecipientSignatureInfo();
    new DocuSignAPI.RecipientSMSAuthentication();
    new DocuSignAPI.RecipientStatus();
    new DocuSignAPI.RecipientStatusEsignAgreementInformation();
    new DocuSignAPI.Reminders();
    new DocuSignAPI.RemoveAddressBookItems_element();
    new DocuSignAPI.RemoveAddressBookItemsResponse_element();
    new DocuSignAPI.RequestCertificate_element();
    new DocuSignAPI.RequestCertificateResponse_element();
    new DocuSignAPI.RequestCorrectToken_element();
    new DocuSignAPI.RequestCorrectTokenResponse_element();
    new DocuSignAPI.RequestDocumentPDFs_element();
    new DocuSignAPI.RequestDocumentPDFsEx_element();
    new DocuSignAPI.RequestDocumentPDFsExResponse_element();
    new DocuSignAPI.RequestDocumentPDFsRecipientsView_element();
    new DocuSignAPI.RequestDocumentPDFsRecipientsViewResponse_element();
    new DocuSignAPI.RequestDocumentPDFsResponse_element();
    new DocuSignAPI.RequestEnvelope_element();
    new DocuSignAPI.RequestEnvelopeResponse_element();
    new DocuSignAPI.RequestEnvelopeWithDocumentFields_element();
    new DocuSignAPI.RequestEnvelopeWithDocumentFieldsResponse_element();
    new DocuSignAPI.RequestPDF_element();
    new DocuSignAPI.RequestPDFNoWaterMark_element();
    new DocuSignAPI.RequestPDFNoWaterMarkResponse_element();
    new DocuSignAPI.RequestPDFRecipientsView_element();
    new DocuSignAPI.RequestPDFRecipientsViewResponse_element();
    new DocuSignAPI.RequestPDFResponse_element();
    new DocuSignAPI.RequestPDFsWithOptions_element();
    new DocuSignAPI.RequestPDFsWithOptionsResponse_element();
    new DocuSignAPI.RequestPDFWithCert_element();
    new DocuSignAPI.RequestPDFWithCertResponse_element();
    new DocuSignAPI.RequestPDFWithOptions_element();
    new DocuSignAPI.RequestPDFWithOptionsResponse_element();
    new DocuSignAPI.RequestRecipientFaxPDF_element();
    new DocuSignAPI.RequestRecipientFaxPDFResponse_element();
    new DocuSignAPI.RequestRecipientFaxToken_element();
    new DocuSignAPI.RequestRecipientFaxTokenResponse_element();
    new DocuSignAPI.RequestRecipientToken_element();
    new DocuSignAPI.RequestRecipientTokenAuthenticationAssertion();
    new DocuSignAPI.RequestRecipientTokenClientURLs();
    new DocuSignAPI.RequestRecipientTokenResponse_element();
    new DocuSignAPI.RequestSenderToken_element();
    new DocuSignAPI.RequestSenderTokenResponse_element();
    new DocuSignAPI.RequestStatus_element();
    new DocuSignAPI.RequestStatusChanges_element();
    new DocuSignAPI.RequestStatusChangesResponse_element();
    new DocuSignAPI.RequestStatusCodes_element();
    new DocuSignAPI.RequestStatusCodesResponse_element();
    new DocuSignAPI.RequestStatuses_element();
    new DocuSignAPI.RequestStatusesEx_element();
    new DocuSignAPI.RequestStatusesExResponse_element();
    new DocuSignAPI.RequestStatusesResponse_element();
    new DocuSignAPI.RequestStatusesWithDocumentFields_element();
    new DocuSignAPI.RequestStatusesWithDocumentFieldsResponse_element();
    new DocuSignAPI.RequestStatusEx_element();
    new DocuSignAPI.RequestStatusExResponse_element();
    new DocuSignAPI.RequestStatusResponse_element();
    new DocuSignAPI.RequestStatusWithDocumentFields_element();
    new DocuSignAPI.RequestStatusWithDocumentFieldsResponse_element();
    new DocuSignAPI.RequestTemplate_element();
    new DocuSignAPI.RequestTemplateList_element();
    new DocuSignAPI.RequestTemplateListResponse_element();
    new DocuSignAPI.RequestTemplateListWithDocumentFields_element();
    new DocuSignAPI.RequestTemplateListWithDocumentFieldsResponse_element();
    new DocuSignAPI.RequestTemplateResponse_element();
    new DocuSignAPI.RequestTemplates_element();
    new DocuSignAPI.RequestTemplatesResponse_element();
    new DocuSignAPI.RequestTemplateWithDocumentFields_element();
    new DocuSignAPI.RequestTemplateWithDocumentFieldsResponse_element();
    new DocuSignAPI.SAMLAttribute();
    new DocuSignAPI.SaveTemplate_element();
    new DocuSignAPI.SaveTemplateResponse_element();
    new DocuSignAPI.SaveTemplateResult();
    new DocuSignAPI.SendEnvelope_element();
    new DocuSignAPI.SendEnvelopeResponse_element();
    new DocuSignAPI.ServerTemplate();
    new DocuSignAPI.SetSharedAccess_element();
    new DocuSignAPI.SetSharedAccessRequest();
    new DocuSignAPI.SetSharedAccessResponse_element();
    new DocuSignAPI.SetSharedAccessResult();
    new DocuSignAPI.SharedAccessFilter();
    new DocuSignAPI.SharedAccessItemResult();
    new DocuSignAPI.SharedItemRequest();
    new DocuSignAPI.SharedItemResult();
    new DocuSignAPI.SharedItems();
    new DocuSignAPI.SharedUserInfoRequest();
    new DocuSignAPI.SharedUserInfoResult();
    new DocuSignAPI.SSN4Information();
    new DocuSignAPI.SSN4InformationInput();
    new DocuSignAPI.SSN9Information();
    new DocuSignAPI.SSN9InformationInput();
    new DocuSignAPI.SynchEnvelope_element();
    new DocuSignAPI.SynchEnvelopeResponse_element();
    new DocuSignAPI.SynchEnvelopeStatus();
    new DocuSignAPI.Tab();
    new DocuSignAPI.TabStatus();
    new DocuSignAPI.TemplateReference();
    new DocuSignAPI.TemplateReferenceFieldData();
    new DocuSignAPI.TemplateReferenceFieldDataDataValue();
    new DocuSignAPI.TemplateReferenceRoleAssignment();
    new DocuSignAPI.TransferEnvelope_element();
    new DocuSignAPI.TransferEnvelopeResponse_element();
    new DocuSignAPI.TransferEnvelopeStatus();
    new DocuSignAPI.UpdateAddressBookItems_element();
    new DocuSignAPI.UpdateAddressBookItemsResponse_element();
    new DocuSignAPI.UpdateAddressBookResult();
    new DocuSignAPI.UploadTemplate_element();
    new DocuSignAPI.UploadTemplateResponse_element();
    new DocuSignAPI.UserInfo();
    new DocuSignAPI.VaultingDetails();
    new DocuSignAPI.VaultingOptions();
    new DocuSignAPI.VoidEnvelope_element();
    new DocuSignAPI.VoidEnvelopeResponse_element();
    new DocuSignAPI.VoidEnvelopeStatus();
  }
  @isTest static void coverCodeForAcknowledgeAuthoritativeCopyExport(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.AcknowledgeAuthoritativeCopyExport(null, null, null));
  }
  @isTest static void coverCodeForCorrectAndResendEnvelope(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.CorrectAndResendEnvelope(null));
  }
  @isTest static void coverCodeForCreateAccountBrands(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.CreateAccountBrands(null, null));
  }
  @isTest static void coverCodeForCreateAndSendEnvelope(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.CreateAndSendEnvelope(null));
  }
  @isTest static void coverCodeForCreateEnvelope(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.CreateEnvelope(null));
  }
  @isTest static void coverCodeForCreateEnvelopeFromTemplates(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.CreateEnvelopeFromTemplates(null, null, null, null));
  }
  @isTest static void coverCodeForCreateEnvelopeFromTemplatesAndForms(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.CreateEnvelopeFromTemplatesAndForms(null, null, null));
  }
  @isTest static void coverCodeForDeleteAccountBrands(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.DeleteAccountBrands(null, null));
  }
  @isTest static void coverCodeForDeleteCaptiveRecipientsSignatures(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.DeleteCaptiveRecipientsSignatures(null, null));
  }
  @isTest static void coverCodeForDeleteEnvelopes(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.DeleteEnvelopes(null));
  }
  @isTest static void coverCodeForEnvelopeAuditEvents(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.EnvelopeAuditEvents(null));
  }
  @isTest static void coverCodeForExportAuthoritativeCopy(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.ExportAuthoritativeCopy(null));
  }
  @isTest static void coverCodeForGetAccountBrands(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetAccountBrands(null));
  }
  @isTest static void coverCodeForGetAccountMembershipFeaturesList(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetAccountMembershipFeaturesList(null));
  }
  @isTest static void coverCodeForGetAccountSettingsList(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetAccountSettingsList(null));
  }
  @isTest static void coverCodeForGetAddressBookItems(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetAddressBookItems(null));
  }
  @isTest static void coverCodeForGetAuthenticationToken(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetAuthenticationToken(null));
  }
  @isTest static void coverCodeForGetConnectFailures(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetConnectFailures(null));
  }
  @isTest static void coverCodeForGetFolderItems(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetFolderItems(null));
  }
  @isTest static void coverCodeForGetFolderList(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetFolderList(null));
  }
  @isTest static void coverCodeForGetRecipientEsignList(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetRecipientEsignList(null, null, null, null));
  }
  @isTest static void coverCodeForGetRecipientList(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetRecipientList(null, null));
  }
  @isTest static void coverCodeForGetSharedAccess(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetSharedAccess(null, null));
  }
  @isTest static void coverCodeForGetStatusInDocuSignConnectFormat(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.GetStatusInDocuSignConnectFormat(null));
  }
  @isTest static void coverCodeForMoveEnvelopes(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.MoveEnvelopes(null));
  }
  @isTest static void coverCodeForPing(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.Ping());
  }
  @isTest static void coverCodeForPublishConnectFailures(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.PublishConnectFailures(null));
  }
  @isTest static void coverCodeForPurgeDocuments(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.PurgeDocuments(null));
  }
  @isTest static void coverCodeForPurgeDocumentsAndMetaData(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.PurgeDocumentsAndMetaData(null));
  }
  @isTest static void coverCodeForRemoveAddressBookItems(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RemoveAddressBookItems(null, null));
  }
  @isTest static void coverCodeForRequestCertificate(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestCertificate(null));
  }
  @isTest static void coverCodeForRequestCorrectToken(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestCorrectToken(null, null, null));
  }
  @isTest static void coverCodeForRequestDocumentPDFs(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestDocumentPDFs(null));
  }
  @isTest static void coverCodeForRequestDocumentPDFsEx(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestDocumentPDFsEx(null));
  }
  @isTest static void coverCodeForRequestDocumentPDFsRecipientsView(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestDocumentPDFsRecipientsView(null, null, null));
  }
  @isTest static void coverCodeForRequestEnvelope(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestEnvelope(null, null));
  }
  @isTest static void coverCodeForRequestEnvelopeWithDocumentFields(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestEnvelopeWithDocumentFields(null, null));
  }
  @isTest static void coverCodeForRequestPDF(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestPDF(null));
  }
  @isTest static void coverCodeForRequestPDFNoWaterMark(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestPDFNoWaterMark(null));
  }
  @isTest static void coverCodeForRequestPDFRecipientsView(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestPDFRecipientsView(null, null, null, null));
  }
  @isTest static void coverCodeForRequestPDFsWithOptions(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestPDFsWithOptions(null, null));
  }
  @isTest static void coverCodeForRequestPDFWithCert(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestPDFWithCert(null, null));
  }
  @isTest static void coverCodeForRequestPDFWithOptions(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestPDFWithOptions(null, null));
  }
  @isTest static void coverCodeForRequestRecipientFaxPDF(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestRecipientFaxPDF(null, null, null, null, null));
  }
  @isTest static void coverCodeForRequestRecipientFaxToken(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestRecipientFaxToken(null, null, null, null, null, null));
  }
  @isTest static void coverCodeForRequestRecipientToken(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestRecipientToken(null, null, null, null, null, null));
  }
  @isTest static void coverCodeForRequestSenderToken(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestSenderToken(null, null, null));
  }
  @isTest static void coverCodeForRequestStatus(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestStatus(null));
  }
  @isTest static void coverCodeForRequestStatusChanges(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestStatusChanges(null));
  }
  @isTest static void coverCodeForRequestStatusCodes(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestStatusCodes(null));
  }
  @isTest static void coverCodeForRequestStatuses(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestStatuses(null));
  }
  @isTest static void coverCodeForRequestStatusesEx(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestStatusesEx(null));
  }
  @isTest static void coverCodeForRequestStatusesWithDocumentFields(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestStatusesWithDocumentFields(null));
  }
  @isTest static void coverCodeForRequestStatusEx(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestStatusEx(null));
  }
  @isTest static void coverCodeForRequestStatusWithDocumentFields(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestStatusWithDocumentFields(null));
  }
  @isTest static void coverCodeForRequestTemplate(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestTemplate(null, null));
  }
  @isTest static void coverCodeForRequestTemplateList(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestTemplateList(null, null));
  }
  @isTest static void coverCodeForRequestTemplateListWithDocumentFields(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestTemplateListWithDocumentFields(null, null));
  }
  @isTest static void coverCodeForRequestTemplates(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestTemplates(null, null));
  }
  @isTest static void coverCodeForRequestTemplateWithDocumentFields(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.RequestTemplateWithDocumentFields(null, null));
  }
  @isTest static void coverCodeForSaveTemplate(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.SaveTemplate(null));
  }
  @isTest static void coverCodeForSendEnvelope(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.SendEnvelope(null, null));
  }
  @isTest static void coverCodeForSetSharedAccess(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.SetSharedAccess(null));
  }
  @isTest static void coverCodeForSynchEnvelope(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.SynchEnvelope(null, null, null));
  }
  @isTest static void coverCodeForTransferEnvelope(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.TransferEnvelope(null, null, null));
  }
  @isTest static void coverCodeForUpdateAddressBookItems(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.UpdateAddressBookItems(null, null));
  }
  @isTest static void coverCodeForUploadTemplate(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.UploadTemplate(null, null, null));
  }
  @isTest static void coverCodeForVoidEnvelope(){
    Test.setMock(WebServiceMock.class, new DocuSignAPIMockImpl());
    DocuSignAPI.APIServiceSoap testObject = new DocuSignAPI.APIServiceSoap();
    System.assertEquals(null, testObject.VoidEnvelope(null, null));
  }*/
}