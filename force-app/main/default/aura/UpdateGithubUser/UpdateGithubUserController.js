({
  doInit: function (cmp, event, helper) {
    console.log("in doInit");

    var spinner = cmp.find("spinner");
    $A.util.removeClass(spinner, "slds-hide");

    var action = cmp.get("c.updateGithubUser");

    action.setParams({ "githuUserIdAsString": cmp.get("v.recordId") });
    action.setCallback(this, function(response) {
      console.log("callback here.");
      var state = response.getState();
      if (state === "SUCCESS") {
        $A.get('e.force:refreshView').fire();
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
    });
    $A.enqueueAction(action);
  }
})
