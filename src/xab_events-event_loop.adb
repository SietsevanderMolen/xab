-------------------------------------------------------------------------------
--                                                                           --
--                   Copyright (C) 2012-, Sietse van der Molen               --
--                                                                           --
--    This file is part of XAB.                                              --
--                                                                           --
--    XAB is free software: you can redistribute it and/or modify            --
--    it under the terms of the GNU General Public License as published by   --
--    the Free Software Foundation, either version 3 of the License, or      --
--    (at your option) any later version.                                    --
--                                                                           --
--    XAB is distributed in the hope that it will be useful,                 --
--    but WITHOUT ANY WARRANTY; without even the implied warranty of         --
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          --
--    GNU General Public License for more details.                           --
--                                                                           --
--    You should have received a copy of the GNU General Public License      --
--    along with XAB.  If not, see <http://www.gnu.org/licenses/>.           --
--                                                                           --
-------------------------------------------------------------------------------

with xcb;
with xcbada_xproto;

with Ada.Text_IO;
with Ada.Unchecked_Conversion;
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
      vc     : xcb.xcb_void_cookie_t;  -- used when a cookie is not necessary
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
               response_type : Integer := Integer (ev.response_type);
               function Convert is new Ada.Unchecked_Conversion(
                  xcb.xcb_generic_event_t_p,
                  xcbada_xproto.xcb_button_press_event_t_p);
            begin
               --Ada.Text_IO.Put_Line (Interfaces.Unsigned_8'Image (ev.all.response_type));
               Ada.Text_IO.Put_Line ("Got ev type: " & Integer'Image (response_type));
               case response_type is
                  when xcbada_xproto.XCB_BUTTON_PRESS =>
                     declare
                        event : xcbada_xproto.xcb_button_press_event_t_p :=
                                Convert (ev);
                        event_x : String := Interfaces.Unsigned_16'Image (event.event_x);
                     begin
                        Ada.Text_IO.Put_Line ("Button press at " & event_x);
                     end;
                  when others =>
                        Ada.Text_IO.Put_Line ("Unhandled event: " &
                        Integer'Image (response_type));
               end case;
            end;
         end loop;
      end Main_Loop;
   begin
      null;
   end start_event_loop;
end Xab_Events.Event_Loop;
--  vim:ts=3:expandtab:tw=80
