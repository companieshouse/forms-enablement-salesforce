

Companies House Forms Enablement Salesforce
=====================

This service serves as the front-end from Forms Enablement service for Companies House. This forms factory can dynamically build and deploy forms for the Forms Enablement service. This service works with the [Companies House Forms Enablement API Service](https://github.com/companieshouse/forms-enablement-api) to send JSON/XML to the Companies House Information Processing System (CHIPS).

### About this application

This application is written in [APEX](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/) for Salesforce. From Salesforce - "Apex is a strongly typed, object-oriented programming language that allows developers to execute flow and transaction control statements on the Force.com platform server in conjunction with calls to the Force.com​ API. Using syntax that looks like Java and acts like database stored procedures, Apex enables developers to add business logic to most system events, including button clicks, related record updates, and Visualforce pages. Apex code can be initiated by Web service requests and from triggers on objects."

### Prerequisites

In order to run this service you will need the following:

- [Salesforce Account](https://developer.salesforce.com/signup)
- [Docusign for Salesforce](https://maven.apache.org/download.cgi)
- [Docusign Account](https://github.com/docusign/docusign-soap-sdk)
- [Git](https://git-scm.com/downloads)
- [ANT](http://ant.apache.org/)
- [Force Migration Tool](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_deploying_ant.htm)
- [Sublime Text](https://www.sublimetext.com/) and [Mavens Mate](http://mavensmate.com/)

 or
- [Eclipse](https://eclipse.org/), [Salesforce Eclipse plugin](https://developer.salesforce.com/page/Force.com_IDE_Installation) and [Java](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

 or
- [Force.com IDE package instructions](https://developer.salesforce.com/page/Force.com_IDE_Installation)

### Getting Started

Run the following from the command line to download the repository and change into the directory:

```
git clone git@github.com:companieshouse/forms-enablement-salesforce.git

cd forms-enablement-salesforce
```


### Running the application

To run the application you have to first create a salesforce developer account or a Salesforce Sandbox Account. Then install the DocuSign API and then deploy this repository to your sandbox. This is a publically facing application so to run this application publically you will need to enable [Force.com Sites](https://developer.salesforce.com/page/Sites).
