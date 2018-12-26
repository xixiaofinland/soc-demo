public with sharing class JSONParser {
  public static UserProfile parseUserData(String jsonString){
    return (UserProfile) JSON.deserialize(jsonString, UserProfile.class);
  }

  public class UserProfile {
    public String login;
    public String html_url;
    public Integer public_repos;
    public Integer public_gists;
  }

  public class JSONParserException extends Exception {}
}
