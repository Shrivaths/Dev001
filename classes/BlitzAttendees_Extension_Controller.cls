public class BlitzAttendees_Extension_Controller{
    private ApexPages.StandardController sc;
    private Blitz_Attendees__c blitzAttendees;
    public String mode{get;set;}
    public String id{get;set;}
    public String header{get;set;}
    public BlitzAttendees_Extension_Controller(ApexPages.StandardController sc){
        this.sc = sc;
        blitzAttendees= (Blitz_Attendees__c)sc.getRecord();
        mode = ApexPages.currentPage().getParameters().get('mode');
        if(mode=='new'){
            header = 'New Blitz Attendees';
        }else if(mode=='edit'){
            header = 'Edit Blitz Attendees';
        }
    }
    public PageReference save() {
        //PageReference detailPage = sc.save();
        sc.save();
        PageReference viewPage = null;
        blitzAttendees= (Blitz_Attendees__c)sc.getRecord();
        //insert candidate;
        if(blitzAttendees.Id!=null){
          id =blitzAttendees.Id;
        }
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='view';
            viewPage = new PageReference('/apex/Blitz_Attendees_View?id='+id+'&mode='+mode);
        //} 
     return viewPage.setRedirect(true);
    }
    
     public PageReference edit() {
        //PageReference detailPage = sc.save();
        PageReference editPage= null;
        blitzAttendees= (Blitz_Attendees__c)sc.getRecord();
        
        if(blitzAttendees.Id!=null){
            id =blitzAttendees.Id;
        }
       // if (detailPage != null) {
            
            // Construct URL of edit page or whatever other page you want
            mode ='edit';
            editPage= new PageReference('/apex/Blitz_Attendees_Edit?id='+id+'&mode='+mode);
        //} 
     return editPage.setRedirect(true);
    }
    
    public PageReference cancel() {
        PageReference cancelPage= sc.save();
        PageReference viewPage = null;        
         if(blitzAttendees.Id!=null){
            id =blitzAttendees.Id;
        }
        if (cancelPage != null) {
             mode ='view';
            // Construct URL of edit page or whatever other page you want
            viewPage = new PageReference('/apex/Blitz_Attendees_View?id='+id+'&mode='+mode);
        }
        
        return viewPage.setRedirect(true);
    }

}