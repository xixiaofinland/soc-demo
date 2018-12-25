({
  doCreateAction: function (cmp, event, helper) {
    console.log("in doCreateAction");

    var spinner = cmp.find("spinner");
    $A.util.removeClass(spinner, "slds-hide");

    var action = cmp.get("c.createGithubUser");
    var userId = cmp.get("v.userId");
    console.log('userId: ' + userId);

    action.setParams({ "newUserId" : userId });
    action.setCallback(this, function(response) {
      console.log("callback here.");
      var state = response.getState();
      if (state === "SUCCESS") {
        $A.get('e.force:refreshView').fire();
        console.log(response.getReturnValue());
      } else if(state === "ERROR") {
        let errors = response.getError();
        let message = 'Unknown error';
        if (errors && Array.isArray(errors) && errors.length > 0) {
            message = errors[0].message;
        }
        console.error(message);
      }
      $A.util.addClass(spinner, "slds-hide");
      $A.get("e.force:closeQuickAction").fire();
      cmp.destroy();
    });
    $A.enqueueAction(action);
  },

  doCancelAction : function(cmp, event, helper) {
    $A.get("e.force:closeQuickAction").fire();
    cmp.destroy();
  }
})
