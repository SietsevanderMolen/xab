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

with System,
     Interfaces.C,
     Interfaces.C.Strings;
with xcb;
with xcbada_xproto;
with xcbada_xinerama;

with Xab_Events;
with Xab_Types;

package Xab is
   type Integer_Array is array (Natural range <>) of Integer;

   --  Connect to xcb using env variables for both the display
   --  and the screen
   function Connect return Xab_Types.Connection;

   --  Connect to xcb using an env variable for the screen
   function Connect (Display_Name : String)
                         return Xab_Types.Connection;

   --  Connect to xcb
   function Connect (Display_Name : String;
                     Screen   : Xab_Types.Screen)
      return Xab_Types.Connection;

   --  Return the root screen for this connection
   function Get_Root_Screen (Connection : Xab_Types.Connection)
      return Xab_Types.Screen;

   --  Check wether the Xinerama extension is available on this connection
   function Has_Xinerama (Connection : Xab_Types.Connection)
      return Boolean;

   --  Check wether the RandR extension is available on this connection
   function Has_Randr (Connection : Xab_Types.Connection)
      return Boolean;

   --  Helper procedure to configure a window
   procedure Configure_Window (Connection : Xab_Types.Connection;
                               Win : Xab_Types.Window;
                               X : Integer;
                               Y : Integer;
                               Width : Integer;
                               Height : Integer);

   --  Change a window's attributes
   procedure Change_Window_Attributes (Connection : Xab_Types.Connection;
                                       Win : Xab_Types.Window;
                                       Value_Mask : Xab_Types.Event_Mask;
                                       Value_List : Integer_Array)
   with
      Pre => (Value_List'Length = 12);

   --  Maps a window
   procedure Map_Window (Connection : Xab_Types.Connection;
                             Window : Xab_Types.Window);

   --  Wait for an event on the connection
   function Wait_For_Event (Connection : Xab_Types.Connection)
      return Xab_Events.Generic_Event'class;
private
   --  An access type to the xcb_screen type
   type xcb_screen_ptr is access all xcbada_xproto.xcb_screen_t;
   Null_Screen : constant xcb_screen_ptr := null;

   function Xab_Screen_To_xcb_screen (xabscreen : Xab_Types.Screen)
      return xcbada_xproto.xcb_screen_t;

   function Xcb_Screen_To_Xab_Screen (xcbscreen : xcbada_xproto.xcb_screen_t)
      return Xab_Types.Screen;

   --  Check a connection for errors
   --  @Raises: ConnectionFailedException
   procedure Check_Connection (Connection : Xab_Types.Connection);
end Xab;
--  vim:ts=3:sts=3:sw=3:expandtab:tw=80
