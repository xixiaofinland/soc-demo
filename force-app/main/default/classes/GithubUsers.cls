public with sharing class GithubUsers {
  public static List<Id> createRecords(List<JSONParser.UserProfile> userProfiles){ 
    List<GithubUser__c> githhubUsersToInsert = new List<GithubUser__c>();
    for(JSONParser.UserProfile userProfile : userProfiles){
      githhubUsersToInsert.add(createGithubUser(userProfile));
    }
    insert githhubUsersToInsert;

    List<Id> ids = new List<Id>();
    for(GithubUser__c u : githhubUsersToInsert){
      ids.add(u.Id);
    }
    return ids;
  }

  private static GithubUser__c createGithubUser(JSONParser.UserProfile userProfile){
    return new GithubUser__c(Name = userProfile.login,
                            url__c = userProfile.url,
                            public_repos__c = userProfile.public_repos,
                            public_gists__c = userProfile.public_gists);
  }
}
