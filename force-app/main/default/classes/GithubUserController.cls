public with sharing class GithubUserController {
  @AuraEnabled
  public static String createNewGithubUser(String newUserName) {
    try{
      Id newGithubUserId = KohdeService.createKohde(newGithubUserName);
      return String.valueOf(newGithubUserId);
    }catch(Exception e){
      throw new AuraHandledException('Something went wrong: ' + e.getMessage());
    }
  }

  @AuraEnabled
  public static void updateGithubUser(String githubUserIdAsString) {
    try{
      Id githubUserId = Id.valueOf(githubUserIdAsString);
      KohdeService.updateKohdes(new Set<Id>{ githubUserId });
    }catch(Exception e){
      throw new AuraHandledException('Something went wrong: ' + e.getMessage());
    }
  }
}

