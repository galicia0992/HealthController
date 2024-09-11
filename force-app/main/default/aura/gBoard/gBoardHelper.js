({
    getWords: function(count){
        let wordsArray = [
            "Apple", "Mountain", "River", "Space", "Galaxy", "Forest", "Ocean", "Sun", "Moon", "Star", 
            "Book", "Pen", "Computer", "Phone", "Chair", "Table", "Window", "Door", "Building", "Street", 
            "Garden", "Flower", "Tree", "Leaf", "Bird", "Fish", "Dog", "Cat", "Horse", "Sheep", 
            "Cow", "Car", "Bicycle", "Train", "Airplane", "Ship", "Boat", "Bus", "Motorcycle", "Helicopter", 
            "Rocket", "Satellite", "Planet", "Universe", "Atom", "Molecule", "Cell", "Tissue", "Organ", "System", 
            "Brain", "Heart", "Lung", "Kidney", "Liver", "Stomach", "Skin", "Bone", "Muscle", "Blood", 
            "Nerve", "Eye", "Ear", "Nose", "Mouth", "Tooth", "Tongue", "Finger", "Hand", "Arm", 
            "Leg", "Foot", "Hair", "Nail", "Feather", "Wing", "Tail", "Claw", "Fin", "Scale", 
            "Shell", "Beak", "Horn", "Antler", "Hoof", "Snout", "Whisker", "Tentacle", "Trunk", "Fur", 
            "Wool", "Silk", "Cotton", "Leather", "Stone", "Metal", "Wood", "Plastic", "Glass", "Rubber"
        ];
        wordsArray = this.randomize(wordsArray)
        return wordsArray.slice(0, count)
    },
    randomize: function(arr){
        let randomArr = arr
        for(let i = randomArr.length - 1; i > 0; i--){
            let j = Math.floor(Math.random() * (i + 1));
            let temp = randomArr[i];
            randomArr[i] = randomArr[j];
            randomArr[j] = temp;
        }
        return randomArr
    },
    getWinword: function(arr){
        const randomLoc = Math.floor(Math.random() * arr.length)
        return arr[randomLoc]
    },
    getListaLibros: function(cmp, event){
        console.log('corriendo')
        let action = cmp.get('c.getLibrosById')
        action.setCallback(this, function(response) {
            let state = response.getState();
            console.log(response.getReturnValue())
            if (state === "SUCCESS") {
                // Asignar la lista de libros a la variable `listaLibros`
                cmp.set('v.listaLibros', response.getReturnValue());
                
            } else {
                console.error("Failed with state: " + state);
            }
        });

        // Enqueue the action to send the request to the server
        $A.enqueueAction(action);
    },
    enableBoard: function (cmp, e) {
        cmp.set("v.disableWords", 'auto');
    },
    disableBoard: function (cmp, e) {
        cmp.set("v.disableWords", 'none');
    },
    resetBoard: function(cmp, e, helper){
        cmp.set('v.clickCount', 0)
        cmp.set('v.openAll', false)
        this.enableBoard(cmp)
    },
    fireResultEvent: function (resultValue) {
        const appEvent = $A.get('e.c:resultApplication');
        console.log('Evento resultApplication:', appEvent);
        appEvent.setParams({ result: resultValue });
        console.log('Parámetros del evento:', appEvent.getParams());
        appEvent.fire();
        console.log('Evento disparado');
    },
    callConfetti: function(cmp, e) {
        let arr = ['basic', 'fireworks', 'celebration', 'burst']
        const randomIndex = Math.floor(Math.random() * arr.length);
        console.log(randomIndex)
        let fireConfetti = cmp.find("fireConfetti");
        let getFireFireworks = fireConfetti.get("c." + arr[randomIndex]);
        fireConfetti ? $A.enqueueAction(getFireFireworks) : ""
    }
    
})
