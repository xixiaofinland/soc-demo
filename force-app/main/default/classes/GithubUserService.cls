public with sharing class GithubUserService {
  public static List<Id> createGithubUsers(Set<String> userIds){
    try{
      List<JSONParser.UserProfile> userProfiles = new List<JSONParser.UserProfile>();

      for(String userId : userIds){
        String remoteServiceResponse = RemoteService.getUserData(userId);
        JSONParser.UserProfile userProfile = JSONParser.parseUserData(remoteServiceResponse);
        if(doesExist(userProfile)){
          userProfiles.add(userProfile);
        }else {
          throw new GithubUserServiceException(userId + ' does not exist in Github.');
        }
      }

      List<Id> newGithubUserRecordIds = GithubUsers.createRecords(userProfiles);
      return newGithubUserRecordIds;
    }catch (Exception e){
      System.Debug('Exception: ' + e.getTypeName() + ': \n' + e.getMessage());
      throw new GithubUserServiceException('Create GithubUser action failed.');
    }
  }

  private static Boolean doesExist(JSONParser.UserProfile userProfile){
    return userProfile.message == null;
  }

  public class GithubUserServiceException extends Exception {}
}
