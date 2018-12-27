@isTest
public with sharing class GithubUserControllerTest {
  @isTest
  public static void whenRemoteExistAndLocalNonExistThenCreateUser(){
    Test.setMock(HttpCalloutMock.class, new MockUserXixiao007SuccessResponse());

    Test.startTest();
    GithubUserController.createGithubUser('aGithubUserId');
    Test.stopTest();

    List<GithubUser__c> githubUsers = GithubUsersSelector.getAll();
    GithubUser__c githubUserRecord = githubUsers[0];

    System.assertEquals(1, githubUsers.size(), 'One githubUser record should be created.');
    validateFieldValues(githubUserRecord);
  }

  private static void validateFieldValues(GithubUser__c githubUserRecord){
    System.assertEquals(TestData.LOGIN, githubUserRecord.Name, 'Login value should copy to record name.');
    System.assertEquals(TestData.LOGIN, githubUserRecord.Github_User_Id__c, 'Login value should copy to record github_user_id.');
    System.assertEquals(TestData.HTML_URL, githubUserRecord.html_url__c, 'html url value should copy to record html_url__c.');
    System.assertEquals(TestData.PUBLIC_REPOS, githubUserRecord.public_repos__c, 'public repos value should copy to record public_repos__c.');
    System.assertEquals(TestData.PUBLIC_GISTS, githubUserRecord.public_gists__c, 'public repos value should copy to record public_gists__c.');
  }

  private class MockUserXixiao007SuccessResponse implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
      HTTPResponse res = new HTTPResponse();
      if(req.getMethod() == 'GET'){
        res.setBody(TestData.XIXIAO007_SUCCESS_RESPONSE);
        res.setStatusCode(200);
      }
      return res;
    }
  }

  @isTest
  public static void whenRemoteNonExistThenCreateUserFail(){
    Test.setMock(HttpCalloutMock.class, new Mock404Response());
    Boolean didThrowException = false;
    String exceptionMessage;

    Test.startTest();
    try{
      GithubUserController.createGithubUser('aGithubUserId');
    } catch (AuraHandledException e){
      didThrowException = true;
      exceptionMessage = e.getMessage();
    }
    Test.stopTest();

    List<GithubUser__c> githubUsers = GithubUsersSelector.getAll();

    System.assertEquals(0, githubUsers.size(), 'No githubUser record should be created.');
    System.assertEquals(true, didThrowException, 'AuraHandledException should be thrown');
    System.assertEquals('Something went wrong: remote service returned status code: 404',
                    exceptionMessage, 'message thrown from RemoteServiceException in RemoteService class should be present.');
  }

  private class Mock404Response implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
      HTTPResponse res = new HTTPResponse();
      if(req.getMethod() == 'GET'){
        res.setStatusCode(404);
      }
      return res;
    }
  }

  @isTest
  public static void whenLocalAlreadyExistThenCreateUserFail(){
    Test.setMock(HttpCalloutMock.class, new MockUserXixiao007SuccessResponse());
    String userName = 'xixiao007';
    createGithubUserRecord(userName);
    Boolean didThrowException = false;
    String exceptionMessage;

    Test.startTest();
    try{
      GithubUserController.createGithubUser(userName);
    } catch (AuraHandledException e){
      didThrowException = true;
      exceptionMessage = e.getMessage();
    }
    Test.stopTest();

    List<GithubUser__c> githubUsers = GithubUsersSelector.getAll();

    System.assertEquals(1, githubUsers.size(), 'No more githubUser record should be created after startTest.');
    System.assertEquals(true, didThrowException, 'AuraHandledException should be thrown.');
    System.assertEquals('Something went wrong: create record failed.', exceptionMessage,
                'message thrown from DMLException in GithubUsers class should be present.');
  }

  private static void createGithubUserRecord(String userName){
    GithubUser__c githubUser = new GithubUser__c(Name = userName, Github_User_Id__c = userName);
    insert githubUser;
  }
}
