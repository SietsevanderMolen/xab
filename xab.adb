with Interfaces.C.Strings;
with Interfaces; use Interfaces;
with xinerama;

package body xab is
   function xab_connect
      return xab_connection_t
   is
      Connection : xab_connection_t;
   begin
      Connection := xcb.xcb_connect (Interfaces.C.Strings.Null_Ptr,
                                     Null_Screen);
      xab_check_connection (Connection);
      --  Return the connection
      return Connection;
   end xab_connect;

   function xab_connect (Display_Name : String)
                         return xab_connection_t is
      Connection : xab_connection_t;
      --  Convert display name to C style string
      xcbdisplayname : Interfaces.C.Strings.chars_ptr :=
         Interfaces.C.Strings.New_String (Display_Name);
   begin
      Connection := xcb.xcb_connect (xcbdisplayname, Null_Screen);
      xab_check_connection (Connection);
      return Connection;
   end xab_connect;

   function xab_connect (Display_Name : String;
                         Screen       : xab_screen_t)
                         return xab_connection_t is
      Connection : xab_connection_t;
      --  Convert display name to C style string
      xcbdisplayname : Interfaces.C.Strings.chars_ptr :=
         Interfaces.C.Strings.New_String (Display_Name);
      --  Convert the xab screen to an xcb screen
      xcbscreen : aliased xproto.xcb_screen_t :=
         xab_screen_t_to_xcb_screen_t (Screen);
   begin
      Connection := xcb.xcb_connect (xcbdisplayname,
                                     xcbscreen'Access);
      xab_check_connection (Connection);
      return Connection;
   end xab_connect;

   procedure xab_check_connection (Connection : xab_connection_t)
   is
      ConnectionFailedException : exception;
   begin
      --  Check connection for errors
      if xcb.xcb_connection_has_error (Connection) = 1 then
         raise ConnectionFailedException with "Connection failed";
      end if;
   end xab_check_connection;

   function xab_has_randr (Connection : xab_connection_t)
      return Boolean
   is
   begin
      return False;
   end xab_has_randr;

   function xab_has_xinerama (Connection : xab_connection_t)
      return Boolean
   is
   begin
      return False;
   end xab_has_xinerama;

   --  Convert a xab screen to an xcb screen for internal use
   function xab_screen_t_to_xcb_screen_t (xabscreen : xab_screen_t)
      return xproto.xcb_screen_t
   is
      screen : xproto.xcb_screen_t;
   begin
      screen.root                  := Unsigned_32'Value (Integer'Image (xabscreen.root));
      screen.default_colormap      := Unsigned_32'Value (Integer'Image (xabscreen.default_colormap));
      screen.white_pixel           := Unsigned_32'Value (Integer'Image(xabscreen.white_pixel));
      screen.black_pixel           := Unsigned_32'Value (Integer'Image(xabscreen.black_pixel));
      screen.current_input_masks   := Unsigned_32'Value (Integer'Image(xabscreen.current_input_masks));
      screen.width_in_pixels       := Unsigned_16'Value (Integer'Image(xabscreen.width_in_pixels));
      screen.height_in_pixels      := Unsigned_16'Value (Integer'Image(xabscreen.height_in_pixels));
      screen.width_in_millimeters  := Unsigned_16'Value (Integer'Image(xabscreen.width_in_millimeters));
      screen.height_in_millimeters := Unsigned_16'Value (Integer'Image(xabscreen.height_in_millimeters));
      screen.min_installed_maps    := Unsigned_16'Value (Integer'Image(xabscreen.min_installed_maps));
      screen.max_installed_maps    := Unsigned_16'Value (Integer'Image(xabscreen.max_installed_maps));
      screen.root_visual           := Unsigned_32'Value (Integer'Image(xabscreen.root_visual));
      screen.backing_stores        := Unsigned_8'Value  (Integer'Image(xabscreen.backing_stores));
      screen.save_unders           := Unsigned_8'Value  (Integer'Image(xabscreen.save_unders));
      screen.root_depth            := Unsigned_8'Value  (Integer'Image(xabscreen.root_depth));
      screen.allowed_depths_len    := Unsigned_8'Value  (Integer'Image(xabscreen.allowed_depths_len));
      return screen;
   end xab_screen_t_to_xcb_screen_t;
end xab;
