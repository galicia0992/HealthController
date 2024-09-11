public class CTPersonController {
    public static String getToken(String mobileNo){

        //Generamos un codigo MD5
        Blob targetBlob = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);
        String result = EncodingUtil.base64Encode(hash);
            return result;
    }

    public static List<Person__c> getRecentHealthChanges(){
        List <Person__c> phList = [SELECT Health_status__c, Mobile__c, Name, Id, Status_Update_Date__c, Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC LIMIT 100];
        return phList;
    }
    public static List<Person__c> searchPeople(String searchTerm){
        List <Person__c> phList = [SELECT Health_status__c, Mobile__c, Name, Id, Status_Update_Date__c, Token__c FROM Person__c WHERE Name LIKE :searchTerm OR Mobile__c LIKE :searchTerm OR Token__c LIKE :searchTerm ORDER BY Status_Update_Date__c DESC];
        return phList;
    }
    public static Person__c getPersonById(String personId){
        List<Person__c> phList = [SELECT Health_status__c, Mobile__c, Name, Id, Status_Update_Date__c, Token__c FROM Person__c WHERE Id =:personId];
        if(phList != null && phList.size() > 0){
            return phList[0];
        }
        return null;
    }
    public static Map<String, Integer> getHealthStatusCount(){
        //creamos un map donde el String va a ser el estatus y el integer el conteo ej(green = 6)
        Map<String, Integer> healthStatusCount = new Map<String, Integer>();

        //creamos la consulta con el metodo count, este nos va a regresar el estatos y el conteo de cuantas personas hay hay con el estatus
        List<AggregateResult> agList = [SELECT Health_Status__c, COUNT(Id) total FROM Person__c GROUP BY Health_Status__c];

        //iteramos sobre la lista
        for(AggregateResult ar: agList){

            //el valueOf retorna el valor del campo que contiene dentro, en este caso regresa el valor del campo Health_status__c el cual obtenemos usando el ar.get y se convierte en string
            String healthStatus = String.valueOf(ar.get('Health_Status__c'));
            Integer count = Integer.valueOf(ar.get('total'));  

            //le colocamos al map para que quede (color tal=2) donde color t al seria la key y 2 el valor
            healthStatusCount.put(healthStatus, count);
        }
        return healthStatusCount;
    }

    public static Set<Id> getCohabitants(Set<Id> personsId, Set<Id> alreadyProcessed){
        List<String> healthStatuses = new List<String>{'Green', 'Yellow'};
        List<People_Tracing__c> peopleTraces = [SELECT Id, Person_1__c, Person_2__c FROM People_Tracing__c WHERE (Person_1__c IN :personsId OR Person_2__c IN :personsId) AND Contact_Type__c = 'Cohabitant' AND (Person_1__r.Health_Status__c IN :healthStatuses OR Person_2__r.Health_Status__c IN :healthStatuses)];

        Set<Id> cohabitants = new Set<Id>();
        for(People_Tracing__c pt: peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                cohabitants.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!personsId.contains(pt.Person_2__c)){
                cohabitants.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);
            }
        }
        return cohabitants;
    }
    public static Set<Id> getNeighbours(Set<Id> personsId, Set<Id> alreadyProcessed){
        
        List<People_Tracing__c> peopleTraces = [SELECT Id, Person_1__c, Person_2__c FROM People_Tracing__c WHERE (Person_1__c IN :personsId OR Person_2__c IN :personsId) AND Contact_Type__c = 'Neighbour' AND (Person_1__r.Health_Status__c ='Green' OR Person_2__r.Health_Status__c ='Green')];

        Set<Id> neighbours = new Set<Id>();
        for(People_Tracing__c pt: peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                neighbours.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!alreadyProcessed.contains(pt.Person_2__c)){
                neighbours.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);
            }
        }
        return neighbours;
    }
    public static Set<Id> getPrimaryContact(Set<Id> personsId, Set<Id> alreadyProcessed){
        List<String> healthStatuses = new List<String>{'Green', 'Yellow'};
        List<People_Tracing__c> peopleTraces = [SELECT Id, Person_1__c, Person_2__c FROM People_Tracing__c WHERE (Person_1__c IN :personsId OR Person_2__c IN :personsId) AND Contact_Type__c = 'Other' AND (Person_1__r.Health_Status__c IN :healthStatuses OR Person_2__r.Health_Status__c IN :healthStatuses) AND Contact_Date__c = LAST_N_DAYS:10];

        Set<Id> primaryContacts = new Set<Id>();
        for(People_Tracing__c pt: peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                primaryContacts.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!alreadyProcessed.contains(pt.Person_2__c)){
                primaryContacts.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);
            }
        }
        return primaryContacts;
    }
    public static Set<Id> getSecondaryContact(Set<Id> primaryContactsIds, Set<Id> alreadyProcessed){
        List<String> healthStatuses = new List<String>{'Green', 'Yellow'};
        List<People_Tracing__c> peopleTraces = [SELECT Id, Person_1__c, Person_2__c FROM People_Tracing__c WHERE (Person_1__c IN :primaryContactsIds OR Person_2__c IN :primaryContactsIds) AND Contact_Type__c = 'Other' AND (Person_1__r.Health_Status__c IN :healthStatuses OR Person_2__r.Health_Status__c IN :healthStatuses) AND Contact_Date__c = LAST_N_DAYS:10];

        Set<Id> secondaryContacts = new Set<Id>();
        for(People_Tracing__c pt: peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                secondaryContacts.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!alreadyProcessed.contains(pt.Person_2__c)){
                secondaryContacts.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);
            }
        }
        return secondaryContacts;
    }
}