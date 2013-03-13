with System;
package xab_types is
   subtype xab_connection_t is System.Address;

   subtype xcb_window_t is Integer;
   subtype xcb_colormap_t is Integer;
   subtype xcb_visualid_t is Integer;

   subtype xcb_keycode_t is Integer;

   type xab_screen_t is record
      root                  : aliased xcb_window_t;
      default_colormap      : aliased xcb_colormap_t;
      white_pixel           : aliased Integer;
      black_pixel           : aliased Integer;
      current_input_masks   : aliased Integer;
      width_in_pixels       : aliased Integer;
      height_in_pixels      : aliased Integer;
      width_in_millimeters  : aliased Integer;
      height_in_millimeters : aliased Integer;
      min_installed_maps    : aliased Integer;
      max_installed_maps    : aliased Integer;
      root_visual           : aliased xcb_visualid_t;
      backing_stores        : aliased Integer;
      save_unders           : aliased Integer;
      root_depth            : aliased Integer;
      allowed_depths_len    : aliased Integer;
   end record;
end xab_types;
