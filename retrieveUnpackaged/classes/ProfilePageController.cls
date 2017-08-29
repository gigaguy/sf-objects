public class ProfilePageController { 
    public string sID {get;set;}
    public boolean valid {get;set;}
    public id uID {get;set;}
    public string userName {get;set;}
    public id supID {get;set;}
    public id timekID {get;set;}
    public id sup2ID {get;set;}
    public id fundID {get;set;}
    public id trainID {get;set;}

    public User u {get;set;}
    public Contact c {get;set;}
    public Boolean useContact {get;set;}
    
    public ProfilePageController() {
        valid = false;
        // Get session ID from URL parameters, get user ID from the matching session
        sID = UtilityMethods.getSessionID();
        uID = UtilityMethods.getUserID(sID);
        
        
        useContact = Contact_Approvers__c.getValues('Use Contact Fields').Use_Contact__c; // checkbox from "Contact Approvers" Custom Setting
        
        // Validate Session, temporarily disabled until more user data from proxy 
        valid = UtilityMethods.validateSession(sID, uID);
        
        // Get related users from User record for Approval process
        if (uID != null && valid) {
            u = [select id, LAN_ID__c, Supervisor__c, Time_Keeper__c, Supervisor_2__c, Funding_official__c, Training_Officer__c from User where Session_Token__c = :sID];
            userName = UtilityMethods.getUserName(uID);
              //get related users from Contact fields for Approval process

              c = [select id, Name, LAN_ID__c, Supervisor__c, Time_Keeper__c, Supervisor_2__c, Funding_official__c, Training_Officer__c from Contact where LAN_ID__c = :u.LAN_ID__c];
	              supID = c.supervisor__c;
	              timekID = c.Time_Keeper__c;
	              sup2ID = c.Supervisor_2__c;
	              fundID = c.Funding_official__c;
	              trainID = c.Training_Officer__c;
        }
        return;
    }
    
    public PageReference validateOrRedirect() {
        // Log Header & Parameters
        UtilityMethods.logHeaders();
        // End Log Header & Parameters
        
        // Valid value from Verify Session call above
        if (!valid) {
            PageReference retURL = new PageReference('/');
            return retURL;
        }
        else { return null; }       
    }
    
    public pageReference save() {
        update u;
        
        c.supervisor__c = supID;
        c.Time_Keeper__c = timekID;
	    c.Supervisor_2__c = sup2ID;
	    c.Funding_official__c = fundID;
	    c.Training_Officer__c = trainID;
        update c;
        
        PageReference newPR = new PageReference('/ProfilePage');
        newPR.getParameters().clear();
        newPR.getParameters().put('sID', sID);
        newPR.setRedirect(true);
        return newPR;
    }
    
    public pageReference cancel() {
        PageReference newPR = new PageReference('/FormPage');
        newPR.getParameters().clear();
        newPR.getParameters().put('sID', sID);
        newPR.setRedirect(true);
        return newPR;
    }
    
}