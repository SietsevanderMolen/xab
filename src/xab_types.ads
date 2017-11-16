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
with Interfaces;
with Ada.Unchecked_Conversion;
with System;

package Xab_Types is
   subtype Bit          is Integer range 0 .. 1;
   subtype Colormap     is Integer;
   subtype Connection   is System.Address;
   subtype Extension    is System.Address;
   subtype Gcontext     is Integer;
   subtype Keycode      is Integer;
   subtype Pixmap       is Integer;
   subtype Randr_Output is Integer;
   subtype Visualid     is Integer;
   subtype Window       is Integer;

   type Screen is record
      Root                  : aliased Window;
      Default_Colormap      : aliased Colormap;
      White_Pixel           : aliased Integer;
      Black_Pixel           : aliased Integer;
      Current_Input_Masks   : aliased Integer;
      Width_In_Pixels       : aliased Integer;
      Height_In_Pixels      : aliased Integer;
      Width_In_Millimeters  : aliased Integer;
      Height_In_Millimeters : aliased Integer;
      Min_Installed_Maps    : aliased Integer;
      Max_Installed_Maps    : aliased Integer;
      Root_Visual           : aliased Visualid;
      Backing_Stores        : aliased Integer;
      Save_Unders           : aliased Integer;
      Root_Depth            : aliased Integer;
      Allowed_Depths_Len    : aliased Integer;
   end record;

   type Stack_Mode is (Above, Below, Top_If, Bottom_If, Opposite);

   type Event_Mask is
   record
      EVENT_MASK_NO_EVENT              : Bit;
      EVENT_MASK_KEY_PRESS             : Bit;
      EVENT_MASK_KEY_RELEASE           : Bit;
      EVENT_MASK_BUTTON_PRESS          : Bit;
      EVENT_MASK_BUTTON_RELEASE        : Bit;
      EVENT_MASK_ENTER_WINDOW          : Bit;
      EVENT_MASK_LEAVE_WINDOW          : Bit;
      EVENT_MASK_POINTER_MOTION        : Bit;
      EVENT_MASK_POINTER_MOTION_HINT   : Bit;
      EVENT_MASK_BUTTON_1_MOTION       : Bit;
      EVENT_MASK_BUTTON_2_MOTION       : Bit;
      EVENT_MASK_BUTTON_3_MOTION       : Bit;
      EVENT_MASK_BUTTON_4_MOTION       : Bit;
      EVENT_MASK_BUTTON_5_MOTION       : Bit;
      EVENT_MASK_BUTTON_MOTION         : Bit;
      EVENT_MASK_KEYMAP_STATE          : Bit;
      EVENT_MASK_EXPOSURE              : Bit;
      EVENT_MASK_VISIBILITY_CHANGE     : Bit;
      EVENT_MASK_STRUCTURE_NOTIFY      : Bit;
      EVENT_MASK_RESIZE_REDIRECT       : Bit;
      EVENT_MASK_SUBSTRUCTURE_NOTIFY   : Bit;
      EVENT_MASK_SUBSTRUCTURE_REDIRECT : Bit;
      EVENT_MASK_FOCUS_CHANGE          : Bit;
      EVENT_MASK_PROPERTY_CHANGE       : Bit;
      EVENT_MASK_COLOR_MAP_CHANGE      : Bit;
      EVENT_MASK_OWNER_GRAB_BUTTON     : Bit;
      Padding                          : Bit;
   end record;
   for Event_Mask use record
      EVENT_MASK_NO_EVENT              at 0 range  0 ..  0;
      EVENT_MASK_KEY_PRESS             at 0 range  1 ..  1;
      EVENT_MASK_KEY_RELEASE           at 0 range  2 ..  2;
      EVENT_MASK_BUTTON_PRESS          at 0 range  3 ..  3;
      EVENT_MASK_BUTTON_RELEASE        at 0 range  4 ..  4;
      EVENT_MASK_ENTER_WINDOW          at 0 range  5 ..  5;
      EVENT_MASK_LEAVE_WINDOW          at 0 range  6 ..  6;
      EVENT_MASK_POINTER_MOTION        at 0 range  7 ..  7;
      EVENT_MASK_POINTER_MOTION_HINT   at 0 range  8 ..  8;
      EVENT_MASK_BUTTON_1_MOTION       at 0 range  9 ..  9;
      EVENT_MASK_BUTTON_2_MOTION       at 0 range 10 .. 10;
      EVENT_MASK_BUTTON_3_MOTION       at 0 range 11 .. 11;
      EVENT_MASK_BUTTON_4_MOTION       at 0 range 12 .. 12;
      EVENT_MASK_BUTTON_5_MOTION       at 0 range 13 .. 13;
      EVENT_MASK_BUTTON_MOTION         at 0 range 14 .. 14;
      EVENT_MASK_KEYMAP_STATE          at 0 range 15 .. 15;
      EVENT_MASK_EXPOSURE              at 0 range 16 .. 16;
      EVENT_MASK_VISIBILITY_CHANGE     at 0 range 17 .. 17;
      EVENT_MASK_STRUCTURE_NOTIFY      at 0 range 18 .. 18;
      EVENT_MASK_RESIZE_REDIRECT       at 0 range 19 .. 19;
      EVENT_MASK_SUBSTRUCTURE_NOTIFY   at 0 range 20 .. 20;
      EVENT_MASK_SUBSTRUCTURE_REDIRECT at 0 range 21 .. 21;
      EVENT_MASK_FOCUS_CHANGE          at 0 range 22 .. 22;
      EVENT_MASK_PROPERTY_CHANGE       at 0 range 23 .. 23;
      EVENT_MASK_COLOR_MAP_CHANGE      at 0 range 24 .. 24;
      EVENT_MASK_OWNER_GRAB_BUTTON     at 0 range 25 .. 25;
      Padding                          at 0 range 26 .. 31;
   end record;
   pragma Pack (Event_Mask);

   function Pack is new Ada.Unchecked_Conversion (Source => Event_Mask,
                                                  Target => Interfaces.Unsigned_32);
   function Unpack is new Ada.Unchecked_Conversion (Source => Interfaces.Unsigned_32,
                                                    Target => Event_Mask);
end Xab_Types;
--  vim:ts=3:sts=3:sw=3:expandtab:tw=80
