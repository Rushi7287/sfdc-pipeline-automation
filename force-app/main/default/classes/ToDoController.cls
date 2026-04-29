public with sharing class ToDoController {
    @AuraEnabled(cacheable=true)
    public static List<ToDo_List__c> getLists() {
        return [SELECT Id, Name FROM ToDo_List__c ORDER BY Name];
    }

    @AuraEnabled(cacheable=true)
    public static List<ToDo_Task__c> getTasks(Id listId) {
        return [
            SELECT Id, Name, Is_Completed__c, Due_Date__c
            FROM ToDo_Task__c
            WHERE List__c = :listId
            ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static void updateTaskStatus(Id taskId, Boolean isCompleted) {
        ToDo_Task__c task = [SELECT Id FROM ToDo_Task__c WHERE Id = :taskId LIMIT 1];
        task.Is_Completed__c = isCompleted;
        update task;
    }

    @AuraEnabled
    public static void createTask(String name, Id listId) {
        insert new ToDo_Task__c(Name = name, List__c = listId);
    }

    @AuraEnabled
    public static void createList(String name) {
        insert new ToDo_List__c(Name = name);
    }
}