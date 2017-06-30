({
	sendNotification : function(component, event, helper){
	  var selectedItem = event.currentTarget;
      var chairPersonSelectedId = selectedItem.dataset.record;
      console.log('Chairperson selected Id in TQBCPWizardCoordinator = '+ chairPersonSelectedId);
      helper.sendNotifyEmail(component, event, chairPersonSelectedId);
	}
})