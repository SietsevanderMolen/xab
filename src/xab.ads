with System,
     Interfaces.C,
     Interfaces.C.Strings;
with xcb;
with xproto;
with xinerama;
with xab_types; use xab_types;

package xab is
   --  Connect to xcb using env variables for both the display
   --  and the screen
   function xab_connect return xab_connection_t;

   --  Connect to xcb using an env variable for the screen
   function xab_connect (Display_Name : String)
                         return xab_connection_t;

   --  Connect to xcb
   function xab_connect (Display_Name : String;
                         Screen       : xab_screen_t)
                         return xab_connection_t;

   --  Return the root screen for this connection
   function xab_get_root_screen (Connection : xab_connection_t)
      return xab_screen_t;

   --  Check wether the Xinerama extension is available on this connection
   function xab_has_xinerama (Connection : xab_connection_t)
      return Boolean;

   --  Check wether the RandR extension is available on this connection
   function xab_has_randr (Connection : xab_connection_t)
      return Boolean;
private

   --  An access type to the xcb_screen_t type
   type xcb_screen_t_ptr is access all xproto.xcb_screen_t;
   Null_Screen : constant xcb_screen_t_ptr := null;

   function xab_screen_t_to_xcb_screen_t (xabscreen : xab_screen_t)
      return xproto.xcb_screen_t;

   function xcb_screen_t_to_xab_screen_t (xcbscreen : xproto.xcb_screen_t)
      return xab_screen_t;

   --  Check a connection for errors
   --  @Raises: ConnectionFailedException
   procedure xab_check_connection (Connection : xab_connection_t);
end xab;
