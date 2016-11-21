public class Panelist_Extension_Controller{
    private ApexPages.StandardController sc;
    private Panelist__c panelist;
    public String mode{get;set;}
    public String id{get;set;}
    public String header{get;set;}
    public List<Panelist__c> listPanelist{get;set;}
    
    public Panelist_Extension_Controller(ApexPages.StandardController sc){
        this.sc = sc;
        panelist= (Panelist__c)sc.getRecord();
        
        mode = ApexPages.currentPage().getParameters().get('mode');
        if(mode=='new'){
            header = 'New Panelist';
        }else if(mode=='edit'){
            header = 'Edit Panelist';
        }
    }
    public PageReference save() {
        //PageReference detailPage = sc.save();
        sc.save();
        PageReference viewPage = null;
        panelist= (Panelist__c)sc.getRecord();
        //insert candidate;
        id =panelist.Id;
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='view';
            viewPage = new PageReference('/apex/Panelist_Detail?id='+id+'&mode='+mode);
        //} 
     return viewPage.setRedirect(true);
    }
    
     public PageReference edit() {
        //PageReference detailPage = sc.save();
        PageReference editPage= null;
        panelist = (Panelist__c)sc.getRecord();
        id =panelist.Id;
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='edit';
            editPage= new PageReference('/apex/Panelists_Custom?id='+id+'&mode='+mode);
        //} 
     return editPage.setRedirect(true);
    }
    
    public PageReference cancel() {
        PageReference cancelPage= sc.save();
        PageReference viewPage = null;        
        id =panelist.Id;
        if (cancelPage != null) {
             mode ='view';
            // Construct URL of edit page or whatever other page you want
            viewPage = new PageReference('/apex/Panelist_Detail?id='+id+'&mode='+mode);
        }
        
        return viewPage.setRedirect(true);
    }
    
    
    public void getPanelists(){
        listPanelist = new List<Panelist__c>();
        listPanelist = [select id, Name, First_Name__c, Last_Name__c, Email__c, Round__c,Phone__c  from Panelist__c];
    }
}