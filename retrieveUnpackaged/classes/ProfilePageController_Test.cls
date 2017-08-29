@isTest
public class ProfilePageController_Test {

    @isTest
    static void testController(){
    	insert new Contact_Approvers__c(name='Use Contact Fields', Use_Contact__c = false); // checkbox from "Contact Approvers" Custom Setting
        User u = [select id, Lan_ID__c, FirstName, LastName from User where isActive = true limit 1];
        u.Session_Token__c = '12345';
        u.Session_IP__c = '111-111-1111';
        u.Session_Environment__c = 'chrome';
        u.Session_Timestamp__c = datetime.now().addMinutes(-1);
        update u;
        
        Account a = new Account(name = 'acme');
        insert a;
        Contact c = new Contact(accountid = a.id, lastname = 'jones', Lan_ID__c = u.Lan_ID__c);
        insert c;
        
        Test.setCurrentPageReference(new PageReference('Page.ProfilePage')); 
        System.currentPageReference().getParameters().put('sID', '12345');

        System.currentPageReference().getHeaders().put('sID', '12345');
        System.currentPageReference().getHeaders().put('X-Salesforce-SIP', '111-111-1111');
        System.currentPageReference().getHeaders().put('User-Agent', 'chrome');
        ProfilePageController controller = new ProfilePageController();
        controller.validateOrRedirect();
        controller.save();
        controller.cancel();
    }
}