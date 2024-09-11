({
    closeModal: function(cmp){
        cmp.set('v.isOpen', false)
    },
    confirmacion: function(cmp){
        
        

        let dispararEvento = cmp.getEvent('messageAlert')
        dispararEvento.setParams({message: 'Haz reiniciado el juego'})
        dispararEvento.fire()
        
        
    }
})
