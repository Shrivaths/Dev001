public class Candidate_Extension_Controller{
    
    private ApexPages.StandardController sc;
    private Candidate__c candidate;
    public String mode{get;set;}
    public String candId{get;set;}
    public String header{get;set;}
    public String  Capabilitymsg {get;set;}
    public List<Blitz_Plan__c> listBlitz{get;set;}
    public Date blitzDate{get;set;}
    public Candidate_Extension_Controller(ApexPages.StandardController sc){
        this.sc = sc;
        candidate = (Candidate__c)sc.getRecord();
        
        mode = ApexPages.currentPage().getParameters().get('mode');
        if(mode=='new'){
            header = 'New Candidate';
        }else if(mode=='edit'){
            header = 'Edit Candidate';
        }
    }
    public PageReference saveAction() {
        try{
            //sc.save();
            PageReference viewPage = null;
            candidate = (Candidate__c)sc.getRecord();
            System.debug('@@@@@'+candidate );
            if(mode=='new'){
                Candidate__c cc = new Candidate__c();
                cc.Active__c = candidate.Active__c;
                cc.Capability__c = candidate.Capability__c;
                cc.Current_Company__c = candidate.Current_Company__c;
                cc.Current_Designation__c = candidate.Current_Designation__c;
                cc.Email__c = candidate.Email__c;
                cc.First_Name__c = candidate.First_Name__c;
                cc.Last_Name__c = candidate.Last_Name__c;
               // cc.On_Hold_Reason__c = candidate.On_Hold_Reason__c;
                cc.Other_capability__c = candidate.Other_capability__c;
                cc.Phone__c = candidate.Phone__c;
                cc.Relevant_Experience_In_Months__c = candidate.Relevant_Experience_In_Months__c;
                cc.Status__c = candidate.Status__c;
                cc.Total_Experience_In_Months__c = candidate.Total_Experience_In_Months__c;
                if(cc != null)
                insert cc;
                candId= cc.id;
                System.debug('@@@@@'+cc );
            }
          if(mode=='edit'){
                if(candidate.Id!=null){
                    candId =candidate.Id;
                }
           }
            System.debug('@@@@@'+candId);
            // Construct URL of edit page or whatever other page you want
            mode ='view';
            String pageRef = '/apex/Candidate_Detail?';
           if(candId!=null){
                pageRef+='Id='+candId+'&';
            }
                pageRef+='mode='+mode;
                 System.debug('@@@@@'+pageRef);
                viewPage = new PageReference(pageRef);
         return viewPage.setRedirect(true);
        }catch (Exception ex){
             Capabilitymsg = '';
             if(ex.getMessage().contains('Please fill in Capability')){
             Capabilitymsg = 'Please fill in Capability.';
             }
             if(ex.getMessage().contains('Please fill in On-Hold Reason.')){
             Capabilitymsg += '\n'+ 'Please fill in On-Hold Reason.';
             }
             if(ex.getMessage().contains('Please provide Other Capability.')){
             Capabilitymsg += '\n'+ 'Please provide Other Capability.';
             }
                System.debug('###Exception : '+ ex.getMessage());
                return null;
        }
    }
    
     public PageReference editAction() {
        PageReference editPage= null;
        candidate = (Candidate__c)sc.getRecord();
        if(candidate.Id!=null){
            candId =candidate.Id;
        }
            mode ='edit';
            editPage= new PageReference('/apex/Candidate_Edit?Id='+candId+'&mode='+mode);
        return editPage.setRedirect(true);
    }
    
    public PageReference cancelAction() {
        PageReference cancelPage= sc.save();
        PageReference viewPage = null;        
        candId=candidate.Id;
        if (cancelPage != null) {
             mode ='view';
            // Construct URL of edit page or whatever other page you want
            viewPage = new PageReference('/apex/Candidate_Detail?Id='+candId+'&mode='+mode);
        }
        
        return viewPage.setRedirect(true);
    }
    
  public pageReference getBlitzDate(){
    Date d = Date.today();
    String query = 'select Id, Blitz_Planned_Date__c from Blitz_Plan__c where Blitz_Planned_Date__c>:d';
    listBlitz = Database.query(query);
    System.Debug('today'+DateTime.now());
    System.Debug('lstBlitz'+listBlitz);
    return null;
    }
  public void saveBlitzDate(){
      System.Debug('Save Date');
      //candidate = (Candidate__c)sc.getRecord();
      //id=candidate.id;
      //candId= 'a0C11000003eOvH';
      List<Candidate__c> lstCandidate = [select Id, Blitz_Date__c from Candidate__c where id=:candId];
      Candidate__c c = lstCandidate.get(0);
      blitzDate = listBlitz.get(0).Blitz_Planned_Date__c;
      System.Debug('blitzDate'+blitzDate);
      c.Blitz_Date__c = blitzDate;
      update c;
  } 
  }