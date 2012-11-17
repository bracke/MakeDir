with Main;                       use Main;
with Reporter;
with Ada.Exceptions;

with RASCAL.TaskManager;         use RASCAL.TaskManager;

package body Controller_Internet is

   --

   package TaskManager renames RASCAL.TaskManager;
   
   --
   
   procedure Handle (The : in TEL_ViewHomePage_Type) is

      Child : Integer;
   begin
      Child := Start_Task ("URIdispatch http://www.arcsite.de/hp/bracke/programming/mtools.html#makedir");
   exception
      when e: others => Report_Error("VIEWHOMEPAGE",Ada.Exceptions.Exception_Information (e));
   end Handle;
   
   --
   
   procedure Handle (The : in TEL_SendEmail_Type) is

      Child : Integer;
   begin
      Child := Start_Task ("URIdispatch mailto:bbracke@web.de");
   exception
      when e: others => Report_Error("SENDEMAIL",Ada.Exceptions.Exception_Information (e));      
   end Handle;

   --

end Controller_Internet;
