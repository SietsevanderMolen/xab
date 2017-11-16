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
with Ada.Unchecked_Conversion;
with Ada.Text_IO;

package body Xab_Events is
   function FromXCB (Event : xcb.xcb_generic_event_t)
      return Generic_Event'class
   is
      response_type : Integer := Integer (Event.response_type);
   begin
      case response_type is
         when xcbada_xproto.XCB_CONFIGURE_REQUEST =>
            declare
               function Convert is new Ada.Unchecked_Conversion(
                  xcb.xcb_generic_event_t,
                  xcbada_xproto.xcb_configure_request_event_t);
               e  : xcbada_xproto.xcb_configure_request_event_t :=
                  Convert (Event);
               ne : Configure_Request;
            begin
               ne.Stack_Mode := Xab_Types.Stack_Mode'Val (e.stack_mode);
               ne.Parent := Xab_Types.Window (e.parent);
               ne.Window := Xab_Types.Window (e.window);
               ne.Sibling := Xab_Types.Window (e.sibling);
               ne.X := Integer (e.x);
               ne.Y := Integer (e.y);
               ne.Width := Integer (e.width);
               ne.Height := Integer (e.height);
               ne.Border_Width := Integer (e.border_width);
               return ne;
            end;
         when xcbada_xproto.XCB_MAP_REQUEST =>
            declare
               function Convert is new Ada.Unchecked_Conversion(
                  xcb.xcb_generic_event_t,
                  xcbada_xproto.xcb_map_request_event_t);
               e  : xcbada_xproto.xcb_map_request_event_t := Convert (Event);
               ne : Map_Request;
            begin
               ne.Parent := Xab_Types.Window (e.parent);
               ne.Window := Xab_Types.Window (e.window);
               return ne;
            end;
         when others =>
            declare
               ne : None;
            begin
               ne.Response_Type := response_type;
               return ne;
            end;
      end case;
   end FromXCB;
end Xab_Events;
--  vim:ts=3:sts=3:sw=3:expandtab:tw=80
