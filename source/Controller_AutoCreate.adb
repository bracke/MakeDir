with RASCAL.Utility;             use RASCAL.Utility;
with RASCAL.WimpTask;            use RASCAL.WimpTask;

with Main;                       use Main;
with Interfaces.C;               use Interfaces.C;
with Ada.Exceptions;

package body Controller_AutoCreate is

   --

   procedure Handle (The : in TEL_Toolbox_ObjectAutoCreated) is

      Name   : String     := To_Ada(The.Event.all.Template_Name);
      Object : Object_ID  := Get_Self_Id(Main_Task);
   begin
      if Name = "Main" then
         main_objectid := Object;
      elsif Name = "SaveAs" then
         SaveAs_ObjectId := Object;
      end if;
   exception
      when e: others => Report_Error("AUTOCREATE",Ada.Exceptions.Exception_Information (e));      
   end Handle;

   --
        
end Controller_AutoCreate;
