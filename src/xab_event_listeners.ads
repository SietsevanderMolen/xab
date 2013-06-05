package Xab_Event_Listeners is
   
   type Event_Listener is Interface;
   procedure Notify_Handler is abstract;
   
end Xab_Event_Listeners;
