trigger CandiadateArrival on Candidate__c (after insert,after update) {

    if(Trigger.isInsert)
    {
        CandiadateArrivalTriggerHelper.InsertCreateCandidateBlitzHistory(trigger.new);
    }

    if(Trigger.isUpdate)
    {
        CandiadateArrivalTriggerHelper.CreateCandidateBlitzHistory(trigger.new,trigger.oldmap);
    }
}