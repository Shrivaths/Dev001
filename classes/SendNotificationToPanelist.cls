global class SendNotificationToPanelist implements Database.Batchable <sObject>{

    public String query;
    public Date dateToday = System.today();
    
    public Database.querylocator start(Database.BatchableContext BC){
        query = 'Select id,Status__c,CutOff_Date__c  from Blitz_Panelists__c where Status__c = \''+Label.Reply_Awaited+'\' AND CutOff_Date__c >= :dateToday ';
        system.debug('Query'+query);
        return Database.getQueryLocator(query);
    }

    
    public void execute(Database.BatchableContext BC, List <Blitz_Panelists__c> BlitzPanelList) {
        List<Blitz_Panelists__c> BPLUpdateList = new List<Blitz_Panelists__c>();
        for(Blitz_Panelists__c BPL : BlitzPanelList)
        {
            BPL.Status__c = 'Notification Sent';
            BPLUpdateList.add(BPL);
        } 
        
        if(BPLUpdateList.size()>0){
            
            Database.SaveResult[] sr = Database.update(BPLUpdateList,false);
            
        }
        
    }

    public void finish (Database.BatchableContext BC) {
        
    }
    

}