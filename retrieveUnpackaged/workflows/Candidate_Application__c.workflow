<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Candidate_Package_Approved</fullName>
        <description>Candidate Package Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TQB_Email_Templates/Candidate_Package_Approved</template>
    </alerts>
    <alerts>
        <fullName>Candidate_Package_Rejected</fullName>
        <description>Candidate Package Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TQB_Email_Templates/Candidate_Package_Rejected</template>
    </alerts>
    <alerts>
        <fullName>LOI_Approved_Notification</fullName>
        <description>LOI Approved Notification</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TQB_Email_Templates/LOI_Approved_Notification</template>
    </alerts>
    <alerts>
        <fullName>LOI_Rejected_Notification</fullName>
        <description>LOI Rejected Notification</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TQB_Email_Templates/Letter_of_Intent_Rejected</template>
    </alerts>
    <alerts>
        <fullName>TQB_Effective_Date_Notification</fullName>
        <description>TQB Effective Date Notification</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TQB_Email_Templates/TQB_Promotion_Effective_Date_Notification</template>
    </alerts>
    <alerts>
        <fullName>TQB_LCO_Director_Approval_Notification</fullName>
        <description>TQB LCO Director Approval Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Second_Line_Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>TQB_Chair__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>TQB_Coordinator_2__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>TQB_Coordinator__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TQB_Email_Templates/LCO_Director_Approval</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Status_to_LOI_Approved</fullName>
        <field>Status__c</field>
        <literalValue>LOI Approved</literalValue>
        <name>Update Status to LOI Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Status to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Submitted</fullName>
        <field>Status__c</field>
        <literalValue>Submitted</literalValue>
        <name>Update Status to Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_TQB_Chair_Approved</fullName>
        <field>TQB_Chair_Approved__c</field>
        <literalValue>1</literalValue>
        <name>Update TQB Chair Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Candidate_Package</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Candidate_Package</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update to Candidate Package</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>TQB Director Approval Notification</fullName>
        <actions>
            <name>TQB_LCO_Director_Approval_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Candidate_Application__c.Promotion_Decision__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TQB Promotion Effective Date Notification</fullName>
        <actions>
            <name>TQB_Effective_Date_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Candidate_Application__c.Effective_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
