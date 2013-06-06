with xcb;
with xcbada_xproto;

package body Xab_Events.Event_Loop is
   procedure handle_event (e : in Xab_Events.Event.Object'Class) is
   begin
      null;
   end handle_event;

   procedure start_event_loop (connection : xab_types.xab_connection_t)
   is
      ev : xcb.xcb_generic_event_t_p;
      dpy : xcb.xcb_connection_t;

      task Main_Loop is
         entry Start;
      end Main_Loop;
      task body Main_Loop is
      begin
         accept Start;
         loop
            ev := xcb.xcb_wait_for_event (dpy);
         end loop;
      end Main_Loop;
   begin
      null;
   end start_event_loop;
end Xab_Events.Event_Loop;
