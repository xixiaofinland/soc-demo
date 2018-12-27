public with sharing class GithubUsersSelector {
  public static List<GithubUser__c> getAll(){
    return [SELECT Id, Name, html_url__c, public_repos__c,
                  Github_User_Id__c, public_gists__c
                FROM GithubUser__c];
  }
}
