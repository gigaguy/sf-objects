trigger TESTTRIG on TEST__c (before update) {
    
    
    ID sessionID = UserInfo.getSessionId();
    ID sessionPermSetId;
    
    try{
        SessionPermSetActivation dur = [select id from SessionPermSetActivation where AuthSessionId =: sessionID limit 1];
        system.debug('found');
        delete dur;
    }catch(exception e){system.debug('none?');}
    
    Test__c a = Trigger.new[0];
    if(a.Name == 'a')
        sessionPermSetId = '0PSr00000000TOIGA2';
    else
        sessionPermSetId = '0PSr00000000TOhGAM';
    
    SessionPermSetActivation activation = new SessionPermSetActivation();
    activation.AuthSessionId = sessionId;
    activation.PermissionSetId = sessionPermSetId;
    activation.Description = 'created by SessionPermSetActivationController';
    
    insert activation;


}