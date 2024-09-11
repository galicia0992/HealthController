@IsTest

private class AccountManagerTest {

    @isTest

    static void testGetContactsByAccountId() {

        Id recordId = createTestRecord();

        RestRequest request = new RestRequest();

        request.requestUri = 'https://yourInstance.my.salesforce.com/services/apexrest/Accounts/'+recordId+'/contacts';

        request.httpMethod = 'GET';

        RestContext.request = request;

        Account thisAccount = AccountManager.getAccount();

        System.assert(thisAccount != null);

        System.assertEquals('TestRecord', thisAccount.Name);

    }

    static Id createTestRecord(){

        Account accountTest = new Account(

        Name = 'TestRecord');

        insert accountTest;

        Contact contactTest = new Contact (

        FirstName = 'Khakan', 

		LastName = 'Ispakhev',

		AccountId = accountTest.Id

        );

    insert contactTest;

    return accountTest.Id;

    }

}