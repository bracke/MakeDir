with RASCAL.OS;                         use RASCAL.OS;
with RASCAL.Utility;                    use RASCAL.Utility;
with RASCAL.FileExternal;               use RASCAL.FileExternal;
with RASCAL.WimpTask;                   use RASCAL.WimpTask;
with RASCAL.FileName;

with Main;                       use Main;
with Interfaces.C;               use Interfaces.C;

package body Controller_SaveAs is

   --

   package OS           renames RASCAL.OS;
   package Utility      renames RASCAL.Utility;     
   package FileExternal renames RASCAL.FileExternal;
   package WimpTask     renames RASCAL.WimpTask;    
   package FileName     renames RASCAL.FileName;

   --

   procedure Handle (The : in TEL_SaveAs_SaveToFile) is

      Object : Object_ID := Get_Self_Id(Main_Task);
      Name   : String    := To_Ada(The.Event.all.Filename);
   begin
      Hide_Object(Object);
      if Exists(Name) then
         Report_Error("EXISTS","");
      else
         Create_Directory(Name);
         Call_OS_CLI("Filer_Run " & Name);
      end if;
   end Handle;

   --

end Controller_SaveAs;
