with Xab_Events.Event;
with xab_types;

package Xab_Events.Event_Loop is
   --  Starts the main event loop
   procedure start_event_loop (connection : xab_types.xab_connection_t);
private
   procedure handle_event (e : in Xab_Events.Event.Object'Class);
end Xab_Events.Event_Loop;
