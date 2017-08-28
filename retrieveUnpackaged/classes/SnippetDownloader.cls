public class SnippetDownloader {
    
    public Map<String,String> requests { get; set; }
    public List<Snippet__c> snippets {get; set;}
    
	public Id Id { get; set; }
    public Snippet__c snippet { get; set; }
    public String userText = '';
    
    public SnippetDownloader(ApexPages.StandardController standardController)
    {                        
        snippet = (Snippet__c) standardController.getRecord();
        Id = snippet.Id;
       /*
        System.debug('recordId = '+Id);
        List<Snippet__c> snippets = [SELECT Extracted_Text__c FROM Snippet__c WHERE Id =: Id];
        if(snippets.size() > 0){
            snippet = snippets[0];
            userText = snippet.Extracted_Text__c;
        }     	
        requests = new Map<String,String>();
        System.debug(userText);
        requests.put('userText', userText); 
        System.debug('SC '+requests);
	  */
        requests = new Map<String,String>();
    }
  
    public SnippetDownloader()
    {
    	 
        requests = new Map<String,String>(); 
        /*
        requests.put('Two', 'As a result of changes made to the preamble and final rule prior to signature, and due to the volume of comments received, some responses in the Response to Comments Document may not reflect the language in the preamble and final rule in every respect. Where the response is in conflict with the preamble or the final rule, the language in the final preamble and rule controls and should be used for purposes of understanding the scope, requirements, and basis of the final rule. In addition, due to the large number of comments that addressed similar issues, as well as the volume of the comments received, the Response to Comments Document does not always cross-reference each response to the commenter(s) who raised the particular issue involved. The responses presented in this document are intended to augment the responses to comments that appear in the preamble to the final rule or to address comments not discussed in that preamble. Although portions of the preamble to the final rule are paraphrased in this document where useful to add clarity to responses, the preamble itself remains the definitive statement of the rationale for the revisions adopted in the final rule. In many instances, particular responses presented in the Response to Comments Document include cross references to responses on related issues that are located either in the preamble to the Clean Water Rule, the Technical Support Document, or elsewhere in the Response to Comments Document. All issues on which the agencies are taking final action in the Clean Water Rule are addressed in the Clean Water Rule rulemaking record.');
        requests.put('Three', 'Accordingly, the Response to Comments Document, together with the preamble to the Clean Water Rule and the information contained in the Technical Support Document, the Science Report, and the rest of the administrative record should be considered collectively as the agencies response to all of the significant comments submitted on the proposed rule. The Response to Comments Document incorporates directly or by reference the significant public comments addressed in the preamble to the Clean Water Rule as well as other significant public comments that were submitted on the proposed rule.');
        requests.put('Four', 'This compendium, as part of the Response to Comments Document, provides a compendium of the technical comments about general matters including state and tribal authorities submitted by commenters. Comments have been copied into this document as is with no editing or summarizing. Footnotes in regular font are taken directly from the comments.');        
		*/
		// Download all Snippets
		snippets = [SELECT Submission_Number__c,Response__c,Submission__c,Document_Number__c,Name,Topic__c,Topic__r.Name,Extracted_Text__c,Topic__r.Topic_Number__c FROM Snippet__c ORDER BY Topic__r.Topic_Number__c ASC];		
    }
         
	public PageReference printView() {
        
     requests.put('userText', userText);         
     System.debug('PV -'+requests); 
   	 PageReference oPageRef = Page.DemoWordGeneration;
     oPageRef.setRedirect(false);
     return oPageRef;
	}
}