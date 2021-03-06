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

with Xab_Types;
with xcb;
with xcbada_xproto;
with xcbada_xinerama;

package Xab_Events is
   type Generic_Event is tagged null record;
   function FromXCB (Event : xcb.xcb_generic_event_t)
      return Generic_Event'class;

   type None is new Generic_Event with
      record
         Response_Type : Integer;
      end record;

   type Configure_Request is new Generic_Event with
      record
         Stack_Mode : Xab_Types.Stack_Mode;
         Sequence : Integer;
         Parent : Xab_Types.Window;
         Window : Xab_Types.Window;
         Sibling : Xab_Types.Window;
         X : Integer;
         Y : Integer;
         Width : Integer;
         Height : Integer;
         Border_Width : Integer;
      end record;

   type Map_Request is new Generic_Event with
      record
         Stack_Mode : Xab_Types.Stack_Mode;
         Sequence : integer;
         Parent : Xab_Types.Window;
         Window : Xab_Types.Window;
      end record;
end Xab_Events;
--  vim:ts=3:sts=3:sw=3:expandtab:tw=80
