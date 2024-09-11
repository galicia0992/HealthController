({
  closeModal: function(cmp, e, helper) {
    cmp.set("v.isOpen", false);
    helper.refreshResultTable()
  },
  confirmacion: function(cmp, e, helper) {
    cmp.set("v.isOpen", false);
    let comEvent = cmp.getEvent("resetGame");
    comEvent.fire();
    
    helper.refreshResultTable()
  }
});
