trigger AccountDetailTrigger on Account (before insert, before Update, before delete, after Insert, after Update, after delete) {
    TriggerEventRouter.route(new AccountTriggerHandler());
}