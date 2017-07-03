public class FormPageVFController { 
    public string sID {get;set;}
    public boolean valid {get;set;}
    public id uID {get;set;}
    public string userName {get;set;}

    public FormPageVFController() {
        valid = true;
        sID = UtilityMethods.getSessionID();
        uID = UtilityMethods.getUserID(sID);
        
        // Validate Session
        //valid = UtilityMethods.validateSession(sID, uID);
        
        if (uID != null && valid) {
            valid = true;
            userName = UtilityMethods.getUserName(uID);
        }
        return;
    }
    
    public PageReference validateOrRedirect() {
        if (!valid) {
            PageReference retURL = new PageReference('/');
     		return retURL;
        }
        else { return null; }       
 	}
    
}