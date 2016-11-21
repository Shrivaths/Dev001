trigger ManageBlitzPlan on Blitz_Plan__c (after insert) {

if(Trigger.isInsert){
    List<Location_SPOC_s__c> lsUlist = new List<Location_SPOC_s__c>([Select id,Send_Notification__c,Capability__c from Location_SPOC_s__c limit 10]);
    
    
    List<Location_SPOC_s__c> lsList = new list<Location_SPOC_s__c>();
    for(Blitz_Plan__c bp:Trigger.new){
        Location_SPOC_s__c ls = new Location_SPOC_s__c();
       // if(lsmap.get(bp.Capability__c) == 'SFDC'){
            ls.id = lsUlist [0].id;
            ls.Send_Notification__c = true;
            lsList.add(ls);
       // }
    }
    if(lsList.size()>0){
        update lsList;
    }

}
}