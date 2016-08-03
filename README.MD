

Companies House Forms Enablement Salesforce
=====================

This service serves as the front-end for Forms Enablement service for Companies House. This service serves as a forms factory to dynamically build and deploy forms for Companies House using Salesforce. This service works with the [Companies House Forms Enablement API Service](https://github.com/companieshouse/forms-enablement-api) to send JSON data to Companies House Information Processing System (CHIPS).

### About this application

This application is written in Apex [APEX](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/) for Salesforce.

### Prerequisites

In order to run this service you will need the following.

- [Salesforce Account](https://developer.salesforce.com/signup)
- [Docusign for Salesforce](https://maven.apache.org/download.cgi)
-[Docusign Account](https://github.com/docusign/docusign-soap-sdk)
- [Git](https://git-scm.com/downloads)
-[Sublime Text](https://www.sublimetext.com/) and -[Mavens Mate](http://mavensmate.com/)
 or
-[Eclipse](https://eclipse.org/), [Salesforce Eclipse plugin](https://developer.salesforce.com/page/Force.com_IDE_Installation) and [Java](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
or
-[Force.com IDE package instructions](https://developer.salesforce.com/page/Force.com_IDE_Installation)
-[ANT](http://ant.apache.org/)
-[Force Migration Tool](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_deploying_ant.htm)

### Getting Started

Run the following from the command line to download the repository and change into the directory:

```
git clone git@github.com:companieshouse/forms-enablement-salesforce.git

cd forms-enablement-salesforce
```


### Running the application

To run the application you have to first install the DocuSign API and then deploy this repository to your sandbox. This is a publically facing application so to run this application [Force.com Sites](https://developer.salesforce.com/page/Sites) has to be enabled to use this product.
