public with sharing class JSONParser {
  //TODO: throw good exception message;
  public static KohdeData parseUserData(String jsonString){
    return (KohdeData) JSON.deserialize(jsonString, KohdeData.class);
  }

  public class KohdeData {
    public Tilaus tilaus;
    public HintaTiedot hintaTiedot;
  }

  public class Tilaus {
    public String tilaus_id_talosofta;
    public String asiakas_id_talosofta;
  }

  public class HintaTiedot {
    public String myyntihinta_alv0;
    public String myyntihinta_alv;
    public String myyntiKate;
    public String omakustanneHinta;
  }

  public class JSONParserException extends Exception {}
}
