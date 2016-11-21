public class BlitzSPOC_Extension_Controller{
    private ApexPages.StandardController sc;
    private Blitz_SPOC__c blitzSPOC;
    public String mode{get;set;}
    public String id{get;set;}
    public BlitzSPOC_Extension_Controller(ApexPages.StandardController sc){
        this.sc = sc;
        blitzSPOC= (Blitz_SPOC__c)sc.getRecord();
    }
    public PageReference save() {
        //PageReference detailPage = sc.save();
        sc.save();
        PageReference viewPage = null;
        blitzSPOC= (Blitz_SPOC__c)sc.getRecord();
        //insert candidate;
        if(blitzSPOC.Id!=null){
          id =blitzSPOC.Id;
        }
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='view';
            viewPage = new PageReference('/apex/Blitz_SPOC_View?id='+id+'&mode='+mode);
        //} 
     return viewPage.setRedirect(true);
    }
    
     public PageReference edit() {
        //PageReference detailPage = sc.save();
        PageReference editPage= null;
        blitzSPOC = (Blitz_SPOC__c)sc.getRecord();
        
        if(blitzSPOC.Id!=null){
            id =blitzSPOC.Id;
        }
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='edit';
            editPage= new PageReference('/apex/Blitz_SPOC_Edit?id='+id+'&mode='+mode);
        //} 
     return editPage.setRedirect(true);
    }
    
    public PageReference cancel() {
        PageReference cancelPage= sc.save();
        PageReference viewPage = null;        
         if(blitzSPOC.Id!=null){
            id =blitzSPOC.Id;
        }
        if (cancelPage != null) {
             mode ='view';
            // Construct URL of edit page or whatever other page you want
            viewPage = new PageReference('/apex/Blitz_SPOC_View?id='+id+'&mode='+mode);
        }
        
        return viewPage.setRedirect(true);
    }

}