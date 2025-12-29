public with sharing class GenerateLostCallsBatch implements Database.Batchable<sObject>, Schedulable {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Date fourteenDaysAgo = Date.today().addDays(-14);
        return Database.getQueryLocator('SELECT Id, OwnerId, WhoId FROM Task WHERE Type = \'Call\' AND Status = \'Not Started\''+
        ' AND CreatedDate = :fourteenDaysAgo');
    }
    public void execute(Database.BatchableContext bc, List<Task> calls) {
        List<Task> newCalls = new List<Task>();
        for (Task call : calls) {
            
            Task newCall = new Task();
            newCall.Subject = 'Encuesta satisfacción cliente';
            newCall.WhoId = call.WhoId;
            newCall.Type = 'Call';
            newCall.Status = 'Not Started';
            newCall.OwnerId = call.OwnerId;
            newCall.ActivityDate = Date.today().addDays(1);

            newCalls.add(newCall);
        }
        insert newCalls;
    }
    public void finish(Database.BatchableContext bc){}
    
    public void execute(SchedulableContext sc){
        GenerateLostCallsBatch b = new GenerateLostCallsBatch();
        Database.executeBatch(b);
    }
}