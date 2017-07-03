public class UtilityMethods { 

    public static string getSessionID() {
        string sessionID;
        sessionID = ApexPages.currentPage().getParameters().get('sID');
        return sessionID;
    }

    public static string getUserID(String sessionID) {
        string userID;
        if (sessionID != null) {
            User u = [select id from User where Session_Token__c = :sessionID];
            if (u != null) {
                userID = u.ID;
            } 
        } 
        return userID;
    }
    
    public static string getUserName(String userID) {
        string userName;
        if (userID != null) {
            User u = [select id, FirstName, LastName from User where id = :userID];
            if (u != null) {
                userName = u.FirstName + ' ' + u.LastName;
            } 
        } 
        return userName;
    }
    
    public static boolean validateSession(String sessionID, string userID) {    
        User u = [select id, Session_Token__c, Session_IP__c, Session_Environment__c, Session_Timestamp__c from User where id = :userID AND Session_Token__c = :sessionID];
		// Check that the IP address and user environment is the same as when the session was created, and that the session is less than 12 hours old
        if (u.Session_IP__c == ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP') &&
        		u.Session_Environment__c == ApexPages.currentPage().getHeaders().get('User-Agent') &&
           		u.Session_Timestamp__c.addHours(12) > System.now()) {
            return true;
        }
        // Return false unless all elements validate
        return false;
    }
    
}