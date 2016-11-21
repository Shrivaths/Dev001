public class importDataFromCSVController {
public Blob csvFileBody{get;set;}
public string csvAsString{get;set;}
public String[] csvFileLines{get;set;}
public List<wrapCandidate> wrapCandList{get;set;}
public List<Candidate__c> savedCands{get; set;}
public List<Candidate__c> deletedCands{get; set;}
public List<Candidate__c> allCandList{get;set;}
public boolean exportButton{get;set;}
public boolean sendEmailButton{get; set;}
//public List<wrapCandidate> candDupList{get;set;}
  public importDataFromCSVController(){
    csvFileLines = new String[]{};
    wrapCandList = New List<wrapCandidate>(); 
    //candDupList = New List<wrapCandidate>();
    allCandList = New List<Candidate__c>();
    exportButton = true;
    sendEmailButton = true;
   }
  
  public void importCSVFile(){
       try{
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
           wrapCandList = New List<wrapCandidate>(); 
           allCandList = [SELECT First_Name__c,Last_Name__c,Email__c,Phone__c,PAN_Number__c FROM Candidate__c ORDER BY CreatedDate DESC]; 
           for(Integer i=1;i<csvFileLines.size();i++){
               Candidate__c candObj = new Candidate__c() ;
               string[] csvRecordData = csvFileLines[i].split(',');
               candObj.First_Name__c= csvRecordData[0] ;             
               candObj.Last_Name__c= csvRecordData[1];
               candObj.Phone__c= csvRecordData[2];
               candObj.Email__c= csvRecordData[3];
               candObj.PAN_Number__c= csvRecordData[4];
               candObj.Capability__c= csvRecordData[5];   
               candObj.Total_Experience_In_Months__c = Integer.valueOf(csvRecordData[6]);
               candObj.Current_Company__c= csvRecordData[7];
               //candObj.Last_Blitz_Attended__c= Date.valueOf(csvRecordData[8]);
               candObj.Source__c= csvRecordData[9];
               //candObj.Blitz_Date__c= Date.valueOf(csvRecordData[10]);                                                                             
                
               for(Candidate__c c: allCandList)
                   {
                       if((c.Email__c==candObj.Email__c)||(c.PAN_Number__c==candObj.PAN_Number__c)||
                       ((c.First_Name__c==candObj.First_Name__c) && (c.Last_Name__c==candObj.Last_Name__c) && (c.Phone__c==candObj.Phone__c))||((c.Email__c==candObj.Email__c)&&(c.Phone__c==candObj.Phone__c)))
                       {
                           candObj.Duplicate_Record__c = URL.getSalesforceBaseUrl().toExternalForm() + '/' + c.Id;
                       }
                   }
               wrapCandList.add(new wrapCandidate(candObj));
              
           }
        //insert candList;
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }  
  }
  
  public void removeSelected(){
      exportButton = false;
      sendEmailButton = false;
      savedCands = new List<Candidate__c>();
      deletedCands = new List<Candidate__c>();
      
      for(wrapCandidate wrapcan : wrapCandList)
      {
          if(wrapcan.isSelected==true)
          {
          deletedCands.add(wrapcan.Cand); 
          }else{
          savedCands.add(wrapcan.Cand);
          }
      }
      //delete deletedCands;
      wrapCandList = new List<wrapCandidate>();
      for(Candidate__c sc : savedCands)
      {
      wrapCandList.add(new wrapCandidate(sc));
      } 
      
      //delete deletedCands;
     
      
  }
  
  public void sendEmail(){
  }
  
  public void exportAsCSV(){
  }
  /* Wrapper Class*/
  public class wrapCandidate{
  public Candidate__c Cand{get;set;}
  public boolean isSelected{get;set;}
      public wrapCandidate(Candidate__c c){
          Cand = c;
          isSelected = true;
      }
  
}
}