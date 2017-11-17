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
   type Integer_Array is array (Natural range <>) of Integer;

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

   type CW is
      record
         BACK_PIXMAP        : Bit := 0;
         BACK_PIXEL         : Bit := 0;
         BORDER_PIXMAP      : Bit := 0;
         BORDER_PIXEL       : Bit := 0;
         BIT_GRAVITY        : Bit := 0;
         WIN_GRAVITY        : Bit := 0;
         BACKING_STORE      : Bit := 0;
         BACKING_PLANES     : Bit := 0;
         BACKING_PIXEL      : Bit := 0;
         OVERRIDE_REDIRECT  : Bit := 0;
         SAVE_UNDER         : Bit := 0;
         EVENT_MASK         : Bit := 0;
         DONT_PROPAGATE     : Bit := 0;
         COLORMAP           : Bit := 0;
         CURSOR             : Bit := 0;
         Padding            : Bit := 0;
      end record;
   for CW use
      record
         BACK_PIXMAP        at 0 range  0 ..  0;
         BACK_PIXEL         at 0 range  1 ..  1;
         BORDER_PIXMAP      at 0 range  2 ..  2;
         BORDER_PIXEL       at 0 range  3 ..  3;
         BIT_GRAVITY        at 0 range  4 ..  4;
         WIN_GRAVITY        at 0 range  5 ..  5;
         BACKING_STORE      at 0 range  6 ..  6;
         BACKING_PLANES     at 0 range  7 ..  7;
         BACKING_PIXEL      at 0 range  8 ..  8;
         OVERRIDE_REDIRECT  at 0 range  9 ..  9;
         SAVE_UNDER         at 0 range 10 .. 10;
         EVENT_MASK         at 0 range 11 .. 11;
         DONT_PROPAGATE     at 0 range 12 .. 12;
         COLORMAP           at 0 range 13 .. 13;
         CURSOR             at 0 range 14 .. 14;
         Padding            at 0 range 15 .. 31;
      end record;
   function Pack is new Ada.Unchecked_Conversion (Source => CW,
                                                  Target => Interfaces.Unsigned_32);
   function Unpack is new Ada.Unchecked_Conversion (Source => Interfaces.Unsigned_32,
                                                    Target => CW);

   type Event_Mask is
   record
      NO_EVENT              : Bit := 0;
      KEY_PRESS             : Bit := 0;
      KEY_RELEASE           : Bit := 0;
      BUTTON_PRESS          : Bit := 0;
      BUTTON_RELEASE        : Bit := 0;
      ENTER_WINDOW          : Bit := 0;
      LEAVE_WINDOW          : Bit := 0;
      POINTER_MOTION        : Bit := 0;
      POINTER_MOTION_HINT   : Bit := 0;
      BUTTON_1_MOTION       : Bit := 0;
      BUTTON_2_MOTION       : Bit := 0;
      BUTTON_3_MOTION       : Bit := 0;
      BUTTON_4_MOTION       : Bit := 0;
      BUTTON_5_MOTION       : Bit := 0;
      BUTTON_MOTION         : Bit := 0;
      KEYMAP_STATE          : Bit := 0;
      EXPOSURE              : Bit := 0;
      VISIBILITY_CHANGE     : Bit := 0;
      STRUCTURE_NOTIFY      : Bit := 0;
      RESIZE_REDIRECT       : Bit := 0;
      SUBSTRUCTURE_NOTIFY   : Bit := 0;
      SUBSTRUCTURE_REDIRECT : Bit := 0;
      FOCUS_CHANGE          : Bit := 0;
      PROPERTY_CHANGE       : Bit := 0;
      COLOR_MAP_CHANGE      : Bit := 0;
      OWNER_GRAB_BUTTON     : Bit := 0;
      Padding               : Bit := 0;
   end record;
   for Event_Mask use record
      NO_EVENT              at 0 range  0 ..  0;
      KEY_PRESS             at 0 range  1 ..  1;
      KEY_RELEASE           at 0 range  2 ..  2;
      BUTTON_PRESS          at 0 range  3 ..  3;
      BUTTON_RELEASE        at 0 range  4 ..  4;
      ENTER_WINDOW          at 0 range  5 ..  5;
      LEAVE_WINDOW          at 0 range  6 ..  6;
      POINTER_MOTION        at 0 range  7 ..  7;
      POINTER_MOTION_HINT   at 0 range  8 ..  8;
      BUTTON_1_MOTION       at 0 range  9 ..  9;
      BUTTON_2_MOTION       at 0 range 10 .. 10;
      BUTTON_3_MOTION       at 0 range 11 .. 11;
      BUTTON_4_MOTION       at 0 range 12 .. 12;
      BUTTON_5_MOTION       at 0 range 13 .. 13;
      BUTTON_MOTION         at 0 range 14 .. 14;
      KEYMAP_STATE          at 0 range 15 .. 15;
      EXPOSURE              at 0 range 16 .. 16;
      VISIBILITY_CHANGE     at 0 range 17 .. 17;
      STRUCTURE_NOTIFY      at 0 range 18 .. 18;
      RESIZE_REDIRECT       at 0 range 19 .. 19;
      SUBSTRUCTURE_NOTIFY   at 0 range 20 .. 20;
      SUBSTRUCTURE_REDIRECT at 0 range 21 .. 21;
      FOCUS_CHANGE          at 0 range 22 .. 22;
      PROPERTY_CHANGE       at 0 range 23 .. 23;
      COLOR_MAP_CHANGE      at 0 range 24 .. 24;
      OWNER_GRAB_BUTTON     at 0 range 25 .. 25;
      Padding               at 0 range 26 .. 31;
   end record;
   function Pack is new Ada.Unchecked_Conversion (Source => Event_Mask,
                                                  Target => Interfaces.Unsigned_32);
   function Unpack is new Ada.Unchecked_Conversion (Source => Interfaces.Unsigned_32,
                                                    Target => Event_Mask);
end Xab_Types;
--  vim:ts=3:sts=3:sw=3:expandtab:tw=80
