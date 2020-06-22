public inherited sharing class DocusignResponsiveRestAPI {
    public class Document{
        public String documentId {get; set;}
        public String name {get; set;}
        public HtmlDefinition htmlDefinition {get; set;}
    }

    public class HtmlDefinition{
        public String maxScreenWidth {get; set;}
        public String source {get; set;}
    }

    public class Envelope{
        public Document[] documents {get; set;}
        public String emailSubject {get; set;}
        public String status {get; set;}
        public Recipient recipients {get; set;}
        public String brandId {get; set;}
        public String emailBlurb {get; set;}
        public Notification notification {get; set;}
        public TextCustomFields customFields {get; set;}
    }

    public class Notification{
        public String useAccountDefaults {get; set;}
    }

    public class Recipient{
        public Signer[] signers {get; set;}
    }

    public class Signer{
        public String recipientId {get; set;}
        public String clientUserId {get; set;}
        public String email {get; set;}
        public String name {get; set;}
        public String routingOrder {get; set;}
        public String[] customFields {get; set;}
    }

    public class TextCustomFields {
        public TextCustomField[] textCustomFields {get; set;}
    }
    public class TextCustomField{
        public String value {get; set;}
        public String name {get; set;}
    }
}