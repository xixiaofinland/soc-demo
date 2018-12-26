public with sharing class RemoteService {
  public static String getUserData(String remoteUserId) {
    String remoteURLInNamedCredentials = 'callout:Github_REST_API/users/' + remoteUserId;
    HttpResponse response = doHTTPRequest('GET', remoteURLInNamedCredentials);
    if(response.getStatusCode() != 200){
      throw new RemoteServiceException('remote service returned status code: ' + response.getStatusCode());
    }
    return response.getBody();
  }

  private static HttpResponse doHTTPRequest(String action, String remoteURL){
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod(action);
    request.setEndpoint(remoteURL);
    return http.send(request);
  }

  public class RemoteServiceException extends Exception {}
}
