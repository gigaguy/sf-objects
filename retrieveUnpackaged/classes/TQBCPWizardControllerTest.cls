//Developer :Naveen Sadhu
//Test cases for TQBCPWizardController apex server controller

@isTest
public class TQBCPWizardControllerTest {
    
    @isTest static void testGetCandidatePackage() {
        TestDataFactory.createLOIRecords(1);
        Test.startTest();               
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
        Test.stopTest();
        System.assert(cp.Id!=null);
    }        
    
     @isTest static void testSaveCandidatePackage() {
        TestDataFactory.createLOIRecords(1);
        Test.startTest();
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
          TQB_Candidate_Package__c cpSaved = TQBCPWizardController.saveCandidatePackage(cp);
        Test.stopTest();
        System.assert(cpSaved.Id!=null);
    }
    
    @isTest static void testCreateCandidatePackage() {
        
        TestDataFactory.createLOIRecords(1);
        Test.startTest();  
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
        Test.stopTest();
        System.assert(newCP.Id!=null);  
        System.assert(cp.Id!=null);
    }
    
    @isTest static void testvalidateCandidateQuestionnaireTrue() {
        TestDataFactory.createLOIRecords(1);
        Test.startTest();  
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
          TestDataFactoryCPWizard.createCPQuestions(1,cp.Id);
          TQBCPWizardController.validateCandidateQuestionnaire(cp.Id);
        Test.stopTest();        
    }
    /*
    @isTest static void testvalidateCandidateQuestionnaireFalse() {
        String errorMessage;
        try{
             TestDataFactory.createLOIRecords(1);
            Test.startTest();  
              TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
              TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
              TestDataFactoryCPWizard.createCPQuestions(1,cp.Id);
              TQBCPWizardController.validateCandidateQuestionnaire(cp.Id);
              TQBCPWizardController.submitCandidatePackage(cp.Id);
            Test.stopTest();   
        }
        catch(DMLException e) {
            System.debug(e.getDmlMessage(0));
           errorMessage = e.getDmlMessage(0);
        }
        System.assertEquals(errorMessage,'null');
    }*/
    
     @isTest static void testGetCandidateLOI() {
         TestDataFactory.createLOIRecords(1);
        Test.startTest();  
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
          TQB_Letter_of_Intent__c LOI = TQBCPWizardController.getCandidateLOI(cp.Id);
        Test.stopTest();
         System.assert(LOI.Id!=null);      
     }
    
     @isTest static void testGetUserRole() {
         Test.startTest();  
             User loggedInUserRole = TQBCPWizardController.getUserRole();
         Test.stopTest();
         System.assert(loggedInUserRole.UserRole.Name!=null);
     }
    
    @isTest static void testsaveQuest() {
        TestDataFactory.createLOIRecords(1);
        Test.startTest();  
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
          List<TQB_Candidate_Questionnaire__c> questionlist = TestDataFactoryCPWizard.createCPQuestions(1,cp.Id);
          questionlist[0].Answer__c = 'update salesforce';
           TQB_Candidate_Questionnaire__c savedQuestion = TQBCPWizardController.saveQuest(cp.Id, questionlist[0]);
        Test.stopTest();   
         System.assertEquals(savedQuestion.Answer__c,'update salesforce');
    }
    
     @isTest static void testGetCandidateQuestions() {
          TestDataFactory.createLOIRecords(1);
          Integer questionCount = TestDataFactoryCPWizard.getQuestionsByTrack();
         Test.startTest();  
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
          List<TQB_Candidate_Questionnaire__c> questionlist = TQBCPWizardController.getCandidateQuestions(cp.Id);
         Test.stopTest();   
         System.assertEquals(questionlist.size(),questionCount);
     }
     
    @isTest static void testSaveQuestionCommentServer() {
        TestDataFactory.createLOIRecords(1);
         Test.startTest();  
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
           List<TQB_Candidate_Questionnaire__c> questionlist = TestDataFactoryCPWizard.createCPQuestions(1,cp.Id);
           String comment = TQBCPWizardController.saveQuestionCommentServer('hello', 'firstLineSupComment', cp.Id, questionlist[0].Id);
           String updatedComment = TQBCPWizardController.saveQuestionCommentServer('hello Updated', 'firstLineSupComment', cp.Id, questionlist[0].Id);
         Test.stopTest(); 
         System.assertEquals(comment,'hello');
         System.assertEquals(updatedComment,'hello Updated');
    }
    
    
    @isTest static void testPopulateQuestionCommentsServer() {
        TestDataFactory.createLOIRecords(1);
         Test.startTest();  
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
           List<TQB_Candidate_Questionnaire__c> questionlist = TestDataFactoryCPWizard.createCPQuestions(1,cp.Id);
           String comment = TQBCPWizardController.saveQuestionCommentServer('hello', 'firstLineSupComment', cp.Id, questionlist[0].Id);
           String populatedComment = TQBCPWizardController.populateQuestionCommentsServer(cp.Id , 'firstLineSupComment', questionlist[0].Id);
         Test.stopTest();
        System.assertEquals(comment, populatedComment);
    }
    
