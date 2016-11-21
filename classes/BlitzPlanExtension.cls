public class BlitzPlanExtension {

    public BlitzPlanExtension(ApexPages.StandardController controller) {
    blitzplan = [Select Name, Blitz_Planned_Date__c from Blitz_Plan__c limit 100 ];
    }


public List<Blitz_Plan__c> blitzplan{get;set;}

     public BlitzPlanExtension() {

         blitzplan = [Select Name, Blitz_Planned_Date__c from Blitz_Plan__c limit 100 ];

      }

}