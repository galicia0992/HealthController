public class librosFetch {
  @AuraEnabled
  public static List<Object> getLibrosById() {
      Http http = new Http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint('https://jsonplaceholder.typicode.com/todos/');
      request.setMethod('GET');
      HttpResponse response = http.send(request);
      List<Object> res = new List<Object>();
      if (response.getStatusCode() == 200) {
          List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
          return results;
      } else {
          return res;
      }
  }
}