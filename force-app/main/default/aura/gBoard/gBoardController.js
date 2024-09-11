({
  doInit: function(cmp, e, helper) {
    let gameMode = cmp.get("v.mode");
    console.log("modo: ", gameMode);
    let column = 0;
    if (gameMode && gameMode === "hard") {
      column = 6;
    } else if (gameMode && gameMode === "medium") {
      column = 4;
    } else {
      column = 3;
    }
    let randomWords = helper.getWords(column * column);
    let winWord = helper.getWinword(randomWords);
    let blockSize = 12 / column;
    cmp.set("v.blockSize", blockSize);
    cmp.set("v.initRes", randomWords);
    cmp.set("v.winWord", winWord);
    helper.resetBoard(cmp);
  },
  doRender: function(cmp, e) {
    console.log("render disparado");
  },
  clickEventLabel: function(cmp, e, helper) {
    let val = e.getParam("value");
    let clickCount = cmp.get("v.clickCount") + 1;

    cmp.set("v.clickCount", clickCount);

    if (val === cmp.get("v.winWord")) {
      helper.fireResultEvent("win");
      cmp.set("v.won", true);
      cmp.set("v.openAll", true);
      cmp.set("v.isOpen", true);
      helper.disableBoard(cmp);
      helper.callConfetti(cmp)
    } else if (clickCount === 3) {
      helper.fireResultEvent("lose");
      cmp.set("v.won", false);
      cmp.set("v.openAll", true);
      cmp.set("v.isOpen", true);
      helper.disableBoard(cmp);
    }
  },
  reShuffle: function(cmp, e, helper){
    let words = cmp.get('v.initRes')
    let random = helper.randomize(words)
    cmp.set('v.initRes', random)
    helper.resetBoard(cmp)
  }
});
