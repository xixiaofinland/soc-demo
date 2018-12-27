public with sharing class GithubUserController {
  @AuraEnabled
  public static String createGithubUser(String newUserId) {
    try{
      List<Id> newGithubRecordIds = GithubUserService.createGithubUsers(new Set<String>{ newUserId });
      return String.valueOf(newGithubRecordIds[0]);
    }catch(Exception e){
      String message = 'Something went wrong: ' + e.getMessage();
      AuraHandledException ex = new AuraHandledException('Something went wrong: ' + e.getMessage());
      ex.setMessage(message);
      throw ex;
    }
  }
}

