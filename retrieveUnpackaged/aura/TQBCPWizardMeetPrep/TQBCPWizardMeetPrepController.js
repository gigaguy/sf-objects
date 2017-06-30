({
	populateMeetPrep : function(component, event, helper) {
		var candpkg = event.getParam("candpkg");
		component.set("v.candPackage",candpkg);

		helper.populateCandidateLOI(component, event);
	    helper.getloggedInUserRole(component, event);
	    helper.getTQBChairPersonList(component, event);
	    //helper.getTQBPanelMembersList(component, event);
	}
})