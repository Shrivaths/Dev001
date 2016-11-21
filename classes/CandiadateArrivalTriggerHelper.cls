public  class CandiadateArrivalTriggerHelper{
    
    public static void CreateCandidateBlitzHistory(List<Candidate__c> NewValue, Map<id,Candidate__c> OldMapValue){
        
        List<Blitz_Attendees__c> Blitz = new List<Blitz_Attendees__c>();
        List<Blitz_Attendees__c> BlitzSquence = new List<Blitz_Attendees__c>();
        List<Candidate_History__c > CandH= new List<Candidate_History__c >();
        List<Candidate_Assesment__c > CandAssessList= new List<Candidate_Assesment__c >();
        List<Blitz_Plan__c> BlitzPlanList = new List<Blitz_Plan__c >();
        Blitz_Attendees__c BlitzAtt = new Blitz_Attendees__c();
        //Map<string, string> mcs = new Map<string, Capability_Code__c>();
        
            
        for(Candidate__c c : NewValue)
        {
            if(c.Status__c == 'Candidate Arrived' && c.Status__c != OldMapValue.get(c.id).Status__c)
            {
                Blitz_Attendees__c blitzAttNew = new Blitz_Attendees__c();
                Integer SequenceNum;
                BlitzSquence = [SELECT Id,Name,Capability__c,Sequence__c 
                FROM Blitz_Attendees__c 
                WHERE Capability__c =: c.Capability__c 
                LIMIT 1];
                
                BlitzPlanList  = [SELECT Id,Name,Capability__c,Capability_HR_SPOC__c
                FROM Blitz_Plan__c
                WHERE Capability__c =: c.Capability__c AND Blitz_Planned_Date__c =: System.today() AND Blitz_Location__c =: c.Location__c
                LIMIT 1];
                
                if(!BlitzSquence.isEmpty())
                {
                    BlitzAtt = BlitzSquence.get(0);
                    if(BlitzAtt.Sequence__c>0)
                    {
                        SequenceNum = Integer.valueOf(BlitzAtt.Sequence__c) + 1;
                        blitzAttNew.Sequence__c = SequenceNum;
                    } 
                    else
                    {
                        SequenceNum = 1;
                        blitzAttNew.Sequence__c = SequenceNum ;
                    }
                }else
                {
                    SequenceNum = 1;
                    blitzAttNew.Sequence__c = SequenceNum ;
                }
                
                //String s = String.format("%03d", SequenceNum);
                

                //Map<String,Capability_Code__c> mcs = new Map<string,Capability_Code__c>();
                //mcs = Capability_Code__c.getAll();

                //List<Capability_Code__c> mc = Capability_Code__c.getall().values();


                blitzAttNew.Candidate__c = c.Id;
                if(BlitzPlanList !=Null)
                {
                blitzAttNew.Blitz_Plan__c = BlitzPlanList.get(0).id;
                if(BlitzPlanList.get(0).Capability_HR_SPOC__c != NULL)
                {
                blitzAttNew.Capability_HR_SPOC__c = BlitzPlanList.get(0).Capability_HR_SPOC__c;
                List<Location_SPOC_s__c> LocSpocList = new List<Location_SPOC_s__c>();
                LocSpocList = [SELECT Id,Name,Send_Notification__c
                FROM Location_SPOC_s__c
                WHERE Id =: BlitzPlanList.get(0).Capability_HR_SPOC__c
                LIMIT 1];
                LocSpocList.get(0).Send_Notification__c = true;
                Update LocSpocList;
                }
                }
                blitzAttNew.Capability__c = c.Capability__c;
                blitzAttNew.Stage__c = 'Round 1';
                blitzAttNew.Status__c = c.Status__c;
                if(c.Capability__c!=NULL)
                {
                    String temp = String.valueOf(c.Capability__c);
                   Capability_Code__c mcs = Capability_Code__c.getValues(temp);
                    
                    //Capability_Code__c mc = Capability_Code__c.getInstance('SFDC');
                    String a = String.valueOf(mcs.Capability__c);
                    
                    String SeqNumStr = String.valueof(SequenceNum);
                    if(SeqNumStr.length()==1)
                    {
                        blitzAttNew.Arrival_Sequence__c = a + '000' + SeqNumStr ;
                    }
                    if(SeqNumStr.length()==2)
                    {
                        blitzAttNew.Arrival_Sequence__c = a + '00' + SeqNumStr ;
                    }
                    if(SeqNumStr.length()==3)
                    {
                        blitzAttNew.Arrival_Sequence__c = a + '0' + SeqNumStr ;
                    }
                    if(SeqNumStr.length()==4)
                    {
                        blitzAttNew.Arrival_Sequence__c = a  + SeqNumStr ;
                    }
                }
                insert blitzAttNew;
                Candidate_History__c candHis = new Candidate_History__c();
                candHis.Candidate__c = c.Id;
                candHis.Blitz_History__c = blitzAttNew.id;
                candHis.Status__c = c.Status__c;
                CandH.add(candHis);
                
                Candidate_Assesment__c candAssessObj = new Candidate_Assesment__c();
                candAssessObj.Candidate__c = c.Id;
                candAssessObj.Blitz_Attendees__c = blitzAttNew.id;
                CandAssessList.add(candAssessObj);
            }
        }
        
        insert CandH;
        insert CandAssessList;
        
    }
    
    
    public static void InsertCreateCandidateBlitzHistory(List<Candidate__c> NewValue){
        
        List<Blitz_Attendees__c> Blitz = new List<Blitz_Attendees__c>();
        List<Blitz_Attendees__c> BlitzSquence = new List<Blitz_Attendees__c>();
        List<Candidate_History__c > CandH= new List<Candidate_History__c >();
        List<Candidate_Assesment__c > CandAssessList= new List<Candidate_Assesment__c >();
        List<Blitz_Plan__c> BlitzPlanList = new List<Blitz_Plan__c >();
        Blitz_Attendees__c BlitzAtt = new Blitz_Attendees__c();
        //Map<string, string> mcs = new Map<string, Capability_Code__c>();
        
            
        for(Candidate__c c : NewValue)
        {
            if(c.Status__c == 'Candidate Arrived')
            {
                Blitz_Attendees__c blitzAttNew = new Blitz_Attendees__c();
                Integer SequenceNum;
                BlitzSquence = [SELECT Id,Name,Capability__c,Sequence__c 
                FROM Blitz_Attendees__c 
                WHERE Capability__c =: c.Capability__c 
                LIMIT 1];
                
                BlitzPlanList  = [SELECT Id,Name,Capability__c,Capability_HR_SPOC__c
                FROM Blitz_Plan__c
                WHERE Capability__c =: c.Capability__c AND Blitz_Planned_Date__c =: System.today() AND Blitz_Location__c =: c.Location__c
                LIMIT 1];
                
                if(!BlitzSquence.isEmpty())
                {
                    BlitzAtt = BlitzSquence.get(0);
                    if(BlitzAtt.Sequence__c>0)
                    {
                        SequenceNum = Integer.valueOf(BlitzAtt.Sequence__c) + 1;
                        blitzAttNew.Sequence__c = SequenceNum;
                    } 
                    else
                    {
                        SequenceNum = 1;
                        blitzAttNew.Sequence__c = SequenceNum ;
                    }
                }else
                {
                    SequenceNum = 1;
                    blitzAttNew.Sequence__c = SequenceNum ;
                }
                
                //String s = String.format("%03d", SequenceNum);
                

                //Map<String,Capability_Code__c> mcs = new Map<string,Capability_Code__c>();
                //mcs = Capability_Code__c.getAll();

                //List<Capability_Code__c> mc = Capability_Code__c.getall().values();


                blitzAttNew.Candidate__c = c.Id;
                
                if(BlitzPlanList !=Null)
                {
                blitzAttNew.Blitz_Plan__c = BlitzPlanList.get(0).id;
                if(BlitzPlanList.get(0).Capability_HR_SPOC__c != NULL)
                {
                blitzAttNew.Capability_HR_SPOC__c = BlitzPlanList.get(0).Capability_HR_SPOC__c;
                List<Location_SPOC_s__c> LocSpocList = new List<Location_SPOC_s__c>();
                LocSpocList = [SELECT Id,Name,Send_Notification__c
                FROM Location_SPOC_s__c
                WHERE Id =: BlitzPlanList.get(0).Capability_HR_SPOC__c
                LIMIT 1];
                LocSpocList.get(0).Send_Notification__c = true;
                Update LocSpocList;
                }
                }
                blitzAttNew.Capability__c = c.Capability__c;
                blitzAttNew.Stage__c = 'Round 1';
                blitzAttNew.Status__c = c.Status__c;
                if(c.Capability__c!=NULL)
                {
                    String temp = String.valueOf(c.Capability__c);
                   Capability_Code__c mcs = Capability_Code__c.getValues(temp);
                    
                    //Capability_Code__c mc = Capability_Code__c.getInstance('SFDC');
                    String a = String.valueOf(mcs.Capability__c);
                    
                    String SeqNumStr = String.valueof(SequenceNum);
                    if(SeqNumStr.length()==1)
                    {
                        blitzAttNew.Arrival_Sequence__c = a + '000' + SeqNumStr ;
                    }
                    if(SeqNumStr.length()==2)
                    {
                        blitzAttNew.Arrival_Sequence__c = a + '00' + SeqNumStr ;
                    }
                    if(SeqNumStr.length()==3)
                    {
                        blitzAttNew.Arrival_Sequence__c = a + '0' + SeqNumStr ;
                    }
                    if(SeqNumStr.length()==4)
                    {
                        blitzAttNew.Arrival_Sequence__c = a  + SeqNumStr ;
                    }
                }
                insert blitzAttNew;
                Candidate_History__c candHis = new Candidate_History__c();
                candHis.Candidate__c = c.Id;
                candHis.Blitz_History__c = blitzAttNew.id;
                candHis.Status__c = c.Status__c;
                CandH.add(candHis);
                
                Candidate_Assesment__c candAssessObj = new Candidate_Assesment__c();
                candAssessObj.Candidate__c = c.Id;
                candAssessObj.Blitz_Attendees__c = blitzAttNew.id;
               
                 CandAssessList.add(candAssessObj);
            }
        }
        
        insert CandH;
        insert CandAssessList;
        
        
    }

}