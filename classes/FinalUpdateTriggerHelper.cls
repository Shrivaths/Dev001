public  class FinalUpdateTriggerHelper{

    public static void UpdateCandidateBlitzHistory(List<Blitz_Attendees__c > NewValue, Map<id,Blitz_Attendees__c > OldMapValue){
        
        Set<id> relatedBlitzAttIdsSet = new Set<Id>();
        for(Blitz_Attendees__c  BA: NewValue)
        {
            if((BA.Status__c == 'Rejected' || BA.Status__c == 'Offer released') && BA.Status__c != OldMapValue.get(BA.id).Status__c)
            {
                relatedBlitzAttIdsSet.add(BA.Id);
            }
        }
        
        List<Candidate_History__c> CHList = new List<Candidate_History__c>();
        List<Candidate_History__c> CHListNew = new List<Candidate_History__c>();
        CHList = [Select Id,Name,First_Name__c,Candidate__r.On_Hold_Reason__c,Blitz_History__c,Candidate__c,Candidate__r.Blitz_Date__c,Blitz_History__r.Status__c,Candidate__r.First_Name__c,Candidate__r.Phone__c,Candidate__r.Last_Name__c,Candidate__r.Total_Experience_In_Months__c,Candidate__r.Relevant_Experience_In_Months__c,Candidate__r.Capability__c,Candidate__r.Email__c 
                    FROM Candidate_History__c 
                    WHERE Blitz_History__c  IN : relatedBlitzAttIdsSet];
        
        for(Candidate_History__c C: CHList)
        {
            C.First_Name__c = C.Candidate__r.First_Name__c;         
            C.Last_Name__c = C.Candidate__r.Last_Name__c ;
            C.Total_Experiance__c = C.Candidate__r.Total_Experience_In_Months__c;
            C.Relevant_Experience__c = C.Candidate__r.Relevant_Experience_In_Months__c;
            C.Capability__c = C.Candidate__r.Capability__c ;
            C.Email__c = C.Candidate__r.Email__c ;
            C.Phone__c = C.Candidate__r.Phone__c ;
            C.Status__c = C.Blitz_History__r.Status__c ;
            C.Blitz_Date__c = C.Candidate__r.Blitz_Date__c ;
            C.On_Hold_Reason__c = C.Candidate__r.On_Hold_Reason__c;
            CHListNew.add(C);
        }
        update CHListNew;
    }
    
    public static void UpdatePanelistSendNotification(List<Blitz_Attendees__c > NewValue, Map<id,Blitz_Attendees__c > OldMapValue){
        Set<id> relatedPanelistIdsSet = new Set<Id>();
        for(Blitz_Attendees__c  BA: NewValue)
        {
            if((BA.Round_1_Panelist__c != OldMapValue.get(BA.id).Round_1_Panelist__c))
            {
                relatedPanelistIdsSet.add(BA.Round_1_Panelist__c);
            }
            if((BA.Round_1_Panelist__c != OldMapValue.get(BA.id).Round_2_Panelist__c))
            {
                relatedPanelistIdsSet.add(BA.Round_2_Panelist__c);
            }
            if((BA.Round_1_Panelist__c != OldMapValue.get(BA.id).Round_3_Panelist__c))
            {
                relatedPanelistIdsSet.add(BA.Round_3_Panelist__c);
            }
            
            List<Panelist__c> pList = [SELECT Id, Send_Notification__c FROM Panelist__c WHERE Id IN:relatedPanelistIdsSet];
            for(Panelist__c p:pList){
                p.Send_Notification__c = true;
            }
            update pList;
        }
    }
}