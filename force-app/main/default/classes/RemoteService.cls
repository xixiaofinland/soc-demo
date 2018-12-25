public with sharing class RemoteService {
  public String getUserData(String remoteUserId) {
    HttpResponse response = doHTTPRequest('GET', remoteURL);
    if(response.getStatusCode() != 200){
      throw new RemoteServiceException('remote service returned status code other than 200.');
    }
    return response.getBody();
  }

  private HttpResponse doHTTPRequest(String action, String remoteURL){
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod(action);
    request.setEndpoint(remoteURL);
    return http.send(request);
  }

  public class RemoteServiceException extends Exception {}
}
