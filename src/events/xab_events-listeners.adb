package body Xab_Events.Listeners is
   --  Registers a new listener to be notified
   procedure Register_Listener (L : in out Listener'Class;
                                H : in Listener_Access)
   is
   begin
      L.Listener_List.Append (New_Item => H);
   end Register_Listener;

   --  Removes a listener from the notification list
   procedure Unregister_Listener (Handler : in Listener'Class)
   is
   begin
      null;
   end Unregister_Listener;

   --  Notifies listeners of a new event
   procedure Notify_Listeners (E : in Xab_Events.Event.Object'Class)
   is
   begin
      null;
   end Notify_Listeners;
end Xab_Events.Listeners;
