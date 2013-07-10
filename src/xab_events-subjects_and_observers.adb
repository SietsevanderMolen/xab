-------------------------------------------------------------------------------
--                                                                           --
--                   Copyright (C) 2012-, Sietse van der Molen		     --
--                                                                           --
--    This file is part of XAB.			 	   	             --
--									     --
--    XAB is free software: you can redistribute it and/or modify            --
--    it under the terms of the GNU General Public License as published by   --
--    the Free Software Foundation, either version 3 of the License, or      --
--    (at your option) any later version.                                    --
--   		 		 	 	 	 	 	     --
--    XAB is distributed in the hope that it will be useful,                 --
--    but WITHOUT ANY WARRANTY; without even the implied warranty of         --
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          --
--    GNU General Public License for more details.                           --
--                                                                           --
--    You should have received a copy of the GNU General Public License      --
--    along with XAB.  If not, see <http://www.gnu.org/licenses/>.           --
--                                                                           --
-------------------------------------------------------------------------------

package body Xab_Events.Subjects_And_Observers is
   procedure Notify (Subject : in out Subject_T'Class) is
      Observer : Observer_Access := Subject.Head;
   begin
      while Observer /= null loop
         Update (Observer);
         Observer := Observer.Next;
      end loop;
   end Notify;

   procedure Initialize (Control : in out Observer_Control) is Observer :
      constant Observer_Access := Control.Observer.all'Unchecked_Access;

      Subject : Subject_T'Class renames Observer.Subject.all;
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

         Subject : Subject_T'Class renames Observer.Subject.all;

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
