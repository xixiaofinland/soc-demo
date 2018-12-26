public with sharing class JSONParser {
  public static UserProfile parseUserData(String jsonString){
    return (UserProfile) JSON.deserialize(jsonString, UserProfile.class);
  }

  public class UserProfile {
    public String message;
    public String login;
    public String url;
    public String public_repos;
    public String public_gists;
  }

  public class JSONParserException extends Exception {}
}
