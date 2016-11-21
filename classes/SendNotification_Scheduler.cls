global class SendNotification_Scheduler implements Schedulable{



    global void execute(SchedulableContext sc) {

        SendNotificationToPanelist b1 = new SendNotificationToPanelist();
        Database.executeBatch(b1);           
    }
}