with Interfaces.C.Strings;
with Interfaces; use Interfaces;
with xinerama;

ackage body xab is
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

   function xab_get_root_screen (Connection : xab_connection_t)
      return xab_screen_t
   is
      setup : access xproto.xcb_setup_t := xcb.xcb_get_setup (Connection);
      screen : access xproto.xcb_screen_t := 
         xproto.xcb_setup_roots_iterator (setup).data;
   begin
      return xcb_screen_t_to_xab_screen_t (screen.all);
   end xab_get_root_screen;

   function xab_has_randr (Connection : xab_connection_t)
      return Boolean
   is
      xcb_randr_id : aliased xcb.xcb_extension_t;
      extension_reply : access xproto.xcb_query_extension_reply_t;
   begin
      xcb_randr_id.name := Interfaces.C.Strings.New_String ("RANDR");
      extension_reply := xcb.xcb_get_extension_data(Connection, xcb_randr_id);

      if extension_reply.present = 1 then
         return True;
      else
         return False;
      end if;
   end xab_has_randr;

   function xab_has_xinerama (Connection : xab_connection_t)
      return Boolean
   is
      xcb_xinerama_id : aliased xcb.xcb_extension_t;
      extension_reply : access xproto.xcb_query_extension_reply_t;
   begin
      xcb_xinerama_id.name := Interfaces.C.Strings.New_String ("XINERAMA");
      extension_reply := xcb.xcb_get_extension_data(Connection, xcb_xinerama_id);

      if extension_reply.present = 1 then
         return True;
      else
         return False;
      end if;
   end xab_has_xinerama;

   --  Convert a xab screen to an xcb screen for internal use
   function xab_screen_t_to_xcb_screen_t (xabscreen : xab_screen_t)
      return xproto.xcb_screen_t
   is
      screen : xproto.xcb_screen_t;
   begin
      screen.root                  := Unsigned_32'Value (Integer'Image (xabscreen.root));
      screen.default_colormap      := Unsigned_32'Value (Integer'Image (xabscreen.default_colormap));
      screen.white_pixel           := Unsigned_32'Value (Integer'Image (xabscreen.white_pixel));
      screen.black_pixel           := Unsigned_32'Value (Integer'Image (xabscreen.black_pixel));
      screen.current_input_masks   := Unsigned_32'Value (Integer'Image (xabscreen.current_input_masks));
      screen.width_in_pixels       := Unsigned_16'Value (Integer'Image (xabscreen.width_in_pixels));
      screen.height_in_pixels      := Unsigned_16'Value (Integer'Image (xabscreen.height_in_pixels));
      screen.width_in_millimeters  := Unsigned_16'Value (Integer'Image (xabscreen.width_in_millimeters));
      screen.height_in_millimeters := Unsigned_16'Value (Integer'Image (xabscreen.height_in_millimeters));
      screen.min_installed_maps    := Unsigned_16'Value (Integer'Image (xabscreen.min_installed_maps));
      screen.max_installed_maps    := Unsigned_16'Value (Integer'Image (xabscreen.max_installed_maps));
      screen.root_visual           := Unsigned_32'Value (Integer'Image (xabscreen.root_visual));
      screen.backing_stores        := Unsigned_8'Value  (Integer'Image (xabscreen.backing_stores));
      screen.save_unders           := Unsigned_8'Value  (Integer'Image (xabscreen.save_unders));
      screen.root_depth            := Unsigned_8'Value  (Integer'Image (xabscreen.root_depth));
      screen.allowed_depths_len    := Unsigned_8'Value  (Integer'Image (xabscreen.allowed_depths_len));
      return screen;
   end xab_screen_t_to_xcb_screen_t;

   --  Convert a xab screen to an xcb screen for internal use
   function xcb_screen_t_to_xab_screen_t (xcbscreen : xproto.xcb_screen_t)
      return xab_screen_t
   is
      screen : xab_screen_t;
   begin
      screen.root                  := Integer'Value (Unsigned_32'Image (xcbscreen.root));
      screen.default_colormap      := Integer'Value (Unsigned_32'Image (xcbscreen.default_colormap));
      screen.white_pixel           := Integer'Value (Unsigned_32'Image (xcbscreen.white_pixel));
      screen.black_pixel           := Integer'Value (Unsigned_32'Image (xcbscreen.black_pixel));
      screen.current_input_masks   := Integer'Value (Unsigned_32'Image (xcbscreen.current_input_masks));
      screen.width_in_pixels       := Integer'Value (Unsigned_16'Image (xcbscreen.width_in_pixels));
      screen.height_in_pixels      := Integer'Value (Unsigned_16'Image (xcbscreen.height_in_pixels));
      screen.width_in_millimeters  := Integer'Value (Unsigned_16'Image (xcbscreen.width_in_millimeters));
      screen.height_in_millimeters := Integer'Value (Unsigned_16'Image (xcbscreen.height_in_millimeters));
      screen.min_installed_maps    := Integer'Value (Unsigned_16'Image (xcbscreen.min_installed_maps));
      screen.max_installed_maps    := Integer'Value (Unsigned_16'Image (xcbscreen.max_installed_maps));
      screen.root_visual           := Integer'Value (Unsigned_32'Image (xcbscreen.root_visual));
      screen.backing_stores        := Integer'Value  (Unsigned_8'Image (xcbscreen.backing_stores));
      screen.save_unders           := Integer'Value  (Unsigned_8'Image (xcbscreen.save_unders));
      screen.root_depth            := Integer'Value  (Unsigned_8'Image (xcbscreen.root_depth));
      screen.allowed_depths_len    := Integer'Value  (Unsigned_8'Image (xcbscreen.allowed_depths_len));
      return screen;
   end xcb_screen_t_to_xab_screen_t;
end xab;
