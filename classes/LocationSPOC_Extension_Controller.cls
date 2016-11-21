public class LocationSPOC_Extension_Controller{
    private ApexPages.StandardController sc;
    private Location_SPOC_s__c locSPOC;
    public String mode{get;set;}
    public String id{get;set;}
    public LocationSPOC_Extension_Controller(ApexPages.StandardController sc){
        this.sc = sc;
        locSPOC= (Location_SPOC_s__c)sc.getRecord();
    }
    public PageReference save() {
        //PageReference detailPage = sc.save();
        sc.save();
        PageReference viewPage = null;
        locSPOC= (Location_SPOC_s__c)sc.getRecord();
        //insert candidate;
        if(locSPOC.Id!=null){
          id =locSPOC.Id;
        }
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='view';
            viewPage = new PageReference('/apex/Location_SPOC_View?id='+id+'&mode='+mode);
        //} 
     return viewPage.setRedirect(true);
    }
    
     public PageReference edit() {
        //PageReference detailPage = sc.save();
        PageReference editPage= null;
        locSPOC= (Location_SPOC_s__c)sc.getRecord();
        
        if(locSPOC.Id!=null){
            id =locSPOC.Id;
        }
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='edit';
            editPage= new PageReference('/apex/Location_SPOC_Edit?id='+id+'&mode='+mode);
        //} 
     return editPage.setRedirect(true);
    }
    
    public PageReference cancel() {
        PageReference cancelPage= sc.save();
        PageReference viewPage = null;        
         if(locSPOC.Id!=null){
            id =locSPOC.Id;
        }
        if (cancelPage != null) {
             mode ='view';
            // Construct URL of edit page or whatever other page you want
            viewPage = new PageReference('/apex/Location_SPOC_View?id='+id+'&mode='+mode);
        }
        
        return viewPage.setRedirect(true);
    }

}