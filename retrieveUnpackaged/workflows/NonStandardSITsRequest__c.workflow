<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Supervisor_ApprovalNSSR</fullName>
        <description>Supervisor needs to review for approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>caruthers.marcus2@epa.gov</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Dev_Sandbox_Submission_Notification_Template</template>
    </alerts>
</Workflow>
