with xcb;
with xcbada_xproto;

with Ada.Text_IO;
with Interfaces; use Interfaces;

package body Xab_Events.Event_Loop is
   procedure handle_event (e : in Xab_Events.Event.Object'Class) is
   begin
      null;
   end handle_event;

   procedure start_event_loop (connection : xab_types.xab_connection_t)
   is
      vi     : Integer;
      pragma Unreferenced (vi);
      vc     : xcb.xcb_void_cookie_t;
      pragma Unreferenced (vc);
      ev : xcb.xcb_generic_event_t_p;
      dpy : xcb.xcb_connection_t := xcb.xcb_connection_t (connection);
      root   : xcbada_xproto.xcb_drawable_t;
      screen : access xcbada_xproto.xcb_screen_t;
      task Main_Loop is
      end Main_Loop;
      task body Main_Loop is
      begin
         screen := xcbada_xproto.xcb_setup_roots_iterator (xcb.get_setup (dpy)).data;
         root := screen.root;
         --  Left mouse button
         vc := xcbada_xproto.xcb_grab_button (dpy, 0, root,
                  xcbada_xproto.XCB_EVENT_MASK_BUTTON_PRESS or xcbada_xproto.XCB_EVENT_MASK_BUTTON_RELEASE,
                  xcbada_xproto.XCB_GRAB_MODE_ASYNC, xcbada_xproto.XCB_GRAB_MODE_ASYNC, root, xcb.XCB_NONE, 1,
                  xcbada_xproto.XCB_MOD_MASK_ANY);
         --  Right mouse button
         vc := xcbada_xproto.xcb_grab_button (dpy, 0, root,
                  xcbada_xproto.XCB_EVENT_MASK_BUTTON_PRESS or xcbada_xproto.XCB_EVENT_MASK_BUTTON_RELEASE,
                  xcbada_xproto.XCB_GRAB_MODE_ASYNC, xcbada_xproto.XCB_GRAB_MODE_ASYNC, root, xcb.XCB_NONE, 3,
                  xcbada_xproto.XCB_MOD_MASK_ANY);
         vi := xcb.flush (dpy);

         Ada.Text_IO.Put_Line ("starting loop");
         loop
            ev := xcb.wait_for_event (dpy);
            declare
               i : Integer := Integer (ev.all.response_type);
            begin
               --Ada.Text_IO.Put_Line (Interfaces.Unsigned_8'Image (ev.all.response_type));
               Ada.Text_IO.Put_Line ("Got event type: " & Integer'Image (i));
            end;
         end loop;
      end Main_Loop;
   begin
      null;
   end start_event_loop;
end Xab_Events.Event_Loop;
