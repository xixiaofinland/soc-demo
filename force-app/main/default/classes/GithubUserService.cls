public with sharing class GithubUserService {
  public static List<Id> createGithubUsers(Set<String> userIds){
    try{
      List<JSONParser.UserProfile> userProfiles = new List<JSONParser.UserProfile>();

      for(String userId : userIds){
        String remoteServiceResponse = RemoteService.getUserData(userId);
        userProfiles.add(JSONParser.parseUserData(remoteServiceResponse));
      }

      return GithubUsers.createRecords(userProfiles);
    }catch (Exception e){
      throw new GithubUserServiceException(e.getMessage());
    }
  }

  private static Boolean doesExist(JSONParser.UserProfile userProfile){
    return userProfile.message == null;
  }

  public class GithubUserServiceException extends Exception {}
}
