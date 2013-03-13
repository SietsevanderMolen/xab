with Interfaces;

package xab_xproto is
   subtype xcb_window_t is Interfaces.Unsigned_32;
   subtype xcb_colormap_t is Interfaces.Unsigned_32;
   subtype xcb_visualid_t is Interfaces.Unsigned_32;

   subtype xcb_keycode_t is Interfaces.Unsigned_8;

   type xcb_screen_t is record
      root                  : aliased xcb_window_t;
      default_colormap      : aliased xcb_colormap_t;
      white_pixel           : aliased Interfaces.Unsigned_32;
      black_pixel           : aliased Interfaces.Unsigned_32;
      current_input_masks   : aliased Interfaces.Unsigned_32;
      width_in_pixels       : aliased Interfaces.Unsigned_16;
      height_in_pixels      : aliased Interfaces.Unsigned_16;
      width_in_millimeters  : aliased Interfaces.Unsigned_16;
      height_in_millimeters : aliased Interfaces.Unsigned_16;
      min_installed_maps    : aliased Interfaces.Unsigned_16;
      max_installed_maps    : aliased Interfaces.Unsigned_16;
      root_visual           : aliased xcb_visualid_t;
      backing_stores        : aliased Interfaces.Unsigned_8;
      save_unders           : aliased Interfaces.Unsigned_8;
      root_depth            : aliased Interfaces.Unsigned_8;
      allowed_depths_len    : aliased Interfaces.Unsigned_8;
   end record;
   pragma Convention (C_Pass_By_Copy, xcb_screen_t);
end xab.xproto;
