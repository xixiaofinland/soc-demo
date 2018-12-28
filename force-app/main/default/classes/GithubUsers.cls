public with sharing class GithubUsers {
  public static List<Id> createRecords(List<JSONParser.UserProfile> userProfiles){
    List<GithubUser__c> githhubUsersToInsert = new List<GithubUser__c>();
    for(JSONParser.UserProfile userProfile : userProfiles){
      githhubUsersToInsert.add(createGithubUser(userProfile));
    }
    try{
        insert githhubUsersToInsert;
    } catch (DmlException e){
      throw new GithubUsersException('create record failed.');
    }
    return getIdsFromSObjects(githhubUsersToInsert);
  }

  private static GithubUser__c createGithubUser(JSONParser.UserProfile userProfile){
    return new GithubUser__c(Name = userProfile.login,
                            Github_User_Id__c = userProfile.login,
                            html_url__c = userProfile.html_url,
                            public_repos__c = userProfile.public_repos,
                            public_gists__c = userProfile.public_gists);
  }

  private static List<Id> getIdsFromSObjects(List<SObject> sObjects){
    return new List<Id>((new Map<Id,SObject>(sObjects)).keySet());
  }

  public class GithubUsersException extends Exception {}
}
