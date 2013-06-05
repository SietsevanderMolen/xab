with Ada.Strings.Unbounded;

package Xab_Events.Event is

   type Object is tagged private;

private
   type Object is tagged
      record
         Name : Ada.Strings.Unbounded.Unbounded_String;
      end record;
end Xab_Events.Event;
