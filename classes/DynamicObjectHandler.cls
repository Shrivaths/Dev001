public class DynamicObjectHandler {
  public String selectedObj{get;set;}
  public String childObjl{get;set;}
 
public List<SelectOption> getobjName(){
    List<Schema.SObjectType> sobjType= Schema.getGlobalDescribe().Values();     
    List<SelectOption> options = new List<SelectOption>();

    for(Schema.SObjectType sObjVar : sobjType){
       options.add(new SelectOption(sObjVar.getDescribe().getLabel(),sObjVar.getDescribe().getLabel()));
    }
return options;
}
public List<SelectOption> getchildObjName(){
    Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
    System.debug('selectedObj ***'+ selectedObj);
    System.debug('gd ***'+ gd);
    Schema.SObjectType sobjType = gd.get(selectedObj);
    System.debug('sobjType ***'+ sobjType );
    Schema.DescribeSObjectResult describeresult = sobjType.getDescribe();
    List<Schema.ChildRelationship> sChildObj = describeresult.getChildRelationships(); 
    List<SelectOption> options = new List<SelectOption>();
    for(Schema.ChildRelationship sChildObjVar:sChildObj){
        //options.add(new SelectOption(sChildObjVar.childSObject,sChildObjVar.childSObject));
    }
return options;
}
}