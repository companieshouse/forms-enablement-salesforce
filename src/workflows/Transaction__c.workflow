<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ContactPresenteronDecline</fullName>
        <description>ContactPresenteronDecline</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail__c</field>
            <type>email</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/testDocusignEmail</template>
    </alerts>
    <alerts>
        <fullName>EMAIL_NOTIFICATION_FOR_EXPIRED_SIGNING_PERIOD_RESTART_JOURNEY</fullName>
        <description>EMAIL NOTIFICATION FOR EXPIRED SIGNING PERIOD: RESTART JOURNEY</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ExpiryNotification</template>
    </alerts>
    <alerts>
        <fullName>Notify_presenter_that_documents_are_signed_and_awaiting_review_redirect_to_the_r</fullName>
        <description>Notify presenter that documents are signed and awaiting review - redirect to the review page</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail__c</field>
            <type>email</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/ReviewStatus</template>
    </alerts>
    <fieldUpdates>
        <fullName>setContactFieldtoPresenter</fullName>
        <field>ContactEmail__c</field>
        <formula>IF(ISBLANK(&apos;ContactEmail__c&apos;),Presenter__c, ContactEmail__c )</formula>
        <name>setContactFieldtoPresenter</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>setExpireDate</fullName>
        <description>sets expire time when expiry custom meta data is upserted into record</description>
        <field>ExpiryDate__c</field>
        <formula>Today()+ Expiry_Date_Length__c</formula>
        <name>setExpireDate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>updateExpirySentField</fullName>
        <description>update that the expiry has been sent and the transaction will now be ready to cleanup during batch</description>
        <field>ExpirySEnt__c</field>
        <literalValue>1</literalValue>
        <name>updateExpirySentField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Decline notification</fullName>
        <actions>
            <name>ContactPresenteronDecline</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Transaction__c.Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <description>Notify presenter when Transaction Status is update with &apos;Declined&apos;.
Email should contain a URL to start a new journey</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Expiry notification</fullName>
        <actions>
            <name>EMAIL_NOTIFICATION_FOR_EXPIRED_SIGNING_PERIOD_RESTART_JOURNEY</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>updateExpirySentField</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Transaction__c.MultipleDirectors__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Transaction__c.ExpiryDate__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Transaction__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Signed</value>
        </criteriaItems>
        <description>Notify presenter when Transaction Status has expired.
Email should contain a URL to start a new journey</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ReviewTransaction</fullName>
        <actions>
            <name>Notify_presenter_that_documents_are_signed_and_awaiting_review_redirect_to_the_r</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Transaction__c.ReviewRedirect__c</field>
            <operation>contains</operation>
            <value>http</value>
        </criteriaItems>
        <description>Notifies presenter when multiple directors have finished signing their documents and redirects the presenter back to the review page</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>expirydateupdater</fullName>
        <actions>
            <name>setExpireDate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Transaction__c.Expiry_Date_Length__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
