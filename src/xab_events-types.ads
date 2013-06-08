with Xab_Events.Subjects_And_Observers;

package Xab_Events.Types is
   type Generic_Event_T is new Xab_Events.Subjects_And_Observers.Subject_T with private;
private
   type Generic_Event_T is
      new Xab_Events.Subjects_And_Observers.Subject_T with
   record
      neee : Boolean;
   end record;
end Xab_Events.Types;
