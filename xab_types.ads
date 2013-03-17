with System;
package xab_types is
   --  type Integer_8  is range -2**(8-1)  .. 2**(8-1) - 1;
   --  type Integer_16 is range -2**(16-1) .. 2**(16-1) - 1;
   --  type Integer_32 is range -2**(32-1) .. 2**(32-1) - 1;

   subtype xab_window_t       is Integer;
   subtype xab_colormap_t     is Integer;
   subtype xab_connection_t   is System.Address;
   subtype xab_extension_t    is System.Address;
   subtype xab_keycode_t      is Integer;
   subtype xab_randr_output_t is Integer;
   subtype xab_visualid_t     is Integer;

   type xab_screen_t is record
      root                  : aliased xab_window_t;
      default_colormap      : aliased xab_colormap_t;
      white_pixel           : aliased Integer;
      black_pixel           : aliased Integer;
      current_input_masks   : aliased Integer;
      width_in_pixels       : aliased Integer;
      height_in_pixels      : aliased Integer;
      width_in_millimeters  : aliased Integer;
      height_in_millimeters : aliased Integer;
      min_installed_maps    : aliased Integer;
      max_installed_maps    : aliased Integer;
      root_visual           : aliased xab_visualid_t;
      backing_stores        : aliased Integer;
      save_unders           : aliased Integer;
      root_depth            : aliased Integer;
      allowed_depths_len    : aliased Integer;
   end record;
end xab_types;
