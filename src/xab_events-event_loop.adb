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

with Xab; use Xab;
with Xab_Types;

package body Xab_Events.Event_Loop is
   procedure start_event_loop (connection : Xab_Types.Connection)
   is
      vi     : Integer;
      pragma Unreferenced (vi);
      vc     : xcb.xcb_void_cookie_t;  -- used when a cookie is not necessary
      pragma Unreferenced (vc);
      ev : xcb.xcb_generic_event_t_p;
      events_we_listen_to : aliased xcbada_xproto.xcb_event_mask_t :=
         (xcbada_xproto.XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT or
         xcbada_xproto.XCB_EVENT_MASK_STRUCTURE_NOTIFY or
         xcbada_xproto.XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY);
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
      -- other events
      vc := xcbada_xproto.xcb_change_window_attributes (dpy, root, xcbada_xproto.XCB_CW_EVENT_MASK,
                                                        events_we_listen_to'Access);
      vi := xcb.flush (dpy);

      loop
         ev := xcb.wait_for_event (dpy);
         declare
            response_type : Integer := Integer (ev.response_type);
         begin
            Ada.Text_IO.Put_Line ("Got ev type: " & Integer'Image (response_type));
            case response_type is
               when xcbada_xproto.XCB_BUTTON_PRESS =>
                  declare
                     function Convert is new Ada.Unchecked_Conversion(
                        xcb.xcb_generic_event_t, xcbada_xproto.xcb_button_press_event_t);
                     event : xcbada_xproto.xcb_button_press_event_t := Convert (ev.all);
                     event_x : String := Interfaces.Integer_16'Image (event.event_x);
                     begin
                        Ada.Text_IO.Put_Line ("Button press at " & event_x);
                     end;
               when xcbada_xproto.XCB_CONFIGURE_REQUEST =>
                  declare
                     function Convert is new Ada.Unchecked_Conversion(
                        xcb.xcb_generic_event_t, xcbada_xproto.xcb_configure_request_event_t);
                     event : xcbada_xproto.xcb_configure_request_event_t := Convert (ev.all);
                     mask : String := Interfaces.Unsigned_16'Image (event.value_mask);
                  begin
                     Ada.Text_IO.Put_Line ("configure request with X: " & Interfaces.Integer_16'Image (event.x));
                     Ada.Text_IO.Put_Line ("configure request with Y: " & Interfaces.Integer_16'Image(event.y));
                     Ada.Text_IO.Put_Line ("configure request with Width: " & Interfaces.Unsigned_16'Image (event.width));
                     Ada.Text_IO.Put_Line ("configure request with Height: " & Interfaces.Unsigned_16'Image (event.height));
                     Xab.Configure_Window (dpy, Integer(event.window),
                                                Integer (event.x), Integer (event.y),
                                                Integer (event.width), Integer (event.height)); 
                  end;
               when xcbada_xproto.XCB_MAP_REQUEST =>
                  declare
                     function Convert is new Ada.Unchecked_Conversion(
                        xcb.xcb_generic_event_t, xcbada_xproto.xcb_map_request_event_t);
                     event : xcbada_xproto.xcb_map_request_event_t := Convert (ev.all);
                     begin
                        Ada.Text_IO.Put_Line ("map request");
                        Xab.Map_Window (dpy, Xab_Types.Window (event.window));
                     end;
               when others =>
                  Ada.Text_IO.Put_Line ("Unhandled event: " & Integer'Image (response_type));
            end case;
         end;
      end loop;
   end Main_Loop;
begin
   null;
end start_event_loop;
end Xab_Events.Event_Loop;
--  vim:ts=3:expandtab:tw=80
