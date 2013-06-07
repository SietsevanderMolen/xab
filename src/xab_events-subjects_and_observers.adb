package body Xab_Events.Subjects_And_Observers is
   procedure Notify (Subject : in out Subject_Type'Class) is
      Observer : Observer_Access := Subject.Head;
   begin
      while Observer /= null loop
         Update (Observer);
         Observer := Observer.Next;
      end loop;
   end Notify;

   procedure Initialize (Control : in out Observer_Control) is Observer :
      constant Observer_Access := Control.Observer.all'Unchecked_Access;

      Subject : Subject_Type'Class renames Observer.Subject.all;
   begin
      Observer.Next := Subject.Head;
      Subject.Head := Observer;
   end;

   --  During finalization tho observer unregisters and gets removed from the
   --  list. This guarantees there won't be any dangling reference problems.
   --  This means we can turn off access checks with 'Unchecked_Access' (and we
   --  have to)
   procedure Finalize (Control : in out Observer_Control) is
      Observer : constant Observer_Access :=
         Control.Observer.all'Unchecked_Access;

         Subject : Subject_Type'Class renames Observer.Subject.all;

         Prev  : Observer_Access;
         Index : Observer_Access;
   begin
      if Subject.Head = Observer then
         Subject.Head := Subject.Head.Next;
      else
         Prev := Subject.Head;
         Index := Subject.Head.Next;

         while Index /= Observer loop
            Prev := Index;
            Index := Index.Next;
         end loop;

         Prev.Next := Index.Next;
      end if;
   end Finalize;
end Xab_Events.Subjects_And_Observers;
