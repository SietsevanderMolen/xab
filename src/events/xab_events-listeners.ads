with Xab_Events.Event;

package Xab_Events.Listeners is
   type Listener is tagged private;

   --  Registers a new listener to be notified
   procedure Register_Listener (Handler : in Listener'Class);
   --  Removes a listener from the notification list
   procedure Unregister_Listener (Handler : in Listener'Class);
   --  Notifies listeners of a new event
   procedure Notify_Listeners (E : in Xab_Events.Event.Object'Class);

   type Key_Press_Event_Listener is new Listener with private;
   type Key_Release_Event_Listener is new Listener with private;
   type Map_Event_Listener is new Listener with private;
   type Unmap_Event_Listener is new Listener with private;
   type Button_Press_Event_Listener is new Listener with private;
   --  other event listeners here

private
   type Listener is tagged
      record
         null;
      end record;

   type Key_Press_Event_Listener is new Listener with null record;
   type Key_Release_Event_Listener is new Listener with null record;
   type Map_Event_Listener is new Listener with null record;
   type Unmap_Event_Listener is new Listener with null record;
   type Button_Press_Event_Listener is new Listener with null record;
end Xab_Events.Listeners;
