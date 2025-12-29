public with sharing class ContactTriggerHelper {
    public static void crearLlamada(List<Contact> newContacts) {
        List<Task> calls = new List<Task>();
        for (Contact contact : newContacts) {
            Task call = new Task();
            call.Subject = 'Encuesta satisfacción cliente';
            call.WhoId = contact.Id;
            call.Type = 'Call';
            call.Status = 'Not Started';
            call.OwnerId = contact.OwnerId;

            if (contact.Vip__c) {
                call.Urgente__c = true;
            }
            calls.add(call);
        }
        insert calls;
    }
}