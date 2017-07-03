public class AuthLanding { 
    private map<string,String> headers;
    private map<string, string> params;
    private string UID;

    private user u;
    private string sessionID;
    private string sessionIP;
    private string sessionTimeStamp;
    private string sessionEnvironment;
    
    private HeaderLog__c hl;
    private string userIP;

    public AuthLanding(){
        UID = '';
        // Get headers and parameters from the page
        headers = ApexPages.currentPage().getHeaders();
        params = ApexPages.currentPage().getParameters();

        // Check for user identification from WAM headers
        if (headers.containsKey('uid')) UID = headers.get('uid');
        else if (headers.containsKey('AUTH_USER')) UID = headers.get('AUTH_USER');
        else if (headers.containsKey('REMOTE_USER')) UID = headers.get('REMOTE_USER');

        // Manual override URL parameter for testing, will be removed once deployed
        if (params.containsKey('UID')) uId = params.get('UID');
        
        // Set any found user identification to lowercase for comparison to user object
        UID = UID.toLowerCase();
    }

    public PageReference onLoad() {
        // Log Header & Parameters
        string headerString = '';
        string paramString = '';
        string pageURL = '';
        pageURL = ApexPages.currentPage().getURL();
        paramString = 'getURL=' + pageURL + '\n';
       	paramString += 'externalForm=' + System.URL.getSalesforceBaseUrl().toExternalForm() + '\n';
        paramString += 'currentRequest=' + System.URL.getCurrentRequestUrl() + '\n';
        paramString += 'file=' + System.URL.getCurrentRequestUrl().getFile() + '\n';
        paramString += 'host=' + System.URL.getCurrentRequestUrl().getHost() + '\n';
        paramString += 'host=' + System.URL.getCurrentRequestUrl().getPath() + '\n';
        paramString += 'port=' + System.URL.getCurrentRequestUrl().getPort() + '\n';
        paramString += 'protocol=' + System.URL.getCurrentRequestUrl().getProtocol() + '\n';
        paramString += 'query=' + System.URL.getCurrentRequestUrl().getQuery() + '\n';
        paramString += 'ref=' + System.URL.getCurrentRequestUrl().getRef() + '\n';
        for (string key : headers.keySet() ){
            headerString += key;
            headerString += '=';
            headerString += headers.get(key);
            headerString += '\n';
        }
        for (string key : params.keySet() ){
            paramString += key;
            paramString += '=';
            paramString += params.get(key);
            paramString += '\n';
        }
        hl = new HeaderLog__c(HeaderDump__c = headerString, ParamDump__c = paramString);
        insert hl;
        // End Log Header & Parameters
        
        // If user identification is present
        if (UID != '') {
            //find contact/user
            u = findUser();
            
            // If a user is found with the matching federation id, generate session and store information about the users environment
            if (u != null) {
                // Generate sessionID and store on user record
           		sessionID = generateSessionID(20);
                u.Session_Token__c = sessionId;
                
                // Get and store information about the users IP address (if available), browser and current timestamp
                if (headers.get('X-Salesforce-SIP') != null) { u.Session_IP__c = headers.get('X-Salesforce-SIP'); }
                else { u.Session_IP__c = 'not available'; }
                u.Session_Environment__c = headers.get('User-Agent');
                u.Session_Timestamp__c = System.now();
            	
                update u;
    			
                // Redirect user to the form page with the new session ID set
                PageReference newPR = new PageReference('https://oeiodsta-oeiodstadev.cs33.force.com/FormPage');
                newPR.getParameters().put('sID', sessionID);
                //newPr.setRedirect(true);
                return newPR;
            } // End if (u != null)
        } // End if (UID != '') 
        return null;
    } // End onLoad()

    private User findUser(){
        User u = [select id from User where FederationIdentifier = :UID limit 1];
        return u;
    }

    private String generateSessionID(Integer sessionIDLength) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String sessionID = '';
        while (sessionID.length() < sessionIDLength) {
           Integer index = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           sessionID += chars.substring(index, index+1);
        }
        return sessionID; 
    }
    
}