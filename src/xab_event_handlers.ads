with Xab_Event_Listeners;

package Xab_Event_Handlers is
   
   type Event_Handler is Interface;
   procedure Register_Listener(Handler : in Event_Handler) is abstract;
   procedure Unregister_Listener(Handler : in Event_Handler) is abstract;
   procedure Notify_Listeners is abstract;
   
end Xab_Event_Handlers;
