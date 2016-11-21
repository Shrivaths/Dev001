public class BlitzPanelists_Extension_Controller{
    private ApexPages.StandardController sc;
    private Blitz_Panelists__c blitzPanelists;
    public String mode{get;set;}
    public String id{get;set;}
    public BlitzPanelists_Extension_Controller(ApexPages.StandardController sc){
        this.sc = sc;
        blitzPanelists= (Blitz_Panelists__c)sc.getRecord();
    }
    public PageReference save() {
        //PageReference detailPage = sc.save();
        sc.save();
        PageReference viewPage = null;
        blitzPanelists= (Blitz_Panelists__c)sc.getRecord();
        //insert candidate;
        if(blitzPanelists.Id!=null){
          id =blitzPanelists.Id;
        }
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='view';
            viewPage = new PageReference('/apex/Blitz_Panelists_View?id='+id+'&mode='+mode);
        //} 
     return viewPage.setRedirect(true);
    }
    
     public PageReference edit() {
        //PageReference detailPage = sc.save();
        PageReference editPage= null;
        blitzPanelists= (Blitz_Panelists__c)sc.getRecord();
        
        if(blitzPanelists.Id!=null){
            id =blitzPanelists.Id;
        }
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='edit';
            editPage= new PageReference('/apex/Blitz_Panelists_Edit?id='+id+'&mode='+mode);
        //} 
     return editPage.setRedirect(true);
    }
    
    public PageReference cancel() {
        PageReference cancelPage= sc.save();
        PageReference viewPage = null;        
         if(blitzPanelists.Id!=null){
            id =blitzPanelists.Id;
        }
        if (cancelPage != null) {
             mode ='view';
            // Construct URL of edit page or whatever other page you want
            viewPage = new PageReference('/apex/Blitz_Panelists_View?id='+id+'&mode='+mode);
        }
        
        return viewPage.setRedirect(true);
    }

}