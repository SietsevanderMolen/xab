package body Xab_Events.Event_Loop is
   procedure Handle_Event (E : in Xab_Events.Event.Object'Class) is
   begin
      null;
   end Handle_Event;

   task body Main_Loop is
   begin
      accept Start;
      loop
         select
            accept Event (E : in Xab_Events.Event.Object'Class) do
               Handle_Event (E);
            end Event;
         end select;
      end loop;
   end Main_Loop;
end Xab_Events.Event_Loop;
