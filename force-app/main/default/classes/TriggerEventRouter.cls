// This is Trigger Handler For all the Trigger

public class TriggerEventRouter {

	public Enum TriggerEvents {beforeInsert, beforeUpdate, beforeDelete, afterInsert, afterUpdate, afterDelete, afterUndelete}

	public static void route(ITriggerHandler handler){
		TriggerContext tContext = new TriggerContext(handler);
	}

    public class TriggerContext {

        public String sObjectName {get;set;}

        public String handlerName {get;set;}

        public TriggerEventRouter.TriggerEvents eventName {get;set;}

        public boolean possibleRecursion {get;set;}

        public final ITriggerHandler handler {get;set;}

        public TriggerContext(ITriggerHandler handler) {

            this.handler = handler;

            this.possibleRecursion = false;

            if(Trigger.new != NULL) {
                this.sObjectName = Trigger.new[0].getSObjectType().getDescribe().getName();  
            } else {
                this.sObjectName = Trigger.old[0].getSObjectType().getDescribe().getName();
            }
            
            if(Trigger.IsBefore){
                if (Trigger.IsInsert)
                    eventName = TriggerEventRouter.TriggerEvents.beforeInsert;                
                if (Trigger.IsUpdate)
                    eventName = TriggerEventRouter.TriggerEvents.beforeUpdate;
                if (Trigger.IsDelete)
                    eventName = TriggerEventRouter.TriggerEvents.beforeDelete;
            } else {
                if (Trigger.IsInsert)
                    eventName = TriggerEventRouter.TriggerEvents.afterInsert;
                if (Trigger.IsUpdate)
                    eventName = TriggerEventRouter.TriggerEvents.afterUpdate;              
                if (trigger.IsDelete)
                    eventName = TriggerEventRouter.TriggerEvents.afterDelete;
                if (trigger.isUndelete)
                    eventName = TriggerEventRouter.TriggerEvents.afterUndelete;
            } 

            this.handlerName = handler != NULL ? String.valueOf(handler).split(':')[0] : '';
        }
        
        public String getName() {
            return this.sObjectName + this.eventName.name() + this.handlerName;
        }
        
        public TriggerContext getCopy() {

            TriggerContext tContext = new TriggerContext(NULL);
            tContext.eventName = this.eventName;
            tContext.sObjectName = this.sObjectName;
            tContext.handlerName = this.handlerName;
            tContext.possibleRecursion = this.possibleRecursion;
            return tContext;
        }
    }
}