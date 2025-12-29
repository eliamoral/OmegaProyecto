public with sharing class TaskController {
    @AuraEnabled(cacheable=true)
    public static List<Task> getAllTasks() {
        Date nextWeek = Date.today().addDays(7);
        
        List<Task> tasksList = [
            SELECT Id, ActivityDate, Priority, Status, Subject, Urgente__c
            FROM Task 
            WHERE ActivityDate < :nextWeek AND ActivityDate >= TODAY
                AND Type = 'Call' AND Status = 'Not Started'
            ORDER BY ActivityDate ASC 
            LIMIT 50
        ];

        System.debug(tasksList);

        return tasksList;
    }
}