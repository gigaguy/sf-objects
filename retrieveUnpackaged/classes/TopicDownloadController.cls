public class TopicDownloadController {
	@AuraEnabled
    public static Map<String,Object> getAllSnippets(String topicId) {
        Map<String,Object> result = new Map<String,Object>();
        // get topic number for the selected topic
        List<Topic__c> topics = [select Name,Topic_Number__c from Topic__c where id = :topicId];
        if(topics.size() > 0){
			Topic__c topic = topics[0];
            List<Topic__c> relatedTopicIds = TopicDownloadController.getAllRelatedTopic(topic.Topic_Number__c);
       	 	result.put('topic', topic);
			result.put('snippets', [select Name,Topic__r.Name,Submission__r.Commenter_Name__c,Submission__r.Letter_Type__c,Submission__r.Submission_Number__c,Submission__r.Agency_Name__c from Snippet__c where Topic__c in :relatedTopicIds]);            
        }
        return result;
    }
    
    @AuraEnabled
    public static TopicsWrapper getSnippets(String topicId, Decimal pageNumber) {

        TopicsWrapper topicsResult = new TopicsWrapper();
        topicsResult.isLastPage = pageNumber>=5;
        return topicsResult;
    }
    
    public static List<Topic__c> getAllRelatedTopic(String topicNumber){
        String topicPattern = '';
		List<String> stringComponents = topicNumber.split('\\.');
        if(stringComponents.size() > 0){
            String parentNumber = stringComponents[0];
            topicPattern =  parentNumber + '.%';
            String pattern2 = parentNumber + ' %';		
            return [select Id from Topic__c where Name like : topicPattern OR Name like : pattern2];
        }
        else{
			topicPattern = topicNumber+' %';
            return [select Id from Topic__c where Name like : topicPattern];
        }               
    }
    
    public class TopicsWrapper{
        @AuraEnabled public Integer pageSize {get;set;}
    	@AuraEnabled public Integer page {get;set;}
	    @AuraEnabled public Integer total {get;set;}
        @AuraEnabled public Boolean isLastPage {get;set;}
	    @AuraEnabled public List<SObject> snippets {get;set;}
    }
    public class SnippetWrapper{
        @AuraEnabled public Integer pageSize {get;set;}
    	@AuraEnabled public Integer page {get;set;}
	    @AuraEnabled public Integer total {get;set;}	    
    }
}