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

with System;
package Xab_Types is
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

end Xab_Types;
--  vim:ts=3:expandtab:tw=80
