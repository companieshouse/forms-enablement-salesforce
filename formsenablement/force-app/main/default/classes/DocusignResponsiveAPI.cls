public inherited sharing class DocusignResponsiveAPI {
    public class AccountMembershipFeaturesList {
		public String Email;
		public String UserName;
		public DocusignResponsiveAPI.ArrayOfString4 EnabledFeaturesSet;
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EnabledFeaturesSet_type_info = new String[]{'EnabledFeaturesSet','http://www.docusign.net/API/3.0','ArrayOfString4','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Email','UserName','EnabledFeaturesSet'};
	}
	public class AccountSetting {
		public String Name;
		public String Value;
		public String Type_x;
		public String TestSetting;
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Value_type_info = new String[]{'Value','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Type_x_type_info = new String[]{'Type','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TestSetting_type_info = new String[]{'TestSetting','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Name','Value','Type_x','TestSetting'};
	}
	public class AccountSettingsList {
		public DocusignResponsiveAPI.AccountSetting[] AccountSetting;
		private transient String[] AccountSetting_type_info = new String[]{'AccountSetting','http://www.docusign.net/API/3.0','AccountSetting','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountSetting'};
	}
	public class AcknowledgeAuthoritativeCopyExport_element {
		public String EnvelopeId;
		public String TransactionId;
		public String checkSumHash;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TransactionId_type_info = new String[]{'TransactionId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] checkSumHash_type_info = new String[]{'checkSumHash','http://www.docusign.net/API/3.0','base64Binary','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','TransactionId','checkSumHash'};
	}
	public class AcknowledgeAuthoritativeCopyExportResponse_element {
		public DocusignResponsiveAPI.AuthoritativeCopyExportStatus AcknowledgeAuthoritativeCopyExportResult;
		private transient String[] AcknowledgeAuthoritativeCopyExportResult_type_info = new String[]{'AcknowledgeAuthoritativeCopyExportResult','http://www.docusign.net/API/3.0','AuthoritativeCopyExportStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AcknowledgeAuthoritativeCopyExportResult'};
	}
	public class AddressBookItem {
		public String AddressBookID;
		public String Email;
		public String UserName;
		public String AccountName;
		public Boolean Shared;
		public DateTime Created;
		public Boolean Owner;
		public DocusignResponsiveAPI.AddressBookPhoneNumber Phone1;
		public DocusignResponsiveAPI.AddressBookPhoneNumber Phone2;
		public DocusignResponsiveAPI.AddressBookPhoneNumber Phone3;
		public DocusignResponsiveAPI.AddressBookPhoneNumber Phone4;
		private transient String[] AddressBookID_type_info = new String[]{'AddressBookID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AccountName_type_info = new String[]{'AccountName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Shared_type_info = new String[]{'Shared','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] Created_type_info = new String[]{'Created','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Owner_type_info = new String[]{'Owner','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Phone1_type_info = new String[]{'Phone1','http://www.docusign.net/API/3.0','AddressBookPhoneNumber','0','1','false'};
		private transient String[] Phone2_type_info = new String[]{'Phone2','http://www.docusign.net/API/3.0','AddressBookPhoneNumber','0','1','false'};
		private transient String[] Phone3_type_info = new String[]{'Phone3','http://www.docusign.net/API/3.0','AddressBookPhoneNumber','0','1','false'};
		private transient String[] Phone4_type_info = new String[]{'Phone4','http://www.docusign.net/API/3.0','AddressBookPhoneNumber','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AddressBookID','Email','UserName','AccountName','Shared','Created','Owner','Phone1','Phone2','Phone3','Phone4'};
	}
	public class AddressBookPhoneNumber {
		public String PhoneNumber;
		public String Designation;
		private transient String[] PhoneNumber_type_info = new String[]{'PhoneNumber','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Designation_type_info = new String[]{'Designation','http://www.docusign.net/API/3.0','PhoneNumberDesignation','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PhoneNumber','Designation'};
	}
	public class AddressBookRemoveItem {
		public String AddressBookID;
		private transient String[] AddressBookID_type_info = new String[]{'AddressBookID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AddressBookID'};
	}
	public class AddressInformation {
		public String Street1;
		public String Street2;
		public String City;
		public String State;
		public String Zip;
		public String ZipPlus4;
		private transient String[] Street1_type_info = new String[]{'Street1','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Street2_type_info = new String[]{'Street2','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] City_type_info = new String[]{'City','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] State_type_info = new String[]{'State','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Zip_type_info = new String[]{'Zip','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ZipPlus4_type_info = new String[]{'ZipPlus4','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Street1','Street2','City','State','Zip','ZipPlus4'};
	}
	public class AddressInformationInput {
		public DocusignResponsiveAPI.AddressInformation AddressInformation;
		public String DisplayLevel;
		public Boolean ReceiveInResponse;
		private transient String[] AddressInformation_type_info = new String[]{'AddressInformation','http://www.docusign.net/API/3.0','AddressInformation','0','1','false'};
		private transient String[] DisplayLevel_type_info = new String[]{'DisplayLevel','http://www.docusign.net/API/3.0','DisplayLevelCode','0','1','false'};
		private transient String[] ReceiveInResponse_type_info = new String[]{'ReceiveInResponse','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AddressInformation','DisplayLevel','ReceiveInResponse'};
	}
	public class AnchorTab {
		public String AnchorTabString;
		public Double XOffset;
		public Double YOffset;
		public String Unit;
		public Boolean IgnoreIfNotPresent;
		public Boolean MatchWholeWord;
		public Boolean CaseSensitive;
		public String AnchorTabProcessorVersion;
		public String HorizontalAlignment;
		private transient String[] AnchorTabString_type_info = new String[]{'AnchorTabString','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] XOffset_type_info = new String[]{'XOffset','http://www.docusign.net/API/3.0','double','0','1','false'};
		private transient String[] YOffset_type_info = new String[]{'YOffset','http://www.docusign.net/API/3.0','double','0','1','false'};
		private transient String[] Unit_type_info = new String[]{'Unit','http://www.docusign.net/API/3.0','UnitTypeCode','0','1','false'};
		private transient String[] IgnoreIfNotPresent_type_info = new String[]{'IgnoreIfNotPresent','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] MatchWholeWord_type_info = new String[]{'MatchWholeWord','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CaseSensitive_type_info = new String[]{'CaseSensitive','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AnchorTabProcessorVersion_type_info = new String[]{'AnchorTabProcessorVersion','http://www.docusign.net/API/3.0','AnchorTabProcessorVersion','0','1','false'};
		private transient String[] HorizontalAlignment_type_info = new String[]{'HorizontalAlignment','http://www.docusign.net/API/3.0','HorizontalAlignmentType','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AnchorTabString','XOffset','YOffset','Unit','IgnoreIfNotPresent','MatchWholeWord','CaseSensitive','AnchorTabProcessorVersion','HorizontalAlignment'};
	}
	public class APIServiceSoap {
		public String endpoint_x = 'https://demo.docusign.net/api/3.0/api.asmx';
		public Map<String,String> inputHttpHeaders_x;
		public Map<String,String> outputHttpHeaders_x;
		public String clientCertName_x;
		public String clientCert_x;
		public String clientCertPasswd_x;
		public Integer timeout_x;
		private transient String[] ns_map_type_info = new String[]{'http://www.docusign.net/API/3.0','DocusignResponsiveAPI'};
		public DocusignResponsiveAPI.AuthoritativeCopyExportStatus AcknowledgeAuthoritativeCopyExport(String EnvelopeId,String TransactionId,String checkSumHash) {
			DocusignResponsiveAPI.AcknowledgeAuthoritativeCopyExport_element request_x = new DocusignResponsiveAPI.AcknowledgeAuthoritativeCopyExport_element();
			DocusignResponsiveAPI.AcknowledgeAuthoritativeCopyExportResponse_element response_x;
			request_x.EnvelopeId = EnvelopeId;
			request_x.TransactionId = TransactionId;
			request_x.checkSumHash = checkSumHash;
			Map<String, DocusignResponsiveAPI.AcknowledgeAuthoritativeCopyExportResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.AcknowledgeAuthoritativeCopyExportResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/AcknowledgeAuthoritativeCopyExport',
				'http://www.docusign.net/API/3.0',
				'AcknowledgeAuthoritativeCopyExport',
				'http://www.docusign.net/API/3.0',
				'AcknowledgeAuthoritativeCopyExportResponse',
				'DocusignResponsiveAPI.AcknowledgeAuthoritativeCopyExportResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.AcknowledgeAuthoritativeCopyExportResult;
		}
		public DocusignResponsiveAPI.AuthoritativeCopyExportStatus CompleteAuthoritativeCopyExport(String EnvelopeId,String TransactionId,String ExternalId) {
			DocusignResponsiveAPI.CompleteAuthoritativeCopyExport_element request_x = new DocusignResponsiveAPI.CompleteAuthoritativeCopyExport_element();
			DocusignResponsiveAPI.CompleteAuthoritativeCopyExportResponse_element response_x;
			request_x.EnvelopeId = EnvelopeId;
			request_x.TransactionId = TransactionId;
			request_x.ExternalId = ExternalId;
			Map<String, DocusignResponsiveAPI.CompleteAuthoritativeCopyExportResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.CompleteAuthoritativeCopyExportResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/CompleteAuthoritativeCopyExport',
				'http://www.docusign.net/API/3.0',
				'CompleteAuthoritativeCopyExport',
				'http://www.docusign.net/API/3.0',
				'CompleteAuthoritativeCopyExportResponse',
				'DocusignResponsiveAPI.CompleteAuthoritativeCopyExportResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.CompleteAuthoritativeCopyExportResult;
		}
		public DocusignResponsiveAPI.CorrectionStatus CorrectAndResendEnvelope(DocusignResponsiveAPI.Correction Correction) {
			DocusignResponsiveAPI.CorrectAndResendEnvelope_element request_x = new DocusignResponsiveAPI.CorrectAndResendEnvelope_element();
			DocusignResponsiveAPI.CorrectAndResendEnvelopeResponse_element response_x;
			request_x.Correction = Correction;
			Map<String, DocusignResponsiveAPI.CorrectAndResendEnvelopeResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.CorrectAndResendEnvelopeResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/CorrectAndResendEnvelope',
				'http://www.docusign.net/API/3.0',
				'CorrectAndResendEnvelope',
				'http://www.docusign.net/API/3.0',
				'CorrectAndResendEnvelopeResponse',
				'DocusignResponsiveAPI.CorrectAndResendEnvelopeResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.CorrectAndResendEnvelopeResult;
		}
		public DocusignResponsiveAPI.BrandResults CreateAccountBrands(String AccountId,DocusignResponsiveAPI.BrandDefinitions BrandDefinitions) {
			DocusignResponsiveAPI.CreateAccountBrands_element request_x = new DocusignResponsiveAPI.CreateAccountBrands_element();
			DocusignResponsiveAPI.CreateAccountBrandsResponse_element response_x;
			request_x.AccountId = AccountId;
			request_x.BrandDefinitions = BrandDefinitions;
			Map<String, DocusignResponsiveAPI.CreateAccountBrandsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.CreateAccountBrandsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/CreateAccountBrands',
				'http://www.docusign.net/API/3.0',
				'CreateAccountBrands',
				'http://www.docusign.net/API/3.0',
				'CreateAccountBrandsResponse',
				'DocusignResponsiveAPI.CreateAccountBrandsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.CreateAccountBrandsResult;
		}
		public DocusignResponsiveAPI.EnvelopeStatus CreateAndSendEnvelope(DocusignResponsiveAPI.Envelope Envelope) {
			DocusignResponsiveAPI.CreateAndSendEnvelope_element request_x = new DocusignResponsiveAPI.CreateAndSendEnvelope_element();
			DocusignResponsiveAPI.CreateAndSendEnvelopeResponse_element response_x;
			request_x.Envelope = Envelope;
			Map<String, DocusignResponsiveAPI.CreateAndSendEnvelopeResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.CreateAndSendEnvelopeResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/CreateAndSendEnvelope',
				'http://www.docusign.net/API/3.0',
				'CreateAndSendEnvelope',
				'http://www.docusign.net/API/3.0',
				'CreateAndSendEnvelopeResponse',
				'DocusignResponsiveAPI.CreateAndSendEnvelopeResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.CreateAndSendEnvelopeResult;
		}
		public DocusignResponsiveAPI.EnvelopeStatus CreateEnvelope(DocusignResponsiveAPI.Envelope Envelope) {
			DocusignResponsiveAPI.CreateEnvelope_element request_x = new DocusignResponsiveAPI.CreateEnvelope_element();
			DocusignResponsiveAPI.CreateEnvelopeResponse_element response_x;
			request_x.Envelope = Envelope;
			Map<String, DocusignResponsiveAPI.CreateEnvelopeResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.CreateEnvelopeResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/CreateEnvelope',
				'http://www.docusign.net/API/3.0',
				'CreateEnvelope',
				'http://www.docusign.net/API/3.0',
				'CreateEnvelopeResponse',
				'DocusignResponsiveAPI.CreateEnvelopeResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.CreateEnvelopeResult;
		}
		public DocusignResponsiveAPI.EnvelopeStatus CreateEnvelopeFromTemplates(DocusignResponsiveAPI.ArrayOfTemplateReference TemplateReferences,DocusignResponsiveAPI.ArrayOfRecipient1 Recipients,DocusignResponsiveAPI.EnvelopeInformation EnvelopeInformation,Boolean ActivateEnvelope) {
			DocusignResponsiveAPI.CreateEnvelopeFromTemplates_element request_x = new DocusignResponsiveAPI.CreateEnvelopeFromTemplates_element();
			DocusignResponsiveAPI.CreateEnvelopeFromTemplatesResponse_element response_x;
			request_x.TemplateReferences = TemplateReferences;
			request_x.Recipients = Recipients;
			request_x.EnvelopeInformation = EnvelopeInformation;
			request_x.ActivateEnvelope = ActivateEnvelope;
			Map<String, DocusignResponsiveAPI.CreateEnvelopeFromTemplatesResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.CreateEnvelopeFromTemplatesResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/CreateEnvelopeFromTemplates',
				'http://www.docusign.net/API/3.0',
				'CreateEnvelopeFromTemplates',
				'http://www.docusign.net/API/3.0',
				'CreateEnvelopeFromTemplatesResponse',
				'DocusignResponsiveAPI.CreateEnvelopeFromTemplatesResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.CreateEnvelopeFromTemplatesResult;
		}
		public DocusignResponsiveAPI.EnvelopeStatus CreateEnvelopeFromTemplatesAndForms(DocusignResponsiveAPI.EnvelopeInformation EnvelopeInformation,DocusignResponsiveAPI.ArrayOfCompositeTemplate CompositeTemplates,Boolean ActivateEnvelope) {
			DocusignResponsiveAPI.CreateEnvelopeFromTemplatesAndForms_element request_x = new DocusignResponsiveAPI.CreateEnvelopeFromTemplatesAndForms_element();
			DocusignResponsiveAPI.CreateEnvelopeFromTemplatesAndFormsResponse_element response_x;
			request_x.EnvelopeInformation = EnvelopeInformation;
			request_x.CompositeTemplates = CompositeTemplates;
			request_x.ActivateEnvelope = ActivateEnvelope;
			Map<String, DocusignResponsiveAPI.CreateEnvelopeFromTemplatesAndFormsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.CreateEnvelopeFromTemplatesAndFormsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/CreateEnvelopeFromTemplatesAndForms',
				'http://www.docusign.net/API/3.0',
				'CreateEnvelopeFromTemplatesAndForms',
				'http://www.docusign.net/API/3.0',
				'CreateEnvelopeFromTemplatesAndFormsResponse',
				'DocusignResponsiveAPI.CreateEnvelopeFromTemplatesAndFormsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.CreateEnvelopeFromTemplatesAndFormsResult;
		}
		public DocusignResponsiveAPI.BrandResults DeleteAccountBrands(String AccountId,DocusignResponsiveAPI.BrandDeleteRequest BrandDeleteRequest) {
			DocusignResponsiveAPI.DeleteAccountBrands_element request_x = new DocusignResponsiveAPI.DeleteAccountBrands_element();
			DocusignResponsiveAPI.DeleteAccountBrandsResponse_element response_x;
			request_x.AccountId = AccountId;
			request_x.BrandDeleteRequest = BrandDeleteRequest;
			Map<String, DocusignResponsiveAPI.DeleteAccountBrandsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.DeleteAccountBrandsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/DeleteAccountBrands',
				'http://www.docusign.net/API/3.0',
				'DeleteAccountBrands',
				'http://www.docusign.net/API/3.0',
				'DeleteAccountBrandsResponse',
				'DocusignResponsiveAPI.DeleteAccountBrandsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.DeleteAccountBrandsResult;
		}
		public DocusignResponsiveAPI.CaptiveRecipientResults DeleteCaptiveRecipientsSignatures(String AccountId,DocusignResponsiveAPI.DeleteCaptiveRecipientsSignaturesArg Arg) {
			DocusignResponsiveAPI.DeleteCaptiveRecipientsSignatures_element request_x = new DocusignResponsiveAPI.DeleteCaptiveRecipientsSignatures_element();
			DocusignResponsiveAPI.DeleteCaptiveRecipientsSignaturesResponse_element response_x;
			request_x.AccountId = AccountId;
			request_x.Arg = Arg;
			Map<String, DocusignResponsiveAPI.DeleteCaptiveRecipientsSignaturesResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.DeleteCaptiveRecipientsSignaturesResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/DeleteCaptiveRecipientsSignatures',
				'http://www.docusign.net/API/3.0',
				'DeleteCaptiveRecipientsSignatures',
				'http://www.docusign.net/API/3.0',
				'DeleteCaptiveRecipientsSignaturesResponse',
				'DocusignResponsiveAPI.DeleteCaptiveRecipientsSignaturesResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.DeleteCaptiveRecipientsSignaturesResult;
		}
		public Boolean DeleteEnvelopes(DocusignResponsiveAPI.DeleteEnvelopesArg Arg) {
			DocusignResponsiveAPI.DeleteEnvelopes_element request_x = new DocusignResponsiveAPI.DeleteEnvelopes_element();
			DocusignResponsiveAPI.DeleteEnvelopesResponse_element response_x;
			request_x.Arg = Arg;
			Map<String, DocusignResponsiveAPI.DeleteEnvelopesResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.DeleteEnvelopesResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/DeleteEnvelopes',
				'http://www.docusign.net/API/3.0',
				'DeleteEnvelopes',
				'http://www.docusign.net/API/3.0',
				'DeleteEnvelopesResponse',
				'DocusignResponsiveAPI.DeleteEnvelopesResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.DeleteEnvelopesResult;
		}
		public DocusignResponsiveAPI.EnvelopeAuditEventsResponse_EnvelopeAuditEventsResult_element EnvelopeAuditEvents(String EnvelopeId) {
			DocusignResponsiveAPI.EnvelopeAuditEvents_element request_x = new DocusignResponsiveAPI.EnvelopeAuditEvents_element();
			DocusignResponsiveAPI.EnvelopeAuditEventsResponse_element response_x;
			request_x.EnvelopeId = EnvelopeId;
			Map<String, DocusignResponsiveAPI.EnvelopeAuditEventsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.EnvelopeAuditEventsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/EnvelopeAuditEvents',
				'http://www.docusign.net/API/3.0',
				'EnvelopeAuditEvents',
				'http://www.docusign.net/API/3.0',
				'EnvelopeAuditEventsResponse',
				'DocusignResponsiveAPI.EnvelopeAuditEventsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.EnvelopeAuditEventsResult;
		}
		public DocusignResponsiveAPI.ArrayOfEnvelopeAuditEvent EnvelopeAuditEventsV2(String EnvelopeId) {
			DocusignResponsiveAPI.EnvelopeAuditEventsV2_element request_x = new DocusignResponsiveAPI.EnvelopeAuditEventsV2_element();
			DocusignResponsiveAPI.EnvelopeAuditEventsV2Response_element response_x;
			request_x.EnvelopeId = EnvelopeId;
			Map<String, DocusignResponsiveAPI.EnvelopeAuditEventsV2Response_element> response_map_x = new Map<String, DocusignResponsiveAPI.EnvelopeAuditEventsV2Response_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/EnvelopeAuditEventsV2',
				'http://www.docusign.net/API/3.0',
				'EnvelopeAuditEventsV2',
				'http://www.docusign.net/API/3.0',
				'EnvelopeAuditEventsV2Response',
				'DocusignResponsiveAPI.EnvelopeAuditEventsV2Response_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.EnvelopeAuditEventsV2Result;
		}
		public DocusignResponsiveAPI.AuthoritativeCopyExportDocuments ExportAuthoritativeCopy(String EnvelopeId) {
			DocusignResponsiveAPI.ExportAuthoritativeCopy_element request_x = new DocusignResponsiveAPI.ExportAuthoritativeCopy_element();
			DocusignResponsiveAPI.ExportAuthoritativeCopyResponse_element response_x;
			request_x.EnvelopeId = EnvelopeId;
			Map<String, DocusignResponsiveAPI.ExportAuthoritativeCopyResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.ExportAuthoritativeCopyResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/ExportAuthoritativeCopy',
				'http://www.docusign.net/API/3.0',
				'ExportAuthoritativeCopy',
				'http://www.docusign.net/API/3.0',
				'ExportAuthoritativeCopyResponse',
				'DocusignResponsiveAPI.ExportAuthoritativeCopyResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.ExportAuthoritativeCopyResult;
		}
		public DocusignResponsiveAPI.BrandResults GetAccountBrands(String AccountId) {
			DocusignResponsiveAPI.GetAccountBrands_element request_x = new DocusignResponsiveAPI.GetAccountBrands_element();
			DocusignResponsiveAPI.GetAccountBrandsResponse_element response_x;
			request_x.AccountId = AccountId;
			Map<String, DocusignResponsiveAPI.GetAccountBrandsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetAccountBrandsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetAccountBrands',
				'http://www.docusign.net/API/3.0',
				'GetAccountBrands',
				'http://www.docusign.net/API/3.0',
				'GetAccountBrandsResponse',
				'DocusignResponsiveAPI.GetAccountBrandsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetAccountBrandsResult;
		}
		public DocusignResponsiveAPI.AccountMembershipFeaturesList GetAccountMembershipFeaturesList(String AccountId) {
			DocusignResponsiveAPI.GetAccountMembershipFeaturesList_element request_x = new DocusignResponsiveAPI.GetAccountMembershipFeaturesList_element();
			DocusignResponsiveAPI.GetAccountMembershipFeaturesListResponse_element response_x;
			request_x.AccountId = AccountId;
			Map<String, DocusignResponsiveAPI.GetAccountMembershipFeaturesListResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetAccountMembershipFeaturesListResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetAccountMembershipFeaturesList',
				'http://www.docusign.net/API/3.0',
				'GetAccountMembershipFeaturesList',
				'http://www.docusign.net/API/3.0',
				'GetAccountMembershipFeaturesListResponse',
				'DocusignResponsiveAPI.GetAccountMembershipFeaturesListResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetAccountMembershipFeaturesListResult;
		}
		public DocusignResponsiveAPI.AccountSettingsList GetAccountSettingsList(String AccountId) {
			DocusignResponsiveAPI.GetAccountSettingsList_element request_x = new DocusignResponsiveAPI.GetAccountSettingsList_element();
			DocusignResponsiveAPI.GetAccountSettingsListResponse_element response_x;
			request_x.AccountId = AccountId;
			Map<String, DocusignResponsiveAPI.GetAccountSettingsListResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetAccountSettingsListResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetAccountSettingsList',
				'http://www.docusign.net/API/3.0',
				'GetAccountSettingsList',
				'http://www.docusign.net/API/3.0',
				'GetAccountSettingsListResponse',
				'DocusignResponsiveAPI.GetAccountSettingsListResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetAccountSettingsListResult;
		}
		public DocusignResponsiveAPI.ArrayOfAddressBookItem GetAddressBookItems(String AccountID) {
			DocusignResponsiveAPI.GetAddressBookItems_element request_x = new DocusignResponsiveAPI.GetAddressBookItems_element();
			DocusignResponsiveAPI.GetAddressBookItemsResponse_element response_x;
			request_x.AccountID = AccountID;
			Map<String, DocusignResponsiveAPI.GetAddressBookItemsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetAddressBookItemsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetAddressBookItems',
				'http://www.docusign.net/API/3.0',
				'GetAddressBookItems',
				'http://www.docusign.net/API/3.0',
				'GetAddressBookItemsResponse',
				'DocusignResponsiveAPI.GetAddressBookItemsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetAddressBookItemsResult;
		}
		public String GetAuthenticationToken(String GoToEnvelopeID) {
			DocusignResponsiveAPI.GetAuthenticationToken_element request_x = new DocusignResponsiveAPI.GetAuthenticationToken_element();
			DocusignResponsiveAPI.GetAuthenticationTokenResponse_element response_x;
			request_x.GoToEnvelopeID = GoToEnvelopeID;
			Map<String, DocusignResponsiveAPI.GetAuthenticationTokenResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetAuthenticationTokenResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetAuthenticationToken',
				'http://www.docusign.net/API/3.0',
				'GetAuthenticationToken',
				'http://www.docusign.net/API/3.0',
				'GetAuthenticationTokenResponse',
				'DocusignResponsiveAPI.GetAuthenticationTokenResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetAuthenticationTokenResult;
		}
		public DocusignResponsiveAPI.AuthoritativeCopyExportStatus GetAuthoritativeCopyExportKey(String EnvelopeId,String TransactionId,String checkSumHash) {
			DocusignResponsiveAPI.GetAuthoritativeCopyExportKey_element request_x = new DocusignResponsiveAPI.GetAuthoritativeCopyExportKey_element();
			DocusignResponsiveAPI.GetAuthoritativeCopyExportKeyResponse_element response_x;
			request_x.EnvelopeId = EnvelopeId;
			request_x.TransactionId = TransactionId;
			request_x.checkSumHash = checkSumHash;
			Map<String, DocusignResponsiveAPI.GetAuthoritativeCopyExportKeyResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetAuthoritativeCopyExportKeyResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetAuthoritativeCopyExportKey',
				'http://www.docusign.net/API/3.0',
				'GetAuthoritativeCopyExportKey',
				'http://www.docusign.net/API/3.0',
				'GetAuthoritativeCopyExportKeyResponse',
				'DocusignResponsiveAPI.GetAuthoritativeCopyExportKeyResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetAuthoritativeCopyExportKeyResult;
		}
		public DocusignResponsiveAPI.ArrayOfConnectFailure GetConnectFailures(DocusignResponsiveAPI.ConnectFailuresFilter ConnectFailuresFilter) {
			DocusignResponsiveAPI.GetConnectFailures_element request_x = new DocusignResponsiveAPI.GetConnectFailures_element();
			DocusignResponsiveAPI.GetConnectFailuresResponse_element response_x;
			request_x.ConnectFailuresFilter = ConnectFailuresFilter;
			Map<String, DocusignResponsiveAPI.GetConnectFailuresResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetConnectFailuresResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetConnectFailures',
				'http://www.docusign.net/API/3.0',
				'GetConnectFailures',
				'http://www.docusign.net/API/3.0',
				'GetConnectFailuresResponse',
				'DocusignResponsiveAPI.GetConnectFailuresResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetConnectFailuresResult;
		}
		public DocusignResponsiveAPI.FolderResults GetFolderItems(DocusignResponsiveAPI.FolderFilter FolderFilter) {
			DocusignResponsiveAPI.GetFolderItems_element request_x = new DocusignResponsiveAPI.GetFolderItems_element();
			DocusignResponsiveAPI.GetFolderItemsResponse_element response_x;
			request_x.FolderFilter = FolderFilter;
			Map<String, DocusignResponsiveAPI.GetFolderItemsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetFolderItemsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetFolderItems',
				'http://www.docusign.net/API/3.0',
				'GetFolderItems',
				'http://www.docusign.net/API/3.0',
				'GetFolderItemsResponse',
				'DocusignResponsiveAPI.GetFolderItemsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetFolderItemsResult;
		}
		public DocusignResponsiveAPI.AvailableFolders GetFolderList(DocusignResponsiveAPI.FoldersFilter FoldersFilter) {
			DocusignResponsiveAPI.GetFolderList_element request_x = new DocusignResponsiveAPI.GetFolderList_element();
			DocusignResponsiveAPI.GetFolderListResponse_element response_x;
			request_x.FoldersFilter = FoldersFilter;
			Map<String, DocusignResponsiveAPI.GetFolderListResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetFolderListResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetFolderList',
				'http://www.docusign.net/API/3.0',
				'GetFolderList',
				'http://www.docusign.net/API/3.0',
				'GetFolderListResponse',
				'DocusignResponsiveAPI.GetFolderListResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetFolderListResult;
		}
		public DocusignResponsiveAPI.AuthenticationStatus GetRecipientAuthenticationStatusEx(DocusignResponsiveAPI.GetRecipientAuthenticationStatusExArg Arg) {
			DocusignResponsiveAPI.GetRecipientAuthenticationStatusEx_element request_x = new DocusignResponsiveAPI.GetRecipientAuthenticationStatusEx_element();
			DocusignResponsiveAPI.GetRecipientAuthenticationStatusExResponse_element response_x;
			request_x.Arg = Arg;
			Map<String, DocusignResponsiveAPI.GetRecipientAuthenticationStatusExResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetRecipientAuthenticationStatusExResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetRecipientAuthenticationStatusEx',
				'http://www.docusign.net/API/3.0',
				'GetRecipientAuthenticationStatusEx',
				'http://www.docusign.net/API/3.0',
				'GetRecipientAuthenticationStatusExResponse',
				'DocusignResponsiveAPI.GetRecipientAuthenticationStatusExResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetRecipientAuthenticationStatusExResult;
		}
		public DocusignResponsiveAPI.RecipientEsignList GetRecipientEsignList(String UserName,String SenderEmail,String SenderAccountId,String RecipientEmail) {
			DocusignResponsiveAPI.GetRecipientEsignList_element request_x = new DocusignResponsiveAPI.GetRecipientEsignList_element();
			DocusignResponsiveAPI.GetRecipientEsignListResponse_element response_x;
			request_x.UserName = UserName;
			request_x.SenderEmail = SenderEmail;
			request_x.SenderAccountId = SenderAccountId;
			request_x.RecipientEmail = RecipientEmail;
			Map<String, DocusignResponsiveAPI.GetRecipientEsignListResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetRecipientEsignListResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetRecipientEsignList',
				'http://www.docusign.net/API/3.0',
				'GetRecipientEsignList',
				'http://www.docusign.net/API/3.0',
				'GetRecipientEsignListResponse',
				'DocusignResponsiveAPI.GetRecipientEsignListResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetRecipientEsignListResult;
		}
		public DocusignResponsiveAPI.RecipientList GetRecipientList(String SenderAccountId,String RecipientEmail) {
			DocusignResponsiveAPI.GetRecipientList_element request_x = new DocusignResponsiveAPI.GetRecipientList_element();
			DocusignResponsiveAPI.GetRecipientListResponse_element response_x;
			request_x.SenderAccountId = SenderAccountId;
			request_x.RecipientEmail = RecipientEmail;
			Map<String, DocusignResponsiveAPI.GetRecipientListResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetRecipientListResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetRecipientList',
				'http://www.docusign.net/API/3.0',
				'GetRecipientList',
				'http://www.docusign.net/API/3.0',
				'GetRecipientListResponse',
				'DocusignResponsiveAPI.GetRecipientListResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetRecipientListResult;
		}
		public DocusignResponsiveAPI.GetSharedAccessResult GetSharedAccess(String AccountId,DocusignResponsiveAPI.SharedAccessFilter SharedAccessFilter) {
			DocusignResponsiveAPI.GetSharedAccess_element request_x = new DocusignResponsiveAPI.GetSharedAccess_element();
			DocusignResponsiveAPI.GetSharedAccessResponse_element response_x;
			request_x.AccountId = AccountId;
			request_x.SharedAccessFilter = SharedAccessFilter;
			Map<String, DocusignResponsiveAPI.GetSharedAccessResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetSharedAccessResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetSharedAccess',
				'http://www.docusign.net/API/3.0',
				'GetSharedAccess',
				'http://www.docusign.net/API/3.0',
				'GetSharedAccessResponse',
				'DocusignResponsiveAPI.GetSharedAccessResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetSharedAccessResult;
		}
		public DocusignResponsiveAPI.DocuSignEnvelopeInformation GetStatusInDocuSignConnectFormat(String EnvelopeID) {
			DocusignResponsiveAPI.GetStatusInDocuSignConnectFormat_element request_x = new DocusignResponsiveAPI.GetStatusInDocuSignConnectFormat_element();
			DocusignResponsiveAPI.GetStatusInDocuSignConnectFormatResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.GetStatusInDocuSignConnectFormatResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.GetStatusInDocuSignConnectFormatResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/GetStatusInDocuSignConnectFormat',
				'http://www.docusign.net/API/3.0',
				'GetStatusInDocuSignConnectFormat',
				'http://www.docusign.net/API/3.0',
				'GetStatusInDocuSignConnectFormatResponse',
				'DocusignResponsiveAPI.GetStatusInDocuSignConnectFormatResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.GetStatusInDocuSignConnectFormatResult;
		}
		public Boolean MoveEnvelopes(DocusignResponsiveAPI.MoveEnvelopesArg Arg) {
			DocusignResponsiveAPI.MoveEnvelopes_element request_x = new DocusignResponsiveAPI.MoveEnvelopes_element();
			DocusignResponsiveAPI.MoveEnvelopesResponse_element response_x;
			request_x.Arg = Arg;
			Map<String, DocusignResponsiveAPI.MoveEnvelopesResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.MoveEnvelopesResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/MoveEnvelopes',
				'http://www.docusign.net/API/3.0',
				'MoveEnvelopes',
				'http://www.docusign.net/API/3.0',
				'MoveEnvelopesResponse',
				'DocusignResponsiveAPI.MoveEnvelopesResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.MoveEnvelopesResult;
		}
		public Boolean Ping() {
			DocusignResponsiveAPI.Ping_element request_x = new DocusignResponsiveAPI.Ping_element();
			DocusignResponsiveAPI.PingResponse_element response_x;
			Map<String, DocusignResponsiveAPI.PingResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.PingResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/Ping',
				'http://www.docusign.net/API/3.0',
				'Ping',
				'http://www.docusign.net/API/3.0',
				'PingResponse',
				'DocusignResponsiveAPI.PingResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.PingResult;
		}
		public DocusignResponsiveAPI.ArrayOfPublishConnectFailuresResult PublishConnectFailures(DocusignResponsiveAPI.PublishConnectFailuresFilter PublishConnectFailuresFilter) {
			DocusignResponsiveAPI.PublishConnectFailures_element request_x = new DocusignResponsiveAPI.PublishConnectFailures_element();
			DocusignResponsiveAPI.PublishConnectFailuresResponse_element response_x;
			request_x.PublishConnectFailuresFilter = PublishConnectFailuresFilter;
			Map<String, DocusignResponsiveAPI.PublishConnectFailuresResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.PublishConnectFailuresResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/PublishConnectFailures',
				'http://www.docusign.net/API/3.0',
				'PublishConnectFailures',
				'http://www.docusign.net/API/3.0',
				'PublishConnectFailuresResponse',
				'DocusignResponsiveAPI.PublishConnectFailuresResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.PublishConnectFailuresResult;
		}
		public DocusignResponsiveAPI.PurgeDocumentStatus PurgeDocuments(String EnvelopeID) {
			DocusignResponsiveAPI.PurgeDocuments_element request_x = new DocusignResponsiveAPI.PurgeDocuments_element();
			DocusignResponsiveAPI.PurgeDocumentsResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.PurgeDocumentsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.PurgeDocumentsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/PurgeDocuments',
				'http://www.docusign.net/API/3.0',
				'PurgeDocuments',
				'http://www.docusign.net/API/3.0',
				'PurgeDocumentsResponse',
				'DocusignResponsiveAPI.PurgeDocumentsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.PurgeDocumentsResult;
		}
		public DocusignResponsiveAPI.PurgeDocumentStatus PurgeDocumentsAndMetaData(String EnvelopeID) {
			DocusignResponsiveAPI.PurgeDocumentsAndMetaData_element request_x = new DocusignResponsiveAPI.PurgeDocumentsAndMetaData_element();
			DocusignResponsiveAPI.PurgeDocumentsAndMetaDataResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.PurgeDocumentsAndMetaDataResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.PurgeDocumentsAndMetaDataResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/PurgeDocumentsAndMetaData',
				'http://www.docusign.net/API/3.0',
				'PurgeDocumentsAndMetaData',
				'http://www.docusign.net/API/3.0',
				'PurgeDocumentsAndMetaDataResponse',
				'DocusignResponsiveAPI.PurgeDocumentsAndMetaDataResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.PurgeDocumentsAndMetaDataResult;
		}
		public DocusignResponsiveAPI.PurgeDocumentStatus PurgeDocumentsAndMetaDataAndRedact(String EnvelopeID) {
			DocusignResponsiveAPI.PurgeDocumentsAndMetaDataAndRedact_element request_x = new DocusignResponsiveAPI.PurgeDocumentsAndMetaDataAndRedact_element();
			DocusignResponsiveAPI.PurgeDocumentsAndMetaDataAndRedactResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.PurgeDocumentsAndMetaDataAndRedactResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.PurgeDocumentsAndMetaDataAndRedactResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/PurgeDocumentsAndMetaDataAndRedact',
				'http://www.docusign.net/API/3.0',
				'PurgeDocumentsAndMetaDataAndRedact',
				'http://www.docusign.net/API/3.0',
				'PurgeDocumentsAndMetaDataAndRedactResponse',
				'DocusignResponsiveAPI.PurgeDocumentsAndMetaDataAndRedactResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.PurgeDocumentsAndMetaDataAndRedactResult;
		}
		public DocusignResponsiveAPI.UpdateAddressBookResult RemoveAddressBookItems(DocusignResponsiveAPI.ArrayOfAddressBookRemoveItem AddressBookRemoveItems,Boolean ReturnAddressBook) {
			DocusignResponsiveAPI.RemoveAddressBookItems_element request_x = new DocusignResponsiveAPI.RemoveAddressBookItems_element();
			DocusignResponsiveAPI.RemoveAddressBookItemsResponse_element response_x;
			request_x.AddressBookRemoveItems = AddressBookRemoveItems;
			request_x.ReturnAddressBook = ReturnAddressBook;
			Map<String, DocusignResponsiveAPI.RemoveAddressBookItemsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RemoveAddressBookItemsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RemoveAddressBookItems',
				'http://www.docusign.net/API/3.0',
				'RemoveAddressBookItems',
				'http://www.docusign.net/API/3.0',
				'RemoveAddressBookItemsResponse',
				'DocusignResponsiveAPI.RemoveAddressBookItemsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RemoveAddressBookItemsResult;
		}
		public DocusignResponsiveAPI.DocumentPDFs RequestCertificate(String EnvelopeID) {
			DocusignResponsiveAPI.RequestCertificate_element request_x = new DocusignResponsiveAPI.RequestCertificate_element();
			DocusignResponsiveAPI.RequestCertificateResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.RequestCertificateResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestCertificateResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestCertificate',
				'http://www.docusign.net/API/3.0',
				'RequestCertificate',
				'http://www.docusign.net/API/3.0',
				'RequestCertificateResponse',
				'DocusignResponsiveAPI.RequestCertificateResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestCertificateResult;
		}
		public DocusignResponsiveAPI.DocumentPDFs RequestCertificateWithCertLanguage(String EnvelopeID,String CertLanguage) {
			DocusignResponsiveAPI.RequestCertificateWithCertLanguage_element request_x = new DocusignResponsiveAPI.RequestCertificateWithCertLanguage_element();
			DocusignResponsiveAPI.RequestCertificateWithCertLanguageResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.CertLanguage = CertLanguage;
			Map<String, DocusignResponsiveAPI.RequestCertificateWithCertLanguageResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestCertificateWithCertLanguageResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestCertificateWithCertLanguage',
				'http://www.docusign.net/API/3.0',
				'RequestCertificateWithCertLanguage',
				'http://www.docusign.net/API/3.0',
				'RequestCertificateWithCertLanguageResponse',
				'DocusignResponsiveAPI.RequestCertificateWithCertLanguageResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestCertificateWithCertLanguageResult;
		}
		public String RequestCorrectToken(String EnvelopeID,Boolean SuppressNavigation,String ReturnURL) {
			DocusignResponsiveAPI.RequestCorrectToken_element request_x = new DocusignResponsiveAPI.RequestCorrectToken_element();
			DocusignResponsiveAPI.RequestCorrectTokenResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.SuppressNavigation = SuppressNavigation;
			request_x.ReturnURL = ReturnURL;
			Map<String, DocusignResponsiveAPI.RequestCorrectTokenResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestCorrectTokenResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestCorrectToken',
				'http://www.docusign.net/API/3.0',
				'RequestCorrectToken',
				'http://www.docusign.net/API/3.0',
				'RequestCorrectTokenResponse',
				'DocusignResponsiveAPI.RequestCorrectTokenResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestCorrectTokenResult;
		}
		public DocusignResponsiveAPI.DocumentPDFs RequestDocumentPDFs(String EnvelopeID) {
			DocusignResponsiveAPI.RequestDocumentPDFs_element request_x = new DocusignResponsiveAPI.RequestDocumentPDFs_element();
			DocusignResponsiveAPI.RequestDocumentPDFsResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.RequestDocumentPDFsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestDocumentPDFsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestDocumentPDFs',
				'http://www.docusign.net/API/3.0',
				'RequestDocumentPDFs',
				'http://www.docusign.net/API/3.0',
				'RequestDocumentPDFsResponse',
				'DocusignResponsiveAPI.RequestDocumentPDFsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestDocumentPDFsResult;
		}
		public DocusignResponsiveAPI.DocumentPDFs RequestDocumentPDFsEx(String EnvelopeID) {
			DocusignResponsiveAPI.RequestDocumentPDFsEx_element request_x = new DocusignResponsiveAPI.RequestDocumentPDFsEx_element();
			DocusignResponsiveAPI.RequestDocumentPDFsExResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.RequestDocumentPDFsExResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestDocumentPDFsExResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestDocumentPDFsEx',
				'http://www.docusign.net/API/3.0',
				'RequestDocumentPDFsEx',
				'http://www.docusign.net/API/3.0',
				'RequestDocumentPDFsExResponse',
				'DocusignResponsiveAPI.RequestDocumentPDFsExResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestDocumentPDFsExResult;
		}
		public DocusignResponsiveAPI.DocumentPDFs RequestDocumentPDFsRecipientsView(String EnvelopeID,String RecipientName,String RecipientEmail) {
			DocusignResponsiveAPI.RequestDocumentPDFsRecipientsView_element request_x = new DocusignResponsiveAPI.RequestDocumentPDFsRecipientsView_element();
			DocusignResponsiveAPI.RequestDocumentPDFsRecipientsViewResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.RecipientName = RecipientName;
			request_x.RecipientEmail = RecipientEmail;
			Map<String, DocusignResponsiveAPI.RequestDocumentPDFsRecipientsViewResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestDocumentPDFsRecipientsViewResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestDocumentPDFsRecipientsView',
				'http://www.docusign.net/API/3.0',
				'RequestDocumentPDFsRecipientsView',
				'http://www.docusign.net/API/3.0',
				'RequestDocumentPDFsRecipientsViewResponse',
				'DocusignResponsiveAPI.RequestDocumentPDFsRecipientsViewResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestDocumentPDFsRecipientsViewResult;
		}
		public DocusignResponsiveAPI.Envelope RequestEnvelope(String EnvelopeID,Boolean IncludeDocumentBytes) {
			DocusignResponsiveAPI.RequestEnvelope_element request_x = new DocusignResponsiveAPI.RequestEnvelope_element();
			DocusignResponsiveAPI.RequestEnvelopeResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.IncludeDocumentBytes = IncludeDocumentBytes;
			Map<String, DocusignResponsiveAPI.RequestEnvelopeResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestEnvelopeResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestEnvelope',
				'http://www.docusign.net/API/3.0',
				'RequestEnvelope',
				'http://www.docusign.net/API/3.0',
				'RequestEnvelopeResponse',
				'DocusignResponsiveAPI.RequestEnvelopeResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestEnvelopeResult;
		}
		public String RequestEnvelopeHistoryToken(DocusignResponsiveAPI.RequestEnvelopeHistoryTokenArg Arg) {
			DocusignResponsiveAPI.RequestEnvelopeHistoryToken_element request_x = new DocusignResponsiveAPI.RequestEnvelopeHistoryToken_element();
			DocusignResponsiveAPI.RequestEnvelopeHistoryTokenResponse_element response_x;
			request_x.Arg = Arg;
			Map<String, DocusignResponsiveAPI.RequestEnvelopeHistoryTokenResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestEnvelopeHistoryTokenResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestEnvelopeHistoryToken',
				'http://www.docusign.net/API/3.0',
				'RequestEnvelopeHistoryToken',
				'http://www.docusign.net/API/3.0',
				'RequestEnvelopeHistoryTokenResponse',
				'DocusignResponsiveAPI.RequestEnvelopeHistoryTokenResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestEnvelopeHistoryTokenResult;
		}
		public DocusignResponsiveAPI.Envelope RequestEnvelopeV2(String EnvelopeID,DocusignResponsiveAPI.RequestEnvelopeV2Options Options) {
			DocusignResponsiveAPI.RequestEnvelopeV2_element request_x = new DocusignResponsiveAPI.RequestEnvelopeV2_element();
			DocusignResponsiveAPI.RequestEnvelopeV2Response_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.Options = Options;
			Map<String, DocusignResponsiveAPI.RequestEnvelopeV2Response_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestEnvelopeV2Response_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestEnvelopeV2',
				'http://www.docusign.net/API/3.0',
				'RequestEnvelopeV2',
				'http://www.docusign.net/API/3.0',
				'RequestEnvelopeV2Response',
				'DocusignResponsiveAPI.RequestEnvelopeV2Response_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestEnvelopeV2Result;
		}
		public DocusignResponsiveAPI.Envelope RequestEnvelopeWithDocumentFields(String EnvelopeID,Boolean IncludeDocumentBytes) {
			DocusignResponsiveAPI.RequestEnvelopeWithDocumentFields_element request_x = new DocusignResponsiveAPI.RequestEnvelopeWithDocumentFields_element();
			DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.IncludeDocumentBytes = IncludeDocumentBytes;
			Map<String, DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestEnvelopeWithDocumentFields',
				'http://www.docusign.net/API/3.0',
				'RequestEnvelopeWithDocumentFields',
				'http://www.docusign.net/API/3.0',
				'RequestEnvelopeWithDocumentFieldsResponse',
				'DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestEnvelopeWithDocumentFieldsResult;
		}
		public DocusignResponsiveAPI.EnvelopeV2 RequestEnvelopeWithDocumentFieldsV2(String EnvelopeID,DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsV2Options Options) {
			DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsV2_element request_x = new DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsV2_element();
			DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsV2Response_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.Options = Options;
			Map<String, DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsV2Response_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsV2Response_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestEnvelopeWithDocumentFieldsV2',
				'http://www.docusign.net/API/3.0',
				'RequestEnvelopeWithDocumentFieldsV2',
				'http://www.docusign.net/API/3.0',
				'RequestEnvelopeWithDocumentFieldsV2Response',
				'DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsV2Response_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestEnvelopeWithDocumentFieldsV2Result;
		}
		public DocusignResponsiveAPI.EnvelopePDF RequestPDF(String EnvelopeID) {
			DocusignResponsiveAPI.RequestPDF_element request_x = new DocusignResponsiveAPI.RequestPDF_element();
			DocusignResponsiveAPI.RequestPDFResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.RequestPDFResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestPDFResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestPDF',
				'http://www.docusign.net/API/3.0',
				'RequestPDF',
				'http://www.docusign.net/API/3.0',
				'RequestPDFResponse',
				'DocusignResponsiveAPI.RequestPDFResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestPDFResult;
		}
		public DocusignResponsiveAPI.EnvelopePDF RequestPDFNoWaterMark(String EnvelopeID) {
			DocusignResponsiveAPI.RequestPDFNoWaterMark_element request_x = new DocusignResponsiveAPI.RequestPDFNoWaterMark_element();
			DocusignResponsiveAPI.RequestPDFNoWaterMarkResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.RequestPDFNoWaterMarkResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestPDFNoWaterMarkResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestPDFNoWaterMark',
				'http://www.docusign.net/API/3.0',
				'RequestPDFNoWaterMark',
				'http://www.docusign.net/API/3.0',
				'RequestPDFNoWaterMarkResponse',
				'DocusignResponsiveAPI.RequestPDFNoWaterMarkResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestPDFNoWaterMarkResult;
		}
		public DocusignResponsiveAPI.EnvelopePDF RequestPDFRecipientsView(String EnvelopeID,String RecipientName,String RecipientEmail,DocusignResponsiveAPI.PDFOptions PDFOptions) {
			DocusignResponsiveAPI.RequestPDFRecipientsView_element request_x = new DocusignResponsiveAPI.RequestPDFRecipientsView_element();
			DocusignResponsiveAPI.RequestPDFRecipientsViewResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.RecipientName = RecipientName;
			request_x.RecipientEmail = RecipientEmail;
			request_x.PDFOptions = PDFOptions;
			Map<String, DocusignResponsiveAPI.RequestPDFRecipientsViewResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestPDFRecipientsViewResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestPDFRecipientsView',
				'http://www.docusign.net/API/3.0',
				'RequestPDFRecipientsView',
				'http://www.docusign.net/API/3.0',
				'RequestPDFRecipientsViewResponse',
				'DocusignResponsiveAPI.RequestPDFRecipientsViewResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestPDFRecipientsViewResult;
		}
		public DocusignResponsiveAPI.DocumentPDFs RequestPDFsWithOptions(String EnvelopeID,DocusignResponsiveAPI.PDFsOptions PDFsOptions) {
			DocusignResponsiveAPI.RequestPDFsWithOptions_element request_x = new DocusignResponsiveAPI.RequestPDFsWithOptions_element();
			DocusignResponsiveAPI.RequestPDFsWithOptionsResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.PDFsOptions = PDFsOptions;
			Map<String, DocusignResponsiveAPI.RequestPDFsWithOptionsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestPDFsWithOptionsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestPDFsWithOptions',
				'http://www.docusign.net/API/3.0',
				'RequestPDFsWithOptions',
				'http://www.docusign.net/API/3.0',
				'RequestPDFsWithOptionsResponse',
				'DocusignResponsiveAPI.RequestPDFsWithOptionsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestPDFsWithOptionsResult;
		}
		public DocusignResponsiveAPI.EnvelopePDF RequestPDFWithCert(String EnvelopeID,Boolean AddWaterMark) {
			DocusignResponsiveAPI.RequestPDFWithCert_element request_x = new DocusignResponsiveAPI.RequestPDFWithCert_element();
			DocusignResponsiveAPI.RequestPDFWithCertResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.AddWaterMark = AddWaterMark;
			Map<String, DocusignResponsiveAPI.RequestPDFWithCertResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestPDFWithCertResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestPDFWithCert',
				'http://www.docusign.net/API/3.0',
				'RequestPDFWithCert',
				'http://www.docusign.net/API/3.0',
				'RequestPDFWithCertResponse',
				'DocusignResponsiveAPI.RequestPDFWithCertResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestPDFWithCertResult;
		}
		public DocusignResponsiveAPI.EnvelopePDF RequestPDFWithOptions(String EnvelopeID,DocusignResponsiveAPI.PDFOptions PDFOptions) {
			DocusignResponsiveAPI.RequestPDFWithOptions_element request_x = new DocusignResponsiveAPI.RequestPDFWithOptions_element();
			DocusignResponsiveAPI.RequestPDFWithOptionsResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.PDFOptions = PDFOptions;
			Map<String, DocusignResponsiveAPI.RequestPDFWithOptionsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestPDFWithOptionsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestPDFWithOptions',
				'http://www.docusign.net/API/3.0',
				'RequestPDFWithOptions',
				'http://www.docusign.net/API/3.0',
				'RequestPDFWithOptionsResponse',
				'DocusignResponsiveAPI.RequestPDFWithOptionsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestPDFWithOptionsResult;
		}
		public DocusignResponsiveAPI.EnvelopePDF RequestRecipientFaxPDF(String EnvelopeID,String ClientUserID,String Username,String Email,DocusignResponsiveAPI.RequestRecipientTokenAuthenticationAssertion AuthenticationAssertion) {
			DocusignResponsiveAPI.RequestRecipientFaxPDF_element request_x = new DocusignResponsiveAPI.RequestRecipientFaxPDF_element();
			DocusignResponsiveAPI.RequestRecipientFaxPDFResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.ClientUserID = ClientUserID;
			request_x.Username = Username;
			request_x.Email = Email;
			request_x.AuthenticationAssertion = AuthenticationAssertion;
			Map<String, DocusignResponsiveAPI.RequestRecipientFaxPDFResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestRecipientFaxPDFResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestRecipientFaxPDF',
				'http://www.docusign.net/API/3.0',
				'RequestRecipientFaxPDF',
				'http://www.docusign.net/API/3.0',
				'RequestRecipientFaxPDFResponse',
				'DocusignResponsiveAPI.RequestRecipientFaxPDFResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestRecipientFaxPDFResult;
		}
		public String RequestRecipientFaxToken(String EnvelopeID,String ClientUserID,String Username,String Email,DocusignResponsiveAPI.RequestRecipientTokenAuthenticationAssertion AuthenticationAssertion,DocusignResponsiveAPI.RequestRecipientTokenClientURLs ClientURLs) {
			DocusignResponsiveAPI.RequestRecipientFaxToken_element request_x = new DocusignResponsiveAPI.RequestRecipientFaxToken_element();
			DocusignResponsiveAPI.RequestRecipientFaxTokenResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.ClientUserID = ClientUserID;
			request_x.Username = Username;
			request_x.Email = Email;
			request_x.AuthenticationAssertion = AuthenticationAssertion;
			request_x.ClientURLs = ClientURLs;
			Map<String, DocusignResponsiveAPI.RequestRecipientFaxTokenResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestRecipientFaxTokenResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestRecipientFaxToken',
				'http://www.docusign.net/API/3.0',
				'RequestRecipientFaxToken',
				'http://www.docusign.net/API/3.0',
				'RequestRecipientFaxTokenResponse',
				'DocusignResponsiveAPI.RequestRecipientFaxTokenResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestRecipientFaxTokenResult;
		}
		public String RequestRecipientToken(String EnvelopeID,String ClientUserID,String Username,String Email,DocusignResponsiveAPI.RequestRecipientTokenAuthenticationAssertion AuthenticationAssertion,DocusignResponsiveAPI.RequestRecipientTokenClientURLs ClientURLs) {
			DocusignResponsiveAPI.RequestRecipientToken_element request_x = new DocusignResponsiveAPI.RequestRecipientToken_element();
			DocusignResponsiveAPI.RequestRecipientTokenResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.ClientUserID = ClientUserID;
			request_x.Username = Username;
			request_x.Email = Email;
			request_x.AuthenticationAssertion = AuthenticationAssertion;
			request_x.ClientURLs = ClientURLs;
			Map<String, DocusignResponsiveAPI.RequestRecipientTokenResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestRecipientTokenResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestRecipientToken',
				'http://www.docusign.net/API/3.0',
				'RequestRecipientToken',
				'http://www.docusign.net/API/3.0',
				'RequestRecipientTokenResponse',
				'DocusignResponsiveAPI.RequestRecipientTokenResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestRecipientTokenResult;
		}
		public String RequestSenderToken(String EnvelopeID,String AccountID,String ReturnURL) {
			DocusignResponsiveAPI.RequestSenderToken_element request_x = new DocusignResponsiveAPI.RequestSenderToken_element();
			DocusignResponsiveAPI.RequestSenderTokenResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.AccountID = AccountID;
			request_x.ReturnURL = ReturnURL;
			Map<String, DocusignResponsiveAPI.RequestSenderTokenResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestSenderTokenResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestSenderToken',
				'http://www.docusign.net/API/3.0',
				'RequestSenderToken',
				'http://www.docusign.net/API/3.0',
				'RequestSenderTokenResponse',
				'DocusignResponsiveAPI.RequestSenderTokenResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestSenderTokenResult;
		}
		public DocusignResponsiveAPI.EnvelopeStatus RequestStatus(String EnvelopeID) {
			DocusignResponsiveAPI.RequestStatus_element request_x = new DocusignResponsiveAPI.RequestStatus_element();
			DocusignResponsiveAPI.RequestStatusResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.RequestStatusResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestStatusResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestStatus',
				'http://www.docusign.net/API/3.0',
				'RequestStatus',
				'http://www.docusign.net/API/3.0',
				'RequestStatusResponse',
				'DocusignResponsiveAPI.RequestStatusResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestStatusResult;
		}
		public DocusignResponsiveAPI.FilteredEnvelopeStatusChanges RequestStatusChanges(DocusignResponsiveAPI.EnvelopeStatusChangeFilter EnvelopeStatusChangeFilter) {
			DocusignResponsiveAPI.RequestStatusChanges_element request_x = new DocusignResponsiveAPI.RequestStatusChanges_element();
			DocusignResponsiveAPI.RequestStatusChangesResponse_element response_x;
			request_x.EnvelopeStatusChangeFilter = EnvelopeStatusChangeFilter;
			Map<String, DocusignResponsiveAPI.RequestStatusChangesResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestStatusChangesResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestStatusChanges',
				'http://www.docusign.net/API/3.0',
				'RequestStatusChanges',
				'http://www.docusign.net/API/3.0',
				'RequestStatusChangesResponse',
				'DocusignResponsiveAPI.RequestStatusChangesResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestStatusChangesResult;
		}
		public DocusignResponsiveAPI.FilteredEnvelopeStatusChanges RequestStatusCodes(DocusignResponsiveAPI.EnvelopeStatusFilter EnvelopeStatusFilter) {
			DocusignResponsiveAPI.RequestStatusCodes_element request_x = new DocusignResponsiveAPI.RequestStatusCodes_element();
			DocusignResponsiveAPI.RequestStatusCodesResponse_element response_x;
			request_x.EnvelopeStatusFilter = EnvelopeStatusFilter;
			Map<String, DocusignResponsiveAPI.RequestStatusCodesResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestStatusCodesResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestStatusCodes',
				'http://www.docusign.net/API/3.0',
				'RequestStatusCodes',
				'http://www.docusign.net/API/3.0',
				'RequestStatusCodesResponse',
				'DocusignResponsiveAPI.RequestStatusCodesResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestStatusCodesResult;
		}
		public DocusignResponsiveAPI.FilteredEnvelopeStatuses RequestStatuses(DocusignResponsiveAPI.EnvelopeStatusFilter EnvelopeStatusFilter) {
			DocusignResponsiveAPI.RequestStatuses_element request_x = new DocusignResponsiveAPI.RequestStatuses_element();
			DocusignResponsiveAPI.RequestStatusesResponse_element response_x;
			request_x.EnvelopeStatusFilter = EnvelopeStatusFilter;
			Map<String, DocusignResponsiveAPI.RequestStatusesResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestStatusesResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestStatuses',
				'http://www.docusign.net/API/3.0',
				'RequestStatuses',
				'http://www.docusign.net/API/3.0',
				'RequestStatusesResponse',
				'DocusignResponsiveAPI.RequestStatusesResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestStatusesResult;
		}
		public DocusignResponsiveAPI.FilteredEnvelopeStatuses RequestStatusesEx(DocusignResponsiveAPI.EnvelopeStatusFilter EnvelopeStatusFilter) {
			DocusignResponsiveAPI.RequestStatusesEx_element request_x = new DocusignResponsiveAPI.RequestStatusesEx_element();
			DocusignResponsiveAPI.RequestStatusesExResponse_element response_x;
			request_x.EnvelopeStatusFilter = EnvelopeStatusFilter;
			Map<String, DocusignResponsiveAPI.RequestStatusesExResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestStatusesExResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestStatusesEx',
				'http://www.docusign.net/API/3.0',
				'RequestStatusesEx',
				'http://www.docusign.net/API/3.0',
				'RequestStatusesExResponse',
				'DocusignResponsiveAPI.RequestStatusesExResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestStatusesExResult;
		}
		public DocusignResponsiveAPI.FilteredEnvelopeStatuses RequestStatusesWithDocumentFields(DocusignResponsiveAPI.EnvelopeStatusFilter EnvelopeStatusFilter) {
			DocusignResponsiveAPI.RequestStatusesWithDocumentFields_element request_x = new DocusignResponsiveAPI.RequestStatusesWithDocumentFields_element();
			DocusignResponsiveAPI.RequestStatusesWithDocumentFieldsResponse_element response_x;
			request_x.EnvelopeStatusFilter = EnvelopeStatusFilter;
			Map<String, DocusignResponsiveAPI.RequestStatusesWithDocumentFieldsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestStatusesWithDocumentFieldsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestStatusesWithDocumentFields',
				'http://www.docusign.net/API/3.0',
				'RequestStatusesWithDocumentFields',
				'http://www.docusign.net/API/3.0',
				'RequestStatusesWithDocumentFieldsResponse',
				'DocusignResponsiveAPI.RequestStatusesWithDocumentFieldsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestStatusesWithDocumentFieldsResult;
		}
		public DocusignResponsiveAPI.EnvelopeStatus RequestStatusEx(String EnvelopeID) {
			DocusignResponsiveAPI.RequestStatusEx_element request_x = new DocusignResponsiveAPI.RequestStatusEx_element();
			DocusignResponsiveAPI.RequestStatusExResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.RequestStatusExResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestStatusExResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestStatusEx',
				'http://www.docusign.net/API/3.0',
				'RequestStatusEx',
				'http://www.docusign.net/API/3.0',
				'RequestStatusExResponse',
				'DocusignResponsiveAPI.RequestStatusExResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestStatusExResult;
		}
		public DocusignResponsiveAPI.EnvelopeStatus RequestStatusWithDocumentFields(String EnvelopeID) {
			DocusignResponsiveAPI.RequestStatusWithDocumentFields_element request_x = new DocusignResponsiveAPI.RequestStatusWithDocumentFields_element();
			DocusignResponsiveAPI.RequestStatusWithDocumentFieldsResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			Map<String, DocusignResponsiveAPI.RequestStatusWithDocumentFieldsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestStatusWithDocumentFieldsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestStatusWithDocumentFields',
				'http://www.docusign.net/API/3.0',
				'RequestStatusWithDocumentFields',
				'http://www.docusign.net/API/3.0',
				'RequestStatusWithDocumentFieldsResponse',
				'DocusignResponsiveAPI.RequestStatusWithDocumentFieldsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestStatusWithDocumentFieldsResult;
		}
		public DocusignResponsiveAPI.EnvelopeTemplate RequestTemplate(String TemplateID,Boolean IncludeDocumentBytes) {
			DocusignResponsiveAPI.RequestTemplate_element request_x = new DocusignResponsiveAPI.RequestTemplate_element();
			DocusignResponsiveAPI.RequestTemplateResponse_element response_x;
			request_x.TemplateID = TemplateID;
			request_x.IncludeDocumentBytes = IncludeDocumentBytes;
			Map<String, DocusignResponsiveAPI.RequestTemplateResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestTemplateResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestTemplate',
				'http://www.docusign.net/API/3.0',
				'RequestTemplate',
				'http://www.docusign.net/API/3.0',
				'RequestTemplateResponse',
				'DocusignResponsiveAPI.RequestTemplateResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestTemplateResult;
		}
		public DocusignResponsiveAPI.ArrayOfEnvelopeTemplate RequestTemplateList(DocusignResponsiveAPI.ArrayOfString5 TemplateIDs,Boolean IncludeDocumentBytes) {
			DocusignResponsiveAPI.RequestTemplateList_element request_x = new DocusignResponsiveAPI.RequestTemplateList_element();
			DocusignResponsiveAPI.RequestTemplateListResponse_element response_x;
			request_x.TemplateIDs = TemplateIDs;
			request_x.IncludeDocumentBytes = IncludeDocumentBytes;
			Map<String, DocusignResponsiveAPI.RequestTemplateListResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestTemplateListResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestTemplateList',
				'http://www.docusign.net/API/3.0',
				'RequestTemplateList',
				'http://www.docusign.net/API/3.0',
				'RequestTemplateListResponse',
				'DocusignResponsiveAPI.RequestTemplateListResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestTemplateListResult;
		}
		public DocusignResponsiveAPI.ArrayOfEnvelopeTemplate RequestTemplateListWithDocumentFields(DocusignResponsiveAPI.ArrayOfString5 TemplateIDs,Boolean IncludeDocumentBytes) {
			DocusignResponsiveAPI.RequestTemplateListWithDocumentFields_element request_x = new DocusignResponsiveAPI.RequestTemplateListWithDocumentFields_element();
			DocusignResponsiveAPI.RequestTemplateListWithDocumentFieldsResponse_element response_x;
			request_x.TemplateIDs = TemplateIDs;
			request_x.IncludeDocumentBytes = IncludeDocumentBytes;
			Map<String, DocusignResponsiveAPI.RequestTemplateListWithDocumentFieldsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestTemplateListWithDocumentFieldsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestTemplateListWithDocumentFields',
				'http://www.docusign.net/API/3.0',
				'RequestTemplateListWithDocumentFields',
				'http://www.docusign.net/API/3.0',
				'RequestTemplateListWithDocumentFieldsResponse',
				'DocusignResponsiveAPI.RequestTemplateListWithDocumentFieldsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestTemplateListWithDocumentFieldsResult;
		}
		public DocusignResponsiveAPI.EnvelopeTemplates RequestTemplates(String AccountID,Boolean IncludeAdvancedTemplates) {
			DocusignResponsiveAPI.RequestTemplates_element request_x = new DocusignResponsiveAPI.RequestTemplates_element();
			DocusignResponsiveAPI.RequestTemplatesResponse_element response_x;
			request_x.AccountID = AccountID;
			request_x.IncludeAdvancedTemplates = IncludeAdvancedTemplates;
			Map<String, DocusignResponsiveAPI.RequestTemplatesResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestTemplatesResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestTemplates',
				'http://www.docusign.net/API/3.0',
				'RequestTemplates',
				'http://www.docusign.net/API/3.0',
				'RequestTemplatesResponse',
				'DocusignResponsiveAPI.RequestTemplatesResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestTemplatesResult;
		}
		public DocusignResponsiveAPI.EnvelopeTemplate RequestTemplateWithDocumentFields(String TemplateID,Boolean IncludeDocumentBytes) {
			DocusignResponsiveAPI.RequestTemplateWithDocumentFields_element request_x = new DocusignResponsiveAPI.RequestTemplateWithDocumentFields_element();
			DocusignResponsiveAPI.RequestTemplateWithDocumentFieldsResponse_element response_x;
			request_x.TemplateID = TemplateID;
			request_x.IncludeDocumentBytes = IncludeDocumentBytes;
			Map<String, DocusignResponsiveAPI.RequestTemplateWithDocumentFieldsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.RequestTemplateWithDocumentFieldsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/RequestTemplateWithDocumentFields',
				'http://www.docusign.net/API/3.0',
				'RequestTemplateWithDocumentFields',
				'http://www.docusign.net/API/3.0',
				'RequestTemplateWithDocumentFieldsResponse',
				'DocusignResponsiveAPI.RequestTemplateWithDocumentFieldsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.RequestTemplateWithDocumentFieldsResult;
		}
		public DocusignResponsiveAPI.SaveTemplateResult SaveTemplate(DocusignResponsiveAPI.EnvelopeTemplate EnvelopeTemplate) {
			DocusignResponsiveAPI.SaveTemplate_element request_x = new DocusignResponsiveAPI.SaveTemplate_element();
			DocusignResponsiveAPI.SaveTemplateResponse_element response_x;
			request_x.EnvelopeTemplate = EnvelopeTemplate;
			Map<String, DocusignResponsiveAPI.SaveTemplateResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.SaveTemplateResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/SaveTemplate',
				'http://www.docusign.net/API/3.0',
				'SaveTemplate',
				'http://www.docusign.net/API/3.0',
				'SaveTemplateResponse',
				'DocusignResponsiveAPI.SaveTemplateResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.SaveTemplateResult;
		}
		public DocusignResponsiveAPI.EnvelopeStatus SendEnvelope(String EnvelopeId,String AccountId) {
			DocusignResponsiveAPI.SendEnvelope_element request_x = new DocusignResponsiveAPI.SendEnvelope_element();
			DocusignResponsiveAPI.SendEnvelopeResponse_element response_x;
			request_x.EnvelopeId = EnvelopeId;
			request_x.AccountId = AccountId;
			Map<String, DocusignResponsiveAPI.SendEnvelopeResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.SendEnvelopeResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/SendEnvelope',
				'http://www.docusign.net/API/3.0',
				'SendEnvelope',
				'http://www.docusign.net/API/3.0',
				'SendEnvelopeResponse',
				'DocusignResponsiveAPI.SendEnvelopeResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.SendEnvelopeResult;
		}
		public DocusignResponsiveAPI.SetSharedAccessResult SetSharedAccess(DocusignResponsiveAPI.SetSharedAccessRequest SetSharedAccessRequest) {
			DocusignResponsiveAPI.SetSharedAccess_element request_x = new DocusignResponsiveAPI.SetSharedAccess_element();
			DocusignResponsiveAPI.SetSharedAccessResponse_element response_x;
			request_x.SetSharedAccessRequest = SetSharedAccessRequest;
			Map<String, DocusignResponsiveAPI.SetSharedAccessResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.SetSharedAccessResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/SetSharedAccess',
				'http://www.docusign.net/API/3.0',
				'SetSharedAccess',
				'http://www.docusign.net/API/3.0',
				'SetSharedAccessResponse',
				'DocusignResponsiveAPI.SetSharedAccessResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.SetSharedAccessResult;
		}
		public DocusignResponsiveAPI.SynchEnvelopeStatus SynchEnvelope(String TransactionID,String AccountID,Boolean Block) {
			DocusignResponsiveAPI.SynchEnvelope_element request_x = new DocusignResponsiveAPI.SynchEnvelope_element();
			DocusignResponsiveAPI.SynchEnvelopeResponse_element response_x;
			request_x.TransactionID = TransactionID;
			request_x.AccountID = AccountID;
			request_x.Block = Block;
			Map<String, DocusignResponsiveAPI.SynchEnvelopeResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.SynchEnvelopeResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/SynchEnvelope',
				'http://www.docusign.net/API/3.0',
				'SynchEnvelope',
				'http://www.docusign.net/API/3.0',
				'SynchEnvelopeResponse',
				'DocusignResponsiveAPI.SynchEnvelopeResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.SynchEnvelopeResult;
		}
		public DocusignResponsiveAPI.TransferEnvelopeStatus TransferEnvelope(String EnvelopeID,String AccountID,String UserID) {
			DocusignResponsiveAPI.TransferEnvelope_element request_x = new DocusignResponsiveAPI.TransferEnvelope_element();
			DocusignResponsiveAPI.TransferEnvelopeResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.AccountID = AccountID;
			request_x.UserID = UserID;
			Map<String, DocusignResponsiveAPI.TransferEnvelopeResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.TransferEnvelopeResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/TransferEnvelope',
				'http://www.docusign.net/API/3.0',
				'TransferEnvelope',
				'http://www.docusign.net/API/3.0',
				'TransferEnvelopeResponse',
				'DocusignResponsiveAPI.TransferEnvelopeResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.TransferEnvelopeResult;
		}
		public DocusignResponsiveAPI.UpdateAddressBookResult UpdateAddressBookItems(DocusignResponsiveAPI.ArrayOfAddressBookItem AddressBookItems,Boolean ReturnAddressBook) {
			DocusignResponsiveAPI.UpdateAddressBookItems_element request_x = new DocusignResponsiveAPI.UpdateAddressBookItems_element();
			DocusignResponsiveAPI.UpdateAddressBookItemsResponse_element response_x;
			request_x.AddressBookItems = AddressBookItems;
			request_x.ReturnAddressBook = ReturnAddressBook;
			Map<String, DocusignResponsiveAPI.UpdateAddressBookItemsResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.UpdateAddressBookItemsResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/UpdateAddressBookItems',
				'http://www.docusign.net/API/3.0',
				'UpdateAddressBookItems',
				'http://www.docusign.net/API/3.0',
				'UpdateAddressBookItemsResponse',
				'DocusignResponsiveAPI.UpdateAddressBookItemsResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.UpdateAddressBookItemsResult;
		}
		public DocusignResponsiveAPI.SaveTemplateResult UploadTemplate(String TemplateXML,String AccountID,Boolean Shared) {
			DocusignResponsiveAPI.UploadTemplate_element request_x = new DocusignResponsiveAPI.UploadTemplate_element();
			DocusignResponsiveAPI.UploadTemplateResponse_element response_x;
			request_x.TemplateXML = TemplateXML;
			request_x.AccountID = AccountID;
			request_x.Shared = Shared;
			Map<String, DocusignResponsiveAPI.UploadTemplateResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.UploadTemplateResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/UploadTemplate',
				'http://www.docusign.net/API/3.0',
				'UploadTemplate',
				'http://www.docusign.net/API/3.0',
				'UploadTemplateResponse',
				'DocusignResponsiveAPI.UploadTemplateResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.UploadTemplateResult;
		}
		public DocusignResponsiveAPI.VoidEnvelopeStatus VoidEnvelope(String EnvelopeID,String Reason) {
			DocusignResponsiveAPI.VoidEnvelope_element request_x = new DocusignResponsiveAPI.VoidEnvelope_element();
			DocusignResponsiveAPI.VoidEnvelopeResponse_element response_x;
			request_x.EnvelopeID = EnvelopeID;
			request_x.Reason = Reason;
			Map<String, DocusignResponsiveAPI.VoidEnvelopeResponse_element> response_map_x = new Map<String, DocusignResponsiveAPI.VoidEnvelopeResponse_element>();
			response_map_x.put('response_x', response_x);
			WebServiceCallout.invoke(
				this,
				request_x,
				response_map_x,
				new String[]{endpoint_x,
				'http://www.docusign.net/API/3.0/VoidEnvelope',
				'http://www.docusign.net/API/3.0',
				'VoidEnvelope',
				'http://www.docusign.net/API/3.0',
				'VoidEnvelopeResponse',
				'DocusignResponsiveAPI.VoidEnvelopeResponse_element'}
			);
			response_x = response_map_x.get('response_x');
			return response_x.VoidEnvelopeResult;
		}
	}
	public class ArrayOfAddressBookItem {
		public DocusignResponsiveAPI.AddressBookItem[] AddressBookItem;
		private transient String[] AddressBookItem_type_info = new String[]{'AddressBookItem','http://www.docusign.net/API/3.0','AddressBookItem','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AddressBookItem'};
	}
	public class ArrayOfAddressBookItem1 {
		public DocusignResponsiveAPI.AddressBookItem[] AddressBookItem;
		private transient String[] AddressBookItem_type_info = new String[]{'AddressBookItem','http://www.docusign.net/API/3.0','AddressBookItem','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AddressBookItem'};
	}
	public class ArrayOfAddressBookRemoveItem {
		public DocusignResponsiveAPI.AddressBookRemoveItem[] AddressBookRemoveItem;
		private transient String[] AddressBookRemoveItem_type_info = new String[]{'AddressBookRemoveItem','http://www.docusign.net/API/3.0','AddressBookRemoveItem','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AddressBookRemoveItem'};
	}
	public class ArrayOfAttachment {
		public DocusignResponsiveAPI.Attachment[] Attachment;
		private transient String[] Attachment_type_info = new String[]{'Attachment','http://www.docusign.net/API/3.0','Attachment','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Attachment'};
	}
	public class ArrayOfBCCEmailAddress {
		public DocusignResponsiveAPI.BCCEmailAddress[] BCCEmailAddress;
		private transient String[] BCCEmailAddress_type_info = new String[]{'BCCEmailAddress','http://www.docusign.net/API/3.0','BCCEmailAddress','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'BCCEmailAddress'};
	}
	public class ArrayOfBrandRequestItem {
		public DocusignResponsiveAPI.BrandRequestItem[] BrandRequestItem;
		private transient String[] BrandRequestItem_type_info = new String[]{'BrandRequestItem','http://www.docusign.net/API/3.0','BrandRequestItem','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'BrandRequestItem'};
	}
	public class ArrayOfBrandResultItem {
		public DocusignResponsiveAPI.BrandResultItem[] BrandResultItem;
		private transient String[] BrandResultItem_type_info = new String[]{'BrandResultItem','http://www.docusign.net/API/3.0','BrandResultItem','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'BrandResultItem'};
	}
	public class ArrayOfCaptiveRecipient {
		public DocusignResponsiveAPI.CaptiveRecipient[] CaptiveRecipient;
		private transient String[] CaptiveRecipient_type_info = new String[]{'CaptiveRecipient','http://www.docusign.net/API/3.0','CaptiveRecipient','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CaptiveRecipient'};
	}
	public class ArrayOfCaptiveRecipient1 {
		public DocusignResponsiveAPI.CaptiveRecipient[] BrandResultItem;
		private transient String[] BrandResultItem_type_info = new String[]{'BrandResultItem','http://www.docusign.net/API/3.0','CaptiveRecipient','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'BrandResultItem'};
	}
	public class ArrayOfCompositeTemplate {
		public DocusignResponsiveAPI.CompositeTemplate[] CompositeTemplate;
		private transient String[] CompositeTemplate_type_info = new String[]{'CompositeTemplate','http://www.docusign.net/API/3.0','CompositeTemplate','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CompositeTemplate'};
	}
	public class ArrayOfConnectFailure {
		public DocusignResponsiveAPI.ConnectFailure[] ConnectFailure;
		private transient String[] ConnectFailure_type_info = new String[]{'ConnectFailure','http://www.docusign.net/API/3.0','ConnectFailure','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ConnectFailure'};
	}
	public class ArrayOfCustomField {
		public DocusignResponsiveAPI.CustomField[] CustomField;
		private transient String[] CustomField_type_info = new String[]{'CustomField','http://www.docusign.net/API/3.0','CustomField','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CustomField'};
	}
	public class ArrayOfDisplayAnchor {
		public DocusignResponsiveAPI.DisplayAnchor[] DisplayAnchor;
		private transient String[] DisplayAnchor_type_info = new String[]{'DisplayAnchor','http://www.docusign.net/API/3.0','DisplayAnchor','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DisplayAnchor'};
	}
	public class ArrayOfDocument {
		public DocusignResponsiveAPI.Document[] Document;
		private transient String[] Document_type_info = new String[]{'Document','http://www.docusign.net/API/3.0','Document','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Document'};
	}
	public class ArrayOfDocumentField {
		public DocusignResponsiveAPI.DocumentField[] DocumentField;
		private transient String[] DocumentField_type_info = new String[]{'DocumentField','http://www.docusign.net/API/3.0','DocumentField','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DocumentField'};
	}
	public class ArrayOfDocumentPDF {
		public DocusignResponsiveAPI.DocumentPDF[] DocumentPDF;
		private transient String[] DocumentPDF_type_info = new String[]{'DocumentPDF','http://www.docusign.net/API/3.0','DocumentPDF','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DocumentPDF'};
	}
	public class ArrayOfDocumentStatus {
		public DocusignResponsiveAPI.DocumentStatus[] DocumentStatus;
		private transient String[] DocumentStatus_type_info = new String[]{'DocumentStatus','http://www.docusign.net/API/3.0','DocumentStatus','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DocumentStatus'};
	}
	public class ArrayOfDocumentV2 {
		public DocusignResponsiveAPI.DocumentV2[] DocumentV2;
		private transient String[] DocumentV2_type_info = new String[]{'DocumentV2','http://www.docusign.net/API/3.0','DocumentV2','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DocumentV2'};
	}
	public class ArrayOfEnvelopeAuditEvent {
		public DocusignResponsiveAPI.EnvelopeAuditEvent[] EnvelopeAuditEvent;
		private transient String[] EnvelopeAuditEvent_type_info = new String[]{'EnvelopeAuditEvent','http://www.docusign.net/API/3.0','EnvelopeAuditEvent','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeAuditEvent'};
	}
	public class ArrayOfEnvelopeEvent {
		public DocusignResponsiveAPI.EnvelopeEvent[] EnvelopeEvent;
		private transient String[] EnvelopeEvent_type_info = new String[]{'EnvelopeEvent','http://www.docusign.net/API/3.0','EnvelopeEvent','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeEvent'};
	}
	public class ArrayOfEnvelopeStatus {
		public DocusignResponsiveAPI.EnvelopeStatus[] EnvelopeStatus;
		private transient String[] EnvelopeStatus_type_info = new String[]{'EnvelopeStatus','http://www.docusign.net/API/3.0','EnvelopeStatus','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeStatus'};
	}
	public class ArrayOfEnvelopeStatusChange {
		public DocusignResponsiveAPI.EnvelopeStatusChange[] EnvelopeStatusChange;
		private transient String[] EnvelopeStatusChange_type_info = new String[]{'EnvelopeStatusChange','http://www.docusign.net/API/3.0','EnvelopeStatusChange','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeStatusChange'};
	}
	public class ArrayOfEnvelopeStatusCode {
		public String[] Status;
		private transient String[] Status_type_info = new String[]{'Status','http://www.docusign.net/API/3.0','EnvelopeStatusCode','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Status'};
	}
	public class ArrayOfEnvelopeTemplate {
		public DocusignResponsiveAPI.EnvelopeTemplate[] EnvelopeTemplate;
		private transient String[] EnvelopeTemplate_type_info = new String[]{'EnvelopeTemplate','http://www.docusign.net/API/3.0','EnvelopeTemplate','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeTemplate'};
	}
	public class ArrayOfFolder {
		public DocusignResponsiveAPI.Folder[] Folder;
		private transient String[] Folder_type_info = new String[]{'Folder','http://www.docusign.net/API/3.0','Folder','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Folder'};
	}
	public class ArrayOfFolderItem {
		public DocusignResponsiveAPI.FolderItem[] FolderItem;
		private transient String[] FolderItem_type_info = new String[]{'FolderItem','http://www.docusign.net/API/3.0','FolderItem','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'FolderItem'};
	}
	public class ArrayOfFormDataXfdfField {
		public DocusignResponsiveAPI.FormDataXfdfField[] field;
		private transient String[] field_type_info = new String[]{'field','http://www.docusign.net/API/3.0','FormDataXfdfField','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'field'};
	}
	public class ArrayOfInlineTemplate {
		public DocusignResponsiveAPI.InlineTemplate[] InlineTemplate;
		private transient String[] InlineTemplate_type_info = new String[]{'InlineTemplate','http://www.docusign.net/API/3.0','InlineTemplate','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'InlineTemplate'};
	}
	public class ArrayOfMatchBox {
		public DocusignResponsiveAPI.MatchBox[] MatchBox;
		private transient String[] MatchBox_type_info = new String[]{'MatchBox','http://www.docusign.net/API/3.0','MatchBox','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'MatchBox'};
	}
	public class ArrayOfPositiveInteger {
		public Integer[] DocumentID;
		private transient String[] DocumentID_type_info = new String[]{'DocumentID','http://www.docusign.net/API/3.0','positiveInteger','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DocumentID'};
	}
	public class ArrayOfPublishConnectFailuresResult {
		public DocusignResponsiveAPI.PublishConnectFailuresResult[] PublishConnectFailuresResult;
		private transient String[] PublishConnectFailuresResult_type_info = new String[]{'PublishConnectFailuresResult','http://www.docusign.net/API/3.0','PublishConnectFailuresResult','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PublishConnectFailuresResult'};
	}
	public class ArrayOfRecipient {
		public DocusignResponsiveAPI.Recipient[] Recipient;
		private transient String[] Recipient_type_info = new String[]{'Recipient','http://www.docusign.net/API/3.0','Recipient','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Recipient'};
	}
	public class ArrayOfRecipient1 {
		public DocusignResponsiveAPI.Recipient[] Recipient;
		private transient String[] Recipient_type_info = new String[]{'Recipient','http://www.docusign.net/API/3.0','Recipient','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Recipient'};
	}
	public class ArrayOfRecipientCorrection {
		public DocusignResponsiveAPI.RecipientCorrection[] RecipientCorrection;
		private transient String[] RecipientCorrection_type_info = new String[]{'RecipientCorrection','http://www.docusign.net/API/3.0','RecipientCorrection','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipientCorrection'};
	}
	public class ArrayOfRecipientCorrectionStatus {
		public DocusignResponsiveAPI.RecipientCorrectionStatus[] RecipientCorrectionStatus;
		private transient String[] RecipientCorrectionStatus_type_info = new String[]{'RecipientCorrectionStatus','http://www.docusign.net/API/3.0','RecipientCorrectionStatus','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipientCorrectionStatus'};
	}
	public class ArrayOfRecipientEsign {
		public DocusignResponsiveAPI.RecipientEsign[] RecipientEsign;
		private transient String[] RecipientEsign_type_info = new String[]{'RecipientEsign','http://www.docusign.net/API/3.0','RecipientEsign','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipientEsign'};
	}
	public class ArrayOfRecipientEvent {
		public DocusignResponsiveAPI.RecipientEvent[] RecipientEvent;
		private transient String[] RecipientEvent_type_info = new String[]{'RecipientEvent','http://www.docusign.net/API/3.0','RecipientEvent','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipientEvent'};
	}
	public class ArrayOfRecipientSignatureProvider {
		public DocusignResponsiveAPI.RecipientSignatureProvider[] RecipientSignatureProvider;
		private transient String[] RecipientSignatureProvider_type_info = new String[]{'RecipientSignatureProvider','http://www.docusign.net/API/3.0','RecipientSignatureProvider','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipientSignatureProvider'};
	}
	public class ArrayOfRecipientStatus {
		public DocusignResponsiveAPI.RecipientStatus[] RecipientStatus;
		private transient String[] RecipientStatus_type_info = new String[]{'RecipientStatus','http://www.docusign.net/API/3.0','RecipientStatus','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipientStatus'};
	}
	public class ArrayOfSAMLAttribute {
		public DocusignResponsiveAPI.SAMLAttribute[] SAMLAttribute;
		private transient String[] SAMLAttribute_type_info = new String[]{'SAMLAttribute','http://www.docusign.net/API/3.0','SAMLAttribute','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SAMLAttribute'};
	}
	public class ArrayOfServerTemplate {
		public DocusignResponsiveAPI.ServerTemplate[] ServerTemplate;
		private transient String[] ServerTemplate_type_info = new String[]{'ServerTemplate','http://www.docusign.net/API/3.0','ServerTemplate','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ServerTemplate'};
	}
	public class ArrayOfString {
		public String[] SenderProvidedNumber;
		private transient String[] SenderProvidedNumber_type_info = new String[]{'SenderProvidedNumber','http://www.docusign.net/API/3.0','string','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SenderProvidedNumber'};
	}
	public class ArrayOfString1 {
		public String[] CustomField;
		private transient String[] CustomField_type_info = new String[]{'CustomField','http://www.docusign.net/API/3.0','string','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CustomField'};
	}
	public class ArrayOfString2 {
		public String[] EnvelopeId;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId'};
	}
	public class ArrayOfString3 {
		public String[] RecipientName;
		private transient String[] RecipientName_type_info = new String[]{'RecipientName','http://www.docusign.net/API/3.0','string','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipientName'};
	}
	public class ArrayOfString4 {
		public String[] EnabledFeatures;
		private transient String[] EnabledFeatures_type_info = new String[]{'EnabledFeatures','http://www.docusign.net/API/3.0','string','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnabledFeatures'};
	}
	public class ArrayOfString5 {
		public String[] string_x;
		private transient String[] string_x_type_info = new String[]{'string','http://www.docusign.net/API/3.0','string','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'string_x'};
	}
	public class ArrayOfString6 {
		public String[] UserId;
		private transient String[] UserId_type_info = new String[]{'UserId','http://www.docusign.net/API/3.0','string','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UserId'};
	}
	public class ArrayOfTab {
		public DocusignResponsiveAPI.Tab[] Tab;
		private transient String[] Tab_type_info = new String[]{'Tab','http://www.docusign.net/API/3.0','Tab','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Tab'};
	}
	public class ArrayOfTabStatus {
		public DocusignResponsiveAPI.TabStatus[] TabStatus;
		private transient String[] TabStatus_type_info = new String[]{'TabStatus','http://www.docusign.net/API/3.0','TabStatus','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TabStatus'};
	}
	public class ArrayOfTemplateReference {
		public DocusignResponsiveAPI.TemplateReference[] TemplateReference;
		private transient String[] TemplateReference_type_info = new String[]{'TemplateReference','http://www.docusign.net/API/3.0','TemplateReference','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TemplateReference'};
	}
	public class ArrayOfTemplateReferenceFieldDataDataValue {
		public DocusignResponsiveAPI.TemplateReferenceFieldDataDataValue[] DataValue;
		private transient String[] DataValue_type_info = new String[]{'DataValue','http://www.docusign.net/API/3.0','TemplateReferenceFieldDataDataValue','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DataValue'};
	}
	public class ArrayOfTemplateReferenceRoleAssignment {
		public DocusignResponsiveAPI.TemplateReferenceRoleAssignment[] RoleAssignment;
		private transient String[] RoleAssignment_type_info = new String[]{'RoleAssignment','http://www.docusign.net/API/3.0','TemplateReferenceRoleAssignment','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RoleAssignment'};
	}
	public class Attachment {
		public String Data;
		public String Label;
		public String Type_x;
		private transient String[] Data_type_info = new String[]{'Data','http://www.docusign.net/API/3.0','base64Binary','0','1','false'};
		private transient String[] Label_type_info = new String[]{'Label','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Type_x_type_info = new String[]{'Type','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Data','Label','Type_x'};
	}
	public class AuthenticationStatus {
		public DocusignResponsiveAPI.EventResult AccessCodeResult;
		public DocusignResponsiveAPI.EventResult IDQuestionsResult;
		public DocusignResponsiveAPI.EventResult IDLookupResult;
		public DocusignResponsiveAPI.EventResult AgeVerifyResult;
		public DocusignResponsiveAPI.EventResult STANPinResult;
		public DocusignResponsiveAPI.EventResult OFACResult;
		public DocusignResponsiveAPI.EventResult PhoneAuthResult;
		public DocusignResponsiveAPI.EventResult LiveIDResult;
		public DocusignResponsiveAPI.EventResult FacebookResult;
		public DocusignResponsiveAPI.EventResult GoogleResult;
		public DocusignResponsiveAPI.EventResult LinkedinResult;
		public DocusignResponsiveAPI.EventResult SalesforceResult;
		public DocusignResponsiveAPI.EventResult TwitterResult;
		public DocusignResponsiveAPI.EventResult OpenIDResult;
		public DocusignResponsiveAPI.EventResult AnySocialIDResult;
		public DocusignResponsiveAPI.EventResult YahooResult;
		private transient String[] AccessCodeResult_type_info = new String[]{'AccessCodeResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] IDQuestionsResult_type_info = new String[]{'IDQuestionsResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] IDLookupResult_type_info = new String[]{'IDLookupResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] AgeVerifyResult_type_info = new String[]{'AgeVerifyResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] STANPinResult_type_info = new String[]{'STANPinResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] OFACResult_type_info = new String[]{'OFACResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] PhoneAuthResult_type_info = new String[]{'PhoneAuthResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] LiveIDResult_type_info = new String[]{'LiveIDResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] FacebookResult_type_info = new String[]{'FacebookResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] GoogleResult_type_info = new String[]{'GoogleResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] LinkedinResult_type_info = new String[]{'LinkedinResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] SalesforceResult_type_info = new String[]{'SalesforceResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] TwitterResult_type_info = new String[]{'TwitterResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] OpenIDResult_type_info = new String[]{'OpenIDResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] AnySocialIDResult_type_info = new String[]{'AnySocialIDResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] YahooResult_type_info = new String[]{'YahooResult','http://www.docusign.net/API/3.0','EventResult','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccessCodeResult','IDQuestionsResult','IDLookupResult','AgeVerifyResult','STANPinResult','OFACResult','PhoneAuthResult','LiveIDResult','FacebookResult','GoogleResult','LinkedinResult','SalesforceResult','TwitterResult','OpenIDResult','AnySocialIDResult','YahooResult'};
	}
	public class AuthoritativeCopyExportDocuments {
		public String EnvelopeId;
		public String TransactionId;
		public Integer Count;
		public DocusignResponsiveAPI.DocumentPDF[] DocumentPDF;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TransactionId_type_info = new String[]{'TransactionId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Count_type_info = new String[]{'Count','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] DocumentPDF_type_info = new String[]{'DocumentPDF','http://www.docusign.net/API/3.0','DocumentPDF','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','TransactionId','Count','DocumentPDF'};
	}
	public class AuthoritativeCopyExportStatus {
		public Boolean AuthoritativeCopyExportSuccess;
		public String EnvelopeId;
		public String ExportKey;
		private transient String[] AuthoritativeCopyExportSuccess_type_info = new String[]{'AuthoritativeCopyExportSuccess','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ExportKey_type_info = new String[]{'ExportKey','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AuthoritativeCopyExportSuccess','EnvelopeId','ExportKey'};
	}
	public class AvailableFolders {
		public DocusignResponsiveAPI.ArrayOfFolder Folders;
		private transient String[] Folders_type_info = new String[]{'Folders','http://www.docusign.net/API/3.0','ArrayOfFolder','1','1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Folders'};
	}
	public class BCCEmailAddress {
		public String Email;
		public Integer BCCEmailAddressId;
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] BCCEmailAddressId_type_info = new String[]{'BCCEmailAddressId','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Email','BCCEmailAddressId'};
	}
	public class BrandDefinitions {
		public String BrandDefinitionsFileBytes;
		private transient String[] BrandDefinitionsFileBytes_type_info = new String[]{'BrandDefinitionsFileBytes','http://www.docusign.net/API/3.0','base64Binary','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'BrandDefinitionsFileBytes'};
	}
	public class BrandDeleteRequest {
		public DocusignResponsiveAPI.ArrayOfBrandRequestItem BrandRequestItems;
		private transient String[] BrandRequestItems_type_info = new String[]{'BrandRequestItems','http://www.docusign.net/API/3.0','ArrayOfBrandRequestItem','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'BrandRequestItems'};
	}
	public class BrandRequestItem {
		public String BrandId;
		private transient String[] BrandId_type_info = new String[]{'BrandId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'BrandId'};
	}
	public class BrandResultItem {
		public String BrandId;
		public String BrandName;
		public String BrandCompany;
		public DocusignResponsiveAPI.ErrorDetails ErrorDetails;
		private transient String[] BrandId_type_info = new String[]{'BrandId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] BrandName_type_info = new String[]{'BrandName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] BrandCompany_type_info = new String[]{'BrandCompany','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ErrorDetails_type_info = new String[]{'ErrorDetails','http://www.docusign.net/API/3.0','ErrorDetails','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'BrandId','BrandName','BrandCompany','ErrorDetails'};
	}
	public class BrandResults {
		public String RecipientBrandIdDefault;
		public String SenderBrandIdDefault;
		public DocusignResponsiveAPI.ArrayOfBrandResultItem BrandResultItems;
		private transient String[] RecipientBrandIdDefault_type_info = new String[]{'RecipientBrandIdDefault','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SenderBrandIdDefault_type_info = new String[]{'SenderBrandIdDefault','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] BrandResultItems_type_info = new String[]{'BrandResultItems','http://www.docusign.net/API/3.0','ArrayOfBrandResultItem','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipientBrandIdDefault','SenderBrandIdDefault','BrandResultItems'};
	}
	public class CaptiveRecipient {
		public String ClientUserId;
		public String UserName;
		public String Email;
		public DocusignResponsiveAPI.ErrorDetails ErrorDetails;
		private transient String[] ClientUserId_type_info = new String[]{'ClientUserId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','1','1','true'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','1','1','true'};
		private transient String[] ErrorDetails_type_info = new String[]{'ErrorDetails','http://www.docusign.net/API/3.0','ErrorDetails','1','1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ClientUserId','UserName','Email','ErrorDetails'};
	}
	public class CaptiveRecipientResults {
		public DocusignResponsiveAPI.ArrayOfCaptiveRecipient1 CaptiveRecipients;
		private transient String[] CaptiveRecipients_type_info = new String[]{'CaptiveRecipients','http://www.docusign.net/API/3.0','ArrayOfCaptiveRecipient1','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CaptiveRecipients'};
	}
	public class CollapsibleSettings {
		public String LabelStyle;
		public String ArrowStyle;
		public String ArrowClosed;
		public String ArrowOpen;
		public String ArrowLocation;
		public String ArrowColor;
		public String ArrowSize;
		public String ContainerStyle;
		public Boolean OnlyArrowIsClickable;
		public String OuterLabelAndArrowStyle;
		private transient String[] LabelStyle_type_info = new String[]{'LabelStyle','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ArrowStyle_type_info = new String[]{'ArrowStyle','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ArrowClosed_type_info = new String[]{'ArrowClosed','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ArrowOpen_type_info = new String[]{'ArrowOpen','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ArrowLocation_type_info = new String[]{'ArrowLocation','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ArrowColor_type_info = new String[]{'ArrowColor','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ArrowSize_type_info = new String[]{'ArrowSize','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ContainerStyle_type_info = new String[]{'ContainerStyle','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OnlyArrowIsClickable_type_info = new String[]{'OnlyArrowIsClickable','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] OuterLabelAndArrowStyle_type_info = new String[]{'OuterLabelAndArrowStyle','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'LabelStyle','ArrowStyle','ArrowClosed','ArrowOpen','ArrowLocation','ArrowColor','ArrowSize','ContainerStyle','OnlyArrowIsClickable','OuterLabelAndArrowStyle'};
	}
	public class CompleteAuthoritativeCopyExport_element {
		public String EnvelopeId;
		public String TransactionId;
		public String ExternalId;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TransactionId_type_info = new String[]{'TransactionId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ExternalId_type_info = new String[]{'ExternalId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','TransactionId','ExternalId'};
	}
	public class CompleteAuthoritativeCopyExportResponse_element {
		public DocusignResponsiveAPI.AuthoritativeCopyExportStatus CompleteAuthoritativeCopyExportResult;
		private transient String[] CompleteAuthoritativeCopyExportResult_type_info = new String[]{'CompleteAuthoritativeCopyExportResult','http://www.docusign.net/API/3.0','AuthoritativeCopyExportStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CompleteAuthoritativeCopyExportResult'};
	}
	public class CompositeTemplate {
		public DocusignResponsiveAPI.ArrayOfServerTemplate ServerTemplates;
		public DocusignResponsiveAPI.ArrayOfInlineTemplate InlineTemplates;
		public DocusignResponsiveAPI.PDFMetaDataTemplate PDFMetaDataTemplate;
		public DocusignResponsiveAPI.Document Document;
		private transient String[] ServerTemplates_type_info = new String[]{'ServerTemplates','http://www.docusign.net/API/3.0','ArrayOfServerTemplate','0','1','false'};
		private transient String[] InlineTemplates_type_info = new String[]{'InlineTemplates','http://www.docusign.net/API/3.0','ArrayOfInlineTemplate','0','1','false'};
		private transient String[] PDFMetaDataTemplate_type_info = new String[]{'PDFMetaDataTemplate','http://www.docusign.net/API/3.0','PDFMetaDataTemplate','0','1','false'};
		private transient String[] Document_type_info = new String[]{'Document','http://www.docusign.net/API/3.0','Document','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ServerTemplates','InlineTemplates','PDFMetaDataTemplate','Document'};
	}
	public class ConnectFailure {
		public String EnvelopeId;
		public String AccountId;
		public DateTime Failed;
		public DateTime Retried;
		public Integer RetryCount;
		public String EnvelopeStatus;
		public String Sender;
		public String Email;
		public String Subject;
		public String Error;
		public String ConfigId;
		public String ConfigUrl;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Failed_type_info = new String[]{'Failed','http://www.docusign.net/API/3.0','dateTime','1','1','false'};
		private transient String[] Retried_type_info = new String[]{'Retried','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] RetryCount_type_info = new String[]{'RetryCount','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] EnvelopeStatus_type_info = new String[]{'EnvelopeStatus','http://www.docusign.net/API/3.0','EnvelopeStatusCode','1','1','false'};
		private transient String[] Sender_type_info = new String[]{'Sender','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Subject_type_info = new String[]{'Subject','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Error_type_info = new String[]{'Error','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ConfigId_type_info = new String[]{'ConfigId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ConfigUrl_type_info = new String[]{'ConfigUrl','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','AccountId','Failed','Retried','RetryCount','EnvelopeStatus','Sender','Email','Subject','Error','ConfigId','ConfigUrl'};
	}
	public class ConnectFailuresFilter {
		public String AccountId;
		public DateTime DateFrom;
		public DateTime DateTo;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DateFrom_type_info = new String[]{'DateFrom','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] DateTo_type_info = new String[]{'DateTo','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','DateFrom','DateTo'};
	}
	public class CorrectAndResendEnvelope_element {
		public DocusignResponsiveAPI.Correction Correction;
		private transient String[] Correction_type_info = new String[]{'Correction','http://www.docusign.net/API/3.0','Correction','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Correction'};
	}
	public class CorrectAndResendEnvelopeResponse_element {
		public DocusignResponsiveAPI.CorrectionStatus CorrectAndResendEnvelopeResult;
		private transient String[] CorrectAndResendEnvelopeResult_type_info = new String[]{'CorrectAndResendEnvelopeResult','http://www.docusign.net/API/3.0','CorrectionStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CorrectAndResendEnvelopeResult'};
	}
	public class Correction {
		public String EnvelopeID;
		public DocusignResponsiveAPI.EnvelopeSettings EnvelopeSettingsCorrection;
		public DocusignResponsiveAPI.ArrayOfRecipientCorrection RecipientCorrections;
		public DocusignResponsiveAPI.Reminders Reminders;
		public DocusignResponsiveAPI.Expirations Expirations;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EnvelopeSettingsCorrection_type_info = new String[]{'EnvelopeSettingsCorrection','http://www.docusign.net/API/3.0','EnvelopeSettings','0','1','false'};
		private transient String[] RecipientCorrections_type_info = new String[]{'RecipientCorrections','http://www.docusign.net/API/3.0','ArrayOfRecipientCorrection','0','1','false'};
		private transient String[] Reminders_type_info = new String[]{'Reminders','http://www.docusign.net/API/3.0','Reminders','0','1','false'};
		private transient String[] Expirations_type_info = new String[]{'Expirations','http://www.docusign.net/API/3.0','Expirations','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','EnvelopeSettingsCorrection','RecipientCorrections','Reminders','Expirations'};
	}
	public class CorrectionStatus {
		public DocusignResponsiveAPI.EnvelopeSettings EnvelopeSettingsCorrectionStatus;
		public DocusignResponsiveAPI.ArrayOfRecipientCorrectionStatus RecipientCorrectionStatuses;
		public DocusignResponsiveAPI.Reminders Reminders;
		public DocusignResponsiveAPI.Expirations Expirations;
		private transient String[] EnvelopeSettingsCorrectionStatus_type_info = new String[]{'EnvelopeSettingsCorrectionStatus','http://www.docusign.net/API/3.0','EnvelopeSettings','0','1','false'};
		private transient String[] RecipientCorrectionStatuses_type_info = new String[]{'RecipientCorrectionStatuses','http://www.docusign.net/API/3.0','ArrayOfRecipientCorrectionStatus','0','1','false'};
		private transient String[] Reminders_type_info = new String[]{'Reminders','http://www.docusign.net/API/3.0','Reminders','0','1','false'};
		private transient String[] Expirations_type_info = new String[]{'Expirations','http://www.docusign.net/API/3.0','Expirations','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeSettingsCorrectionStatus','RecipientCorrectionStatuses','Reminders','Expirations'};
	}
	public class CreateAccountBrands_element {
		public String AccountId;
		public DocusignResponsiveAPI.BrandDefinitions BrandDefinitions;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] BrandDefinitions_type_info = new String[]{'BrandDefinitions','http://www.docusign.net/API/3.0','BrandDefinitions','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','BrandDefinitions'};
	}
	public class CreateAccountBrandsResponse_element {
		public DocusignResponsiveAPI.BrandResults CreateAccountBrandsResult;
		private transient String[] CreateAccountBrandsResult_type_info = new String[]{'CreateAccountBrandsResult','http://www.docusign.net/API/3.0','BrandResults','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CreateAccountBrandsResult'};
	}
	public class CreateAndSendEnvelope_element {
		public DocusignResponsiveAPI.Envelope Envelope;
		private transient String[] Envelope_type_info = new String[]{'Envelope','http://www.docusign.net/API/3.0','Envelope','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Envelope'};
	}
	public class CreateAndSendEnvelopeResponse_element {
		public DocusignResponsiveAPI.EnvelopeStatus CreateAndSendEnvelopeResult;
		private transient String[] CreateAndSendEnvelopeResult_type_info = new String[]{'CreateAndSendEnvelopeResult','http://www.docusign.net/API/3.0','EnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CreateAndSendEnvelopeResult'};
	}
	public class CreateEnvelope_element {
		public DocusignResponsiveAPI.Envelope Envelope;
		private transient String[] Envelope_type_info = new String[]{'Envelope','http://www.docusign.net/API/3.0','Envelope','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Envelope'};
	}
	public class CreateEnvelopeFromTemplates_element {
		public DocusignResponsiveAPI.ArrayOfTemplateReference TemplateReferences;
		public DocusignResponsiveAPI.ArrayOfRecipient1 Recipients;
		public DocusignResponsiveAPI.EnvelopeInformation EnvelopeInformation;
		public Boolean ActivateEnvelope;
		private transient String[] TemplateReferences_type_info = new String[]{'TemplateReferences','http://www.docusign.net/API/3.0','ArrayOfTemplateReference','0','1','false'};
		private transient String[] Recipients_type_info = new String[]{'Recipients','http://www.docusign.net/API/3.0','ArrayOfRecipient1','0','1','false'};
		private transient String[] EnvelopeInformation_type_info = new String[]{'EnvelopeInformation','http://www.docusign.net/API/3.0','EnvelopeInformation','0','1','false'};
		private transient String[] ActivateEnvelope_type_info = new String[]{'ActivateEnvelope','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TemplateReferences','Recipients','EnvelopeInformation','ActivateEnvelope'};
	}
	public class CreateEnvelopeFromTemplatesAndForms_element {
		public DocusignResponsiveAPI.EnvelopeInformation EnvelopeInformation;
		public DocusignResponsiveAPI.ArrayOfCompositeTemplate CompositeTemplates;
		public Boolean ActivateEnvelope;
		private transient String[] EnvelopeInformation_type_info = new String[]{'EnvelopeInformation','http://www.docusign.net/API/3.0','EnvelopeInformation','0','1','false'};
		private transient String[] CompositeTemplates_type_info = new String[]{'CompositeTemplates','http://www.docusign.net/API/3.0','ArrayOfCompositeTemplate','0','1','false'};
		private transient String[] ActivateEnvelope_type_info = new String[]{'ActivateEnvelope','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeInformation','CompositeTemplates','ActivateEnvelope'};
	}
	public class CreateEnvelopeFromTemplatesAndFormsResponse_element {
		public DocusignResponsiveAPI.EnvelopeStatus CreateEnvelopeFromTemplatesAndFormsResult;
		private transient String[] CreateEnvelopeFromTemplatesAndFormsResult_type_info = new String[]{'CreateEnvelopeFromTemplatesAndFormsResult','http://www.docusign.net/API/3.0','EnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CreateEnvelopeFromTemplatesAndFormsResult'};
	}
	public class CreateEnvelopeFromTemplatesResponse_element {
		public DocusignResponsiveAPI.EnvelopeStatus CreateEnvelopeFromTemplatesResult;
		private transient String[] CreateEnvelopeFromTemplatesResult_type_info = new String[]{'CreateEnvelopeFromTemplatesResult','http://www.docusign.net/API/3.0','EnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CreateEnvelopeFromTemplatesResult'};
	}
	public class CreateEnvelopeResponse_element {
		public DocusignResponsiveAPI.EnvelopeStatus CreateEnvelopeResult;
		private transient String[] CreateEnvelopeResult_type_info = new String[]{'CreateEnvelopeResult','http://www.docusign.net/API/3.0','EnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CreateEnvelopeResult'};
	}
	public class CustomField {
		public String Name;
		public String Show;
		public String Required;
		public String Value;
		public String CustomFieldType;
		public String ListItems;
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Show_type_info = new String[]{'Show','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Required_type_info = new String[]{'Required','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Value_type_info = new String[]{'Value','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CustomFieldType_type_info = new String[]{'CustomFieldType','http://www.docusign.net/API/3.0','CustomFieldType','0','1','false'};
		private transient String[] ListItems_type_info = new String[]{'ListItems','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Name','Show','Required','Value','CustomFieldType','ListItems'};
	}
	public class DeleteAccountBrands_element {
		public String AccountId;
		public DocusignResponsiveAPI.BrandDeleteRequest BrandDeleteRequest;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] BrandDeleteRequest_type_info = new String[]{'BrandDeleteRequest','http://www.docusign.net/API/3.0','BrandDeleteRequest','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','BrandDeleteRequest'};
	}
	public class DeleteAccountBrandsResponse_element {
		public DocusignResponsiveAPI.BrandResults DeleteAccountBrandsResult;
		private transient String[] DeleteAccountBrandsResult_type_info = new String[]{'DeleteAccountBrandsResult','http://www.docusign.net/API/3.0','BrandResults','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DeleteAccountBrandsResult'};
	}
	public class DeleteCaptiveRecipientsSignatures_element {
		public String AccountId;
		public DocusignResponsiveAPI.DeleteCaptiveRecipientsSignaturesArg Arg;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Arg_type_info = new String[]{'Arg','http://www.docusign.net/API/3.0','DeleteCaptiveRecipientsSignaturesArg','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','Arg'};
	}
	public class DeleteCaptiveRecipientsSignaturesArg {
		public DocusignResponsiveAPI.ArrayOfCaptiveRecipient CaptiveRecipients;
		private transient String[] CaptiveRecipients_type_info = new String[]{'CaptiveRecipients','http://www.docusign.net/API/3.0','ArrayOfCaptiveRecipient','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CaptiveRecipients'};
	}
	public class DeleteCaptiveRecipientsSignaturesResponse_element {
		public DocusignResponsiveAPI.CaptiveRecipientResults DeleteCaptiveRecipientsSignaturesResult;
		private transient String[] DeleteCaptiveRecipientsSignaturesResult_type_info = new String[]{'DeleteCaptiveRecipientsSignaturesResult','http://www.docusign.net/API/3.0','CaptiveRecipientResults','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DeleteCaptiveRecipientsSignaturesResult'};
	}
	public class DeleteEnvelopes_element {
		public DocusignResponsiveAPI.DeleteEnvelopesArg Arg;
		private transient String[] Arg_type_info = new String[]{'Arg','http://www.docusign.net/API/3.0','DeleteEnvelopesArg','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Arg'};
	}
	public class DeleteEnvelopesArg {
		public DocusignResponsiveAPI.ArrayOfString2 EnvelopeIds;
		public String AccountId;
		public DocusignResponsiveAPI.FolderTypeInfo FolderFrom;
		private transient String[] EnvelopeIds_type_info = new String[]{'EnvelopeIds','http://www.docusign.net/API/3.0','ArrayOfString2','0','1','false'};
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] FolderFrom_type_info = new String[]{'FolderFrom','http://www.docusign.net/API/3.0','FolderTypeInfo','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeIds','AccountId','FolderFrom'};
	}
	public class DeleteEnvelopesResponse_element {
		public Boolean DeleteEnvelopesResult;
		private transient String[] DeleteEnvelopesResult_type_info = new String[]{'DeleteEnvelopesResult','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DeleteEnvelopesResult'};
	}
	public class DisplayAnchor {
		public String StartAnchor;
		public String EndAnchor;
		public Boolean RemoveStartAnchor;
		public Boolean RemoveEndAnchor;
		public Boolean CaseSensitive;
		public DocusignResponsiveAPI.DisplaySettings DisplaySettings;
		private transient String[] StartAnchor_type_info = new String[]{'StartAnchor','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EndAnchor_type_info = new String[]{'EndAnchor','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RemoveStartAnchor_type_info = new String[]{'RemoveStartAnchor','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RemoveEndAnchor_type_info = new String[]{'RemoveEndAnchor','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CaseSensitive_type_info = new String[]{'CaseSensitive','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] DisplaySettings_type_info = new String[]{'DisplaySettings','http://www.docusign.net/API/3.0','DisplaySettings','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'StartAnchor','EndAnchor','RemoveStartAnchor','RemoveEndAnchor','CaseSensitive','DisplaySettings'};
	}
	public class DisplaySettings {
		public String Display;
		public String DisplayLabel;
		public Integer DisplayPageNumber;
		public Integer DisplayOrder;
		public String TableStyle;
		public String CellStyle;
		public String InlineOuterStyle;
		public String LabelWhenOpened;
		public String PreLabel;
		public Boolean HideLabelWhenOpened;
		public Boolean ScrollToTopWhenOpened;
		public DocusignResponsiveAPI.CollapsibleSettings CollapsibleSettings;
		private transient String[] Display_type_info = new String[]{'Display','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DisplayLabel_type_info = new String[]{'DisplayLabel','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DisplayPageNumber_type_info = new String[]{'DisplayPageNumber','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] DisplayOrder_type_info = new String[]{'DisplayOrder','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] TableStyle_type_info = new String[]{'TableStyle','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CellStyle_type_info = new String[]{'CellStyle','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] InlineOuterStyle_type_info = new String[]{'InlineOuterStyle','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] LabelWhenOpened_type_info = new String[]{'LabelWhenOpened','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] PreLabel_type_info = new String[]{'PreLabel','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] HideLabelWhenOpened_type_info = new String[]{'HideLabelWhenOpened','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] ScrollToTopWhenOpened_type_info = new String[]{'ScrollToTopWhenOpened','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CollapsibleSettings_type_info = new String[]{'CollapsibleSettings','http://www.docusign.net/API/3.0','CollapsibleSettings','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Display','DisplayLabel','DisplayPageNumber','DisplayOrder','TableStyle','CellStyle','InlineOuterStyle','LabelWhenOpened','PreLabel','HideLabelWhenOpened','ScrollToTopWhenOpened','CollapsibleSettings'};
	}
	public class DOBInformation {
		public DateTime DOB;
		private transient String[] DOB_type_info = new String[]{'DOB','http://www.docusign.net/API/3.0','dateTime','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DOB'};
	}
	public class DOBInformationInput {
		public DocusignResponsiveAPI.DOBInformation DOBInformation;
		public String DisplayLevel;
		public Boolean ReceiveInResponse;
		private transient String[] DOBInformation_type_info = new String[]{'DOBInformation','http://www.docusign.net/API/3.0','DOBInformation','0','1','false'};
		private transient String[] DisplayLevel_type_info = new String[]{'DisplayLevel','http://www.docusign.net/API/3.0','DisplayLevelCode','0','1','false'};
		private transient String[] ReceiveInResponse_type_info = new String[]{'ReceiveInResponse','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DOBInformation','DisplayLevel','ReceiveInResponse'};
	}
	public class Document {
		public Integer ID;
		public String Name;
		public String PDFBytes;
		public String Password;
		public Boolean TransformPdfFields;
		public String FileExtension;
		public DocusignResponsiveAPI.ArrayOfMatchBox MatchBoxes;
		public String AttachmentDescription;
		public DocusignResponsiveAPI.ArrayOfDocumentField DocumentFields;
		public Boolean AuthoritativeCopy;
		public DocusignResponsiveAPI.HtmlDefinition HtmlDefinition;
		private transient String[] ID_type_info = new String[]{'ID','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] PDFBytes_type_info = new String[]{'PDFBytes','http://www.docusign.net/API/3.0','base64Binary','0','1','false'};
		private transient String[] Password_type_info = new String[]{'Password','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TransformPdfFields_type_info = new String[]{'TransformPdfFields','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] FileExtension_type_info = new String[]{'FileExtension','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] MatchBoxes_type_info = new String[]{'MatchBoxes','http://www.docusign.net/API/3.0','ArrayOfMatchBox','0','1','false'};
		private transient String[] AttachmentDescription_type_info = new String[]{'AttachmentDescription','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DocumentFields_type_info = new String[]{'DocumentFields','http://www.docusign.net/API/3.0','ArrayOfDocumentField','0','1','false'};
		private transient String[] AuthoritativeCopy_type_info = new String[]{'AuthoritativeCopy','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] HtmlDefinition_type_info = new String[]{'HtmlDefinition','http://www.docusign.net/API/3.0','HtmlDefinition','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ID','Name','PDFBytes','Password','TransformPdfFields','FileExtension','MatchBoxes','AttachmentDescription','DocumentFields','AuthoritativeCopy','HtmlDefinition'};
	}
	public class DocumentField {
		public String Name;
		public String Value;
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Value_type_info = new String[]{'Value','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Name','Value'};
	}
	public class DocumentPDF {
		public String Name;
		public String PDFBytes;
		public Integer DocumentID;
		public String DocumentType;
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] PDFBytes_type_info = new String[]{'PDFBytes','http://www.docusign.net/API/3.0','base64Binary','0','1','false'};
		private transient String[] DocumentID_type_info = new String[]{'DocumentID','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] DocumentType_type_info = new String[]{'DocumentType','http://www.docusign.net/API/3.0','DocumentType','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Name','PDFBytes','DocumentID','DocumentType'};
	}
	public class DocumentPDFs {
		public String EnvelopeId;
		public DocusignResponsiveAPI.DocumentPDF[] DocumentPDF;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DocumentPDF_type_info = new String[]{'DocumentPDF','http://www.docusign.net/API/3.0','DocumentPDF','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','DocumentPDF'};
	}
	public class DocumentStatus {
		public Integer ID;
		public String Name;
		public String TemplateName;
		public Integer Sequence;
		public DocusignResponsiveAPI.ArrayOfDocumentField DocumentFields;
		private transient String[] ID_type_info = new String[]{'ID','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TemplateName_type_info = new String[]{'TemplateName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Sequence_type_info = new String[]{'Sequence','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] DocumentFields_type_info = new String[]{'DocumentFields','http://www.docusign.net/API/3.0','ArrayOfDocumentField','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ID','Name','TemplateName','Sequence','DocumentFields'};
	}
	
	//Extends http://www.docusign.net/API/3.0:Document
	public class DocumentV2 {
		public Integer ID;
		public String Name;
		public String PDFBytes;
		public String Password;
		public Boolean TransformPdfFields;
		public String FileExtension;
		public DocusignResponsiveAPI.ArrayOfMatchBox MatchBoxes;
		public String AttachmentDescription;
		public DocusignResponsiveAPI.ArrayOfDocumentField DocumentFields;
		public Boolean AuthoritativeCopy;
		public DocusignResponsiveAPI.HtmlDefinition HtmlDefinition;
		private transient String[] ID_type_info = new String[]{'ID','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] PDFBytes_type_info = new String[]{'PDFBytes','http://www.docusign.net/API/3.0','base64Binary','0','1','false'};
		private transient String[] Password_type_info = new String[]{'Password','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TransformPdfFields_type_info = new String[]{'TransformPdfFields','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] FileExtension_type_info = new String[]{'FileExtension','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] MatchBoxes_type_info = new String[]{'MatchBoxes','http://www.docusign.net/API/3.0','ArrayOfMatchBox','0','1','false'};
		private transient String[] AttachmentDescription_type_info = new String[]{'AttachmentDescription','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DocumentFields_type_info = new String[]{'DocumentFields','http://www.docusign.net/API/3.0','ArrayOfDocumentField','0','1','false'};
		private transient String[] AuthoritativeCopy_type_info = new String[]{'AuthoritativeCopy','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] HtmlDefinition_type_info = new String[]{'HtmlDefinition','http://www.docusign.net/API/3.0','HtmlDefinition','0','1','false'};
		public String DocumentType;
		private transient String[] DocumentType_type_info = new String[]{'DocumentType','http://www.docusign.net/API/3.0','DocumentType','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ID','Name','PDFBytes','Password','TransformPdfFields','FileExtension','MatchBoxes','AttachmentDescription','DocumentFields','AuthoritativeCopy','HtmlDefinition','DocumentType'};
	}
	public class DocuSignEnvelopeInformation {
		public DocusignResponsiveAPI.EnvelopeStatus EnvelopeStatus;
		public DocusignResponsiveAPI.ArrayOfDocumentPDF DocumentPDFs;
		public String TimeZone;
		public Integer TimeZoneOffset;
		private transient String[] EnvelopeStatus_type_info = new String[]{'EnvelopeStatus','http://www.docusign.net/API/3.0','EnvelopeStatus','0','1','false'};
		private transient String[] DocumentPDFs_type_info = new String[]{'DocumentPDFs','http://www.docusign.net/API/3.0','ArrayOfDocumentPDF','0','1','false'};
		private transient String[] TimeZone_type_info = new String[]{'TimeZone','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TimeZoneOffset_type_info = new String[]{'TimeZoneOffset','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeStatus','DocumentPDFs','TimeZone','TimeZoneOffset'};
	}
	public class EmailSettings {
		public String ReplyEmailAddressOverride;
		public String ReplyEmailNameOverride;
		public DocusignResponsiveAPI.ArrayOfBCCEmailAddress BCCEmailAddresses;
		private transient String[] ReplyEmailAddressOverride_type_info = new String[]{'ReplyEmailAddressOverride','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ReplyEmailNameOverride_type_info = new String[]{'ReplyEmailNameOverride','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] BCCEmailAddresses_type_info = new String[]{'BCCEmailAddresses','http://www.docusign.net/API/3.0','ArrayOfBCCEmailAddress','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ReplyEmailAddressOverride','ReplyEmailNameOverride','BCCEmailAddresses'};
	}
	public class Envelope {
		public String TransactionID;
		public Boolean Asynchronous;
		public String AccountId;
		public DocusignResponsiveAPI.ArrayOfDocument Documents;
		public DocusignResponsiveAPI.ArrayOfRecipient Recipients;
		public DocusignResponsiveAPI.ArrayOfTab Tabs;
		public String Subject;
		public String EmailBlurb;
		public String SigningLocation;
		public DocusignResponsiveAPI.ArrayOfCustomField CustomFields;
		public DocusignResponsiveAPI.VaultingOptions VaultingOptions;
		public Boolean AutoNavigation;
		public Boolean EnvelopeIdStamping;
		public Boolean AuthoritativeCopy;
		public DocusignResponsiveAPI.Notification Notification;
		public DocusignResponsiveAPI.ArrayOfAttachment EnvelopeAttachment;
		public Boolean EnforceSignerVisibility;
		public Boolean EnableWetSign;
		public Boolean AllowMarkup;
		public DocusignResponsiveAPI.EventNotification EventNotification;
		public Boolean AllowReassign;
		public String BrandId;
		public Boolean BrandLock;
		public String Accessibility;
		public Boolean MessageLock;
		public Boolean RecipientsLock;
		public Boolean UseDisclosure;
		public DocusignResponsiveAPI.EmailSettings EmailSettings;
		public Boolean AuthoritativeCopyDefault;
		private transient String[] TransactionID_type_info = new String[]{'TransactionID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Asynchronous_type_info = new String[]{'Asynchronous','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Documents_type_info = new String[]{'Documents','http://www.docusign.net/API/3.0','ArrayOfDocument','0','1','false'};
		private transient String[] Recipients_type_info = new String[]{'Recipients','http://www.docusign.net/API/3.0','ArrayOfRecipient','0','1','false'};
		private transient String[] Tabs_type_info = new String[]{'Tabs','http://www.docusign.net/API/3.0','ArrayOfTab','0','1','false'};
		private transient String[] Subject_type_info = new String[]{'Subject','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EmailBlurb_type_info = new String[]{'EmailBlurb','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SigningLocation_type_info = new String[]{'SigningLocation','http://www.docusign.net/API/3.0','SigningLocationCode','0','1','false'};
		private transient String[] CustomFields_type_info = new String[]{'CustomFields','http://www.docusign.net/API/3.0','ArrayOfCustomField','0','1','false'};
		private transient String[] VaultingOptions_type_info = new String[]{'VaultingOptions','http://www.docusign.net/API/3.0','VaultingOptions','0','1','false'};
		private transient String[] AutoNavigation_type_info = new String[]{'AutoNavigation','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnvelopeIdStamping_type_info = new String[]{'EnvelopeIdStamping','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AuthoritativeCopy_type_info = new String[]{'AuthoritativeCopy','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Notification_type_info = new String[]{'Notification','http://www.docusign.net/API/3.0','Notification','0','1','false'};
		private transient String[] EnvelopeAttachment_type_info = new String[]{'EnvelopeAttachment','http://www.docusign.net/API/3.0','ArrayOfAttachment','0','1','false'};
		private transient String[] EnforceSignerVisibility_type_info = new String[]{'EnforceSignerVisibility','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnableWetSign_type_info = new String[]{'EnableWetSign','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AllowMarkup_type_info = new String[]{'AllowMarkup','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EventNotification_type_info = new String[]{'EventNotification','http://www.docusign.net/API/3.0','EventNotification','0','1','false'};
		private transient String[] AllowReassign_type_info = new String[]{'AllowReassign','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] BrandId_type_info = new String[]{'BrandId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] BrandLock_type_info = new String[]{'BrandLock','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Accessibility_type_info = new String[]{'Accessibility','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] MessageLock_type_info = new String[]{'MessageLock','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RecipientsLock_type_info = new String[]{'RecipientsLock','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] UseDisclosure_type_info = new String[]{'UseDisclosure','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EmailSettings_type_info = new String[]{'EmailSettings','http://www.docusign.net/API/3.0','EmailSettings','0','1','false'};
		private transient String[] AuthoritativeCopyDefault_type_info = new String[]{'AuthoritativeCopyDefault','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TransactionID','Asynchronous','AccountId','Documents','Recipients','Tabs','Subject','EmailBlurb','SigningLocation','CustomFields','VaultingOptions','AutoNavigation','EnvelopeIdStamping','AuthoritativeCopy','Notification','EnvelopeAttachment','EnforceSignerVisibility','EnableWetSign','AllowMarkup','EventNotification','AllowReassign','BrandId','BrandLock','Accessibility','MessageLock','RecipientsLock','UseDisclosure','EmailSettings','AuthoritativeCopyDefault'};
	}
	public class EnvelopeAuditEvent {
		public String LogTime;
		public String Source;
		public String UserName;
		public String UserId;
		public String Action;
		public String Message;
		public String EnvelopeStatus;
		public String ClientIPAddress;
		public String Information;
		public String GeoLocation;
		public String Language;
		private transient String[] LogTime_type_info = new String[]{'LogTime','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Source_type_info = new String[]{'Source','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserId_type_info = new String[]{'UserId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Action_type_info = new String[]{'Action','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Message_type_info = new String[]{'Message','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EnvelopeStatus_type_info = new String[]{'EnvelopeStatus','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ClientIPAddress_type_info = new String[]{'ClientIPAddress','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Information_type_info = new String[]{'Information','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] GeoLocation_type_info = new String[]{'GeoLocation','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Language_type_info = new String[]{'Language','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'LogTime','Source','UserName','UserId','Action','Message','EnvelopeStatus','ClientIPAddress','Information','GeoLocation','Language'};
	}
	public class EnvelopeAuditEvents_element {
		public String EnvelopeId;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId'};
	}
	public class EnvelopeAuditEventsResponse_element {
		public DocusignResponsiveAPI.EnvelopeAuditEventsResponse_EnvelopeAuditEventsResult_element EnvelopeAuditEventsResult;
		private transient String[] EnvelopeAuditEventsResult_type_info = new String[]{'EnvelopeAuditEventsResult','http://www.docusign.net/API/3.0','','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeAuditEventsResult'};
	}
	
	//Warning: '<xsd:any>' element type has been changed to dataType List<DOM.XmlNode> called anyElement
	public class EnvelopeAuditEventsResponse_EnvelopeAuditEventsResult_element {
		public List<DOM.XmlNode> anyElement;
		private transient String[] anyElement_type_info = new String[]{'anyElement','http://www.docusign.net/API/3.0','List<DOM.XmlNode>','0','1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'anyElement'};
	}
	public class EnvelopeAuditEventsV2_element {
		public String EnvelopeId;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId'};
	}
	public class EnvelopeAuditEventsV2Response_element {
		public DocusignResponsiveAPI.ArrayOfEnvelopeAuditEvent EnvelopeAuditEventsV2Result;
		private transient String[] EnvelopeAuditEventsV2Result_type_info = new String[]{'EnvelopeAuditEventsV2Result','http://www.docusign.net/API/3.0','ArrayOfEnvelopeAuditEvent','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeAuditEventsV2Result'};
	}
	public class EnvelopeEvent {
		public String EnvelopeEventStatusCode;
		public Boolean IncludeDocuments;
		private transient String[] EnvelopeEventStatusCode_type_info = new String[]{'EnvelopeEventStatusCode','http://www.docusign.net/API/3.0','EnvelopeEventStatusCode','1','1','false'};
		private transient String[] IncludeDocuments_type_info = new String[]{'IncludeDocuments','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeEventStatusCode','IncludeDocuments'};
	}
	public class EnvelopeInformation {
		public String TransactionID;
		public Boolean Asynchronous;
		public String AccountId;
		public String EmailBlurb;
		public String Subject;
		public String SigningLocation;
		public DocusignResponsiveAPI.ArrayOfCustomField CustomFields;
		public DocusignResponsiveAPI.VaultingOptions VaultingOptions;
		public Boolean AutoNavigation;
		public Boolean EnvelopeIdStamping;
		public Boolean AuthoritativeCopy;
		public Boolean AuthoritativeCopyDefault;
		public DocusignResponsiveAPI.Notification Notification;
		public Boolean EnforceSignerVisibility;
		public Boolean EnableWetSign;
		public Boolean AllowRecipientRecursion;
		public Boolean AllowMarkup;
		public String BrandId;
		public DocusignResponsiveAPI.EventNotification EventNotification;
		public Boolean AllowReassign;
		public String Accessibility;
		public Boolean MessageLock;
		public Boolean RecipientsLock;
		public Boolean UseDisclosure;
		public DocusignResponsiveAPI.EmailSettings EmailSettings;
		private transient String[] TransactionID_type_info = new String[]{'TransactionID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Asynchronous_type_info = new String[]{'Asynchronous','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EmailBlurb_type_info = new String[]{'EmailBlurb','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Subject_type_info = new String[]{'Subject','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SigningLocation_type_info = new String[]{'SigningLocation','http://www.docusign.net/API/3.0','SigningLocationCode','0','1','false'};
		private transient String[] CustomFields_type_info = new String[]{'CustomFields','http://www.docusign.net/API/3.0','ArrayOfCustomField','0','1','false'};
		private transient String[] VaultingOptions_type_info = new String[]{'VaultingOptions','http://www.docusign.net/API/3.0','VaultingOptions','0','1','false'};
		private transient String[] AutoNavigation_type_info = new String[]{'AutoNavigation','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnvelopeIdStamping_type_info = new String[]{'EnvelopeIdStamping','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AuthoritativeCopy_type_info = new String[]{'AuthoritativeCopy','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AuthoritativeCopyDefault_type_info = new String[]{'AuthoritativeCopyDefault','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Notification_type_info = new String[]{'Notification','http://www.docusign.net/API/3.0','Notification','0','1','false'};
		private transient String[] EnforceSignerVisibility_type_info = new String[]{'EnforceSignerVisibility','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnableWetSign_type_info = new String[]{'EnableWetSign','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AllowRecipientRecursion_type_info = new String[]{'AllowRecipientRecursion','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AllowMarkup_type_info = new String[]{'AllowMarkup','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] BrandId_type_info = new String[]{'BrandId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EventNotification_type_info = new String[]{'EventNotification','http://www.docusign.net/API/3.0','EventNotification','0','1','false'};
		private transient String[] AllowReassign_type_info = new String[]{'AllowReassign','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Accessibility_type_info = new String[]{'Accessibility','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] MessageLock_type_info = new String[]{'MessageLock','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RecipientsLock_type_info = new String[]{'RecipientsLock','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] UseDisclosure_type_info = new String[]{'UseDisclosure','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EmailSettings_type_info = new String[]{'EmailSettings','http://www.docusign.net/API/3.0','EmailSettings','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TransactionID','Asynchronous','AccountId','EmailBlurb','Subject','SigningLocation','CustomFields','VaultingOptions','AutoNavigation','EnvelopeIdStamping','AuthoritativeCopy','AuthoritativeCopyDefault','Notification','EnforceSignerVisibility','EnableWetSign','AllowRecipientRecursion','AllowMarkup','BrandId','EventNotification','AllowReassign','Accessibility','MessageLock','RecipientsLock','UseDisclosure','EmailSettings'};
	}
	public class EnvelopePDF {
		public String EnvelopeID;
		public String PDFBytes;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] PDFBytes_type_info = new String[]{'PDFBytes','http://www.docusign.net/API/3.0','base64Binary','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','PDFBytes'};
	}
	public class EnvelopeSettings {
		public Boolean AutoNavigation;
		public Boolean EnvelopeIdStamping;
		private transient String[] AutoNavigation_type_info = new String[]{'AutoNavigation','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnvelopeIdStamping_type_info = new String[]{'EnvelopeIdStamping','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AutoNavigation','EnvelopeIdStamping'};
	}
	public class EnvelopeStatus {
		public DocusignResponsiveAPI.ArrayOfRecipientStatus RecipientStatuses;
		public DateTime TimeGenerated;
		public String EnvelopeID;
		public String Subject;
		public String UserName;
		public String Email;
		public String Status;
		public DateTime Created;
		public DateTime Deleted;
		public DateTime Sent;
		public DateTime Delivered;
		public DateTime Signed;
		public DateTime Completed;
		public DateTime Declined;
		public DateTime TimedOut;
		public String ACStatus;
		public DateTime ACStatusDate;
		public String ACHolder;
		public String ACHolderEmail;
		public String ACHolderLocation;
		public String SigningLocation;
		public String SenderIPAddress;
		public String EnvelopePDFHash;
		public DocusignResponsiveAPI.ArrayOfCustomField CustomFields;
		public DocusignResponsiveAPI.VaultingDetails VaultingDetails;
		public Boolean AutoNavigation;
		public Boolean EnvelopeIdStamping;
		public Boolean AuthoritativeCopy;
		public DocusignResponsiveAPI.ArrayOfAttachment EnvelopeAttachment;
		public DocusignResponsiveAPI.ArrayOfDocumentStatus DocumentStatuses;
		public DocusignResponsiveAPI.FormData FormData;
		public String VoidReason;
		private transient String[] RecipientStatuses_type_info = new String[]{'RecipientStatuses','http://www.docusign.net/API/3.0','ArrayOfRecipientStatus','1','1','true'};
		private transient String[] TimeGenerated_type_info = new String[]{'TimeGenerated','http://www.docusign.net/API/3.0','dateTime','1','1','false'};
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Subject_type_info = new String[]{'Subject','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Status_type_info = new String[]{'Status','http://www.docusign.net/API/3.0','EnvelopeStatusCode','1','1','false'};
		private transient String[] Created_type_info = new String[]{'Created','http://www.docusign.net/API/3.0','dateTime','1','1','false'};
		private transient String[] Deleted_type_info = new String[]{'Deleted','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Sent_type_info = new String[]{'Sent','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Delivered_type_info = new String[]{'Delivered','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Signed_type_info = new String[]{'Signed','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Completed_type_info = new String[]{'Completed','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Declined_type_info = new String[]{'Declined','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] TimedOut_type_info = new String[]{'TimedOut','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] ACStatus_type_info = new String[]{'ACStatus','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ACStatusDate_type_info = new String[]{'ACStatusDate','http://www.docusign.net/API/3.0','dateTime','1','1','false'};
		private transient String[] ACHolder_type_info = new String[]{'ACHolder','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ACHolderEmail_type_info = new String[]{'ACHolderEmail','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ACHolderLocation_type_info = new String[]{'ACHolderLocation','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SigningLocation_type_info = new String[]{'SigningLocation','http://www.docusign.net/API/3.0','SigningLocationCode','1','1','false'};
		private transient String[] SenderIPAddress_type_info = new String[]{'SenderIPAddress','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EnvelopePDFHash_type_info = new String[]{'EnvelopePDFHash','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CustomFields_type_info = new String[]{'CustomFields','http://www.docusign.net/API/3.0','ArrayOfCustomField','0','1','false'};
		private transient String[] VaultingDetails_type_info = new String[]{'VaultingDetails','http://www.docusign.net/API/3.0','VaultingDetails','0','1','false'};
		private transient String[] AutoNavigation_type_info = new String[]{'AutoNavigation','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] EnvelopeIdStamping_type_info = new String[]{'EnvelopeIdStamping','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] AuthoritativeCopy_type_info = new String[]{'AuthoritativeCopy','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnvelopeAttachment_type_info = new String[]{'EnvelopeAttachment','http://www.docusign.net/API/3.0','ArrayOfAttachment','0','1','false'};
		private transient String[] DocumentStatuses_type_info = new String[]{'DocumentStatuses','http://www.docusign.net/API/3.0','ArrayOfDocumentStatus','0','1','false'};
		private transient String[] FormData_type_info = new String[]{'FormData','http://www.docusign.net/API/3.0','FormData','0','1','false'};
		private transient String[] VoidReason_type_info = new String[]{'VoidReason','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipientStatuses','TimeGenerated','EnvelopeID','Subject','UserName','Email','Status','Created','Deleted','Sent','Delivered','Signed','Completed','Declined','TimedOut','ACStatus','ACStatusDate','ACHolder','ACHolderEmail','ACHolderLocation','SigningLocation','SenderIPAddress','EnvelopePDFHash','CustomFields','VaultingDetails','AutoNavigation','EnvelopeIdStamping','AuthoritativeCopy','EnvelopeAttachment','DocumentStatuses','FormData','VoidReason'};
	}
	public class EnvelopeStatusChange {
		public String EnvelopeID;
		public String Status;
		public DateTime StatusChanged;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Status_type_info = new String[]{'Status','http://www.docusign.net/API/3.0','EnvelopeStatusCode','1','1','false'};
		private transient String[] StatusChanged_type_info = new String[]{'StatusChanged','http://www.docusign.net/API/3.0','dateTime','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','Status','StatusChanged'};
	}
	public class EnvelopeStatusChangeFilter {
		public String AccountId;
		public DocusignResponsiveAPI.UserInfo UserInfo;
		public DateTime StatusChangedSince;
		public DocusignResponsiveAPI.ArrayOfEnvelopeStatusCode Statuses;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserInfo_type_info = new String[]{'UserInfo','http://www.docusign.net/API/3.0','UserInfo','0','1','false'};
		private transient String[] StatusChangedSince_type_info = new String[]{'StatusChangedSince','http://www.docusign.net/API/3.0','dateTime','1','1','false'};
		private transient String[] Statuses_type_info = new String[]{'Statuses','http://www.docusign.net/API/3.0','ArrayOfEnvelopeStatusCode','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','UserInfo','StatusChangedSince','Statuses'};
	}
	public class EnvelopeStatusFilter {
		public DocusignResponsiveAPI.UserInfo UserInfo;
		public String AccountId;
		public DocusignResponsiveAPI.EnvelopeStatusFilterBeginDateTime BeginDateTime;
		public DateTime EndDateTime;
		public DocusignResponsiveAPI.ArrayOfEnvelopeStatusCode Statuses;
		public DocusignResponsiveAPI.ArrayOfString2 EnvelopeIds;
		public Integer StartAtIndex;
		public String ACStatus;
		private transient String[] UserInfo_type_info = new String[]{'UserInfo','http://www.docusign.net/API/3.0','UserInfo','0','1','false'};
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] BeginDateTime_type_info = new String[]{'BeginDateTime','http://www.docusign.net/API/3.0','EnvelopeStatusFilterBeginDateTime','1','1','true'};
		private transient String[] EndDateTime_type_info = new String[]{'EndDateTime','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Statuses_type_info = new String[]{'Statuses','http://www.docusign.net/API/3.0','ArrayOfEnvelopeStatusCode','0','1','false'};
		private transient String[] EnvelopeIds_type_info = new String[]{'EnvelopeIds','http://www.docusign.net/API/3.0','ArrayOfString2','0','1','false'};
		private transient String[] StartAtIndex_type_info = new String[]{'StartAtIndex','http://www.docusign.net/API/3.0','nonNegativeInteger','1','1','true'};
		private transient String[] ACStatus_type_info = new String[]{'ACStatus','http://www.docusign.net/API/3.0','EnvelopeACStatusCode','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UserInfo','AccountId','BeginDateTime','EndDateTime','Statuses','EnvelopeIds','StartAtIndex','ACStatus'};
	}
	
	//Warning: Simple Content Types with Attributes are not supported by WebServiceCallout.invoke
	public class EnvelopeStatusFilterBeginDateTime {
		public DateTime input;
		private transient String[] input_type_info = new String[]{'input','http://www.w3.org/2001/XMLSchema','dateTime','1','1','false'};
		public String statusQualifier;
		public String[] statusQualifier_att_info = new String[]{'statusQualifier'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{};
	}
	public class EnvelopeTemplate {
		public DocusignResponsiveAPI.EnvelopeTemplateDefinition EnvelopeTemplateDefinition;
		public DocusignResponsiveAPI.Envelope Envelope;
		private transient String[] EnvelopeTemplateDefinition_type_info = new String[]{'EnvelopeTemplateDefinition','http://www.docusign.net/API/3.0','EnvelopeTemplateDefinition','0','1','false'};
		private transient String[] Envelope_type_info = new String[]{'Envelope','http://www.docusign.net/API/3.0','Envelope','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeTemplateDefinition','Envelope'};
	}
	public class EnvelopeTemplateDefinition {
		public String TemplateID;
		public String Name;
		public Boolean Shared;
		public String TemplatePassword;
		public String TemplateDescription;
		public DateTime LastModified;
		public Integer PageCount;
		private transient String[] TemplateID_type_info = new String[]{'TemplateID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Shared_type_info = new String[]{'Shared','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] TemplatePassword_type_info = new String[]{'TemplatePassword','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TemplateDescription_type_info = new String[]{'TemplateDescription','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] LastModified_type_info = new String[]{'LastModified','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] PageCount_type_info = new String[]{'PageCount','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TemplateID','Name','Shared','TemplatePassword','TemplateDescription','LastModified','PageCount'};
	}
	public class EnvelopeTemplates {
		public DocusignResponsiveAPI.EnvelopeTemplateDefinition[] EnvelopeTemplateDefinition;
		private transient String[] EnvelopeTemplateDefinition_type_info = new String[]{'EnvelopeTemplateDefinition','http://www.docusign.net/API/3.0','EnvelopeTemplateDefinition','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeTemplateDefinition'};
	}
	public class EnvelopeV2 {
		public String TransactionID;
		public Boolean Asynchronous;
		public String AccountId;
		public DocusignResponsiveAPI.ArrayOfDocumentV2 DocumentsV2;
		public DocusignResponsiveAPI.ArrayOfRecipient Recipients;
		public DocusignResponsiveAPI.ArrayOfTab Tabs;
		public String Subject;
		public String EmailBlurb;
		public String SigningLocation;
		public DocusignResponsiveAPI.ArrayOfCustomField CustomFields;
		public DocusignResponsiveAPI.VaultingOptions VaultingOptions;
		public Boolean AutoNavigation;
		public Boolean EnvelopeIdStamping;
		public Boolean AuthoritativeCopy;
		public DocusignResponsiveAPI.Notification Notification;
		public DocusignResponsiveAPI.ArrayOfAttachment EnvelopeAttachment;
		public Boolean EnforceSignerVisibility;
		public Boolean EnableWetSign;
		public Boolean AllowMarkup;
		public DocusignResponsiveAPI.EventNotification EventNotification;
		public Boolean AllowReassign;
		public Boolean UsedResponsiveSigning;
		public String BrandId;
		public Boolean BrandLock;
		public String Accessibility;
		public Boolean MessageLock;
		public Boolean RecipientsLock;
		public Boolean UseDisclosure;
		public DocusignResponsiveAPI.EmailSettings EmailSettings;
		public Boolean AuthoritativeCopyDefault;
		private transient String[] TransactionID_type_info = new String[]{'TransactionID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Asynchronous_type_info = new String[]{'Asynchronous','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DocumentsV2_type_info = new String[]{'DocumentsV2','http://www.docusign.net/API/3.0','ArrayOfDocumentV2','0','1','false'};
		private transient String[] Recipients_type_info = new String[]{'Recipients','http://www.docusign.net/API/3.0','ArrayOfRecipient','0','1','false'};
		private transient String[] Tabs_type_info = new String[]{'Tabs','http://www.docusign.net/API/3.0','ArrayOfTab','0','1','false'};
		private transient String[] Subject_type_info = new String[]{'Subject','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EmailBlurb_type_info = new String[]{'EmailBlurb','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SigningLocation_type_info = new String[]{'SigningLocation','http://www.docusign.net/API/3.0','SigningLocationCode','0','1','false'};
		private transient String[] CustomFields_type_info = new String[]{'CustomFields','http://www.docusign.net/API/3.0','ArrayOfCustomField','0','1','false'};
		private transient String[] VaultingOptions_type_info = new String[]{'VaultingOptions','http://www.docusign.net/API/3.0','VaultingOptions','0','1','false'};
		private transient String[] AutoNavigation_type_info = new String[]{'AutoNavigation','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnvelopeIdStamping_type_info = new String[]{'EnvelopeIdStamping','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AuthoritativeCopy_type_info = new String[]{'AuthoritativeCopy','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Notification_type_info = new String[]{'Notification','http://www.docusign.net/API/3.0','Notification','0','1','false'};
		private transient String[] EnvelopeAttachment_type_info = new String[]{'EnvelopeAttachment','http://www.docusign.net/API/3.0','ArrayOfAttachment','0','1','false'};
		private transient String[] EnforceSignerVisibility_type_info = new String[]{'EnforceSignerVisibility','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnableWetSign_type_info = new String[]{'EnableWetSign','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AllowMarkup_type_info = new String[]{'AllowMarkup','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EventNotification_type_info = new String[]{'EventNotification','http://www.docusign.net/API/3.0','EventNotification','0','1','false'};
		private transient String[] AllowReassign_type_info = new String[]{'AllowReassign','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] UsedResponsiveSigning_type_info = new String[]{'UsedResponsiveSigning','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] BrandId_type_info = new String[]{'BrandId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] BrandLock_type_info = new String[]{'BrandLock','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Accessibility_type_info = new String[]{'Accessibility','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] MessageLock_type_info = new String[]{'MessageLock','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RecipientsLock_type_info = new String[]{'RecipientsLock','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] UseDisclosure_type_info = new String[]{'UseDisclosure','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EmailSettings_type_info = new String[]{'EmailSettings','http://www.docusign.net/API/3.0','EmailSettings','0','1','false'};
		private transient String[] AuthoritativeCopyDefault_type_info = new String[]{'AuthoritativeCopyDefault','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TransactionID','Asynchronous','AccountId','DocumentsV2','Recipients','Tabs','Subject','EmailBlurb','SigningLocation','CustomFields','VaultingOptions','AutoNavigation','EnvelopeIdStamping','AuthoritativeCopy','Notification','EnvelopeAttachment','EnforceSignerVisibility','EnableWetSign','AllowMarkup','EventNotification','AllowReassign','UsedResponsiveSigning','BrandId','BrandLock','Accessibility','MessageLock','RecipientsLock','UseDisclosure','EmailSettings','AuthoritativeCopyDefault'};
	}
	public class ErrorDetails {
		public String ErrorCode;
		public String Message;
		private transient String[] ErrorCode_type_info = new String[]{'ErrorCode','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Message_type_info = new String[]{'Message','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ErrorCode','Message'};
	}
	public class EventNotification {
		public String URL;
		public Boolean LoggingEnabled;
		public Boolean RequireAcknowledgment;
		public Boolean UseSoapInterface;
		public String SoapNameSpace;
		public Boolean IncludeCertificateWithSoap;
		public Boolean SignMessageWithX509Cert;
		public Boolean IncludeDocuments;
		public Boolean IncludeHMAC;
		public Boolean IncludeTimeZone;
		public Boolean IncludeEnvelopeVoidReason;
		public Boolean IncludeDocumentFields;
		public Boolean IncludeCertificateOfCompletion;
		public Boolean IncludeSenderAccountAsCustomField;
		public DocusignResponsiveAPI.ArrayOfEnvelopeEvent EnvelopeEvents;
		public DocusignResponsiveAPI.ArrayOfRecipientEvent RecipientEvents;
		private transient String[] URL_type_info = new String[]{'URL','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] LoggingEnabled_type_info = new String[]{'LoggingEnabled','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RequireAcknowledgment_type_info = new String[]{'RequireAcknowledgment','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] UseSoapInterface_type_info = new String[]{'UseSoapInterface','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] SoapNameSpace_type_info = new String[]{'SoapNameSpace','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] IncludeCertificateWithSoap_type_info = new String[]{'IncludeCertificateWithSoap','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] SignMessageWithX509Cert_type_info = new String[]{'SignMessageWithX509Cert','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeDocuments_type_info = new String[]{'IncludeDocuments','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeHMAC_type_info = new String[]{'IncludeHMAC','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeTimeZone_type_info = new String[]{'IncludeTimeZone','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeEnvelopeVoidReason_type_info = new String[]{'IncludeEnvelopeVoidReason','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeDocumentFields_type_info = new String[]{'IncludeDocumentFields','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeCertificateOfCompletion_type_info = new String[]{'IncludeCertificateOfCompletion','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeSenderAccountAsCustomField_type_info = new String[]{'IncludeSenderAccountAsCustomField','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnvelopeEvents_type_info = new String[]{'EnvelopeEvents','http://www.docusign.net/API/3.0','ArrayOfEnvelopeEvent','0','1','false'};
		private transient String[] RecipientEvents_type_info = new String[]{'RecipientEvents','http://www.docusign.net/API/3.0','ArrayOfRecipientEvent','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'URL','LoggingEnabled','RequireAcknowledgment','UseSoapInterface','SoapNameSpace','IncludeCertificateWithSoap','SignMessageWithX509Cert','IncludeDocuments','IncludeHMAC','IncludeTimeZone','IncludeEnvelopeVoidReason','IncludeDocumentFields','IncludeCertificateOfCompletion','IncludeSenderAccountAsCustomField','EnvelopeEvents','RecipientEvents'};
	}
	public class EventResult {
		public String Status;
		public DateTime EventTimestamp;
		public String FailureDescription;
		public String VendorFailureStatusCode;
		private transient String[] Status_type_info = new String[]{'Status','http://www.docusign.net/API/3.0','EventStatusCode','1','1','false'};
		private transient String[] EventTimestamp_type_info = new String[]{'EventTimestamp','http://www.docusign.net/API/3.0','dateTime','1','1','false'};
		private transient String[] FailureDescription_type_info = new String[]{'FailureDescription','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] VendorFailureStatusCode_type_info = new String[]{'VendorFailureStatusCode','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Status','EventTimestamp','FailureDescription','VendorFailureStatusCode'};
	}
	public class Expirations {
		public Boolean ExpireEnabled;
		public Integer ExpireAfter;
		public Integer ExpireWarn;
		private transient String[] ExpireEnabled_type_info = new String[]{'ExpireEnabled','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] ExpireAfter_type_info = new String[]{'ExpireAfter','http://www.docusign.net/API/3.0','nonNegativeInteger','0','1','false'};
		private transient String[] ExpireWarn_type_info = new String[]{'ExpireWarn','http://www.docusign.net/API/3.0','nonNegativeInteger','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ExpireEnabled','ExpireAfter','ExpireWarn'};
	}
	public class ExportAuthoritativeCopy_element {
		public String EnvelopeId;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId'};
	}
	public class ExportAuthoritativeCopyResponse_element {
		public DocusignResponsiveAPI.AuthoritativeCopyExportDocuments ExportAuthoritativeCopyResult;
		private transient String[] ExportAuthoritativeCopyResult_type_info = new String[]{'ExportAuthoritativeCopyResult','http://www.docusign.net/API/3.0','AuthoritativeCopyExportDocuments','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ExportAuthoritativeCopyResult'};
	}
	public class FilteredEnvelopeStatusChanges {
		public Integer ResultSetSize;
		public DocusignResponsiveAPI.ArrayOfEnvelopeStatusChange EnvelopeStatusChanges;
		private transient String[] ResultSetSize_type_info = new String[]{'ResultSetSize','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] EnvelopeStatusChanges_type_info = new String[]{'EnvelopeStatusChanges','http://www.docusign.net/API/3.0','ArrayOfEnvelopeStatusChange','1','1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ResultSetSize','EnvelopeStatusChanges'};
	}
	public class FilteredEnvelopeStatuses {
		public Integer ResultSetSize;
		public DocusignResponsiveAPI.EnvelopeStatusFilter EnvelopeStatusFilter;
		public DocusignResponsiveAPI.ArrayOfEnvelopeStatus EnvelopeStatuses;
		private transient String[] ResultSetSize_type_info = new String[]{'ResultSetSize','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] EnvelopeStatusFilter_type_info = new String[]{'EnvelopeStatusFilter','http://www.docusign.net/API/3.0','EnvelopeStatusFilter','0','1','false'};
		private transient String[] EnvelopeStatuses_type_info = new String[]{'EnvelopeStatuses','http://www.docusign.net/API/3.0','ArrayOfEnvelopeStatus','1','1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ResultSetSize','EnvelopeStatusFilter','EnvelopeStatuses'};
	}
	public class Folder {
		public DocusignResponsiveAPI.UserInfo FolderOwner;
		public DocusignResponsiveAPI.FolderTypeInfo FolderTypeInfo;
		private transient String[] FolderOwner_type_info = new String[]{'FolderOwner','http://www.docusign.net/API/3.0','UserInfo','0','1','false'};
		private transient String[] FolderTypeInfo_type_info = new String[]{'FolderTypeInfo','http://www.docusign.net/API/3.0','FolderTypeInfo','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'FolderOwner','FolderTypeInfo'};
	}
	public class FolderFilter {
		public String AccountId;
		public DocusignResponsiveAPI.UserInfo FolderOwner;
		public DocusignResponsiveAPI.FolderTypeInfo FolderTypeInfo;
		public Integer StartPosition;
		public DateTime FromDate;
		public DateTime ToDate;
		public String SearchText;
		public String Status;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] FolderOwner_type_info = new String[]{'FolderOwner','http://www.docusign.net/API/3.0','UserInfo','0','1','false'};
		private transient String[] FolderTypeInfo_type_info = new String[]{'FolderTypeInfo','http://www.docusign.net/API/3.0','FolderTypeInfo','0','1','false'};
		private transient String[] StartPosition_type_info = new String[]{'StartPosition','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] FromDate_type_info = new String[]{'FromDate','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] ToDate_type_info = new String[]{'ToDate','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] SearchText_type_info = new String[]{'SearchText','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Status_type_info = new String[]{'Status','http://www.docusign.net/API/3.0','EnvelopeStatusCode','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','FolderOwner','FolderTypeInfo','StartPosition','FromDate','ToDate','SearchText','Status'};
	}
	public class FolderItem {
		public String EnvelopeId;
		public String Status;
		public String Owner;
		public String SenderName;
		public String SenderEmail;
		public String SenderCompany;
		public DocusignResponsiveAPI.ArrayOfRecipientStatus RecipientStatuses;
		public DocusignResponsiveAPI.ArrayOfCustomField CustomFields;
		public DateTime Created;
		public DateTime Sent;
		public DateTime Completed;
		public String Subject;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Status_type_info = new String[]{'Status','http://www.docusign.net/API/3.0','EnvelopeStatusCode','1','1','false'};
		private transient String[] Owner_type_info = new String[]{'Owner','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SenderName_type_info = new String[]{'SenderName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SenderEmail_type_info = new String[]{'SenderEmail','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SenderCompany_type_info = new String[]{'SenderCompany','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientStatuses_type_info = new String[]{'RecipientStatuses','http://www.docusign.net/API/3.0','ArrayOfRecipientStatus','0','1','false'};
		private transient String[] CustomFields_type_info = new String[]{'CustomFields','http://www.docusign.net/API/3.0','ArrayOfCustomField','0','1','false'};
		private transient String[] Created_type_info = new String[]{'Created','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Sent_type_info = new String[]{'Sent','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Completed_type_info = new String[]{'Completed','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Subject_type_info = new String[]{'Subject','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','Status','Owner','SenderName','SenderEmail','SenderCompany','RecipientStatuses','CustomFields','Created','Sent','Completed','Subject'};
	}
	public class FolderResults {
		public Integer ResultSetSize;
		public Integer StartPosition;
		public Integer EndPosition;
		public DocusignResponsiveAPI.FolderTypeInfo FolderTypeInfo;
		public DocusignResponsiveAPI.ArrayOfFolderItem FolderItems;
		private transient String[] ResultSetSize_type_info = new String[]{'ResultSetSize','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] StartPosition_type_info = new String[]{'StartPosition','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] EndPosition_type_info = new String[]{'EndPosition','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] FolderTypeInfo_type_info = new String[]{'FolderTypeInfo','http://www.docusign.net/API/3.0','FolderTypeInfo','0','1','false'};
		private transient String[] FolderItems_type_info = new String[]{'FolderItems','http://www.docusign.net/API/3.0','ArrayOfFolderItem','1','1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ResultSetSize','StartPosition','EndPosition','FolderTypeInfo','FolderItems'};
	}
	public class FoldersFilter {
		public String AccountId;
		public Boolean IncludeHierarchy;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] IncludeHierarchy_type_info = new String[]{'IncludeHierarchy','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','IncludeHierarchy'};
	}
	public class FolderTypeInfo {
		public String FolderType;
		public String FolderName;
		public String FolderPath;
		public String FolderId;
		private transient String[] FolderType_type_info = new String[]{'FolderType','http://www.docusign.net/API/3.0','FolderType','0','1','false'};
		private transient String[] FolderName_type_info = new String[]{'FolderName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] FolderPath_type_info = new String[]{'FolderPath','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] FolderId_type_info = new String[]{'FolderId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'FolderType','FolderName','FolderPath','FolderId'};
	}
	public class FormData {
		public DocusignResponsiveAPI.FormDataXfdf xfdf;
		private transient String[] xfdf_type_info = new String[]{'xfdf','http://www.docusign.net/API/3.0','FormDataXfdf','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'xfdf'};
	}
	public class FormDataXfdf {
		public DocusignResponsiveAPI.ArrayOfFormDataXfdfField fields;
		private transient String[] fields_type_info = new String[]{'fields','http://www.docusign.net/API/3.0','ArrayOfFormDataXfdfField','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'fields'};
	}
	public class FormDataXfdfField {
		public String value;
		private transient String[] value_type_info = new String[]{'value','http://www.docusign.net/API/3.0','string','0','1','false'};
		public String name;
		public String[] name_att_info = new String[]{'name'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'value'};
	}
	public class GetAccountBrands_element {
		public String AccountId;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId'};
	}
	public class GetAccountBrandsResponse_element {
		public DocusignResponsiveAPI.BrandResults GetAccountBrandsResult;
		private transient String[] GetAccountBrandsResult_type_info = new String[]{'GetAccountBrandsResult','http://www.docusign.net/API/3.0','BrandResults','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetAccountBrandsResult'};
	}
	public class GetAccountMembershipFeaturesList_element {
		public String AccountId;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId'};
	}
	public class GetAccountMembershipFeaturesListResponse_element {
		public DocusignResponsiveAPI.AccountMembershipFeaturesList GetAccountMembershipFeaturesListResult;
		private transient String[] GetAccountMembershipFeaturesListResult_type_info = new String[]{'GetAccountMembershipFeaturesListResult','http://www.docusign.net/API/3.0','AccountMembershipFeaturesList','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetAccountMembershipFeaturesListResult'};
	}
	public class GetAccountSettingsList_element {
		public String AccountId;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId'};
	}
	public class GetAccountSettingsListResponse_element {
		public DocusignResponsiveAPI.AccountSettingsList GetAccountSettingsListResult;
		private transient String[] GetAccountSettingsListResult_type_info = new String[]{'GetAccountSettingsListResult','http://www.docusign.net/API/3.0','AccountSettingsList','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetAccountSettingsListResult'};
	}
	public class GetAddressBookItems_element {
		public String AccountID;
		private transient String[] AccountID_type_info = new String[]{'AccountID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountID'};
	}
	public class GetAddressBookItemsResponse_element {
		public DocusignResponsiveAPI.ArrayOfAddressBookItem GetAddressBookItemsResult;
		private transient String[] GetAddressBookItemsResult_type_info = new String[]{'GetAddressBookItemsResult','http://www.docusign.net/API/3.0','ArrayOfAddressBookItem','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetAddressBookItemsResult'};
	}
	public class GetAuthenticationToken_element {
		public String GoToEnvelopeID;
		private transient String[] GoToEnvelopeID_type_info = new String[]{'GoToEnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GoToEnvelopeID'};
	}
	public class GetAuthenticationTokenResponse_element {
		public String GetAuthenticationTokenResult;
		private transient String[] GetAuthenticationTokenResult_type_info = new String[]{'GetAuthenticationTokenResult','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetAuthenticationTokenResult'};
	}
	public class GetAuthoritativeCopyExportKey_element {
		public String EnvelopeId;
		public String TransactionId;
		public String checkSumHash;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TransactionId_type_info = new String[]{'TransactionId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] checkSumHash_type_info = new String[]{'checkSumHash','http://www.docusign.net/API/3.0','base64Binary','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','TransactionId','checkSumHash'};
	}
	public class GetAuthoritativeCopyExportKeyResponse_element {
		public DocusignResponsiveAPI.AuthoritativeCopyExportStatus GetAuthoritativeCopyExportKeyResult;
		private transient String[] GetAuthoritativeCopyExportKeyResult_type_info = new String[]{'GetAuthoritativeCopyExportKeyResult','http://www.docusign.net/API/3.0','AuthoritativeCopyExportStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetAuthoritativeCopyExportKeyResult'};
	}
	public class GetConnectFailures_element {
		public DocusignResponsiveAPI.ConnectFailuresFilter ConnectFailuresFilter;
		private transient String[] ConnectFailuresFilter_type_info = new String[]{'ConnectFailuresFilter','http://www.docusign.net/API/3.0','ConnectFailuresFilter','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ConnectFailuresFilter'};
	}
	public class GetConnectFailuresResponse_element {
		public DocusignResponsiveAPI.ArrayOfConnectFailure GetConnectFailuresResult;
		private transient String[] GetConnectFailuresResult_type_info = new String[]{'GetConnectFailuresResult','http://www.docusign.net/API/3.0','ArrayOfConnectFailure','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetConnectFailuresResult'};
	}
	public class GetFolderItems_element {
		public DocusignResponsiveAPI.FolderFilter FolderFilter;
		private transient String[] FolderFilter_type_info = new String[]{'FolderFilter','http://www.docusign.net/API/3.0','FolderFilter','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'FolderFilter'};
	}
	public class GetFolderItemsResponse_element {
		public DocusignResponsiveAPI.FolderResults GetFolderItemsResult;
		private transient String[] GetFolderItemsResult_type_info = new String[]{'GetFolderItemsResult','http://www.docusign.net/API/3.0','FolderResults','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetFolderItemsResult'};
	}
	public class GetFolderList_element {
		public DocusignResponsiveAPI.FoldersFilter FoldersFilter;
		private transient String[] FoldersFilter_type_info = new String[]{'FoldersFilter','http://www.docusign.net/API/3.0','FoldersFilter','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'FoldersFilter'};
	}
	public class GetFolderListResponse_element {
		public DocusignResponsiveAPI.AvailableFolders GetFolderListResult;
		private transient String[] GetFolderListResult_type_info = new String[]{'GetFolderListResult','http://www.docusign.net/API/3.0','AvailableFolders','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetFolderListResult'};
	}
	public class GetRecipientAuthenticationStatusEx_element {
		public DocusignResponsiveAPI.GetRecipientAuthenticationStatusExArg Arg;
		private transient String[] Arg_type_info = new String[]{'Arg','http://www.docusign.net/API/3.0','GetRecipientAuthenticationStatusExArg','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Arg'};
	}
	public class GetRecipientAuthenticationStatusExArg {
		public String EnvelopeId;
		public String RecipientName;
		public String RecipientEmail;
		public Integer RoutingOrder;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientName_type_info = new String[]{'RecipientName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientEmail_type_info = new String[]{'RecipientEmail','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RoutingOrder_type_info = new String[]{'RoutingOrder','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','RecipientName','RecipientEmail','RoutingOrder'};
	}
	public class GetRecipientAuthenticationStatusExResponse_element {
		public DocusignResponsiveAPI.AuthenticationStatus GetRecipientAuthenticationStatusExResult;
		private transient String[] GetRecipientAuthenticationStatusExResult_type_info = new String[]{'GetRecipientAuthenticationStatusExResult','http://www.docusign.net/API/3.0','AuthenticationStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetRecipientAuthenticationStatusExResult'};
	}
	public class GetRecipientEsignList_element {
		public String UserName;
		public String SenderEmail;
		public String SenderAccountId;
		public String RecipientEmail;
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SenderEmail_type_info = new String[]{'SenderEmail','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SenderAccountId_type_info = new String[]{'SenderAccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientEmail_type_info = new String[]{'RecipientEmail','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UserName','SenderEmail','SenderAccountId','RecipientEmail'};
	}
	public class GetRecipientEsignListResponse_element {
		public DocusignResponsiveAPI.RecipientEsignList GetRecipientEsignListResult;
		private transient String[] GetRecipientEsignListResult_type_info = new String[]{'GetRecipientEsignListResult','http://www.docusign.net/API/3.0','RecipientEsignList','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetRecipientEsignListResult'};
	}
	public class GetRecipientList_element {
		public String SenderAccountId;
		public String RecipientEmail;
		private transient String[] SenderAccountId_type_info = new String[]{'SenderAccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientEmail_type_info = new String[]{'RecipientEmail','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SenderAccountId','RecipientEmail'};
	}
	public class GetRecipientListResponse_element {
		public DocusignResponsiveAPI.RecipientList GetRecipientListResult;
		private transient String[] GetRecipientListResult_type_info = new String[]{'GetRecipientListResult','http://www.docusign.net/API/3.0','RecipientList','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetRecipientListResult'};
	}
	public class GetSharedAccess_element {
		public String AccountId;
		public DocusignResponsiveAPI.SharedAccessFilter SharedAccessFilter;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SharedAccessFilter_type_info = new String[]{'SharedAccessFilter','http://www.docusign.net/API/3.0','SharedAccessFilter','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','SharedAccessFilter'};
	}
	public class GetSharedAccessResponse_element {
		public DocusignResponsiveAPI.GetSharedAccessResult GetSharedAccessResult;
		private transient String[] GetSharedAccessResult_type_info = new String[]{'GetSharedAccessResult','http://www.docusign.net/API/3.0','GetSharedAccessResult','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetSharedAccessResult'};
	}
	public class GetSharedAccessResult {
		public String AccountId;
		public Integer ResultSetSize;
		public Integer TotalSetSize;
		public Integer StartAtIndex;
		public Integer EndAtIndex;
		public DocusignResponsiveAPI.SharedAccessItemResult[] SharedItems;
		public DocusignResponsiveAPI.ErrorDetails ErrorDetails;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ResultSetSize_type_info = new String[]{'ResultSetSize','http://www.docusign.net/API/3.0','nonNegativeInteger','1','1','true'};
		private transient String[] TotalSetSize_type_info = new String[]{'TotalSetSize','http://www.docusign.net/API/3.0','nonNegativeInteger','1','1','true'};
		private transient String[] StartAtIndex_type_info = new String[]{'StartAtIndex','http://www.docusign.net/API/3.0','nonNegativeInteger','1','1','true'};
		private transient String[] EndAtIndex_type_info = new String[]{'EndAtIndex','http://www.docusign.net/API/3.0','nonNegativeInteger','1','1','true'};
		private transient String[] SharedItems_type_info = new String[]{'SharedItems','http://www.docusign.net/API/3.0','SharedAccessItemResult','0','-1','true'};
		private transient String[] ErrorDetails_type_info = new String[]{'ErrorDetails','http://www.docusign.net/API/3.0','ErrorDetails','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','ResultSetSize','TotalSetSize','StartAtIndex','EndAtIndex','SharedItems','ErrorDetails'};
	}
	public class GetStatusInDocuSignConnectFormat_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class GetStatusInDocuSignConnectFormatResponse_element {
		public DocusignResponsiveAPI.DocuSignEnvelopeInformation GetStatusInDocuSignConnectFormatResult;
		private transient String[] GetStatusInDocuSignConnectFormatResult_type_info = new String[]{'GetStatusInDocuSignConnectFormatResult','http://www.docusign.net/API/3.0','DocuSignEnvelopeInformation','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'GetStatusInDocuSignConnectFormatResult'};
	}
	public class HtmlDefinition {
		public String Source;
		public String RemoveEmptyTags;
		public String HeaderLabel;
		public String DisplayAnchorPrefix;
		public Integer MaxScreenWidth;
		public DocusignResponsiveAPI.ArrayOfDisplayAnchor DisplayAnchors;
		private transient String[] Source_type_info = new String[]{'Source','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RemoveEmptyTags_type_info = new String[]{'RemoveEmptyTags','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] HeaderLabel_type_info = new String[]{'HeaderLabel','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DisplayAnchorPrefix_type_info = new String[]{'DisplayAnchorPrefix','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] MaxScreenWidth_type_info = new String[]{'MaxScreenWidth','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] DisplayAnchors_type_info = new String[]{'DisplayAnchors','http://www.docusign.net/API/3.0','ArrayOfDisplayAnchor','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Source','RemoveEmptyTags','HeaderLabel','DisplayAnchorPrefix','MaxScreenWidth','DisplayAnchors'};
	}
	public class IDCheckInformation {
		public DocusignResponsiveAPI.AddressInformation AddressInformation;
		public DocusignResponsiveAPI.DOBInformation DOBInformation;
		public DocusignResponsiveAPI.SSN4Information SSN4Information;
		private transient String[] AddressInformation_type_info = new String[]{'AddressInformation','http://www.docusign.net/API/3.0','AddressInformation','0','1','false'};
		private transient String[] DOBInformation_type_info = new String[]{'DOBInformation','http://www.docusign.net/API/3.0','DOBInformation','0','1','false'};
		private transient String[] SSN4Information_type_info = new String[]{'SSN4Information','http://www.docusign.net/API/3.0','SSN4Information','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AddressInformation','DOBInformation','SSN4Information'};
	}
	public class IDCheckInformationInput {
		public DocusignResponsiveAPI.AddressInformationInput AddressInformationInput;
		public DocusignResponsiveAPI.DOBInformationInput DOBInformationInput;
		public DocusignResponsiveAPI.SSN4InformationInput SSN4InformationInput;
		public DocusignResponsiveAPI.SSN9InformationInput SSN9InformationInput;
		private transient String[] AddressInformationInput_type_info = new String[]{'AddressInformationInput','http://www.docusign.net/API/3.0','AddressInformationInput','0','1','false'};
		private transient String[] DOBInformationInput_type_info = new String[]{'DOBInformationInput','http://www.docusign.net/API/3.0','DOBInformationInput','0','1','false'};
		private transient String[] SSN4InformationInput_type_info = new String[]{'SSN4InformationInput','http://www.docusign.net/API/3.0','SSN4InformationInput','0','1','false'};
		private transient String[] SSN9InformationInput_type_info = new String[]{'SSN9InformationInput','http://www.docusign.net/API/3.0','SSN9InformationInput','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AddressInformationInput','DOBInformationInput','SSN4InformationInput','SSN9InformationInput'};
	}
	public class InlineTemplate {
		public Integer Sequence;
		public DocusignResponsiveAPI.Envelope Envelope;
		private transient String[] Sequence_type_info = new String[]{'Sequence','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] Envelope_type_info = new String[]{'Envelope','http://www.docusign.net/API/3.0','Envelope','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Sequence','Envelope'};
	}
	public class MatchBox {
		public Integer PageNumber;
		public Integer XPosition;
		public Integer YPosition;
		public Integer Width;
		public Integer Height;
		private transient String[] PageNumber_type_info = new String[]{'PageNumber','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] XPosition_type_info = new String[]{'XPosition','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] YPosition_type_info = new String[]{'YPosition','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] Width_type_info = new String[]{'Width','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] Height_type_info = new String[]{'Height','http://www.docusign.net/API/3.0','int','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PageNumber','XPosition','YPosition','Width','Height'};
	}
	public class MoveEnvelopes_element {
		public DocusignResponsiveAPI.MoveEnvelopesArg Arg;
		private transient String[] Arg_type_info = new String[]{'Arg','http://www.docusign.net/API/3.0','MoveEnvelopesArg','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Arg'};
	}
	public class MoveEnvelopesArg {
		public DocusignResponsiveAPI.ArrayOfString2 EnvelopeIds;
		public String AccountId;
		public DocusignResponsiveAPI.FolderTypeInfo FolderFrom;
		public DocusignResponsiveAPI.FolderTypeInfo FolderTo;
		private transient String[] EnvelopeIds_type_info = new String[]{'EnvelopeIds','http://www.docusign.net/API/3.0','ArrayOfString2','0','1','false'};
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] FolderFrom_type_info = new String[]{'FolderFrom','http://www.docusign.net/API/3.0','FolderTypeInfo','0','1','false'};
		private transient String[] FolderTo_type_info = new String[]{'FolderTo','http://www.docusign.net/API/3.0','FolderTypeInfo','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeIds','AccountId','FolderFrom','FolderTo'};
	}
	public class MoveEnvelopesResponse_element {
		public Boolean MoveEnvelopesResult;
		private transient String[] MoveEnvelopesResult_type_info = new String[]{'MoveEnvelopesResult','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'MoveEnvelopesResult'};
	}
	public class Notification {
		public Boolean UseAccountDefaults;
		public DocusignResponsiveAPI.Reminders Reminders;
		public DocusignResponsiveAPI.Expirations Expirations;
		private transient String[] UseAccountDefaults_type_info = new String[]{'UseAccountDefaults','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Reminders_type_info = new String[]{'Reminders','http://www.docusign.net/API/3.0','Reminders','0','1','false'};
		private transient String[] Expirations_type_info = new String[]{'Expirations','http://www.docusign.net/API/3.0','Expirations','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UseAccountDefaults','Reminders','Expirations'};
	}
	public class PDFMetaDataTemplate {
		public Integer Sequence;
		private transient String[] Sequence_type_info = new String[]{'Sequence','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Sequence'};
	}
	public class PDFOptions {
		public Boolean ShowChanges;
		public Boolean AddWaterMark;
		public Boolean IncludeCert;
		public String CertificateLanguage;
		private transient String[] ShowChanges_type_info = new String[]{'ShowChanges','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] AddWaterMark_type_info = new String[]{'AddWaterMark','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] IncludeCert_type_info = new String[]{'IncludeCert','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] CertificateLanguage_type_info = new String[]{'CertificateLanguage','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ShowChanges','AddWaterMark','IncludeCert','CertificateLanguage'};
	}
	public class PDFsOptions {
		public Boolean ShowChanges;
		public String DocumentID;
		public String CertificateLanguage;
		private transient String[] ShowChanges_type_info = new String[]{'ShowChanges','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] DocumentID_type_info = new String[]{'DocumentID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CertificateLanguage_type_info = new String[]{'CertificateLanguage','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ShowChanges','DocumentID','CertificateLanguage'};
	}
	public class Ping_element {
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{};
	}
	public class PingResponse_element {
		public Boolean PingResult;
		private transient String[] PingResult_type_info = new String[]{'PingResult','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PingResult'};
	}
	public class PublishConnectFailures_element {
		public DocusignResponsiveAPI.PublishConnectFailuresFilter PublishConnectFailuresFilter;
		private transient String[] PublishConnectFailuresFilter_type_info = new String[]{'PublishConnectFailuresFilter','http://www.docusign.net/API/3.0','PublishConnectFailuresFilter','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PublishConnectFailuresFilter'};
	}
	public class PublishConnectFailuresFilter {
		public String AccountId;
		public Boolean Synchronous;
		public DocusignResponsiveAPI.ArrayOfString2 EnvelopeIds;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Synchronous_type_info = new String[]{'Synchronous','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EnvelopeIds_type_info = new String[]{'EnvelopeIds','http://www.docusign.net/API/3.0','ArrayOfString2','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','Synchronous','EnvelopeIds'};
	}
	public class PublishConnectFailuresResponse_element {
		public DocusignResponsiveAPI.ArrayOfPublishConnectFailuresResult PublishConnectFailuresResult;
		private transient String[] PublishConnectFailuresResult_type_info = new String[]{'PublishConnectFailuresResult','http://www.docusign.net/API/3.0','ArrayOfPublishConnectFailuresResult','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PublishConnectFailuresResult'};
	}
	public class PublishConnectFailuresResult {
		public String EnvelopeId;
		public String ConfigId;
		public String ConfigUrl;
		public String Status;
		public String StatusMessage;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ConfigId_type_info = new String[]{'ConfigId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ConfigUrl_type_info = new String[]{'ConfigUrl','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Status_type_info = new String[]{'Status','http://www.docusign.net/API/3.0','ConnectPublishStatus','1','1','false'};
		private transient String[] StatusMessage_type_info = new String[]{'StatusMessage','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','ConfigId','ConfigUrl','Status','StatusMessage'};
	}
	public class PurgeDocuments_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class PurgeDocumentsAndMetaData_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class PurgeDocumentsAndMetaDataAndRedact_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class PurgeDocumentsAndMetaDataAndRedactResponse_element {
		public DocusignResponsiveAPI.PurgeDocumentStatus PurgeDocumentsAndMetaDataAndRedactResult;
		private transient String[] PurgeDocumentsAndMetaDataAndRedactResult_type_info = new String[]{'PurgeDocumentsAndMetaDataAndRedactResult','http://www.docusign.net/API/3.0','PurgeDocumentStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PurgeDocumentsAndMetaDataAndRedactResult'};
	}
	public class PurgeDocumentsAndMetaDataResponse_element {
		public DocusignResponsiveAPI.PurgeDocumentStatus PurgeDocumentsAndMetaDataResult;
		private transient String[] PurgeDocumentsAndMetaDataResult_type_info = new String[]{'PurgeDocumentsAndMetaDataResult','http://www.docusign.net/API/3.0','PurgeDocumentStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PurgeDocumentsAndMetaDataResult'};
	}
	public class PurgeDocumentsResponse_element {
		public DocusignResponsiveAPI.PurgeDocumentStatus PurgeDocumentsResult;
		private transient String[] PurgeDocumentsResult_type_info = new String[]{'PurgeDocumentsResult','http://www.docusign.net/API/3.0','PurgeDocumentStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PurgeDocumentsResult'};
	}
	public class PurgeDocumentStatus {
		public Boolean PurgeDocumentSuccess;
		public String PurgeDocumentError;
		private transient String[] PurgeDocumentSuccess_type_info = new String[]{'PurgeDocumentSuccess','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] PurgeDocumentError_type_info = new String[]{'PurgeDocumentError','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PurgeDocumentSuccess','PurgeDocumentError'};
	}
	public class Recipient {
		public Integer ID;
		public String UserName;
		public String SignerName;
		public String Email;
		public String Type_x;
		public String AccessCode;
		public Boolean AddAccessCodeToEmail;
		public Boolean RequireIDLookup;
		public String IDCheckConfigurationName;
		public String DeliveryMethod;
		public String FaxNumber;
		public Boolean LiveIDRecipientAuthentication;
		public Boolean FacebookRecipientAuthentication;
		public Boolean LinkedinRecipientAuthentication;
		public Boolean GoogleRecipientAuthentication;
		public Boolean SalesforceRecipientAuthentication;
		public Boolean TwitterRecipientAuthentication;
		public Boolean YahooRecipientAuthentication;
		public Boolean OpenIDRecipientAuthentication;
		public Boolean AnySocialIDRecipientAuthentication;
		public DocusignResponsiveAPI.RecipientPhoneAuthentication PhoneAuthentication;
		public DocusignResponsiveAPI.RecipientSAMLAuthentication SAMLAuthentication;
		public DocusignResponsiveAPI.RecipientSMSAuthentication SMSAuthentication;
		public DocusignResponsiveAPI.RecipientSignatureInfo SignatureInfo;
		public DocusignResponsiveAPI.RecipientCaptiveInfo CaptiveInfo;
		public DocusignResponsiveAPI.ArrayOfString1 CustomFields;
		public Integer RoutingOrder;
		public DocusignResponsiveAPI.IDCheckInformationInput IDCheckInformationInput;
		public Boolean AutoNavigation;
		public DocusignResponsiveAPI.ArrayOfAttachment RecipientAttachment;
		public String Note;
		public String RoleName;
		public Boolean TemplateLocked;
		public Boolean TemplateRequired;
		public Boolean TemplateAccessCodeRequired;
		public Boolean DefaultRecipient;
		public DocusignResponsiveAPI.RecipientEmailNotification EmailNotification;
		public Boolean AgentCanEditEmail;
		public Boolean AgentCanEditName;
		public Boolean SignInEachLocation;
		public DocusignResponsiveAPI.ArrayOfPositiveInteger ExcludedDocuments;
		public String RequireSignerCertificate;
		public String RequireNotary;
		public Boolean InheritEmailNotificationConfiguration;
		public String HostedSigner;
		public Boolean IsNotaryTransaction;
		public Long SigningGroupId;
		public DocusignResponsiveAPI.ArrayOfRecipientSignatureProvider RecipientSignatureProviders;
		private transient String[] ID_type_info = new String[]{'ID','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','1','1','true'};
		private transient String[] SignerName_type_info = new String[]{'SignerName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','1','1','true'};
		private transient String[] Type_x_type_info = new String[]{'Type','http://www.docusign.net/API/3.0','RecipientTypeCode','1','1','false'};
		private transient String[] AccessCode_type_info = new String[]{'AccessCode','http://www.docusign.net/API/3.0','string','1','1','true'};
		private transient String[] AddAccessCodeToEmail_type_info = new String[]{'AddAccessCodeToEmail','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RequireIDLookup_type_info = new String[]{'RequireIDLookup','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IDCheckConfigurationName_type_info = new String[]{'IDCheckConfigurationName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DeliveryMethod_type_info = new String[]{'DeliveryMethod','http://www.docusign.net/API/3.0','DeliveryMethod','0','1','false'};
		private transient String[] FaxNumber_type_info = new String[]{'FaxNumber','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] LiveIDRecipientAuthentication_type_info = new String[]{'LiveIDRecipientAuthentication','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] FacebookRecipientAuthentication_type_info = new String[]{'FacebookRecipientAuthentication','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] LinkedinRecipientAuthentication_type_info = new String[]{'LinkedinRecipientAuthentication','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] GoogleRecipientAuthentication_type_info = new String[]{'GoogleRecipientAuthentication','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] SalesforceRecipientAuthentication_type_info = new String[]{'SalesforceRecipientAuthentication','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] TwitterRecipientAuthentication_type_info = new String[]{'TwitterRecipientAuthentication','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] YahooRecipientAuthentication_type_info = new String[]{'YahooRecipientAuthentication','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] OpenIDRecipientAuthentication_type_info = new String[]{'OpenIDRecipientAuthentication','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AnySocialIDRecipientAuthentication_type_info = new String[]{'AnySocialIDRecipientAuthentication','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] PhoneAuthentication_type_info = new String[]{'PhoneAuthentication','http://www.docusign.net/API/3.0','RecipientPhoneAuthentication','0','1','false'};
		private transient String[] SAMLAuthentication_type_info = new String[]{'SAMLAuthentication','http://www.docusign.net/API/3.0','RecipientSAMLAuthentication','0','1','false'};
		private transient String[] SMSAuthentication_type_info = new String[]{'SMSAuthentication','http://www.docusign.net/API/3.0','RecipientSMSAuthentication','0','1','false'};
		private transient String[] SignatureInfo_type_info = new String[]{'SignatureInfo','http://www.docusign.net/API/3.0','RecipientSignatureInfo','0','1','false'};
		private transient String[] CaptiveInfo_type_info = new String[]{'CaptiveInfo','http://www.docusign.net/API/3.0','RecipientCaptiveInfo','0','1','false'};
		private transient String[] CustomFields_type_info = new String[]{'CustomFields','http://www.docusign.net/API/3.0','ArrayOfString1','0','1','false'};
		private transient String[] RoutingOrder_type_info = new String[]{'RoutingOrder','http://www.docusign.net/API/3.0','unsignedShort','0','1','false'};
		private transient String[] IDCheckInformationInput_type_info = new String[]{'IDCheckInformationInput','http://www.docusign.net/API/3.0','IDCheckInformationInput','0','1','false'};
		private transient String[] AutoNavigation_type_info = new String[]{'AutoNavigation','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RecipientAttachment_type_info = new String[]{'RecipientAttachment','http://www.docusign.net/API/3.0','ArrayOfAttachment','0','1','false'};
		private transient String[] Note_type_info = new String[]{'Note','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RoleName_type_info = new String[]{'RoleName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TemplateLocked_type_info = new String[]{'TemplateLocked','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] TemplateRequired_type_info = new String[]{'TemplateRequired','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] TemplateAccessCodeRequired_type_info = new String[]{'TemplateAccessCodeRequired','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] DefaultRecipient_type_info = new String[]{'DefaultRecipient','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] EmailNotification_type_info = new String[]{'EmailNotification','http://www.docusign.net/API/3.0','RecipientEmailNotification','0','1','false'};
		private transient String[] AgentCanEditEmail_type_info = new String[]{'AgentCanEditEmail','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] AgentCanEditName_type_info = new String[]{'AgentCanEditName','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] SignInEachLocation_type_info = new String[]{'SignInEachLocation','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] ExcludedDocuments_type_info = new String[]{'ExcludedDocuments','http://www.docusign.net/API/3.0','ArrayOfPositiveInteger','0','1','false'};
		private transient String[] RequireSignerCertificate_type_info = new String[]{'RequireSignerCertificate','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RequireNotary_type_info = new String[]{'RequireNotary','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] InheritEmailNotificationConfiguration_type_info = new String[]{'InheritEmailNotificationConfiguration','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] HostedSigner_type_info = new String[]{'HostedSigner','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] IsNotaryTransaction_type_info = new String[]{'IsNotaryTransaction','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] SigningGroupId_type_info = new String[]{'SigningGroupId','http://www.docusign.net/API/3.0','long','0','1','false'};
		private transient String[] RecipientSignatureProviders_type_info = new String[]{'RecipientSignatureProviders','http://www.docusign.net/API/3.0','ArrayOfRecipientSignatureProvider','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ID','UserName','SignerName','Email','Type_x','AccessCode','AddAccessCodeToEmail','RequireIDLookup','IDCheckConfigurationName','DeliveryMethod','FaxNumber','LiveIDRecipientAuthentication','FacebookRecipientAuthentication','LinkedinRecipientAuthentication','GoogleRecipientAuthentication','SalesforceRecipientAuthentication','TwitterRecipientAuthentication','YahooRecipientAuthentication','OpenIDRecipientAuthentication','AnySocialIDRecipientAuthentication','PhoneAuthentication','SAMLAuthentication','SMSAuthentication','SignatureInfo','CaptiveInfo','CustomFields','RoutingOrder','IDCheckInformationInput','AutoNavigation','RecipientAttachment','Note','RoleName','TemplateLocked','TemplateRequired','TemplateAccessCodeRequired','DefaultRecipient','EmailNotification','AgentCanEditEmail','AgentCanEditName','SignInEachLocation','ExcludedDocuments','RequireSignerCertificate','RequireNotary','InheritEmailNotificationConfiguration','HostedSigner','IsNotaryTransaction','SigningGroupId','RecipientSignatureProviders'};
	}
	public class RecipientCaptiveInfo {
		public String ClientUserId;
		public String EmbeddedRecipientStartURL;
		private transient String[] ClientUserId_type_info = new String[]{'ClientUserId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EmbeddedRecipientStartURL_type_info = new String[]{'EmbeddedRecipientStartURL','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ClientUserId','EmbeddedRecipientStartURL'};
	}
	public class RecipientCorrection {
		public String PreviousUserName;
		public String PreviousEmail;
		public Integer PreviousRoutingOrder;
		public String PreviousSignerName;
		public String CorrectedUserName;
		public String CorrectedSignerName;
		public String CorrectedEmail;
		public DocusignResponsiveAPI.RecipientCorrectionCorrectedCaptiveInfo CorrectedCaptiveInfo;
		public String CorrectedAccessCode;
		public Boolean CorrectedAccessCodeRequired;
		public Boolean CorrectedRequireIDLookup;
		public String CorrectedIDCheckConfigurationName;
		public Integer CorrectedRoutingOrder;
		public Boolean CorrectedAutoNavigation;
		public DocusignResponsiveAPI.IDCheckInformationInput CorrectedIDCheckInformationInput;
		public Boolean Resend;
		public String CorrectedDeliveryMethod;
		public String CorrectedFaxNumber;
		private transient String[] PreviousUserName_type_info = new String[]{'PreviousUserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] PreviousEmail_type_info = new String[]{'PreviousEmail','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] PreviousRoutingOrder_type_info = new String[]{'PreviousRoutingOrder','http://www.docusign.net/API/3.0','unsignedShort','1','1','false'};
		private transient String[] PreviousSignerName_type_info = new String[]{'PreviousSignerName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CorrectedUserName_type_info = new String[]{'CorrectedUserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CorrectedSignerName_type_info = new String[]{'CorrectedSignerName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CorrectedEmail_type_info = new String[]{'CorrectedEmail','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CorrectedCaptiveInfo_type_info = new String[]{'CorrectedCaptiveInfo','http://www.docusign.net/API/3.0','RecipientCorrectionCorrectedCaptiveInfo','0','1','false'};
		private transient String[] CorrectedAccessCode_type_info = new String[]{'CorrectedAccessCode','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CorrectedAccessCodeRequired_type_info = new String[]{'CorrectedAccessCodeRequired','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CorrectedRequireIDLookup_type_info = new String[]{'CorrectedRequireIDLookup','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CorrectedIDCheckConfigurationName_type_info = new String[]{'CorrectedIDCheckConfigurationName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CorrectedRoutingOrder_type_info = new String[]{'CorrectedRoutingOrder','http://www.docusign.net/API/3.0','unsignedShort','0','1','false'};
		private transient String[] CorrectedAutoNavigation_type_info = new String[]{'CorrectedAutoNavigation','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CorrectedIDCheckInformationInput_type_info = new String[]{'CorrectedIDCheckInformationInput','http://www.docusign.net/API/3.0','IDCheckInformationInput','0','1','false'};
		private transient String[] Resend_type_info = new String[]{'Resend','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CorrectedDeliveryMethod_type_info = new String[]{'CorrectedDeliveryMethod','http://www.docusign.net/API/3.0','DeliveryMethod','0','1','false'};
		private transient String[] CorrectedFaxNumber_type_info = new String[]{'CorrectedFaxNumber','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'PreviousUserName','PreviousEmail','PreviousRoutingOrder','PreviousSignerName','CorrectedUserName','CorrectedSignerName','CorrectedEmail','CorrectedCaptiveInfo','CorrectedAccessCode','CorrectedAccessCodeRequired','CorrectedRequireIDLookup','CorrectedIDCheckConfigurationName','CorrectedRoutingOrder','CorrectedAutoNavigation','CorrectedIDCheckInformationInput','Resend','CorrectedDeliveryMethod','CorrectedFaxNumber'};
	}
	public class RecipientCorrectionCorrectedCaptiveInfo {
		public String ClientUserId;
		public String EmbeddedRecipientStartURL;
		private transient String[] ClientUserId_type_info = new String[]{'ClientUserId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EmbeddedRecipientStartURL_type_info = new String[]{'EmbeddedRecipientStartURL','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ClientUserId','EmbeddedRecipientStartURL'};
	}
	public class RecipientCorrectionStatus {
		public Boolean CorrectionSucceeded;
		public DocusignResponsiveAPI.RecipientCorrection RecipientCorrection;
		public DocusignResponsiveAPI.RecipientStatus RecipientStatus;
		private transient String[] CorrectionSucceeded_type_info = new String[]{'CorrectionSucceeded','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] RecipientCorrection_type_info = new String[]{'RecipientCorrection','http://www.docusign.net/API/3.0','RecipientCorrection','0','1','false'};
		private transient String[] RecipientStatus_type_info = new String[]{'RecipientStatus','http://www.docusign.net/API/3.0','RecipientStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'CorrectionSucceeded','RecipientCorrection','RecipientStatus'};
	}
	public class RecipientEmailNotification {
		public String Subject;
		public String EmailBlurb;
		public String Language;
		private transient String[] Subject_type_info = new String[]{'Subject','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EmailBlurb_type_info = new String[]{'EmailBlurb','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Language_type_info = new String[]{'Language','http://www.docusign.net/API/3.0','SupportedLanguage','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Subject','EmailBlurb','Language'};
	}
	public class RecipientEsign {
		public String UserName;
		public String Email;
		public Boolean Esign;
		public Boolean ReservedRecipientEmail;
		public String ReservedRecipientNames;
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Esign_type_info = new String[]{'Esign','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] ReservedRecipientEmail_type_info = new String[]{'ReservedRecipientEmail','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] ReservedRecipientNames_type_info = new String[]{'ReservedRecipientNames','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UserName','Email','Esign','ReservedRecipientEmail','ReservedRecipientNames'};
	}
	public class RecipientEsignList {
		public String AccountId;
		public DocusignResponsiveAPI.ArrayOfRecipientEsign RecipientEsign;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientEsign_type_info = new String[]{'RecipientEsign','http://www.docusign.net/API/3.0','ArrayOfRecipientEsign','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','RecipientEsign'};
	}
	public class RecipientEvent {
		public String RecipientEventStatusCode;
		public Boolean IncludeDocuments;
		private transient String[] RecipientEventStatusCode_type_info = new String[]{'RecipientEventStatusCode','http://www.docusign.net/API/3.0','RecipientEventStatusCode','1','1','false'};
		private transient String[] IncludeDocuments_type_info = new String[]{'IncludeDocuments','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipientEventStatusCode','IncludeDocuments'};
	}
	public class RecipientList {
		public Boolean ReservedRecipientEmail;
		public Boolean MultipleUsers;
		public DocusignResponsiveAPI.ArrayOfString3 RecipientName;
		private transient String[] ReservedRecipientEmail_type_info = new String[]{'ReservedRecipientEmail','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] MultipleUsers_type_info = new String[]{'MultipleUsers','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RecipientName_type_info = new String[]{'RecipientName','http://www.docusign.net/API/3.0','ArrayOfString3','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ReservedRecipientEmail','MultipleUsers','RecipientName'};
	}
	public class RecipientPhoneAuthentication {
		public Boolean RecipMayProvideNumber;
		public Boolean ValidateRecipProvidedNumber;
		public Boolean RecordVoicePrint;
		public DocusignResponsiveAPI.ArrayOfString SenderProvidedNumbers;
		private transient String[] RecipMayProvideNumber_type_info = new String[]{'RecipMayProvideNumber','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] ValidateRecipProvidedNumber_type_info = new String[]{'ValidateRecipProvidedNumber','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RecordVoicePrint_type_info = new String[]{'RecordVoicePrint','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] SenderProvidedNumbers_type_info = new String[]{'SenderProvidedNumbers','http://www.docusign.net/API/3.0','ArrayOfString','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RecipMayProvideNumber','ValidateRecipProvidedNumber','RecordVoicePrint','SenderProvidedNumbers'};
	}
	public class RecipientSAMLAuthentication {
		public DocusignResponsiveAPI.ArrayOfSAMLAttribute SAMLAttributes;
		private transient String[] SAMLAttributes_type_info = new String[]{'SAMLAttributes','http://www.docusign.net/API/3.0','ArrayOfSAMLAttribute','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SAMLAttributes'};
	}
	public class RecipientSignatureInfo {
		public String SignatureName;
		public String SignatureInitials;
		public String FontStyle;
		private transient String[] SignatureName_type_info = new String[]{'SignatureName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SignatureInitials_type_info = new String[]{'SignatureInitials','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] FontStyle_type_info = new String[]{'FontStyle','http://www.docusign.net/API/3.0','FontStyleCode','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SignatureName','SignatureInitials','FontStyle'};
	}
	public class RecipientSignatureProvider {
		public String SignatureProviderName;
		public DocusignResponsiveAPI.SignatureProviderOptions SignatureProviderOptions;
		private transient String[] SignatureProviderName_type_info = new String[]{'SignatureProviderName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SignatureProviderOptions_type_info = new String[]{'SignatureProviderOptions','http://www.docusign.net/API/3.0','SignatureProviderOptions','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SignatureProviderName','SignatureProviderOptions'};
	}
	public class RecipientSMSAuthentication {
		public DocusignResponsiveAPI.ArrayOfString SenderProvidedNumbers;
		private transient String[] SenderProvidedNumbers_type_info = new String[]{'SenderProvidedNumbers','http://www.docusign.net/API/3.0','ArrayOfString','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SenderProvidedNumbers'};
	}
	public class RecipientStatus {
		public String Type_x;
		public String Email;
		public String UserName;
		public Integer RoutingOrder;
		public DateTime Sent;
		public DateTime Delivered;
		public DateTime Signed;
		public DateTime Declined;
		public String DeclineReason;
		public String AutoRespondedReason;
		public String Status;
		public String RecipientIPAddress;
		public String ClientUserId;
		public Boolean AutoNavigation;
		public DocusignResponsiveAPI.IDCheckInformation IDCheckInformation;
		public DocusignResponsiveAPI.AuthenticationStatus RecipientAuthenticationStatus;
		public DocusignResponsiveAPI.ArrayOfString1 CustomFields;
		public DocusignResponsiveAPI.ArrayOfTabStatus TabStatuses;
		public DocusignResponsiveAPI.ArrayOfAttachment RecipientAttachment;
		public String AccountStatus;
		public DocusignResponsiveAPI.RecipientStatusEsignAgreementInformation EsignAgreementInformation;
		public DocusignResponsiveAPI.FormData FormData;
		public String RecipientId;
		public String DeliveryMethod;
		public String FaxNumber;
		private transient String[] Type_x_type_info = new String[]{'Type','http://www.docusign.net/API/3.0','RecipientTypeCode','1','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RoutingOrder_type_info = new String[]{'RoutingOrder','http://www.docusign.net/API/3.0','unsignedShort','1','1','false'};
		private transient String[] Sent_type_info = new String[]{'Sent','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Delivered_type_info = new String[]{'Delivered','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Signed_type_info = new String[]{'Signed','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] Declined_type_info = new String[]{'Declined','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] DeclineReason_type_info = new String[]{'DeclineReason','http://www.docusign.net/API/3.0','string','1','1','true'};
		private transient String[] AutoRespondedReason_type_info = new String[]{'AutoRespondedReason','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Status_type_info = new String[]{'Status','http://www.docusign.net/API/3.0','RecipientStatusCode','1','1','false'};
		private transient String[] RecipientIPAddress_type_info = new String[]{'RecipientIPAddress','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ClientUserId_type_info = new String[]{'ClientUserId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AutoNavigation_type_info = new String[]{'AutoNavigation','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IDCheckInformation_type_info = new String[]{'IDCheckInformation','http://www.docusign.net/API/3.0','IDCheckInformation','0','1','false'};
		private transient String[] RecipientAuthenticationStatus_type_info = new String[]{'RecipientAuthenticationStatus','http://www.docusign.net/API/3.0','AuthenticationStatus','0','1','false'};
		private transient String[] CustomFields_type_info = new String[]{'CustomFields','http://www.docusign.net/API/3.0','ArrayOfString1','0','1','false'};
		private transient String[] TabStatuses_type_info = new String[]{'TabStatuses','http://www.docusign.net/API/3.0','ArrayOfTabStatus','0','1','false'};
		private transient String[] RecipientAttachment_type_info = new String[]{'RecipientAttachment','http://www.docusign.net/API/3.0','ArrayOfAttachment','0','1','false'};
		private transient String[] AccountStatus_type_info = new String[]{'AccountStatus','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EsignAgreementInformation_type_info = new String[]{'EsignAgreementInformation','http://www.docusign.net/API/3.0','RecipientStatusEsignAgreementInformation','0','1','false'};
		private transient String[] FormData_type_info = new String[]{'FormData','http://www.docusign.net/API/3.0','FormData','0','1','false'};
		private transient String[] RecipientId_type_info = new String[]{'RecipientId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DeliveryMethod_type_info = new String[]{'DeliveryMethod','http://www.docusign.net/API/3.0','DeliveryMethod','0','1','false'};
		private transient String[] FaxNumber_type_info = new String[]{'FaxNumber','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Type_x','Email','UserName','RoutingOrder','Sent','Delivered','Signed','Declined','DeclineReason','AutoRespondedReason','Status','RecipientIPAddress','ClientUserId','AutoNavigation','IDCheckInformation','RecipientAuthenticationStatus','CustomFields','TabStatuses','RecipientAttachment','AccountStatus','EsignAgreementInformation','FormData','RecipientId','DeliveryMethod','FaxNumber'};
	}
	public class RecipientStatusEsignAgreementInformation {
		public String AccountEsignId;
		public String UserEsignId;
		public DateTime AgreementDate;
		private transient String[] AccountEsignId_type_info = new String[]{'AccountEsignId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserEsignId_type_info = new String[]{'UserEsignId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AgreementDate_type_info = new String[]{'AgreementDate','http://www.docusign.net/API/3.0','dateTime','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountEsignId','UserEsignId','AgreementDate'};
	}
	public class Reminders {
		public Boolean ReminderEnabled;
		public Integer ReminderDelay;
		public Integer ReminderFrequency;
		private transient String[] ReminderEnabled_type_info = new String[]{'ReminderEnabled','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] ReminderDelay_type_info = new String[]{'ReminderDelay','http://www.docusign.net/API/3.0','nonNegativeInteger','0','1','false'};
		private transient String[] ReminderFrequency_type_info = new String[]{'ReminderFrequency','http://www.docusign.net/API/3.0','nonNegativeInteger','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'ReminderEnabled','ReminderDelay','ReminderFrequency'};
	}
	public class RemoveAddressBookItems_element {
		public DocusignResponsiveAPI.ArrayOfAddressBookRemoveItem AddressBookRemoveItems;
		public Boolean ReturnAddressBook;
		private transient String[] AddressBookRemoveItems_type_info = new String[]{'AddressBookRemoveItems','http://www.docusign.net/API/3.0','ArrayOfAddressBookRemoveItem','0','1','false'};
		private transient String[] ReturnAddressBook_type_info = new String[]{'ReturnAddressBook','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AddressBookRemoveItems','ReturnAddressBook'};
	}
	public class RemoveAddressBookItemsResponse_element {
		public DocusignResponsiveAPI.UpdateAddressBookResult RemoveAddressBookItemsResult;
		private transient String[] RemoveAddressBookItemsResult_type_info = new String[]{'RemoveAddressBookItemsResult','http://www.docusign.net/API/3.0','UpdateAddressBookResult','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RemoveAddressBookItemsResult'};
	}
	public class RequestCertificate_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class RequestCertificateResponse_element {
		public DocusignResponsiveAPI.DocumentPDFs RequestCertificateResult;
		private transient String[] RequestCertificateResult_type_info = new String[]{'RequestCertificateResult','http://www.docusign.net/API/3.0','DocumentPDFs','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestCertificateResult'};
	}
	public class RequestCertificateWithCertLanguage_element {
		public String EnvelopeID;
		public String CertLanguage;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CertLanguage_type_info = new String[]{'CertLanguage','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','CertLanguage'};
	}
	public class RequestCertificateWithCertLanguageResponse_element {
		public DocusignResponsiveAPI.DocumentPDFs RequestCertificateWithCertLanguageResult;
		private transient String[] RequestCertificateWithCertLanguageResult_type_info = new String[]{'RequestCertificateWithCertLanguageResult','http://www.docusign.net/API/3.0','DocumentPDFs','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestCertificateWithCertLanguageResult'};
	}
	public class RequestCorrectToken_element {
		public String EnvelopeID;
		public Boolean SuppressNavigation;
		public String ReturnURL;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SuppressNavigation_type_info = new String[]{'SuppressNavigation','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] ReturnURL_type_info = new String[]{'ReturnURL','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','SuppressNavigation','ReturnURL'};
	}
	public class RequestCorrectTokenResponse_element {
		public String RequestCorrectTokenResult;
		private transient String[] RequestCorrectTokenResult_type_info = new String[]{'RequestCorrectTokenResult','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestCorrectTokenResult'};
	}
	public class RequestDocumentPDFs_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class RequestDocumentPDFsEx_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class RequestDocumentPDFsExResponse_element {
		public DocusignResponsiveAPI.DocumentPDFs RequestDocumentPDFsExResult;
		private transient String[] RequestDocumentPDFsExResult_type_info = new String[]{'RequestDocumentPDFsExResult','http://www.docusign.net/API/3.0','DocumentPDFs','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestDocumentPDFsExResult'};
	}
	public class RequestDocumentPDFsRecipientsView_element {
		public String EnvelopeID;
		public String RecipientName;
		public String RecipientEmail;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientName_type_info = new String[]{'RecipientName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientEmail_type_info = new String[]{'RecipientEmail','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','RecipientName','RecipientEmail'};
	}
	public class RequestDocumentPDFsRecipientsViewResponse_element {
		public DocusignResponsiveAPI.DocumentPDFs RequestDocumentPDFsRecipientsViewResult;
		private transient String[] RequestDocumentPDFsRecipientsViewResult_type_info = new String[]{'RequestDocumentPDFsRecipientsViewResult','http://www.docusign.net/API/3.0','DocumentPDFs','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestDocumentPDFsRecipientsViewResult'};
	}
	public class RequestDocumentPDFsResponse_element {
		public DocusignResponsiveAPI.DocumentPDFs RequestDocumentPDFsResult;
		private transient String[] RequestDocumentPDFsResult_type_info = new String[]{'RequestDocumentPDFsResult','http://www.docusign.net/API/3.0','DocumentPDFs','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestDocumentPDFsResult'};
	}
	public class RequestEnvelope_element {
		public String EnvelopeID;
		public Boolean IncludeDocumentBytes;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] IncludeDocumentBytes_type_info = new String[]{'IncludeDocumentBytes','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','IncludeDocumentBytes'};
	}
	public class RequestEnvelopeHistoryToken_element {
		public DocusignResponsiveAPI.RequestEnvelopeHistoryTokenArg Arg;
		private transient String[] Arg_type_info = new String[]{'Arg','http://www.docusign.net/API/3.0','RequestEnvelopeHistoryTokenArg','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Arg'};
	}
	public class RequestEnvelopeHistoryTokenArg {
		public String EnvelopeId;
		public String ReturnURL;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ReturnURL_type_info = new String[]{'ReturnURL','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','ReturnURL'};
	}
	public class RequestEnvelopeHistoryTokenResponse_element {
		public String RequestEnvelopeHistoryTokenResult;
		private transient String[] RequestEnvelopeHistoryTokenResult_type_info = new String[]{'RequestEnvelopeHistoryTokenResult','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestEnvelopeHistoryTokenResult'};
	}
	public class RequestEnvelopeResponse_element {
		public DocusignResponsiveAPI.Envelope RequestEnvelopeResult;
		private transient String[] RequestEnvelopeResult_type_info = new String[]{'RequestEnvelopeResult','http://www.docusign.net/API/3.0','Envelope','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestEnvelopeResult'};
	}
	public class RequestEnvelopeV2_element {
		public String EnvelopeID;
		public DocusignResponsiveAPI.RequestEnvelopeV2Options Options;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Options_type_info = new String[]{'Options','http://www.docusign.net/API/3.0','RequestEnvelopeV2Options','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','Options'};
	}
	public class RequestEnvelopeV2Options {
		public Boolean IncludeDocumentBytes;
		public Boolean IncludeAC;
		public Boolean IncludeAnchorTabLocations;
		private transient String[] IncludeDocumentBytes_type_info = new String[]{'IncludeDocumentBytes','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeAC_type_info = new String[]{'IncludeAC','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeAnchorTabLocations_type_info = new String[]{'IncludeAnchorTabLocations','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'IncludeDocumentBytes','IncludeAC','IncludeAnchorTabLocations'};
	}
	public class RequestEnvelopeV2Response_element {
		public DocusignResponsiveAPI.Envelope RequestEnvelopeV2Result;
		private transient String[] RequestEnvelopeV2Result_type_info = new String[]{'RequestEnvelopeV2Result','http://www.docusign.net/API/3.0','Envelope','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestEnvelopeV2Result'};
	}
	public class RequestEnvelopeWithDocumentFields_element {
		public String EnvelopeID;
		public Boolean IncludeDocumentBytes;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] IncludeDocumentBytes_type_info = new String[]{'IncludeDocumentBytes','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','IncludeDocumentBytes'};
	}
	public class RequestEnvelopeWithDocumentFieldsResponse_element {
		public DocusignResponsiveAPI.Envelope RequestEnvelopeWithDocumentFieldsResult;
		private transient String[] RequestEnvelopeWithDocumentFieldsResult_type_info = new String[]{'RequestEnvelopeWithDocumentFieldsResult','http://www.docusign.net/API/3.0','Envelope','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestEnvelopeWithDocumentFieldsResult'};
	}
	public class RequestEnvelopeWithDocumentFieldsV2_element {
		public String EnvelopeID;
		public DocusignResponsiveAPI.RequestEnvelopeWithDocumentFieldsV2Options Options;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Options_type_info = new String[]{'Options','http://www.docusign.net/API/3.0','RequestEnvelopeWithDocumentFieldsV2Options','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','Options'};
	}
	public class RequestEnvelopeWithDocumentFieldsV2Options {
		public Boolean IncludeDocumentBytes;
		public Boolean IncludeSummary;
		public Boolean IncludeUsedResponsiveSigning;
		public String CertLanguage;
		public Boolean IncludeAnchorTabLocations;
		private transient String[] IncludeDocumentBytes_type_info = new String[]{'IncludeDocumentBytes','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeSummary_type_info = new String[]{'IncludeSummary','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IncludeUsedResponsiveSigning_type_info = new String[]{'IncludeUsedResponsiveSigning','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CertLanguage_type_info = new String[]{'CertLanguage','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] IncludeAnchorTabLocations_type_info = new String[]{'IncludeAnchorTabLocations','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'IncludeDocumentBytes','IncludeSummary','IncludeUsedResponsiveSigning','CertLanguage','IncludeAnchorTabLocations'};
	}
	public class RequestEnvelopeWithDocumentFieldsV2Response_element {
		public DocusignResponsiveAPI.EnvelopeV2 RequestEnvelopeWithDocumentFieldsV2Result;
		private transient String[] RequestEnvelopeWithDocumentFieldsV2Result_type_info = new String[]{'RequestEnvelopeWithDocumentFieldsV2Result','http://www.docusign.net/API/3.0','EnvelopeV2','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestEnvelopeWithDocumentFieldsV2Result'};
	}
	public class RequestPDF_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class RequestPDFNoWaterMark_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class RequestPDFNoWaterMarkResponse_element {
		public DocusignResponsiveAPI.EnvelopePDF RequestPDFNoWaterMarkResult;
		private transient String[] RequestPDFNoWaterMarkResult_type_info = new String[]{'RequestPDFNoWaterMarkResult','http://www.docusign.net/API/3.0','EnvelopePDF','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestPDFNoWaterMarkResult'};
	}
	public class RequestPDFRecipientsView_element {
		public String EnvelopeID;
		public String RecipientName;
		public String RecipientEmail;
		public DocusignResponsiveAPI.PDFOptions PDFOptions;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientName_type_info = new String[]{'RecipientName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientEmail_type_info = new String[]{'RecipientEmail','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] PDFOptions_type_info = new String[]{'PDFOptions','http://www.docusign.net/API/3.0','PDFOptions','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','RecipientName','RecipientEmail','PDFOptions'};
	}
	public class RequestPDFRecipientsViewResponse_element {
		public DocusignResponsiveAPI.EnvelopePDF RequestPDFRecipientsViewResult;
		private transient String[] RequestPDFRecipientsViewResult_type_info = new String[]{'RequestPDFRecipientsViewResult','http://www.docusign.net/API/3.0','EnvelopePDF','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestPDFRecipientsViewResult'};
	}
	public class RequestPDFResponse_element {
		public DocusignResponsiveAPI.EnvelopePDF RequestPDFResult;
		private transient String[] RequestPDFResult_type_info = new String[]{'RequestPDFResult','http://www.docusign.net/API/3.0','EnvelopePDF','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestPDFResult'};
	}
	public class RequestPDFsWithOptions_element {
		public String EnvelopeID;
		public DocusignResponsiveAPI.PDFsOptions PDFsOptions;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] PDFsOptions_type_info = new String[]{'PDFsOptions','http://www.docusign.net/API/3.0','PDFsOptions','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','PDFsOptions'};
	}
	public class RequestPDFsWithOptionsResponse_element {
		public DocusignResponsiveAPI.DocumentPDFs RequestPDFsWithOptionsResult;
		private transient String[] RequestPDFsWithOptionsResult_type_info = new String[]{'RequestPDFsWithOptionsResult','http://www.docusign.net/API/3.0','DocumentPDFs','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestPDFsWithOptionsResult'};
	}
	public class RequestPDFWithCert_element {
		public String EnvelopeID;
		public Boolean AddWaterMark;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AddWaterMark_type_info = new String[]{'AddWaterMark','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','AddWaterMark'};
	}
	public class RequestPDFWithCertResponse_element {
		public DocusignResponsiveAPI.EnvelopePDF RequestPDFWithCertResult;
		private transient String[] RequestPDFWithCertResult_type_info = new String[]{'RequestPDFWithCertResult','http://www.docusign.net/API/3.0','EnvelopePDF','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestPDFWithCertResult'};
	}
	public class RequestPDFWithOptions_element {
		public String EnvelopeID;
		public DocusignResponsiveAPI.PDFOptions PDFOptions;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] PDFOptions_type_info = new String[]{'PDFOptions','http://www.docusign.net/API/3.0','PDFOptions','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','PDFOptions'};
	}
	public class RequestPDFWithOptionsResponse_element {
		public DocusignResponsiveAPI.EnvelopePDF RequestPDFWithOptionsResult;
		private transient String[] RequestPDFWithOptionsResult_type_info = new String[]{'RequestPDFWithOptionsResult','http://www.docusign.net/API/3.0','EnvelopePDF','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestPDFWithOptionsResult'};
	}
	public class RequestRecipientFaxPDF_element {
		public String EnvelopeID;
		public String ClientUserID;
		public String Username;
		public String Email;
		public DocusignResponsiveAPI.RequestRecipientTokenAuthenticationAssertion AuthenticationAssertion;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ClientUserID_type_info = new String[]{'ClientUserID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Username_type_info = new String[]{'Username','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AuthenticationAssertion_type_info = new String[]{'AuthenticationAssertion','http://www.docusign.net/API/3.0','RequestRecipientTokenAuthenticationAssertion','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','ClientUserID','Username','Email','AuthenticationAssertion'};
	}
	public class RequestRecipientFaxPDFResponse_element {
		public DocusignResponsiveAPI.EnvelopePDF RequestRecipientFaxPDFResult;
		private transient String[] RequestRecipientFaxPDFResult_type_info = new String[]{'RequestRecipientFaxPDFResult','http://www.docusign.net/API/3.0','EnvelopePDF','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestRecipientFaxPDFResult'};
	}
	public class RequestRecipientFaxToken_element {
		public String EnvelopeID;
		public String ClientUserID;
		public String Username;
		public String Email;
		public DocusignResponsiveAPI.RequestRecipientTokenAuthenticationAssertion AuthenticationAssertion;
		public DocusignResponsiveAPI.RequestRecipientTokenClientURLs ClientURLs;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ClientUserID_type_info = new String[]{'ClientUserID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Username_type_info = new String[]{'Username','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AuthenticationAssertion_type_info = new String[]{'AuthenticationAssertion','http://www.docusign.net/API/3.0','RequestRecipientTokenAuthenticationAssertion','0','1','false'};
		private transient String[] ClientURLs_type_info = new String[]{'ClientURLs','http://www.docusign.net/API/3.0','RequestRecipientTokenClientURLs','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','ClientUserID','Username','Email','AuthenticationAssertion','ClientURLs'};
	}
	public class RequestRecipientFaxTokenResponse_element {
		public String RequestRecipientFaxTokenResult;
		private transient String[] RequestRecipientFaxTokenResult_type_info = new String[]{'RequestRecipientFaxTokenResult','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestRecipientFaxTokenResult'};
	}
	public class RequestRecipientToken_element {
		public String EnvelopeID;
		public String ClientUserID;
		public String Username;
		public String Email;
		public DocusignResponsiveAPI.RequestRecipientTokenAuthenticationAssertion AuthenticationAssertion;
		public DocusignResponsiveAPI.RequestRecipientTokenClientURLs ClientURLs;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ClientUserID_type_info = new String[]{'ClientUserID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Username_type_info = new String[]{'Username','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AuthenticationAssertion_type_info = new String[]{'AuthenticationAssertion','http://www.docusign.net/API/3.0','RequestRecipientTokenAuthenticationAssertion','0','1','false'};
		private transient String[] ClientURLs_type_info = new String[]{'ClientURLs','http://www.docusign.net/API/3.0','RequestRecipientTokenClientURLs','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','ClientUserID','Username','Email','AuthenticationAssertion','ClientURLs'};
	}
	public class RequestRecipientTokenAuthenticationAssertion {
		public String AssertionID;
		public DateTime AuthenticationInstant;
		public String AuthenticationMethod;
		public String SecurityDomain;
		private transient String[] AssertionID_type_info = new String[]{'AssertionID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AuthenticationInstant_type_info = new String[]{'AuthenticationInstant','http://www.docusign.net/API/3.0','dateTime','1','1','false'};
		private transient String[] AuthenticationMethod_type_info = new String[]{'AuthenticationMethod','http://www.docusign.net/API/3.0','RequestRecipientTokenAuthenticationAssertionAuthenticationMethod','1','1','false'};
		private transient String[] SecurityDomain_type_info = new String[]{'SecurityDomain','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AssertionID','AuthenticationInstant','AuthenticationMethod','SecurityDomain'};
	}
	public class RequestRecipientTokenClientURLs {
		public String OnSigningComplete;
		public String OnViewingComplete;
		public String OnCancel;
		public String OnDecline;
		public String OnSessionTimeout;
		public String OnTTLExpired;
		public String OnException;
		public String OnAccessCodeFailed;
		public String OnIdCheckFailed;
		public String OnFaxPending;
		public Boolean GenerateSignedDocumentAsynch;
		private transient String[] OnSigningComplete_type_info = new String[]{'OnSigningComplete','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OnViewingComplete_type_info = new String[]{'OnViewingComplete','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OnCancel_type_info = new String[]{'OnCancel','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OnDecline_type_info = new String[]{'OnDecline','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OnSessionTimeout_type_info = new String[]{'OnSessionTimeout','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OnTTLExpired_type_info = new String[]{'OnTTLExpired','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OnException_type_info = new String[]{'OnException','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OnAccessCodeFailed_type_info = new String[]{'OnAccessCodeFailed','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OnIdCheckFailed_type_info = new String[]{'OnIdCheckFailed','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OnFaxPending_type_info = new String[]{'OnFaxPending','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] GenerateSignedDocumentAsynch_type_info = new String[]{'GenerateSignedDocumentAsynch','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'OnSigningComplete','OnViewingComplete','OnCancel','OnDecline','OnSessionTimeout','OnTTLExpired','OnException','OnAccessCodeFailed','OnIdCheckFailed','OnFaxPending','GenerateSignedDocumentAsynch'};
	}
	public class RequestRecipientTokenResponse_element {
		public String RequestRecipientTokenResult;
		private transient String[] RequestRecipientTokenResult_type_info = new String[]{'RequestRecipientTokenResult','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestRecipientTokenResult'};
	}
	public class RequestSenderToken_element {
		public String EnvelopeID;
		public String AccountID;
		public String ReturnURL;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AccountID_type_info = new String[]{'AccountID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ReturnURL_type_info = new String[]{'ReturnURL','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','AccountID','ReturnURL'};
	}
	public class RequestSenderTokenResponse_element {
		public String RequestSenderTokenResult;
		private transient String[] RequestSenderTokenResult_type_info = new String[]{'RequestSenderTokenResult','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestSenderTokenResult'};
	}
	public class RequestStatus_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class RequestStatusChanges_element {
		public DocusignResponsiveAPI.EnvelopeStatusChangeFilter EnvelopeStatusChangeFilter;
		private transient String[] EnvelopeStatusChangeFilter_type_info = new String[]{'EnvelopeStatusChangeFilter','http://www.docusign.net/API/3.0','EnvelopeStatusChangeFilter','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeStatusChangeFilter'};
	}
	public class RequestStatusChangesResponse_element {
		public DocusignResponsiveAPI.FilteredEnvelopeStatusChanges RequestStatusChangesResult;
		private transient String[] RequestStatusChangesResult_type_info = new String[]{'RequestStatusChangesResult','http://www.docusign.net/API/3.0','FilteredEnvelopeStatusChanges','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestStatusChangesResult'};
	}
	public class RequestStatusCodes_element {
		public DocusignResponsiveAPI.EnvelopeStatusFilter EnvelopeStatusFilter;
		private transient String[] EnvelopeStatusFilter_type_info = new String[]{'EnvelopeStatusFilter','http://www.docusign.net/API/3.0','EnvelopeStatusFilter','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeStatusFilter'};
	}
	public class RequestStatusCodesResponse_element {
		public DocusignResponsiveAPI.FilteredEnvelopeStatusChanges RequestStatusCodesResult;
		private transient String[] RequestStatusCodesResult_type_info = new String[]{'RequestStatusCodesResult','http://www.docusign.net/API/3.0','FilteredEnvelopeStatusChanges','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestStatusCodesResult'};
	}
	public class RequestStatuses_element {
		public DocusignResponsiveAPI.EnvelopeStatusFilter EnvelopeStatusFilter;
		private transient String[] EnvelopeStatusFilter_type_info = new String[]{'EnvelopeStatusFilter','http://www.docusign.net/API/3.0','EnvelopeStatusFilter','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeStatusFilter'};
	}
	public class RequestStatusesEx_element {
		public DocusignResponsiveAPI.EnvelopeStatusFilter EnvelopeStatusFilter;
		private transient String[] EnvelopeStatusFilter_type_info = new String[]{'EnvelopeStatusFilter','http://www.docusign.net/API/3.0','EnvelopeStatusFilter','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeStatusFilter'};
	}
	public class RequestStatusesExResponse_element {
		public DocusignResponsiveAPI.FilteredEnvelopeStatuses RequestStatusesExResult;
		private transient String[] RequestStatusesExResult_type_info = new String[]{'RequestStatusesExResult','http://www.docusign.net/API/3.0','FilteredEnvelopeStatuses','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestStatusesExResult'};
	}
	public class RequestStatusesResponse_element {
		public DocusignResponsiveAPI.FilteredEnvelopeStatuses RequestStatusesResult;
		private transient String[] RequestStatusesResult_type_info = new String[]{'RequestStatusesResult','http://www.docusign.net/API/3.0','FilteredEnvelopeStatuses','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestStatusesResult'};
	}
	public class RequestStatusesWithDocumentFields_element {
		public DocusignResponsiveAPI.EnvelopeStatusFilter EnvelopeStatusFilter;
		private transient String[] EnvelopeStatusFilter_type_info = new String[]{'EnvelopeStatusFilter','http://www.docusign.net/API/3.0','EnvelopeStatusFilter','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeStatusFilter'};
	}
	public class RequestStatusesWithDocumentFieldsResponse_element {
		public DocusignResponsiveAPI.FilteredEnvelopeStatuses RequestStatusesWithDocumentFieldsResult;
		private transient String[] RequestStatusesWithDocumentFieldsResult_type_info = new String[]{'RequestStatusesWithDocumentFieldsResult','http://www.docusign.net/API/3.0','FilteredEnvelopeStatuses','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestStatusesWithDocumentFieldsResult'};
	}
	public class RequestStatusEx_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class RequestStatusExResponse_element {
		public DocusignResponsiveAPI.EnvelopeStatus RequestStatusExResult;
		private transient String[] RequestStatusExResult_type_info = new String[]{'RequestStatusExResult','http://www.docusign.net/API/3.0','EnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestStatusExResult'};
	}
	public class RequestStatusResponse_element {
		public DocusignResponsiveAPI.EnvelopeStatus RequestStatusResult;
		private transient String[] RequestStatusResult_type_info = new String[]{'RequestStatusResult','http://www.docusign.net/API/3.0','EnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestStatusResult'};
	}
	public class RequestStatusWithDocumentFields_element {
		public String EnvelopeID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID'};
	}
	public class RequestStatusWithDocumentFieldsResponse_element {
		public DocusignResponsiveAPI.EnvelopeStatus RequestStatusWithDocumentFieldsResult;
		private transient String[] RequestStatusWithDocumentFieldsResult_type_info = new String[]{'RequestStatusWithDocumentFieldsResult','http://www.docusign.net/API/3.0','EnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestStatusWithDocumentFieldsResult'};
	}
	public class RequestTemplate_element {
		public String TemplateID;
		public Boolean IncludeDocumentBytes;
		private transient String[] TemplateID_type_info = new String[]{'TemplateID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] IncludeDocumentBytes_type_info = new String[]{'IncludeDocumentBytes','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TemplateID','IncludeDocumentBytes'};
	}
	public class RequestTemplateList_element {
		public DocusignResponsiveAPI.ArrayOfString5 TemplateIDs;
		public Boolean IncludeDocumentBytes;
		private transient String[] TemplateIDs_type_info = new String[]{'TemplateIDs','http://www.docusign.net/API/3.0','ArrayOfString5','0','1','false'};
		private transient String[] IncludeDocumentBytes_type_info = new String[]{'IncludeDocumentBytes','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TemplateIDs','IncludeDocumentBytes'};
	}
	public class RequestTemplateListResponse_element {
		public DocusignResponsiveAPI.ArrayOfEnvelopeTemplate RequestTemplateListResult;
		private transient String[] RequestTemplateListResult_type_info = new String[]{'RequestTemplateListResult','http://www.docusign.net/API/3.0','ArrayOfEnvelopeTemplate','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestTemplateListResult'};
	}
	public class RequestTemplateListWithDocumentFields_element {
		public DocusignResponsiveAPI.ArrayOfString5 TemplateIDs;
		public Boolean IncludeDocumentBytes;
		private transient String[] TemplateIDs_type_info = new String[]{'TemplateIDs','http://www.docusign.net/API/3.0','ArrayOfString5','0','1','false'};
		private transient String[] IncludeDocumentBytes_type_info = new String[]{'IncludeDocumentBytes','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TemplateIDs','IncludeDocumentBytes'};
	}
	public class RequestTemplateListWithDocumentFieldsResponse_element {
		public DocusignResponsiveAPI.ArrayOfEnvelopeTemplate RequestTemplateListWithDocumentFieldsResult;
		private transient String[] RequestTemplateListWithDocumentFieldsResult_type_info = new String[]{'RequestTemplateListWithDocumentFieldsResult','http://www.docusign.net/API/3.0','ArrayOfEnvelopeTemplate','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestTemplateListWithDocumentFieldsResult'};
	}
	public class RequestTemplateResponse_element {
		public DocusignResponsiveAPI.EnvelopeTemplate RequestTemplateResult;
		private transient String[] RequestTemplateResult_type_info = new String[]{'RequestTemplateResult','http://www.docusign.net/API/3.0','EnvelopeTemplate','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestTemplateResult'};
	}
	public class RequestTemplates_element {
		public String AccountID;
		public Boolean IncludeAdvancedTemplates;
		private transient String[] AccountID_type_info = new String[]{'AccountID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] IncludeAdvancedTemplates_type_info = new String[]{'IncludeAdvancedTemplates','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountID','IncludeAdvancedTemplates'};
	}
	public class RequestTemplatesResponse_element {
		public DocusignResponsiveAPI.EnvelopeTemplates RequestTemplatesResult;
		private transient String[] RequestTemplatesResult_type_info = new String[]{'RequestTemplatesResult','http://www.docusign.net/API/3.0','EnvelopeTemplates','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestTemplatesResult'};
	}
	public class RequestTemplateWithDocumentFields_element {
		public String TemplateID;
		public Boolean IncludeDocumentBytes;
		private transient String[] TemplateID_type_info = new String[]{'TemplateID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] IncludeDocumentBytes_type_info = new String[]{'IncludeDocumentBytes','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TemplateID','IncludeDocumentBytes'};
	}
	public class RequestTemplateWithDocumentFieldsResponse_element {
		public DocusignResponsiveAPI.EnvelopeTemplate RequestTemplateWithDocumentFieldsResult;
		private transient String[] RequestTemplateWithDocumentFieldsResult_type_info = new String[]{'RequestTemplateWithDocumentFieldsResult','http://www.docusign.net/API/3.0','EnvelopeTemplate','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RequestTemplateWithDocumentFieldsResult'};
	}
	public class SAMLAttribute {
		public String Name;
		public String Value;
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Value_type_info = new String[]{'Value','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Name','Value'};
	}
	public class SaveTemplate_element {
		public DocusignResponsiveAPI.EnvelopeTemplate EnvelopeTemplate;
		private transient String[] EnvelopeTemplate_type_info = new String[]{'EnvelopeTemplate','http://www.docusign.net/API/3.0','EnvelopeTemplate','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeTemplate'};
	}
	public class SaveTemplateResponse_element {
		public DocusignResponsiveAPI.SaveTemplateResult SaveTemplateResult;
		private transient String[] SaveTemplateResult_type_info = new String[]{'SaveTemplateResult','http://www.docusign.net/API/3.0','SaveTemplateResult','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SaveTemplateResult'};
	}
	public class SaveTemplateResult {
		public Boolean Success;
		public String TemplateID;
		public String Name;
		private transient String[] Success_type_info = new String[]{'Success','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] TemplateID_type_info = new String[]{'TemplateID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Success','TemplateID','Name'};
	}
	public class SendEnvelope_element {
		public String EnvelopeId;
		public String AccountId;
		private transient String[] EnvelopeId_type_info = new String[]{'EnvelopeId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeId','AccountId'};
	}
	public class SendEnvelopeResponse_element {
		public DocusignResponsiveAPI.EnvelopeStatus SendEnvelopeResult;
		private transient String[] SendEnvelopeResult_type_info = new String[]{'SendEnvelopeResult','http://www.docusign.net/API/3.0','EnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SendEnvelopeResult'};
	}
	public class ServerTemplate {
		public Integer Sequence;
		public String TemplateID;
		public Integer TabSizingVersion;
		private transient String[] Sequence_type_info = new String[]{'Sequence','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] TemplateID_type_info = new String[]{'TemplateID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TabSizingVersion_type_info = new String[]{'TabSizingVersion','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Sequence','TemplateID','TabSizingVersion'};
	}
	public class SetSharedAccess_element {
		public DocusignResponsiveAPI.SetSharedAccessRequest SetSharedAccessRequest;
		private transient String[] SetSharedAccessRequest_type_info = new String[]{'SetSharedAccessRequest','http://www.docusign.net/API/3.0','SetSharedAccessRequest','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SetSharedAccessRequest'};
	}
	public class SetSharedAccessRequest {
		public String AccountId;
		public DocusignResponsiveAPI.SharedItems[] SharedItems;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SharedItems_type_info = new String[]{'SharedItems','http://www.docusign.net/API/3.0','SharedItems','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','SharedItems'};
	}
	public class SetSharedAccessResponse_element {
		public DocusignResponsiveAPI.SetSharedAccessResult SetSharedAccessResult;
		private transient String[] SetSharedAccessResult_type_info = new String[]{'SetSharedAccessResult','http://www.docusign.net/API/3.0','SetSharedAccessResult','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SetSharedAccessResult'};
	}
	public class SetSharedAccessResult {
		public String AccountId;
		public DocusignResponsiveAPI.SharedAccessItemResult[] SharedItems;
		private transient String[] AccountId_type_info = new String[]{'AccountId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SharedItems_type_info = new String[]{'SharedItems','http://www.docusign.net/API/3.0','SharedAccessItemResult','0','-1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AccountId','SharedItems'};
	}
	public class SharedAccessFilter {
		public DocusignResponsiveAPI.ArrayOfString6 UserIds;
		public String ItemType;
		public String SearchText;
		public String Shared;
		public Integer StartAtIndex;
		public Integer Count;
		private transient String[] UserIds_type_info = new String[]{'UserIds','http://www.docusign.net/API/3.0','ArrayOfString6','0','1','false'};
		private transient String[] ItemType_type_info = new String[]{'ItemType','http://www.docusign.net/API/3.0','SharedAccessItemType','1','1','false'};
		private transient String[] SearchText_type_info = new String[]{'SearchText','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Shared_type_info = new String[]{'Shared','http://www.docusign.net/API/3.0','SharedAccessShareType','1','1','true'};
		private transient String[] StartAtIndex_type_info = new String[]{'StartAtIndex','http://www.docusign.net/API/3.0','nonNegativeInteger','1','1','true'};
		private transient String[] Count_type_info = new String[]{'Count','http://www.docusign.net/API/3.0','nonNegativeInteger','1','1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UserIds','ItemType','SearchText','Shared','StartAtIndex','Count'};
	}
	public class SharedAccessItemResult {
		public DocusignResponsiveAPI.SharedUserInfoResult User_x;
		public DocusignResponsiveAPI.SharedItemResult[] SharedItem;
		public DocusignResponsiveAPI.ErrorDetails ErrorDetails;
		private transient String[] User_x_type_info = new String[]{'User','http://www.docusign.net/API/3.0','SharedUserInfoResult','1','1','true'};
		private transient String[] SharedItem_type_info = new String[]{'SharedItem','http://www.docusign.net/API/3.0','SharedItemResult','0','-1','true'};
		private transient String[] ErrorDetails_type_info = new String[]{'ErrorDetails','http://www.docusign.net/API/3.0','ErrorDetails','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'User_x','SharedItem','ErrorDetails'};
	}
	public class SharedItemRequest {
		public DocusignResponsiveAPI.SharedUserInfoRequest User_x;
		public String Shared;
		public String ItemType;
		private transient String[] User_x_type_info = new String[]{'User','http://www.docusign.net/API/3.0','SharedUserInfoRequest','0','1','false'};
		private transient String[] Shared_type_info = new String[]{'Shared','http://www.docusign.net/API/3.0','SharedAccessShareType','1','1','false'};
		private transient String[] ItemType_type_info = new String[]{'ItemType','http://www.docusign.net/API/3.0','SharedAccessItemType','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'User_x','Shared','ItemType'};
	}
	public class SharedItemResult {
		public DocusignResponsiveAPI.SharedUserInfoResult User_x;
		public String Shared;
		public String ItemType;
		public DocusignResponsiveAPI.ErrorDetails ErrorDetails;
		private transient String[] User_x_type_info = new String[]{'User','http://www.docusign.net/API/3.0','SharedUserInfoResult','0','1','false'};
		private transient String[] Shared_type_info = new String[]{'Shared','http://www.docusign.net/API/3.0','SharedAccessShareType','1','1','false'};
		private transient String[] ItemType_type_info = new String[]{'ItemType','http://www.docusign.net/API/3.0','SharedAccessItemType','1','1','false'};
		private transient String[] ErrorDetails_type_info = new String[]{'ErrorDetails','http://www.docusign.net/API/3.0','ErrorDetails','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'User_x','Shared','ItemType','ErrorDetails'};
	}
	public class SharedItems {
		public DocusignResponsiveAPI.SharedUserInfoRequest User_x;
		public DocusignResponsiveAPI.SharedItemRequest[] SharedItem;
		private transient String[] User_x_type_info = new String[]{'User','http://www.docusign.net/API/3.0','SharedUserInfoRequest','1','1','true'};
		private transient String[] SharedItem_type_info = new String[]{'SharedItem','http://www.docusign.net/API/3.0','SharedItemRequest','0','-1','true'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'User_x','SharedItem'};
	}
	public class SharedUserInfoRequest {
		public String UserId;
		private transient String[] UserId_type_info = new String[]{'UserId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UserId'};
	}
	public class SharedUserInfoResult {
		public String UserId;
		public String Email;
		public String UserName;
		private transient String[] UserId_type_info = new String[]{'UserId','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UserId','Email','UserName'};
	}
	public class SignatureProviderOptions {
		public String Sms;
		public String OneTimePassword;
		public String CPFNumber;
		public String SignerRole;
		private transient String[] Sms_type_info = new String[]{'Sms','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] OneTimePassword_type_info = new String[]{'OneTimePassword','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CPFNumber_type_info = new String[]{'CPFNumber','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SignerRole_type_info = new String[]{'SignerRole','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Sms','OneTimePassword','CPFNumber','SignerRole'};
	}
	public class SSN4Information {
		public String SSN4;
		private transient String[] SSN4_type_info = new String[]{'SSN4','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SSN4'};
	}
	public class SSN4InformationInput {
		public DocusignResponsiveAPI.SSN4Information SSN4Information;
		public String DisplayLevel;
		public Boolean ReceiveInResponse;
		private transient String[] SSN4Information_type_info = new String[]{'SSN4Information','http://www.docusign.net/API/3.0','SSN4Information','0','1','false'};
		private transient String[] DisplayLevel_type_info = new String[]{'DisplayLevel','http://www.docusign.net/API/3.0','DisplayLevelCode','0','1','false'};
		private transient String[] ReceiveInResponse_type_info = new String[]{'ReceiveInResponse','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SSN4Information','DisplayLevel','ReceiveInResponse'};
	}
	public class SSN9Information {
		public String SSN9;
		private transient String[] SSN9_type_info = new String[]{'SSN9','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SSN9'};
	}
	public class SSN9InformationInput {
		public DocusignResponsiveAPI.SSN9Information SSN9Information;
		public String DisplayLevel;
		private transient String[] SSN9Information_type_info = new String[]{'SSN9Information','http://www.docusign.net/API/3.0','SSN9Information','0','1','false'};
		private transient String[] DisplayLevel_type_info = new String[]{'DisplayLevel','http://www.docusign.net/API/3.0','DisplayLevelCode','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SSN9Information','DisplayLevel'};
	}
	public class SynchEnvelope_element {
		public String TransactionID;
		public String AccountID;
		public Boolean Block;
		private transient String[] TransactionID_type_info = new String[]{'TransactionID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AccountID_type_info = new String[]{'AccountID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Block_type_info = new String[]{'Block','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TransactionID','AccountID','Block'};
	}
	public class SynchEnvelopeResponse_element {
		public DocusignResponsiveAPI.SynchEnvelopeStatus SynchEnvelopeResult;
		private transient String[] SynchEnvelopeResult_type_info = new String[]{'SynchEnvelopeResult','http://www.docusign.net/API/3.0','SynchEnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'SynchEnvelopeResult'};
	}
	public class SynchEnvelopeStatus {
		public String EnvelopeStatus;
		public String EnvelopeID;
		private transient String[] EnvelopeStatus_type_info = new String[]{'EnvelopeStatus','http://www.docusign.net/API/3.0','EnvelopeStatusCode','1','1','false'};
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeStatus','EnvelopeID'};
	}
	public class Tab {
		public Integer DocumentID;
		public Integer RecipientID;
		public Integer PageNumber;
		public Integer XPosition;
		public Integer YPosition;
		public Decimal ScaleValue;
		public DocusignResponsiveAPI.AnchorTab AnchorTabItem;
		public String Type_x;
		public String Name;
		public String TabLabel;
		public String Value;
		public String CustomTabType;
		public Integer CustomTabWidth;
		public Integer CustomTabHeight;
		public Boolean CustomTabRequired;
		public Boolean CustomTabLocked;
		public Boolean CustomTabDisableAutoSize;
		public String CustomTabListItems;
		public String CustomTabListValues;
		public String CustomTabListSelectedValue;
		public String CustomTabRadioGroupName;
		public String CustomTabValidationPattern;
		public String CustomTabValidationMessage;
		public Boolean TemplateLocked;
		public Boolean TemplateRequired;
		public String ConditionalParentLabel;
		public String ConditionalParentValue;
		public Boolean SharedTab;
		public Boolean RequireInitialOnSharedTabChange;
		public Boolean ConcealValueOnDocument;
		public String Font;
		public Boolean Bold;
		public Boolean Italic;
		public Boolean Underline;
		public String FontColor;
		public String FontSize;
		public String MergeFieldXml;
		public String MetadataXml;
		public Boolean IncludeNoteInEmail;
		public Boolean IsPaymentAmount;
		public String Formula;
		public Integer RoundDecimalPlaces;
		public Integer MaxLength;
		public Boolean SenderRequired;
		public Boolean RequireAll;
		public Integer TabOrder;
		private transient String[] DocumentID_type_info = new String[]{'DocumentID','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] RecipientID_type_info = new String[]{'RecipientID','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] PageNumber_type_info = new String[]{'PageNumber','http://www.docusign.net/API/3.0','nonNegativeInteger','0','1','false'};
		private transient String[] XPosition_type_info = new String[]{'XPosition','http://www.docusign.net/API/3.0','nonNegativeInteger','0','1','false'};
		private transient String[] YPosition_type_info = new String[]{'YPosition','http://www.docusign.net/API/3.0','nonNegativeInteger','0','1','false'};
		private transient String[] ScaleValue_type_info = new String[]{'ScaleValue','http://www.docusign.net/API/3.0','decimal','0','1','false'};
		private transient String[] AnchorTabItem_type_info = new String[]{'AnchorTabItem','http://www.docusign.net/API/3.0','AnchorTab','0','1','false'};
		private transient String[] Type_x_type_info = new String[]{'Type','http://www.docusign.net/API/3.0','TabTypeCode','1','1','false'};
		private transient String[] Name_type_info = new String[]{'Name','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TabLabel_type_info = new String[]{'TabLabel','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Value_type_info = new String[]{'Value','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CustomTabType_type_info = new String[]{'CustomTabType','http://www.docusign.net/API/3.0','CustomTabType','0','1','false'};
		private transient String[] CustomTabWidth_type_info = new String[]{'CustomTabWidth','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] CustomTabHeight_type_info = new String[]{'CustomTabHeight','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] CustomTabRequired_type_info = new String[]{'CustomTabRequired','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CustomTabLocked_type_info = new String[]{'CustomTabLocked','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CustomTabDisableAutoSize_type_info = new String[]{'CustomTabDisableAutoSize','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] CustomTabListItems_type_info = new String[]{'CustomTabListItems','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CustomTabListValues_type_info = new String[]{'CustomTabListValues','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CustomTabListSelectedValue_type_info = new String[]{'CustomTabListSelectedValue','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CustomTabRadioGroupName_type_info = new String[]{'CustomTabRadioGroupName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CustomTabValidationPattern_type_info = new String[]{'CustomTabValidationPattern','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] CustomTabValidationMessage_type_info = new String[]{'CustomTabValidationMessage','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TemplateLocked_type_info = new String[]{'TemplateLocked','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] TemplateRequired_type_info = new String[]{'TemplateRequired','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] ConditionalParentLabel_type_info = new String[]{'ConditionalParentLabel','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ConditionalParentValue_type_info = new String[]{'ConditionalParentValue','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] SharedTab_type_info = new String[]{'SharedTab','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RequireInitialOnSharedTabChange_type_info = new String[]{'RequireInitialOnSharedTabChange','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] ConcealValueOnDocument_type_info = new String[]{'ConcealValueOnDocument','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Font_type_info = new String[]{'Font','http://www.docusign.net/API/3.0','Font','0','1','false'};
		private transient String[] Bold_type_info = new String[]{'Bold','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Italic_type_info = new String[]{'Italic','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Underline_type_info = new String[]{'Underline','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] FontColor_type_info = new String[]{'FontColor','http://www.docusign.net/API/3.0','FontColor','0','1','false'};
		private transient String[] FontSize_type_info = new String[]{'FontSize','http://www.docusign.net/API/3.0','FontSize','0','1','false'};
		private transient String[] MergeFieldXml_type_info = new String[]{'MergeFieldXml','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] MetadataXml_type_info = new String[]{'MetadataXml','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] IncludeNoteInEmail_type_info = new String[]{'IncludeNoteInEmail','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] IsPaymentAmount_type_info = new String[]{'IsPaymentAmount','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] Formula_type_info = new String[]{'Formula','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RoundDecimalPlaces_type_info = new String[]{'RoundDecimalPlaces','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] MaxLength_type_info = new String[]{'MaxLength','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] SenderRequired_type_info = new String[]{'SenderRequired','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] RequireAll_type_info = new String[]{'RequireAll','http://www.docusign.net/API/3.0','boolean','0','1','false'};
		private transient String[] TabOrder_type_info = new String[]{'TabOrder','http://www.docusign.net/API/3.0','int','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DocumentID','RecipientID','PageNumber','XPosition','YPosition','ScaleValue','AnchorTabItem','Type_x','Name','TabLabel','Value','CustomTabType','CustomTabWidth','CustomTabHeight','CustomTabRequired','CustomTabLocked','CustomTabDisableAutoSize','CustomTabListItems','CustomTabListValues','CustomTabListSelectedValue','CustomTabRadioGroupName','CustomTabValidationPattern','CustomTabValidationMessage','TemplateLocked','TemplateRequired','ConditionalParentLabel','ConditionalParentValue','SharedTab','RequireInitialOnSharedTabChange','ConcealValueOnDocument','Font','Bold','Italic','Underline','FontColor','FontSize','MergeFieldXml','MetadataXml','IncludeNoteInEmail','IsPaymentAmount','Formula','RoundDecimalPlaces','MaxLength','SenderRequired','RequireAll','TabOrder'};
	}
	public class TabStatus {
		public String TabType;
		public String Status;
		public Double XPosition;
		public Double YPosition;
		public DateTime Signed;
		public String TabLabel;
		public String TabName;
		public String TabValue;
		public Integer DocumentID;
		public Integer PageNumber;
		public String OriginalValue;
		public String ValidationPattern;
		public String RoleName;
		public String ListValues;
		public String ListSelectedValue;
		public Decimal ScaleValue;
		public String CustomTabType;
		private transient String[] TabType_type_info = new String[]{'TabType','http://www.docusign.net/API/3.0','TabTypeCode','1','1','false'};
		private transient String[] Status_type_info = new String[]{'Status','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] XPosition_type_info = new String[]{'XPosition','http://www.docusign.net/API/3.0','double','1','1','false'};
		private transient String[] YPosition_type_info = new String[]{'YPosition','http://www.docusign.net/API/3.0','double','1','1','false'};
		private transient String[] Signed_type_info = new String[]{'Signed','http://www.docusign.net/API/3.0','dateTime','0','1','false'};
		private transient String[] TabLabel_type_info = new String[]{'TabLabel','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TabName_type_info = new String[]{'TabName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] TabValue_type_info = new String[]{'TabValue','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] DocumentID_type_info = new String[]{'DocumentID','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] PageNumber_type_info = new String[]{'PageNumber','http://www.docusign.net/API/3.0','nonNegativeInteger','0','1','false'};
		private transient String[] OriginalValue_type_info = new String[]{'OriginalValue','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ValidationPattern_type_info = new String[]{'ValidationPattern','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RoleName_type_info = new String[]{'RoleName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ListValues_type_info = new String[]{'ListValues','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ListSelectedValue_type_info = new String[]{'ListSelectedValue','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] ScaleValue_type_info = new String[]{'ScaleValue','http://www.docusign.net/API/3.0','decimal','0','1','false'};
		private transient String[] CustomTabType_type_info = new String[]{'CustomTabType','http://www.docusign.net/API/3.0','CustomTabType','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TabType','Status','XPosition','YPosition','Signed','TabLabel','TabName','TabValue','DocumentID','PageNumber','OriginalValue','ValidationPattern','RoleName','ListValues','ListSelectedValue','ScaleValue','CustomTabType'};
	}
	public class TemplateReference {
		public String TemplateLocation;
		public String Template;
		public DocusignResponsiveAPI.Document Document;
		public DocusignResponsiveAPI.ArrayOfTemplateReferenceRoleAssignment RoleAssignments;
		public DocusignResponsiveAPI.TemplateReferenceFieldData FieldData;
		public DocusignResponsiveAPI.ArrayOfTab AdditionalTabs;
		public Integer Sequence;
		public DocusignResponsiveAPI.ArrayOfAttachment TemplateAttachments;
		private transient String[] TemplateLocation_type_info = new String[]{'TemplateLocation','http://www.docusign.net/API/3.0','TemplateLocationCode','0','1','false'};
		private transient String[] Template_type_info = new String[]{'Template','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Document_type_info = new String[]{'Document','http://www.docusign.net/API/3.0','Document','0','1','false'};
		private transient String[] RoleAssignments_type_info = new String[]{'RoleAssignments','http://www.docusign.net/API/3.0','ArrayOfTemplateReferenceRoleAssignment','0','1','false'};
		private transient String[] FieldData_type_info = new String[]{'FieldData','http://www.docusign.net/API/3.0','TemplateReferenceFieldData','0','1','false'};
		private transient String[] AdditionalTabs_type_info = new String[]{'AdditionalTabs','http://www.docusign.net/API/3.0','ArrayOfTab','0','1','false'};
		private transient String[] Sequence_type_info = new String[]{'Sequence','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] TemplateAttachments_type_info = new String[]{'TemplateAttachments','http://www.docusign.net/API/3.0','ArrayOfAttachment','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TemplateLocation','Template','Document','RoleAssignments','FieldData','AdditionalTabs','Sequence','TemplateAttachments'};
	}
	public class TemplateReferenceFieldData {
		public DocusignResponsiveAPI.ArrayOfTemplateReferenceFieldDataDataValue DataValues;
		private transient String[] DataValues_type_info = new String[]{'DataValues','http://www.docusign.net/API/3.0','ArrayOfTemplateReferenceFieldDataDataValue','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'DataValues'};
	}
	public class TemplateReferenceFieldDataDataValue {
		public String TabLabel;
		public String Value;
		private transient String[] TabLabel_type_info = new String[]{'TabLabel','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Value_type_info = new String[]{'Value','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TabLabel','Value'};
	}
	public class TemplateReferenceRoleAssignment {
		public String RoleName;
		public Integer RecipientID;
		private transient String[] RoleName_type_info = new String[]{'RoleName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] RecipientID_type_info = new String[]{'RecipientID','http://www.docusign.net/API/3.0','positiveInteger','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'RoleName','RecipientID'};
	}
	public class TransferEnvelope_element {
		public String EnvelopeID;
		public String AccountID;
		public String UserID;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AccountID_type_info = new String[]{'AccountID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] UserID_type_info = new String[]{'UserID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','AccountID','UserID'};
	}
	public class TransferEnvelopeResponse_element {
		public DocusignResponsiveAPI.TransferEnvelopeStatus TransferEnvelopeResult;
		private transient String[] TransferEnvelopeResult_type_info = new String[]{'TransferEnvelopeResult','http://www.docusign.net/API/3.0','TransferEnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TransferEnvelopeResult'};
	}
	public class TransferEnvelopeStatus {
		public Boolean TransferEnvelopeSuccess;
		private transient String[] TransferEnvelopeSuccess_type_info = new String[]{'TransferEnvelopeSuccess','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TransferEnvelopeSuccess'};
	}
	public class UpdateAddressBookItems_element {
		public DocusignResponsiveAPI.ArrayOfAddressBookItem AddressBookItems;
		public Boolean ReturnAddressBook;
		private transient String[] AddressBookItems_type_info = new String[]{'AddressBookItems','http://www.docusign.net/API/3.0','ArrayOfAddressBookItem','0','1','false'};
		private transient String[] ReturnAddressBook_type_info = new String[]{'ReturnAddressBook','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'AddressBookItems','ReturnAddressBook'};
	}
	public class UpdateAddressBookItemsResponse_element {
		public DocusignResponsiveAPI.UpdateAddressBookResult UpdateAddressBookItemsResult;
		private transient String[] UpdateAddressBookItemsResult_type_info = new String[]{'UpdateAddressBookItemsResult','http://www.docusign.net/API/3.0','UpdateAddressBookResult','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UpdateAddressBookItemsResult'};
	}
	public class UpdateAddressBookResult {
		public Boolean Success;
		public DocusignResponsiveAPI.ArrayOfAddressBookItem1 AddressBookItems;
		private transient String[] Success_type_info = new String[]{'Success','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] AddressBookItems_type_info = new String[]{'AddressBookItems','http://www.docusign.net/API/3.0','ArrayOfAddressBookItem1','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'Success','AddressBookItems'};
	}
	public class UploadTemplate_element {
		public String TemplateXML;
		public String AccountID;
		public Boolean Shared;
		private transient String[] TemplateXML_type_info = new String[]{'TemplateXML','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] AccountID_type_info = new String[]{'AccountID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Shared_type_info = new String[]{'Shared','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'TemplateXML','AccountID','Shared'};
	}
	public class UploadTemplateResponse_element {
		public DocusignResponsiveAPI.SaveTemplateResult UploadTemplateResult;
		private transient String[] UploadTemplateResult_type_info = new String[]{'UploadTemplateResult','http://www.docusign.net/API/3.0','SaveTemplateResult','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UploadTemplateResult'};
	}
	public class UserInfo {
		public String UserName;
		public String Email;
		private transient String[] UserName_type_info = new String[]{'UserName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Email_type_info = new String[]{'Email','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'UserName','Email'};
	}
	public class VaultingDetails {
		public String EODTransactionName;
		public String EODTransactionID;
		public String EODDocumentProfileID;
		private transient String[] EODTransactionName_type_info = new String[]{'EODTransactionName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EODTransactionID_type_info = new String[]{'EODTransactionID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EODDocumentProfileID_type_info = new String[]{'EODDocumentProfileID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EODTransactionName','EODTransactionID','EODDocumentProfileID'};
	}
	public class VaultingOptions {
		public String VaultingMode;
		public String EODTransactionName;
		public String EODDocumentName;
		public String EODDocumentDescription;
		private transient String[] VaultingMode_type_info = new String[]{'VaultingMode','http://www.docusign.net/API/3.0','VaultingModeCode','1','1','false'};
		private transient String[] EODTransactionName_type_info = new String[]{'EODTransactionName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EODDocumentName_type_info = new String[]{'EODDocumentName','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] EODDocumentDescription_type_info = new String[]{'EODDocumentDescription','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'VaultingMode','EODTransactionName','EODDocumentName','EODDocumentDescription'};
	}
	public class VoidEnvelope_element {
		public String EnvelopeID;
		public String Reason;
		private transient String[] EnvelopeID_type_info = new String[]{'EnvelopeID','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] Reason_type_info = new String[]{'Reason','http://www.docusign.net/API/3.0','string','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'EnvelopeID','Reason'};
	}
	public class VoidEnvelopeResponse_element {
		public DocusignResponsiveAPI.VoidEnvelopeStatus VoidEnvelopeResult;
		private transient String[] VoidEnvelopeResult_type_info = new String[]{'VoidEnvelopeResult','http://www.docusign.net/API/3.0','VoidEnvelopeStatus','0','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'VoidEnvelopeResult'};
	}
	public class VoidEnvelopeStatus {
		public Boolean VoidSuccess;
		private transient String[] VoidSuccess_type_info = new String[]{'VoidSuccess','http://www.docusign.net/API/3.0','boolean','1','1','false'};
		private transient String[] apex_schema_type_info = new String[]{'http://www.docusign.net/API/3.0','true','false'};
		private transient String[] field_order_type_info = new String[]{'VoidSuccess'};
	}
}