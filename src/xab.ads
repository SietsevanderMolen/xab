with System,
     Interfaces.C,
     Interfaces.C.Strings;
with xcb;
with xcbada_xproto;
with xcbada_xinerama;
with Xab_Types; use Xab_Types;

package Xab is
   --  Connect to xcb using env variables for both the display
   --  and the screen
   function Xab_Connect return Xab_Connection_T;

   --  Connect to xcb using an env variable for the screen
   function Xab_Connect (Display_Name : String)
                         return Xab_Connection_T;

   --  Connect to xcb
   function Xab_Connect (Display_Name : String;
                         Screen       : Xab_Screen_T)
                         return Xab_Connection_T;

   --  Return the root screen for this connection
   function Xab_Get_Root_Screen (Connection : Xab_Connection_T)
      return Xab_Screen_T;

   --  Check wether the Xinerama extension is available on this connection
   function Xab_Has_Xinerama (Connection : Xab_Connection_T)
      return Boolean;

   --  Check wether the RandR extension is available on this connection
   function Xab_Has_Randr (Connection : Xab_Connection_T)
      return Boolean;
private

   --  An access type to the xcb_screen_t type
   type xcb_screen_t_ptr is access all xcbada_xproto.xcb_screen_t;
   Null_Screen : constant xcb_screen_t_ptr := null;

   function Xab_Screen_T_to_xcb_screen_t (xabscreen : Xab_Screen_T)
      return xcbada_xproto.xcb_screen_t;

   function Xcb_Screen_T_To_Xab_Screen_T (xcbscreen : xcbada_xproto.xcb_screen_t)
      return Xab_Screen_T;

   --  Check a connection for errors
   --  @Raises: ConnectionFailedException
   procedure Xab_Check_Connection (Connection : Xab_Connection_T);
end Xab;
