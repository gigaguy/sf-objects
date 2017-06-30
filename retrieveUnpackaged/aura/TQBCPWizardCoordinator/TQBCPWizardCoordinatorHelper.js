({
	sendNotifyEmail : function(component, event, chairPersonSelectedId){

	   var action = component.get("c.sendNotifyEmail");
	   action.setParams({
	      "tqbChairPersonId": chairPersonSelectedId
	    });
	   action.setCallback(this, function(response) {
	      var state = response.getState();
	      if (component.isValid() && state === "SUCCESS") {
            console.log ("TQBCPWizardCoordinatorHelper : Email send  = " + response.getReturnValue());
            var result = response.getReturnValue();
	              $A.createComponents([
	                ["ui:message",{
	                  "title" : "Success :",
	                  "severity" : "confirm",
	                  "class" : "slds-size--1-of-2"
	                }],
	                ["ui:outputText",{
	                  "value" : result
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
	        } else if (state === "ERROR") {
	              var errors = response.getError();
	              console.log(errors[0]);
	              console.log(errors[0].message);
	              if (errors[0] && errors[0].pageErrors) {
	                $A.createComponents([
	                  ["ui:message",{
	                    "title" : "Error:",
	                    "severity" : "error",
	                    "class" : "slds-size--1-of-2"
	                  }],
	                  ["ui:outputText",{
	                    "value" : result
	                  }]
	                ],
	                function(components) {
	                  var message = components[0];
	                  var outputText = components[1];
	                  // set the body of the ui:message to be the ui:outputText
	                  message.set("v.body", outputText);
	                  component.set("v.messages", message);
	                  document.body.scrollTop = document.documentElement.scrollTop = 0;
	                } )
	              } else if (errors[0] && errors[0].message) {
	                    $A.createComponents([
	                      ["ui:message",{
	                        "title" : "Error:",
	                        "severity" : "error",
	                        "class" : "slds-size--1-of-2"
	                      }],
	                      ["ui:outputText",{
	                        "value" : errors[0].message
	                      }]
	                    ],
	                    function(components) {
	                      var message = components[0];
	                      var outputText = components[1];
	                      // set the body of the ui:message to be the ui:outputText
	                      message.set("v.body", outputText);
	                      component.set("v.messages", message);
	                      document.body.scrollTop = document.documentElement.scrollTop = 0;
	                    } )
	                 }
	             }
	    });
	    $A.enqueueAction(action);
	}
})