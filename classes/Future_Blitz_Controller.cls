public class Future_Blitz_Controller{

  public List<Blitz_Plan__c> listBlitz{get;set;}

   public Future_Blitz_Controller(){
        // candidate id pass
    Date d = Date.today();
    String query = 'select Id, Blitz_Planned_Date__c from Blitz_Plan__c where Blitz_Planned_Date__c>:d';
    listBlitz = Database.query(query);
    System.Debug('today'+DateTime.now());
    System.Debug('lstBlitz'+listBlitz);
    }
    
    public void getFutureBlitz(){
        
 
    
    }
}