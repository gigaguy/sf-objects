({
	 selectUser : function(component, event, helper){      
    // get the selected Account from list  
      var getSelectAccount = component.get("v.panelMember");
    // call the event   
      var compEvent = component.getEvent("oSelectedUserEvent");
    // set the Selected Account to the event attribute.  
         compEvent.setParams({"userByEvent" : getSelectAccount });  
    // fire the event  
         compEvent.fire();
    },
})