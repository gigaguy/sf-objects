@istest
public class FormPageController_Test {
	
    @isTest
    static void testGetFormRTs(){
        insert new Contact_Approvers__c(name='Use Contact Fields', Use_Contact__c = false); // checkbox from "Contact Approvers" Custom Setting
        User u = [select id from User where isActive = true and PRofile.Name = 'System Administrator' limit 1];
        u.Session_Token__c = '123ABC';
        update u;
        
        PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = [select id from PermissionSet where Label like '%BAPForms User%' limit 1].ID, AssigneeID = u.Id);
        try{
            //This will never work because you cannot update a setup object and another sObject durring the same transaction. 
            insert psa;
        }
        catch (Exception e){
            System.debug('Try Catch block for testGetFormRTs function: ' + e.getMessage());
        }
        
        System.assert(FormPageController.getFormRTs('123ABC').size() > 0);
    }

    @isTest
    static void testInsertNewForms(){
        insert new Contact_Approvers__c(name='Use Contact Fields', Use_Contact__c = false); // checkbox from "Contact Approvers" Custom Setting
        
        User u = [select id from User where isActive = true limit 1];
        User u2 = [select id from User where isActive = true and PRofile.Name = 'System Administrator' and id != :u.id limit 1];
        
        u.Session_Token__c = '123ABC';
        u.Supervisor__c = u2.id;
        u.Supervisor_2__c = u2.id;
        u.Lan_ID__c = 'thetest';
        
        update u;

        //siteUser
        User uSU = [select id from User where isActive = true AND id != :u.id AND id != :u2.id limit 1];

        //apiUser
        User uAU = [select id from User where isActive = true AND id != :u.id AND id != :u2.id AND id != :uSU.id limit 1];

        contact c = new contact(FirstName='Bob', LastName='Smith', Lan_ID__c = 'thetest');
        
        Forms__c testForm = new Forms__c();

        testForm.Unauthenticated_Owner__c = u.Id;
        testForm.approval_step__c = 'Form Prepared for you by test';
        testForm.RecordTypeID = [select id from RecordType where sObjectType = 'Forms__c' ORDER BY createddate limit 1].id;
        
        insert testForm;

        String sIDString = '123ABC';
        String sIDString2 = 'xyz';
        String rtIDString = [select id from RecordType where sObjectType = 'Forms__c' ORDER BY createddate limit 1].ID;
        String rtIDString2 = [select id from RecordType where name = 'EPA-100' limit 1].ID;
        String siteUserIDString = uSU.id;
        String apiUserIDString = uAU.id;
        String formOptionString = null;

        
        Forms__c form = FormPageController.insertNewForms(sIDString, rtIDString, siteUserIDString, apiUserIDString, formOptionString);     
        //form = FormPageController.insertNewForms('123ABC', [select id from RecordType where sObjectType = 'Forms__c' limit 1].ID,null);
        
        Forms__c xform;
        
        try{
            xform = FormPageController.insertNewForms(sIDString, rtIDString2, siteUserIDString, apiUserIDString, formOptionString);
            }
            catch(exception ex){
                System.debug('Try catch block xform testInsertNewForms: ' + ex.getMessage());  
              }
        
        Forms__c yform;
        try{
            yform = FormPageController.insertNewForms(sIDString2, rtIDString2, siteUserIDString , apiUserIDString, formOptionString);
            }catch(exception ex){
                System.debug('Try catch block yform testInsertNewForms: ' + ex.getMessage());  
            }
               
        if (xform.id != null) {FormPageController.submitForApproval(xform.ID, '123ABC',''); }  
        FormPageController.submitForApproval(form.ID, '123ABC','');         
        FormPageController.findExistingForms('xyz');
        FormPageController.findExistingForms('123ABC');
        FormPageController.viewForm(form.ID, uSU.id);
        FormPageController.viewForm(testForm.ID, uSU.id);
        FormPageController.saveForm(form, '123ABC');
        FormPageController.saveForm(yform, '123ABC');
        FormPageController.deleteForm(form.ID, '123ABC');
        FormPageController.getFandP_FormRTs();
        FormPageController.getSiteUserID();
        FormPageController.getAPIUserID();
        FormPageController.removeFormShare(xform.ID, uSU.id);
    }
      
}