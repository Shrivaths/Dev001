public class BlitzPlan_Extension_Controller{
    private ApexPages.StandardController sc;
    private Blitz_Plan__c blitzPlan;
    public String mode{get;set;}
    public String id{get;set;}
    public String header{get;set;}
    public List<Blitz_Plan__c> listBlitzPlans{get;set;}
    
    public BlitzPlan_Extension_Controller(ApexPages.StandardController sc){
        this.sc = sc;
        blitzPlan= (Blitz_Plan__c)sc.getRecord();
        mode = ApexPages.currentPage().getParameters().get('mode');
        if(mode=='new'){
            header = 'New Blitz';
        }else if(mode=='edit'){
            header = 'Edit Blitz';
        }
    }
    public PageReference saveAction() {
        //PageReference detailPage = sc.save();
        sc.save();
        PageReference viewPage = null;
        blitzPlan= (Blitz_Plan__c)sc.getRecord();
        //insert candidate;
        if(blitzPlan.Id!=null){
          id =blitzPlan.Id;
        }
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='view';
            String pageRef = '/apex/Blitz_Plan_Detail?';
            if(id!=null)
            {
                pageRef+='id='+id+'&';
            }
            pageRef+='mode='+mode;
            viewPage = new PageReference(pageRef);
        //} 
     return viewPage.setRedirect(true);
    }
    
     public PageReference editAction() {
        //PageReference detailPage = sc.save();
        PageReference editPage= null;
        blitzPlan = (Blitz_Plan__c)sc.getRecord();
        
        if(blitzPlan.Id!=null){
            id =blitzPlan.Id;
        }
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='edit';
            editPage= new PageReference('/apex/Blitz_Plan_Edit?id='+id+'&mode='+mode);
        //} 
     return editPage.setRedirect(true);
    }
    
    public PageReference cancelAction() {
        PageReference cancelPage= sc.save();
        PageReference viewPage = null;        
         if(blitzPlan.Id!=null){
            id =blitzPlan.Id;
        }
        if (cancelPage != null) {
             mode ='view';
            // Construct URL of edit page or whatever other page you want
            viewPage = new PageReference('/apex/Blitz_Plan_Detail?id='+id+'&mode='+mode);
        }
        
        return viewPage.setRedirect(true);
    }

    public void getBlitzPlans(){
        
    }
}