    @isTest static void testSaveAdHocEntry() {
        TestDataFactory.createLOIRecords(1);
         Test.startTest();  
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
          List<TQB_Ad_Hoc_Entry__c> adhocList = TestDataFactoryCPWizard.createCPAdhocs(1,cp.Id);
          TQB_Ad_Hoc_Entry__c adhocEntry = TQBCPWizardController.saveAdHocEntry(cp.Id, adhocList[0], 'insert');
         Test.stopTest();
         System.assert(adhocEntry.Id!=null);
    }
    
    @isTest static void testdeleteAdHoc() { 
        TestDataFactory.createLOIRecords(1);
         Test.startTest();  
          TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
          TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);
          List<TQB_Ad_Hoc_Entry__c> adhocList = TestDataFactoryCPWizard.createCPAdhocs(1,cp.Id);
          TQB_Ad_Hoc_Entry__c adhocEntrySaved = TQBCPWizardController.saveAdHocEntry(cp.Id, adhocList[0], 'insert');
          TQB_Ad_Hoc_Entry__c adhocEntryDeleted = TQBCPWizardController.deleteAdHoc(adhocList[0]);
         Test.stopTest();
         System.debug('saved Entry = ' + adhocEntrySaved.Id);
         System.debug('deleted Entry = ' + adhocEntryDeleted.Id);
         System.assertEquals(adhocEntrySaved.Id, adhocEntryDeleted.Id);
    }
    
    @isTest static void testGetCandidateAdHocEntries() { 
         Test.startTest();  
          Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
          List<TQB_Ad_Hoc_Entry__c> adhocList = TestDataFactoryCPWizard.createCPAdhocs(1,candpkgId);
          TQB_Ad_Hoc_Entry__c adhocEntrySaved = TQBCPWizardController.saveAdHocEntry(candpkgId, adhocList[0], 'insert');
          List<TQB_Ad_Hoc_Entry__c> getAdhocList = TQBCPWizardController.getCandidateAdHocEntries(candpkgId);
         Test.stopTest();
        System.assertEquals(adhocList.size(), getAdhocList.size());
    }  
    
     @isTest static void testSaveAdHocCommentServer() { 
          
         String testValue = 'hello';
         Test.startTest();  
          Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
          TQBCPWizardController.saveAdHocCommentServer(testValue,'firstLineSupComment', candpkgId);
          String commentValue = TQBCPWizardController.populateAdHocCommentsServer(candpkgId,'firstLineSupComment');
         Test.stopTest();
         System.debug('commentvalue = '+ commentValue);
         System.assertEquals(testValue, commentValue);
     }
   
    @isTest static void testSaveReviewCommentAndReturn() { 
         String testValue = 'hello';
         Test.startTest();  
          Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
          List<TQB_Comment__c> commentList = TestDataFactoryCPWizard.createCPComments(1, candpkgId);
          TQBCPWizardController.saveReviewCommentAndReturn(candpkgId, commentList[0]);
          List<TQB_Comment__c> commentListretrieved = TQBCPWizardController.getReviewComments(candpkgId);
         Test.stopTest();
        System.debug('commentList size is ='+commentList);
        System.debug('commentListretrieved size is ='+commentListretrieved.size());
        System.assertEquals(commentList.size(), commentListretrieved.size());
   }
    
    @isTest static void testSaveReviewCommentAndReject() { 
         String testValue = 'hello';
         Test.startTest();  
              Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
              List<TQB_Comment__c> commentList = TestDataFactoryCPWizard.createCPComments(1, candpkgId);
              TQBCPWizardController.saveReviewCommentAndReject(candpkgId, commentList[0],'rejected');
              List<TQB_Comment__c> commentListretrieved = TQBCPWizardController.getReviewComments(candpkgId);
         Test.stopTest();
        System.debug('commentList size is ='+commentList.size());
        System.debug('commentListretrieved size is ='+ commentListretrieved.size());
        System.assertEquals(commentList.size(), commentListretrieved.size());
   }
    
    @isTest static void testGetReviewComments() { 
        Test.startTest(); 
           Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
           List<TQB_Comment__c> commentList = TestDataFactoryCPWizard.createCPReviewComments(1, candpkgId);
            TQBCPWizardController.saveReviewCommentAndReject(candpkgId, commentList[0],'rejected');
           List<TQB_Comment__c> commentListretrieved = TQBCPWizardController.getReviewComments(candpkgId);
        Test.stopTest();
        System.assertEquals(commentList.size(), commentListretrieved.size());
    }
    
    @isTest static void testGetCPStatusPickListValues() { 
        Test.startTest(); 
           Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
           List<String> pickListValueStatuses = TQBCPWizardController.getCPStatusPickListValues();
        Test.stopTest();
        System.assertEquals(pickListValueStatuses.size(),9);
    }
    
    @isTest static void testGetStatePickListValues() { 
         TestDataFactory.createLOIRecords(1);
        Test.startTest(); 
           List<String> pickListValuesState = TQBCPWizardController.getStatePickListValues();
        Test.stopTest();
        System.assertEquals(pickListValuesState.size(),52);
    }
    
    @isTest static void testGet1stLineSupCurrentValue() {
         
        Test.startTest(); 
           Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
           Id id =  TQBCPWizardController.get1stLineSupCurrentValue(candpkgId);
        Test.stopTest();
         System.assert(id != null);
    }
    
    @isTest static void testGetCPAttachTypePickListValues() {
         Test.startTest(); 
            Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
            List<String> fileTypeCandidate = TQBCPWizardController.getCPAttachTypePickListValues('candidate');
            List<String> fileTypeReviewer = TQBCPWizardController.getCPAttachTypePickListValues('reviewer');
         Test.stopTest();
        System.assertEquals(fileTypeCandidate.size(), 10);
        System.assertEquals(fileTypeReviewer.size(), 2);
    }
    
     @isTest static void testGetRejectReasonValues() {
          Test.startTest(); 
             Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
            List<String> rejectReasonValues = TQBCPWizardController.getRejectReasonValues();
          Test.stopTest();
         System.assertEquals(rejectReasonValues.size(), 8);
     }
    /*
    @isTest static void testGetTQBChairPersonList() {
        Test.startTest();
          List<User> tqbChairUsersCreated = TestDataFactory.createTQBChairUser();
          List<User> tqbChairUsers = TQBCPWizardController.getTQBChairPersonList();
        Test.stopTest();
        System.debug('tqbChairUsersCreated Created'+ tqbChairUsersCreated.size());
        System.debug('tqbChairUsers Created'+ tqbChairUsers.size());
        System.assertEquals(tqbChairUsersCreated.size(), tqbChairUsers.size());
    }*/
    
    @isTest static void testGetTQBCoordinatorEmailNotification() {
        Test.startTest(); 
           Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
            Boolean result = TQBCPWizardController.getTQBCoordinatorEmailNotification(candpkgId);
        Test.stopTest();
        System.debug('value of email result'+result);
        System.assertEquals(false, result);
    }
        
   @isTest static void testSetTQBPanelMembersList() {
       User user = TestDataFactory.createUser();
       Test.startTest(); 
          Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
          List<User> panelMembers = TQBCPWizardController.setTQBPanelMembersList(candpkgId, user);
       Test.stopTest();
       System.assertEquals(1, panelMembers.size());
    }
    
   @isTest static void testGetTQBPanelMembersList() {
       User user = TestDataFactory.createUser();
       Test.startTest(); 
          Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
          List<User> setPanelMembers = TQBCPWizardController.setTQBPanelMembersList(candpkgId, user);
          List<User> getPanelMembers = TQBCPWizardController.getTQBPanelMembersList(candpkgId);
       Test.stopTest();
       System.assertEquals(setPanelMembers.size(), getPanelMembers.size());
    }
    
    
    @isTest static void testDeleteSelectedPanelMember() {
        User user = TestDataFactory.createUser();
        Test.startTest(); 
          Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();
          List<User> setPanelMembers = TQBCPWizardController.setTQBPanelMembersList(candpkgId, user);
          List<User> getPanelMembers = TQBCPWizardController.getTQBPanelMembersList(candpkgId);
          Boolean deleteResult = TQBCPWizardController.deleteSelectedPanelMember(candpkgId, user.Id);
        Test.stopTest();
        System.assert(deleteResult);
    }
    
    @isTest static void testGetTQBChairPersonName() {
       Test.startTest();
          Id candpkgId  =  TQBCPWizardControllerTest.createCandidatePackage();       
          String chairPersonName = TQBCPWizardController.getTQBChairPersonName(candpkgId);
       Test.stopTest();
        System.debug('value of chair person name' + chairPersonName);
         System.assertEquals(chairPersonName, 'TQB_Chair');
    }
    
    @isTest static void testGetUserFromUserId() {
        
    }
    
    public static Id createCandidatePackage() {
        
        TestDataFactory.createLOIRecords(1);
        TQB_Candidate_Package__c newCP = TQBCPWizardController.createCandidatePackage();
        TQB_Candidate_Package__c cp = TQBCPWizardController.getOrCreateCandidatePackage(newCP.Id);        
        cp.TQB_Chair_Person_Name__c = 'TQB_Chair';
        upsert cp;
       return cp.Id;         
    }
    
    
    
}