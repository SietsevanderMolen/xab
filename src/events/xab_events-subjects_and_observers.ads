with Ada.Finalization;

package Xab_Events.Subjects_And_Observers is
   type Root_Subject_Type is abstract tagged limited private;

   --  Notify all observers of a change in the subject
   procedure Notify (Subject : in out Root_Subject_Type'Class);

   type Root_Observer_Type (Subject : access Root_Subject_Type'Class) is
      abstract tagged limited private;

   --  Notify a single observer of a change in the subject
   procedure Update (Observer : access Root_Observer_Type) is abstract;
private
   type Observer_Access is access all Root_Observer_Type'Class;
   pragma Suppress (Access_Check, On => Observer_Access);

   type Root_Subject_Type is abstract tagged limited record
      Head : Observer_Access;
   end record;

   use Ada.Finalization;

   type Observer_Control (Observer : access Root_Observer_Type'Class) is new
      Limited_Controlled with null record;

   procedure Initialize (Control : in out Observer_Control);

   procedure Finalize (Control : in out Observer_Control);

   type Root_Observer_Type (Subject : access Root_Subject_Type'Class) is
      abstract tagged limited record
        Control : Observer_Control (Root_Observer_Type'Access);
        Next    : Observer_Access;
      end record;
end Xab_Events.Subjects_And_Observers;
