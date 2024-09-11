({
  list: function(cmp) {
    let arr = [
      {
        label: "Easy",
        value: "easy"
      },
      {
        label: "Medium",
        value: "medium"
      },
      {
        label: "Hard",
        value: "hard"
      }
    ];
    cmp.set("v.options", arr);
  },
  handleChange: function(cmp, e) {
    let selectedValue = e.getParam("value");
    cmp.set("v.selectedMode", selectedValue);

    if (!selectedValue) {
      cmp.set("v.disabled", true);
    } else {
      cmp.set("v.disabled", false);
    }
  },
  handleConfirmacion: function(cmp, event) {
    let message = event.getParam("message");

    alert(message);
    cmp.set("v.isOpen", false);
  },
  handleReShuffle: function(cmp, e) {
    console.log('desde handle reshuffle')
    const boardComp = cmp.find('gameBoard')
    boardComp.reShuffle()
    
  },
  handleNewGame: function(cmp, e, helper) {
    let selectedValue = cmp.get("v.selectedMode");
    cmp.set("v.mode", selectedValue);
    cmp.set("v.disabled", true);
   
    if(selectedValue != null){
        const boardComp = cmp.find('gameBoard')
        boardComp.startGame()
    }
  },
  closeModal: function(cmp) {
    cmp.set("v.isOpen", false);
  },
  onResultHandler: function(cmp, event, helper){
    console.log('desde inresulthandler')
    let result = event.getParam('result')
    if(result === 'win'){
        cmp.set('v.reshuffleDisabled', true)
        
    }else{
        cmp.set('v.reshuffleDisabled', false)
    }
    helper.addResultRecord(cmp, result)
  }
});
