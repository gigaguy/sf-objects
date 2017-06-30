({
	
	getSelectedPanelMembers : function(component, event, helper) {
    
     var checkedPanelMembersName= [];
     //Get all the checkboxes
     var getAllCheckboxes = component.find("panelCheckbox");
     console.log('get all checkboxes'+ getAllCheckboxes.length);

     var checkedPanelMembersCount = 0;

      for (var i = 0; i < getAllCheckboxes.length; i++) {
		   if (getAllCheckboxes[i].get("v.value") == true) {
		   	checkedPanelMembersCount += 1;
		    checkedPanelMembersName.push(getAllCheckboxes[i].get("v.text"));
		    }
       }
       component.set("v.checkedPanelMembersName", checkedPanelMembersName);
       //Minimum of three panel members have to be selected
       if(checkedPanelMembersCount < 3) {
          $A.createComponents([
	                ["ui:message",{
	                  "title" : "Error :",
	                  "severity" : "error",
	                  "class" : "slds-size--1-of-2"
	                }],
	                ["ui:outputText",{
	                  "value" : "Please select minimum of 3 Panel Members"
	                }]
	              ],
	              function(components) {
	                var message = components[0];
	                var outputText = components[1];
	                // set the body of the ui:message to be the ui:outputText
	                message.set("v.body", outputText);
	                component.set("v.messages", message);
	                document.body.scrollTop = document.documentElement.scrollTop = 0;
	                window.setTimeout(
	                  $A.getCallback(function() {
	                    component.set("v.messages", []);
	                  }), 5000
	                );
	              } );
          return;
        }
       console.log('count of checked panel members'+ checkedPanelMembersCount);
       console.log('Selected Panel Members List:'+ checkedPanelMembersName);
       helper.selectedPanelMembers(component, event, checkedPanelMembersCount, checkedPanelMembersName);
	},

	handlePanelMember : function(component, event, helper) {

		console.log('Inside the handle panel member');
     
       var selectedPanelMemberFromEvent = event.getParam("userByEvent");
	   component.set("v.selectedRecord" , selectedPanelMemberFromEvent); 
       
       var panelMembers = component.get("v.listOfTQBPanelMembers");
       
       if(panelMembers.length <= 5) {
       	 helper.updatePanelMemberTable(component, event);
       }
       else{
         helper.alertMessage(component, event);
       }
	},

	deletePanelMemberController : function(component, event, helper) {
	  var selectedItem = event.currentTarget;
      var panelMemberSelectedId = selectedItem.dataset.record;
      console.log('Panel Member selected Id in deletePanelMemberController = '+ panelMemberSelectedId);
      helper.deletePanelMemberHelper(component, event, panelMemberSelectedId);
	},

	notifyCoordinator : function(component, event, helper) {

	var panelMembers = component.get("v.listOfTQBPanelMembers");
	console.log('count of panel Members'+ panelMembers.length);
       if(panelMembers.length < 3 || panelMembers.length > 5 )  
       	  helper.alertMessage(component, event);
       else      
		  helper.sendNotifyEmail(component, event); 
	}
})