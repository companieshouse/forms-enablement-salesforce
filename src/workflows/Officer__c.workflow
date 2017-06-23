<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Authorized_Signer</fullName>
        <field>AuthorizedSigner__c</field>
        <formula>AuthorizedSigner__c</formula>
        <name>Authorized Signer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Signed</fullName>
        <field>DateSigned__c</field>
        <formula>DateSigned__c</formula>
        <name>Date Signed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Docusign_Name</fullName>
        <field>DocusignName__c</field>
        <formula>DocusignName__c</formula>
        <name>Docusign Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Email</fullName>
        <field>Email</field>
        <formula>Email__c</formula>
        <name>Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ForeName</fullName>
        <field>FirstName</field>
        <formula>Forename__c</formula>
        <name>ForeName</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Has_Input_Behalf_Signatory_Details</fullName>
        <field>hasInputBehalfDetailsTEXT__c</field>
        <formula>if(hasInputBehalfDetails__c == true, &quot;true&quot;,&quot;false&quot;)</formula>
        <name>Has Input Behalf Signatory Details</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Is_Corporate_Director</fullName>
        <field>isCorporateDirectorTEXT__c</field>
        <formula>if(isCorporateDirector__c == true, &quot;true&quot;, &quot;false&quot;)</formula>
        <name>Is Corporate Director</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MiddleName</fullName>
        <field>Middlenames__c</field>
        <formula>Middlenames__c</formula>
        <name>MiddleName</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recipient_ID</fullName>
        <field>RecipientId__c</field>
        <formula>Value(RecipientId__c)</formula>
        <name>Recipient ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Surname</fullName>
        <field>LastName</field>
        <formula>Surname__c</formula>
        <name>Surname</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Title</fullName>
        <field>Title</field>
        <formula>Title__c</formula>
        <name>Title</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>is_Presenter</fullName>
        <field>IsPresenterTEXT__c</field>
        <formula>if( IsPresenter__c ,&quot;true&quot;,&quot;false&quot;)</formula>
        <name>is Presenter</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>is_Signatory</fullName>
        <field>isSignatoryTEXT__c</field>
        <formula>if(isSignatory__c == true, &quot;true&quot;, &quot;false&quot;)</formula>
        <name>is Signatory</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>is_Signatory_on_Behalf</fullName>
        <field>isSignatoryBehalfTEXT__c</field>
        <formula>if( isSignatoryBehalf__c ,&quot;true&quot;,&quot;false&quot;)</formula>
        <name>is Signatory on Behalf</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>is_power_of_attorney</fullName>
        <field>isPowerOfAttorneyTEXT__c</field>
        <formula>if( isPowerOfAttorney__c ,&quot;true&quot;,&quot;false&quot;)</formula>
        <name>is power of attorney</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Contact__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Update Related Contact</fullName>
        <actions>
            <name>Authorized_Signer</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Docusign_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ForeName</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Has_Input_Behalf_Signatory_Details</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MiddleName</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Recipient_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Surname</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Title</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>If( Contact__c != null , true , false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Related Contact II</fullName>
        <actions>
            <name>Is_Corporate_Director</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>is_Presenter</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>is_Signatory</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>is_Signatory_on_Behalf</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>is_power_of_attorney</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>If( Contact__c != null , true , false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
