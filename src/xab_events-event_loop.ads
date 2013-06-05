with Xab_Events.Event;

package Xab_Events.Event_Loop is
   task Main_Loop is
      entry Start;
      entry Event;
   end Main_Loop;

   procedure Handle_Event (E : in Xab_Events.Event.Object'Class);
end Xab_Events.Event_Loop;
