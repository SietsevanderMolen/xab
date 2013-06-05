package Xab_Events is
   --  Implement event types here
   --  ...

   type Listener is Interface;
   --  Registers a new listener to be notified
   procedure Register_Listener (Handler : in Listener) is abstract;
   --  Removes a listener from the notification list
   procedure Unregister_Listener (Handler : in Listener) is abstract;

   --  Notifies listeners of a new event
   --  procedure Notify_Listeners (E : in Event) is abstract;
end Xab_Events;
