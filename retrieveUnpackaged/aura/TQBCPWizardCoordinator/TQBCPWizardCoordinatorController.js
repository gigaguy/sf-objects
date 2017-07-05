({
	sendNotificationToChairPerson : function(component, event, helper){
	  var selectedItem = event.currentTarget;
        var chairPersonSelectedId = selectedItem.dataset.record;
        var personType='chair';
        console.log('Chairperson selected Id in TQBCPWizardCoordinator = '+ chairPersonSelectedId);
        helper.sendNotifyEmail(component, event, chairPersonSelectedId, personType);
	},
	sendNotificationToPanelPerson : function(component, event, helper){
	  var selectedItem = event.currentTarget;
        var panelPersonSelectedId = selectedItem.dataset.record;
        var personType='panel';
        console.log('panelPerson selected Id in TQBCPWizardCoordinator = '+ panelPersonSelectedId);
        helper.sendNotifyEmail(component, event, panelPersonSelectedId, personType);
	},
	deletePanelMemberController : function(component, event, helper) {
	  var selectedItem = event.currentTarget;
        var panelMemberSelectedId = selectedItem.dataset.record;
        console.log('Panel Member selected Id in deletePanelMemberController = '+ panelMemberSelectedId);
        helper.deletePanelMemberHelper(component, event, panelMemberSelectedId);
	},
      sendNotificationToAdhocMember : function(component, event, helper) {
        var getAllCheckboxes = component.find("checkBox");
        console.log('length of getAllCheckboxes '+ getAllCheckboxes.length);
        var selectedCheckbox,selectedCheckboxId,selectedCheckBoxCount =0;
        for (var i = 0; i < getAllCheckboxes.length; i++) {
           selectedCheckbox = getAllCheckboxes[i].get("v.value");
              if (selectedCheckbox == true) {
               selectedCheckBoxCount  = selectedCheckBoxCount+1;             
              }
        }
        if(selectedCheckBoxCount == 1){
            selectedCheckboxId = getAllCheckboxes[i].get("v.text");
            helper.sendNotifyEmail(component, event, selectedCheckboxId, 'adhoc');
        }
        else{
            $A.createComponents([
                ["ui:message",{
                  "title" : "Error :",
                  "severity" : "error",
                  "class" : "slds-size--1-of-2"
                }],
                ["ui:outputText",{
                  "value" : "Please select only 1 Adhoc Member from the approved list for this package."
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
        }
      }
})