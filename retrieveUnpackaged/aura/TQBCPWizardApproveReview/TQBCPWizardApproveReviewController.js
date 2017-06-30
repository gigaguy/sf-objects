({
	doInit : function(component, event, helper) {
		//var toggleText = component.find("adHocEditView"); //hide ad hoc new entry
		//$A.util.addClass(toggleText,'toggle');
		helper.showHideAddAttachment(component, event);
		//helper.hideSupComments(component, event);
		//helper.populateCandidatePackage(component, event);
		//helper.populateCandidateLOI(component, event);
		helper.populateAttachments(component, event);
    helper.getloggedInUserRole(component, event);
    component.set("v.messages", []);
		document.body.scrollTop = document.documentElement.scrollTop = 0;
	},
    cancelApproveReview : function(component, event, helper) {
        var evt = $A.get("e.c:TQBCPSummaryNavigator");
		evt.setParams({ "candpkg": component.get("v.candPackage")});
		evt.fire();
    },
	submitApproveReview : function(component, event, helper) {
        component.set("v.messages", []);
  		var action = component.get("c.saveReviewCommentAndApprove");
			action.setParams({
				"candidatePackageId" : component.get("v.candPackage.Id"),
				"reviewComment": component.get("v.newComment"),
				"userRole": component.get("v.loggedInUserRole.UserRole.Name")
			});
	      //Error handling and messaging to the user interface so users know if the comment was saved
      //successfully.
			action.setCallback(this, function(response) {
				var state = response.getState();
				if (state === "SUCCESS") {
					//var toggleText = component.find("ListAttachmentView"); //hide
                   // $A.util.addClass(toggleText,'toggle');
                    var toggleText = component.find("addAttachmentView"); //hide
                    $A.util.addClass(toggleText,'toggle');

					$A.createComponents([
						["ui:message",{
							"title" : "Success :",
							"severity" : "confirm",
							"class" : "slds-size--1-of-2"
						}],
						["ui:outputText",{
							"value" : "Candidate package has been approved. You will now be transferred to the home page."
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
								var urlEvent = $A.get("e.force:navigateToURL");
							  urlEvent.setParams({
									"url": 'https://epaoei--ord.lightning.force.com/one/one.app#/home'
								});
								urlEvent.fire();
							}), 5000
						);
					} )
				} else if (state === "ERROR") {
					var errors = response.getError();
					console.log(errors[0]);
					console.log(errors[0].message);
					if (errors[0] && errors[0].pageErrors) {
						$A.createComponents([
							["ui:message",{
								"title" : "Error:",
								"severity" : "error",
								"class" : "slds-size--2-of-3"
							}],
							["ui:outputText",{
								"value" : errors[0].pageErrors[0].message
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
						} )
					} else if (errors[0] && errors[0].message) {
						$A.createComponents([
							["ui:message",{
								"title" : "Error:",
								"severity" : "error",
								"class" : "slds-size--2-of-3"
							}],
							["ui:outputText",{
								"value" : errors[0].message,
								"aura:id" : "msgTextId"
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
						} )
					}
				}
			});
			$A.enqueueAction(action);

	},

	addNewAttachment : function(component, event, helper) {

		var pkg = component.get("v.candPackage");
		var evt = $A.get("e.c:TQBCPNewAttachment");
		evt.setParams({ "candpkg": pkg });
		evt.fire();
	},

	// View the attachment.
	viewAttachment : function(component, event, helper) {
		helper.viewAttachment(component, event);
	},


	// Deletes the attachment.
	deleteAttachment : function(component, event, helper) {
		helper.deleteAttachment(component, event);
	},

	showHideAddAttachment : function(component, event, helper) {
		var toggleText = component.find("ListAttachmentView");
		$A.util.addClass(toggleText,'toggle');
		var toggleText = component.find("addAttachmentView");
		$A.util.removeClass(toggleText,'toggle');
	},



	populateCandidatePackage : function(component, event) {
		var action = component.get("c.getCandidatePackage");
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (component.isValid() && state === "SUCCESS") {
				component.set("v.candPackage", response.getReturnValue());
			}
		});
		$A.enqueueAction(action);
	},

	populateAllAttachment : function(component, event, helper) {
		helper.populateAttachments(component, event);
        component.set("v.messages", []);
	},

	save : function(component, event, helper) {
		helper.save(component, event);
	},

	waiting: function(component, event, helper) {
		$A.util.addClass(component.find("uploading").getElement(), "uploading");
		$A.util.removeClass(component.find("uploading").getElement(), "notUploading");
	},

	doneWaiting: function(component, event, helper) {
		$A.util.removeClass(component.find("uploading").getElement(), "uploading");
		$A.util.addClass(component.find("uploading").getElement(), "notUploading");
	},

	goToQuestionnaire : function(component, event, helper) {
		var pkg = component.get("v.candPackage");
		var evt = $A.get("e.c:TQBCPQuestionNavigator");
		evt.setParams({ "candpkg": pkg });
		evt.fire();
	},

	goToAdHoc : function(component, event, helper) {
		var pkg = component.get("v.candPackage");
		var evt = $A.get("e.c:TQBCPAdHocNavigator");
		evt.setParams({ "candpkg": pkg });
		evt.fire();
	}

})