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
      root                  : aliased Xab_Window_T;
      default_colormap      : aliased Xab_Colormap_T;
      white_pixel           : aliased Integer;
      black_pixel           : aliased Integer;
      current_input_masks   : aliased Integer;
      width_in_pixels       : aliased Integer;
      height_in_pixels      : aliased Integer;
      width_in_millimeters  : aliased Integer;
      height_in_millimeters : aliased Integer;
      min_installed_maps    : aliased Integer;
      max_installed_maps    : aliased Integer;
      root_visual           : aliased Xab_Visualid_T;
      backing_stores        : aliased Integer;
      save_unders           : aliased Integer;
      root_depth            : aliased Integer;
      allowed_depths_len    : aliased Integer;
   end record;
end Xab_Types;
