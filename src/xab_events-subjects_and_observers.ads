-------------------------------------------------------------------------------
--                                                                           --
--                   Copyright (C) 2012-, Sietse van der Molen               --
--                                                                           --
--    This file is part of XAB.                                              --
--                                                                           --
--    XAB is free software: you can redistribute it and/or modify            --
--    it under the terms of the GNU General Public License as published by   --
--    the Free Software Foundation, either version 3 of the License, or      --
--    (at your option) any later version.                                    --
--                                                                           --
--    XAB is distributed in the hope that it will be useful,                 --
--    but WITHOUT ANY WARRANTY; without even the implied warranty of         --
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          --
--    GNU General Public License for more details.                           --
--                                                                           --
--    You should have received a copy of the GNU General Public License      --
--    along with XAB.  If not, see <http://www.gnu.org/licenses/>.           --
--                                                                           --
-------------------------------------------------------------------------------

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
--  vim:ts=3:expandtab:tw=80
