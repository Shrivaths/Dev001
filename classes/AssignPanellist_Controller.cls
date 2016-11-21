public class AssignPanellist_Controller{
    
    public string bAId{get;set;}
    public  List<Blitz_Attendees__c> bAtList = new List<Blitz_Attendees__c>();
    public  List<Panelist__c> pList{get;set;}
    public string intfcVal{get;set;}
    public Panelist__c panelist{get;set;}
    
    public AssignPanellist_Controller(){
        bAId= ApexPages.currentPage().getParameters().get('bAId');
        pList = new List<Panelist__c>();
        if(!String.isBlank(bAId)){
            system.debug(bAId);
            bAtList = [SELECT Id,Capability__c,Stage__c from Blitz_Attendees__c WHERE Id=:bAId LIMIT 1];
            system.debug(bAtList.get(0).Capability__c);
            List<Panelist__c> tempPList = [SELECT Id,First_Name__c,Last_Name__c,Capability__c,Total_Experience_In_Months__c,Location__c,Round__c, Candidates_Assigned__c 
            FROM Panelist__c
            WHERE Capability__c=:bAtList.get(0).Capability__c AND Candidates_Assigned__c < 3];
            
            for(Panelist__c p: tempPList)
            {
                system.debug(p.Round__c);
                if(p.Round__c != null){
                    if(p.Round__c.contains(';')){ 
                        String[] RoundArrayOfPanelist = p.Round__c.split(';');
                        system.debug(RoundArrayOfPanelist);
                        for(string s:RoundArrayOfPanelist) {
                            system.debug(s);
                            system.debug(bAtList.get(0).Stage__c);
                            if(s==bAtList.get(0).Stage__c){
                                pList.add(p);
                                break;
                            } 
                        }                       

                    }
                    else{
                        if(p.Round__c == bAtList.get(0).Stage__c){
                            pList.add(p);
                        }
                    }  
                }               
            }
        }
    }
    
    public PageReference SearchCandidates(){
        if(intfcVal!= ''){
            String qry = 'SELECT Id,First_Name__c,Last_Name__c,Capability__c,Total_Experience_In_Months__c,Location__c,Round__c FROM Panelist__c where First_Name__c like \'%'+intfcVal+'%\'';
            If(Database.query(qry)!=null){
                pList = Database.query(qry);
            }
            else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Match Found');
                ApexPages.addMessage(myMsg);            
                
            } 
        }
        return null;
    }
    
    public pageReference confirmAssignment(){
        String pId = ApexPages.CurrentPage().getParameters().get('panelistId');
        if(pId !=null)
        List<Panelist__c> pList = [SELECT Id from Panelist__c WHERE Id=:pId];
        
        panelist = pList.get(0);
        return null;
    }
    
    public pageReference assignPanelist(){
        bAId= ApexPages.currentPage().getParameters().get('bAId');
        bAtList = [SELECT Id,Capability__c,Stage__c from Blitz_Attendees__c WHERE Id=:bAId LIMIT 1];
        if(bAtList !=null){
            if(bAtList.get(0).Stage__c == 'Round 1'){
                bAtList.get(0).Round_1_Panelist__c = panelist.Id;
                }
                else if(bAtList.get(0).Stage__c == 'Round 2'){
                bAtList.get(0).Round_2_Panelist__c = panelist.Id;
                }
                else if(bAtList.get(0).Stage__c == 'Round 3'){
                bAtList.get(0).Round_3_Panelist__c = panelist.Id;
                }
                update bAtList;
                panelist.Candidates_Assigned__c = panelist.Candidates_Assigned__c + 1;
                update panelist;
            }
            
        return null;
    }
    
    
}