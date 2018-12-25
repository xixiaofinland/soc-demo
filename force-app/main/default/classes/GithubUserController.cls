public with sharing class GithubUserController {
  @AuraEnabled
  public static String createGithubUser(String newUserId) {
    try{
      List<Id> newGithubRecordIds = GithubService.createGithubUsers(new Set<String>{ newUserId });
      return String.valueOf(newGithubRecordIds[0]);
    }catch(Exception e){
      throw new AuraHandledException('Something went wrong: ' + e.getMessage());
    }
  }
}

