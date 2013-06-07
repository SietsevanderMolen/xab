with Ada.Finalization;

package Xab_Events.Subjects_And_Observers is
   type Subject_T is abstract tagged limited private;

   --  Notify all observers of a change in the subject
   procedure Notify (Subject : in out Subject_T'Class);

   --  Would an interface be beneficial here?
   type Observer_T (Subject : access Subject_T'Class) is
      abstract tagged limited private;

   --  Notify a single observer of a change in the subject
   procedure Update (Observer : access Observer_T) is abstract;
private
   type Observer_Access is access all Observer_T'Class;
   pragma Suppress (Access_Check, On => Observer_Access);

   type Subject_T is abstract tagged limited record
      Head : Observer_Access;
   end record;

   use Ada.Finalization;

   type Observer_Control (Observer : access Observer_T'Class) is new
      Limited_Controlled with null record;

   procedure Initialize (Control : in out Observer_Control);

   procedure Finalize (Control : in out Observer_Control);

   type Observer_T (Subject : access Subject_T'Class) is
      abstract tagged limited record
        Control : Observer_Control (Observer_T'Access);
        Next    : Observer_Access;
      end record;
end Xab_Events.Subjects_And_Observers;
