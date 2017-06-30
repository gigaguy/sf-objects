({
	selectedPanelMembers : function(component, event, checkedPanelMembersCount) {
		var action = component.get("c.setSelectedPanelMembers");
	    action.setParams({
	      "candPkgId": component.get("v.candPackage.Id") ,
	      "checkedPanelMembersCount" : checkedPanelMembersCount,
	       "checkedPanelMembersName" : component.get("v.checkedPanelMembersName")
	    });
	    action.setCallback(this, function(response) {
	    	var state = response.getState();
	       if (component.isValid() && state === "SUCCESS") {
				console.log("value of response from server in TQBCPWizardChairPersonHelper", response.getReturnValue());
			} else if (state === "ERROR") {
				console.log('Error from server');
			}
		});
	  $A.enqueueAction(action);	    
	},

	updatePanelMemberTable : function(component, event) {

		console.log('TQBCPWizardChairPersonHelper:updatePanelMemberTable' + component.get("v.selectedRecord"));
       
       var action = component.get("c.getTQBPanelMembersList");
	    action.setParams({
	      "candPkgId": component.get("v.candPackage.Id") ,
	      "user" : component.get("v.selectedRecord")
	    });
	    action.setCallback(this, function(response) {
	    	var state = response.getState();
	       if (component.isValid() && state === "SUCCESS") {
				console.log("value of response from server in TQBCPWizardChairPersonHelper", response.getReturnValue());
				component.set("v.listOfTQBPanelMembers", response.getReturnValue());
			} else if (state === "ERROR") {
				console.log('Error from server');
			}
		});
	  $A.enqueueAction(action);


	}
})