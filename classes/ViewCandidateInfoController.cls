public class ViewCandidateInfoController{
    //Variable
    public Candidate__c candt;
    public List<Candidate__c> cList{get;set;}
    public string intfcVal{get;set;}
    
    public ViewCandidateInfoController(){
        cList = [Select Id,First_Name__c,Last_Name__c,Capability__c,Email__c,Phone__c,Location__c,status__c FROM Candidate__c where status__c ='Candidate Arrived' LIMIT 1000];
    }
    
    public void editCandidate(){
        String cId = ApexPages.CurrentPage().getParameters().get('CandidateId');
        if(cId !=null)
        candt = [SELECT Id,Status__c from Candidate__c WHERE Id=: cId];
    }
    
    public PageReference updateCandidate(){
        try{
        system.debug('Testtt@@@@@@'+candt);
        If(candt!=null){
                        candt.Status__c = 'Candidate Arrived';
            update candt;
        }
        system.debug('Testtt@@@@@@'+candt);
        }
        Catch(exception ex)
        {
             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, ex.getMessage()));
        }
        return null;
    }
    
    public PageReference SearchCandidates(){
        if(intfcVal!= ''){
            String qry = 'Select Id,First_Name__c,Last_Name__c,Capability__c,Email__c,Phone__c,Location__c,status__c FROM Candidate__c where First_Name__c like \'%'+intfcVal+'%\' and status__c =\'Candidate Arrived\'';
            If(Database.query(qry)!=null){
                cList = Database.query(qry);
            }
            else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Match Found');
                ApexPages.addMessage(myMsg);            
                
            } 
        }
        return null;
        
    }
}