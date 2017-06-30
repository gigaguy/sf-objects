// Developer: Chris Alley
// Purpose: TQBCPWizardAttach - sub component to allow user to add
// attachments and stay on same page.
({
    doInit : function(component, event, helper) {
        //helper.hideSupComments(component, event, helper);        
        helper.populateCandidatePackage(component, event);
       // helper.populateCandidateLOI(component, event);
        helper.populatePackageAttachmentTypes(component, event);
    },
    
    createAddAttachment : function(component, event, helper) {
        var pkg = component.get("v.candPackage");
        var selectedContentType = component.find("InputSelectDynamic").get("v.value");
        var evt = $A.get("e.c:TQBCPNewAttachment");
        evt.setParams({ "candpkg": pkg });
        evt.fire();
    },
    
    save : function(component, event, helper) {
        helper.save(component, event);
    },
    
    goToAttach : function(component, event, helper) {
         var evt = $A.get("e.c:TQBCPAttachNavigator");
		 evt.setParams({ "candpkg": component.get("v.candPackage")});
		 evt.fire();
    }
    
})