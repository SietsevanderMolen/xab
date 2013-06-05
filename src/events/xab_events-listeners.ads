with Ada.Containers.Indefinite_Vectors; use Ada.Containers;

with Xab_Events.Event;

package Xab_Events.Listeners is
   type Listener is tagged private;
   type Listener_Access is access all Listener'Class;
   package Listener_Container is new Indefinite_Vectors (Natural, Listener_Access);

   --  Registers a new listener to be notified
   procedure Register_Listener (L : in out Listener'Class;
                                H : in Listener_Access);
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
         Listener_List : Listener_Container.Vector;
      end record;

   type Key_Press_Event_Listener is new Listener with null record;
   type Key_Release_Event_Listener is new Listener with null record;
   type Map_Event_Listener is new Listener with null record;
   type Unmap_Event_Listener is new Listener with null record;
   type Button_Press_Event_Listener is new Listener with null record;
end Xab_Events.Listeners;
