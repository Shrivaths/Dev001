public class CandidateAssesment_Extension_Controller{
    
    private ApexPages.StandardController sc;
    private Candidate_Assesment__c candidateAssesment;
    public String mode{get;set;}
    public String id{get;set;}
    public CandidateAssesment_Extension_Controller(ApexPages.StandardController sc){
        this.sc = sc;
        candidateAssesment = (Candidate_Assesment__c )sc.getRecord();
    }
    
    public PageReference save() {
        //PageReference detailPage = sc.save();
        PageReference viewPage = null;
        if(candidateAssesment!=null){
            upsert candidateAssesment;
            id =candidateAssesment.Id;
        }
        if (id != null) {
            // Construct URL of edit page or whatever other page you want
            mode ='view';
            viewPage = new PageReference('/apex/Candidate_Assesment_Detail?id='+id+'&mode='+mode);
        }
        
        return viewPage.setRedirect(true);
    }
    
    public PageReference cancel() {
        PageReference cancelPage = sc.cancel();
        PageReference viewPage = null;        
        if(candidateAssesment!=null){
            id =candidateAssesment.Id;}
        
        // Construct URL of edit page or whatever other page you want
        mode ='view';
        viewPage = new PageReference('/apex/Candidate_Assesment_Detail?id='+id+'&mode='+mode);
        return viewPage.setRedirect(true);


    }
    
    public PageReference Edit() {
        PageReference viewPage = null;        
        if(candidateAssesment!=null){
            id =candidateAssesment.Id;}
        mode ='view';
        viewPage = new PageReference('/apex/Candidate_Assesment_Edit?id='+id+'&mode='+mode);
        return viewPage.setRedirect(true);
        return null;
    } 

}