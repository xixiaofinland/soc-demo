public with sharing class GithubUserService {
  public static Id createGithubUser(String githubUserId){
    try{
      String remoteServiceResponse = getRemoteServiceResponse();

      JSONParser.CreateKohdeResponse response =
                JSONParser.parseCreateKohdeResponse(remoteServiceResponse);

      Id newKohdeId = Kohdes.createKohde(response, parentOppId, githubUserId);

      return newKohdeId;
    }catch (Exception e){
      System.Debug('Exception: ' + e.getTypeName() + ': \n' + e.getMessage());
      throw new KohdeServiceException('Create Kohde action failed.');
    }
  }

  private static String getRemoteServiceResponse(){
    iRemoteService service = Application.getRemoteService('createKohde');
    return service.createKohde();
  }

  public static void updateKohdes(Set<Id> kohdeIds){
    try{
      IRemoteService service = Application.getRemoteService('readKohde');
      Map<Id, JSONParser.KohdeData> kohdeDataByKohdeId = getRemoteKohdeData(kohdeIds, service);
      Kohdes.updateKohdes(kohdeDataByKohdeId);
    }catch (Exception e){
      System.Debug(e.getTypeName() + ': \n' + e.getMessage());
      throw new KohdeServiceException('Update Kohde action failed.');
    }
  }

  private static Map<Id, JSONParser.KohdeData> getRemoteKohdeData(Set<Id> kohdeIds, IRemoteService service){
    Map<Id, JSONParser.KohdeData> kohdeDataByKohdeId = new Map<Id, JSONParser.KohdeData>();
    List<Kohde__c> kohdesToUpdate = KohdesSelector.getBy(kohdeIds);

    //Talosofta web service doesn't support bulkification, need to call one by one
    //Thus do not flood their service interface by large volumes;
    for (Kohde__c r : kohdesToUpdate) {
      String remoteServiceResponse = service.getKohdeData(r.RemoteId__c);
      JSONParser.KohdeData data = JSONParser.parseKohdeData(remoteServiceResponse);
      kohdeDataByKohdeId.put(r.Id, data);
    }
    return kohdeDataByKohdeId;
  }

  public class KohdeServiceException extends Exception {}
}
