with RASCAL.WimpTask;                   use RASCAL.WimpTask;
with RASCAL.Utility;                    use RASCAL.Utility;
with RASCAL.Variable;                   use RASCAL.Variable;
with RASCAL.Toolbox;                    use RASCAL.Toolbox;
with RASCAL.OS;                         use RASCAL.OS;

package Main is

   app_name       : constant String := "MakeDir";
   Choices_Write  : constant String := "<Choices$Write>." & app_name;
   Choices_Read   : constant String := "Choices:" & app_name & ".Choices";

   Main_Task      : ToolBox_Task_Class;
   main_objectid  : Object_ID             := -1;
   main_winid     : Wimp_Handle_Type      := -1;
   SaveAs_ObjectId: Object_ID;
   source         : ustring;
   Untitled_String: ustring;
   
   -- Choices
   Remove_Pling     : boolean := true;
   Lower_Case       : boolean := true;
   Remove_Extension : boolean := true;

   --

   procedure Report_Error (Token : in String;
                           Info  : in String);

   --

   procedure Main;

   --

 end Main;


