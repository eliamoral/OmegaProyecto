public with sharing class TaskTriggerHelper {
    public static void modificarLlamada(List<Task> updatedTasks, Map<Id,Task> oldTasks) {
        
        for (Task task : updatedTasks) {
            Integer daysSinceCreated =  task.CreatedDate.date().daysBetween(Date.today());
            
            if (task.Type == 'Call' 
            && oldTasks.get(task.Id).Priority != 'High' && task.Priority == 'High'
            && daysSinceCreated >= 7) {
                task.Urgente__c = true;
            }
        }
    }
}