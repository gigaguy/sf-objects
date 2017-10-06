public class TopicDownloadController {
	@AuraEnabled
    public static Map<String,Object> getAllSnippets(String topicId) {
        Map<String,Object> result = new Map<String,Object>();
        result.put('topic', [select Name,Topic_Number__c from Topic__c where id = :topicId]);
		result.put('snippets', [select Name,Submission__r.Commenter_Name__c,Submission__r.Letter_Type__c,Submission__r.Submission_Number__c,Submission__r.Agency_Name__c from Snippet__c where Topic__c = :topicId]);
        return result;
    }
}