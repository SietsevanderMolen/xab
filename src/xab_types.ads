-------------------------------------------------------------------------------
--                                                                           --
--                   Copyright (C) 2012-, Sietse van der Molen		     --
--                                                                           --
--    This file is part of XAB.			 	   	             --
--									     --
--    XAB is free software: you can redistribute it and/or modify            --
--    it under the terms of the GNU General Public License as published by   --
--    the Free Software Foundation, either version 3 of the License, or      --
--    (at your option) any later version.                                    --
--   		 		 	 	 	 	 	     --
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
   subtype Xab_Colormap_T     is Integer;
   subtype Xab_Connection_T   is System.Address;
   subtype Xab_Extension_T    is System.Address;
   subtype Xab_Gcontext_T     is Integer;
   subtype Xab_Keycode_T      is Integer;
   subtype Xab_Pixmap_T       is Integer;
   subtype Xab_Randr_Output_T is Integer;
   subtype Xab_Visualid_T     is Integer;
   subtype Xab_Window_T       is Integer;

   type Xab_Screen_T is record
      Root                  : aliased Xab_Window_T;
      Default_Colormap      : aliased Xab_Colormap_T;
      White_Pixel           : aliased Integer;
      Black_Pixel           : aliased Integer;
      Current_Input_Masks   : aliased Integer;
      Width_In_Pixels       : aliased Integer;
      Height_In_Pixels      : aliased Integer;
      Width_In_Millimeters  : aliased Integer;
      Height_In_Millimeters : aliased Integer;
      Min_Installed_Maps    : aliased Integer;
      Max_Installed_Maps    : aliased Integer;
      Root_Visual           : aliased Xab_Visualid_T;
      Backing_Stores        : aliased Integer;
      Save_Unders           : aliased Integer;
      Root_Depth            : aliased Integer;
      Allowed_Depths_Len    : aliased Integer;
   end record;
end Xab_Types;
