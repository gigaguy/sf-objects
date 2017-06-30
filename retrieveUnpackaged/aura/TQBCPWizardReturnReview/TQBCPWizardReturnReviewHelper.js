({
	populateCandidatePackage : function(component, event) {        
		var action = component.get("c.getCandidatePackage");
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (component.isValid() && state === "SUCCESS") {
				component.set("v.candPackage", response.getReturnValue());
				//var evt = $A.get("e.c:TQBCPAttachNavigator");
				//evt.setParams({ "candpkg": component.get("v.candPackage")});
				//evt.fire();
			}
		});
		$A.enqueueAction(action);
	},

	populateCandidateLOI : function(component, event) {
		var action = component.get("c.getCandidateLOI");
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (component.isValid() && state === "SUCCESS") {
				component.set("v.candLOI", response.getReturnValue());
			}
		});
		$A.enqueueAction(action);
	}
})