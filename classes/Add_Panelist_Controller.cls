public class Add_Panelist_Controller{
    
    public List<wrapPanelist> lstWrapPanelist {get;set;}
    public boolean disableBtn{get;set;}
    public String type{get;set;}
    public list<selectOption> lstPanelistsName{get;set;}
    public String location {get;set;}
        
    public Add_Panelist_Controller(){
        lstPanelistsName = new List<selectOption>();
        String blitzId =  ApexPages.currentPage().getParameters().get('blitzId');
        String SPOCLOCId = ApexPages.currentPage().getParameters().get('SPOCLOCId');
        System.Debug('SPOCLOCId'+SPOCLOCId +'blitzId'+blitzId);
        lstWrapPanelist = new List<wrapPanelist>();
          String query = 'select Blitz_Plan__c, Location_SPOC_s__c, Blitz_Type__c from Blitz_SPOC__c where Blitz_Plan__c = :blitzId and Location_SPOC_s__c = :SPOCLOCId';
        List<Blitz_SPOC__c> lstBlitz = Database.query(query);
        System.Debug('list of blitz spoc'+lstBlitz);
        type = lstBlitz.get(0).Blitz_Type__c;
        List<Location_SPOC_s__c> lstLocation = [select Id, SPOC_Location__c from Location_SPOC_s__c where Id=:SPOCLOCId];
        location = lstLocation.get(0).SPOC_Location__c;
        System.Debug('location'+location);
        String queryStr = 'select Id, First_Name__c, Last_Name__c,Location__c from Panelist__c where Location__c = :location';
        List<Panelist__c> lstPanelist = Database.query(queryStr);
        for(Panelist__c p : lstPanelist){
            String firstName = p.First_Name__c;
            lstPanelistsName.add(new selectOption(firstName,firstName)); 
            System.Debug('lstPanelistsName'+lstPanelistsName); 
            wrapPanelist panelist = new wrapPanelist(p);
            lstWrapPanelist.add(panelist);
        }
    }
    
    public void PanelistChange(){
    
        
    }
    
    public void addPanelistRow(){
    
    }
    
    public void savePanelist(){
    
    }
    
    public void removePanelist(){
    
    }
    
    public class wrapPanelist{       
        public Panelist__c panelist{get; set;}
        public String btnUrl{get;set;}
        public String selPanelist{get;set;} 
        public String panelistName{get;set;}
        public boolean checkBoxVal{get;set;}
        //public wrapPanelist(Blitz_Panelists__c blitzPnlst) {     
        public wrapPanelist(Panelist__c pnlist) { 
           panelist=pnlist;
           panelistName = pnlist.First_Name__c;
           
        }  
        public void sendInvite(){
            
        } 
   /*     public PageReference redirectToEdit(){ 
            String url1 = ApexPages.currentPage().getUrl(); 
            String correctURL = url1.split('//?')[0];
            String url = '/'+iia.Id+'/e?retURL='+Label.IA_ReturnURL;  
            PageReference editPage= new PageReference(url);
            editPage.setRedirect(true);
            return editPage;
        }  */
    }
}