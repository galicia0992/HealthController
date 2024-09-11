public with sharing class BoardPanelController {
   @AuraEnabled
   public static String addResult(String result, String gameMode) {
       // Crear una instancia del objeto World_Shuffle__c
       World_Shuffle__c gameResult = new World_Shuffle__c(Result__c = result, Mode__c = gameMode);
       
       // Insertar el nuevo registro en la base de datos
       insert gameResult;
       
       // Devolver un mensaje de éxito
       return 'Success';
   }
}