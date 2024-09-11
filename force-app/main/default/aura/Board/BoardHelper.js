({
    callNewBoard: function(cmp) {
        console.log('iniciando call new')
        // Encontrar el componente hijo usando aura:id
        let gBoardCmp = cmp.find('gameBoard');
        if (gBoardCmp) {
            // Obtener la función doInit del componente hijo
            let getGBoardFunc = gBoardCmp.get('c.doInit');
            // Encolar la acción para ejecutar la función en el componente hijo
            $A.enqueueAction(getGBoardFunc);
            
        } else {
            console.error('No se pudo encontrar el componente gBoard');
        }
    },
    addResultRecord: function(cmp, gameResult) {
        ///create aplex metod call action
        const action = cmp.get('c.addResult')
        const mode = cmp.get('v.mode')
        action.setParams({
            result: gameResult,
            gameMode: mode
        })
        //define a callback
        action.setCallback(this, function(response) {
            const state = response.getState();
            if(state !== 'SUCCESS'){
                alert('Error saving a record')
            }
        })
        $A.enqueueAction(action)
    }
    
})