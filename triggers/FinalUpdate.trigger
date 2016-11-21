trigger FinalUpdate on Blitz_Attendees__c (after update) {

    if(Trigger.isUpdate)
    {
        FinalUpdateTriggerHelper.UpdateCandidateBlitzHistory(trigger.new,trigger.oldmap);
        FinalUpdateTriggerHelper.UpdatePanelistSendNotification(trigger.new,trigger.oldmap);
    }

}