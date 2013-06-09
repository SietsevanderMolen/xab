with Interfaces.C.Strings;
with Interfaces; use Interfaces;

with Xcbada_Xinerama;
with Xcbada_Xproto;

package body Xab is
   function Xab_Connect
      return Xab_Connection_T
   is
      Connection : Xab_Connection_T;
   begin
      Connection := xcb.connect (xcb.Null_Display,
                                 xcb.Null_Screen);
      Xab_Check_Connection (Connection);
      --  Return the connection
      return Connection;
   end Xab_Connect;

   function Xab_Connect (Display_Name : String)
                         return Xab_Connection_T is
      Connection : Xab_Connection_T;
      --  Convert display name to C style string
      xcbdisplayname : Interfaces.C.Strings.chars_ptr :=
         Interfaces.C.Strings.New_String (Display_Name);
   begin
      Connection := xcb.connect (xcbdisplayname, Null_Screen);
      Xab_Check_Connection (Connection);
      return Connection;
   end Xab_Connect;

   function Xab_Connect (Display_Name : String;
                         Screen       : Xab_Screen_T)
                         return Xab_Connection_T is
      Connection : Xab_Connection_T;
      --  Convert display name to C style string
      xcbdisplayname : Interfaces.C.Strings.chars_ptr :=
         Interfaces.C.Strings.New_String (Display_Name);
      --  Convert the xab screen to an xcb screen
      xcbscreen : aliased xcbada_xproto.xcb_screen_t :=
         Xab_Screen_T_To_Xcb_Screen_T (Screen);
   begin
      Connection := xcb.connect (xcbdisplayname,
                                 xcbscreen'Access);
      Xab_Check_Connection (Connection);
      return Connection;
   end Xab_Connect;

   procedure Xab_Check_Connection (Connection : Xab_Connection_T)
   is
      ConnectionFailedException : exception;
   begin
      --  Check connection for errors
      if xcb.connection_has_error (Connection) = 1 then
         raise ConnectionFailedException with "Connection failed";
      end if;
   end Xab_Check_Connection;

   function xab_get_root_screen (Connection : Xab_Connection_T)
      return Xab_Screen_T
   is
      setup : access xcbada_xproto.xcb_setup_t := xcb.get_setup (Connection);
      screen : access xcbada_xproto.xcb_screen_t := 
         xcbada_xproto.xcb_setup_roots_iterator (setup).data;
   begin
      return Xcb_Screen_T_To_Xab_Screen_T (screen.all);
   end xab_get_root_screen;

   function Xab_Has_Randr (Connection : Xab_Connection_T)
      return Boolean
   is
      xcb_randr_id    : aliased xcb.xcb_extension_t;
      extension_reply : access xcbada_xproto.xcb_query_extension_reply_t;
   begin
      xcb_randr_id.name := Interfaces.C.Strings.New_String ("RANDR");
      extension_reply   := xcb.get_extension_data(Connection, xcb_randr_id);

      if extension_reply.present = 1 then
         return True;
      else
         return False;
      end if;
   end Xab_Has_Randr;

   function Xab_Has_Xinerama (Connection : Xab_Connection_T)
      return Boolean
   is
      xcb_xinerama_id : aliased xcb.xcb_extension_t;
      extension_reply : access xcbada_xproto.xcb_query_extension_reply_t;
   begin
      xcb_xinerama_id.name := Interfaces.C.Strings.New_String ("XINERAMA");
      extension_reply      := xcb.get_extension_data(Connection, xcb_xinerama_id);

      if extension_reply.present = 1 then
         return True;
      else
         return False;
      end if;
   end Xab_Has_Xinerama;

   --  Convert a xab screen to an xcb screen for internal use
   function Xab_Screen_T_To_Xcb_Screen_T (xabscreen : Xab_Screen_T)
      return xcbada_xproto.xcb_screen_t
   is
      screen : xcbada_xproto.xcb_screen_t;
   begin
      screen.root                  := Unsigned_32'Value (Integer'Image (xabscreen.Root));
      screen.default_colormap      := Unsigned_32'Value (Integer'Image (xabscreen.Default_Colormap));
      screen.white_pixel           := Unsigned_32'Value (Integer'Image (xabscreen.White_Pixel));
      screen.black_pixel           := Unsigned_32'Value (Integer'Image (xabscreen.Black_Pixel));
      screen.current_input_masks   := Unsigned_32'Value (Integer'Image (xabscreen.Current_Input_Masks));
      screen.width_in_pixels       := Unsigned_16'Value (Integer'Image (xabscreen.Width_In_Pixels));
      screen.height_in_pixels      := Unsigned_16'Value (Integer'Image (xabscreen.Height_In_Pixels));
      screen.width_in_millimeters  := Unsigned_16'Value (Integer'Image (xabscreen.Width_In_Millimeters));
      screen.height_in_millimeters := Unsigned_16'Value (Integer'Image (xabscreen.Height_In_Millimeters));
      screen.min_installed_maps    := Unsigned_16'Value (Integer'Image (xabscreen.Min_Installed_Maps));
      screen.max_installed_maps    := Unsigned_16'Value (Integer'Image (xabscreen.Max_Installed_Maps));
      screen.root_visual           := Unsigned_32'Value (Integer'Image (xabscreen.Root_Visual));
      screen.backing_stores        := Unsigned_8'Value  (Integer'Image (xabscreen.Backing_Stores));
      screen.save_unders           := Unsigned_8'Value  (Integer'Image (xabscreen.Save_Unders));
      screen.root_depth            := Unsigned_8'Value  (Integer'Image (xabscreen.Root_Depth));
      screen.allowed_depths_len    := Unsigned_8'Value  (Integer'Image (xabscreen.Allowed_Depths_Len));
      return screen;
   end Xab_Screen_T_To_Xcb_Screen_T;

   --  Convert a xab screen to an xcb screen for internal use
   function Xcb_Screen_T_To_Xab_Screen_T (xcbscreen : xcbada_xproto.xcb_screen_t)
      return Xab_Screen_T
   is
      screen : Xab_Screen_T;
   begin
      screen.Root                  := Integer'Value (Unsigned_32'Image (xcbscreen.root));
      screen.Default_Colormap      := Integer'Value (Unsigned_32'Image (xcbscreen.default_colormap));
      screen.White_Pixel           := Integer'Value (Unsigned_32'Image (xcbscreen.white_pixel));
      screen.Black_Pixel           := Integer'Value (Unsigned_32'Image (xcbscreen.black_pixel));
      screen.Current_Input_Masks   := Integer'Value (Unsigned_32'Image (xcbscreen.current_input_masks));
      screen.Width_In_Pixels       := Integer'Value (Unsigned_16'Image (xcbscreen.width_in_pixels));
      screen.Height_In_Pixels      := Integer'Value (Unsigned_16'Image (xcbscreen.height_in_pixels));
      screen.Width_In_Millimeters  := Integer'Value (Unsigned_16'Image (xcbscreen.width_in_millimeters));
      screen.Height_In_Millimeters := Integer'Value (Unsigned_16'Image (xcbscreen.height_in_millimeters));
      screen.Min_Installed_Maps    := Integer'Value (Unsigned_16'Image (xcbscreen.min_installed_maps));
      screen.Max_Installed_Maps    := Integer'Value (Unsigned_16'Image (xcbscreen.max_installed_maps));
      screen.Root_Visual           := Integer'Value (Unsigned_32'Image (xcbscreen.root_visual));
      screen.Backing_Stores        := Integer'Value  (Unsigned_8'Image (xcbscreen.backing_stores));
      screen.Save_Unders           := Integer'Value  (Unsigned_8'Image (xcbscreen.save_unders));
      screen.Root_Depth            := Integer'Value  (Unsigned_8'Image (xcbscreen.root_depth));
      screen.Allowed_Depths_Len    := Integer'Value  (Unsigned_8'Image (xcbscreen.allowed_depths_len));
      return screen;
   end Xcb_Screen_T_To_Xab_Screen_T;
end Xab;
