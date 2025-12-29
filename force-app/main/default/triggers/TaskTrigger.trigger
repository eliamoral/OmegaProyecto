trigger TaskTrigger on Task (before update) {
    if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
            TaskTriggerHelper.modificarLlamada(Trigger.new, Trigger.oldMap);
        }
    }
}