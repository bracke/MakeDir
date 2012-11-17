with Controller_Quit;           use Controller_Quit;
with Controller_Internet;       use Controller_Internet;
with Controller_Bugz;           use Controller_Bugz;
with Controller_Choices;        use Controller_Choices;
with Controller_Help;           use Controller_Help;
with Controller_AutoCreate;     use Controller_AutoCreate;
with Controller_DataLoad;       use Controller_DataLoad;
with Controller_SaveAs;         use Controller_SaveAs;
with Controller_Error;          use Controller_Error;
with Reporter;                  use Reporter;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Ada.Exceptions;
with ADA.IO_EXCEPTIONS;         use ADA.IO_EXCEPTIONS;
with Text_IO;

with RASCAL.OS;                 use RASCAL.OS;
with RASCAL.Toolbox;            use RASCAL.Toolbox;
with RASCAL.MessageTrans;       use RASCAL.MessageTrans;
with RASCAL.Error;              use RASCAL.Error;
with RASCAL.FileExternal;       use RASCAL.FileExternal;
with RASCAL.Utility;            use RASCAL.Utility;
with RASCAL.ToolboxProgInfo;

package body Main is

   --

   package OS              renames RASCAL.OS;
   package Toolbox         renames RASCAL.Toolbox;        
   package MessageTrans    renames RASCAL.MessageTrans;   
   package Error           renames RASCAL.Error;          
   package FileExternal    renames RASCAL.FileExternal;   
   package Utility         renames RASCAL.Utility;        
   package ToolboxProgInfo renames RASCAL.ToolboxProgInfo;
   package WimpTask        renames RASCAL.WimpTask;
   
   --

   procedure Report_Error (Token : in String;
                           Info  : in String) is

      E        : Error_Pointer          := Get_Error (Main_Task);
      M        : Error_Message_Pointer  := new Error_Message_Type;
      Result   : Error_Return_Type      := XButton1;
   begin
      M.all.Token(1..Token'Length) := Token;
      M.all.Param1(1..Info'Length) := Info;
      M.all.Category := Warning;
      M.all.Flags    := Error_Flag_OK;
      Result         := Error.Show_Message (E,M);
   end Report_Error;

   --

   procedure Main is
      ProgInfo : Object_ID;
   begin
      -- Messages
      Add_Listener (Main_Task,new MEL_Message_Bugz_Query);
      Add_Listener (Main_Task,new MEL_Message_DataLoad);
      Add_Listener (Main_Task,new MEL_Message_Quit);          -- React upon quit from taskmanager

      -- Toolbox Events
      Add_Listener (Main_Task,new TEL_Quit_Quit);
      Add_Listener (Main_Task,new TEL_Toolbox_ObjectAutoCreated);
      Add_Listener (Main_Task,new TEL_SaveAs_SaveToFile);

      Add_Listener (Main_Task,new TEL_ViewManual_Type);
      Add_Listener (Main_Task,new TEL_ViewSection_Type);
      Add_Listener (Main_Task,new TEL_ViewIHelp_Type);
      Add_Listener (Main_Task,new TEL_ViewHomePage_Type);
      Add_Listener (Main_Task,new TEL_ViewChoices_Type);
      Add_Listener (Main_Task,new TEL_SendEmail_Type);
      Add_Listener (Main_Task,new TEL_CreateReport_Type);
      Add_Listener (Main_Task,new TEL_Toolbox_Error);

      -- Start task
      WimpTask.Set_Resources_Path(Main_Task,"<MakeDirRes$Dir>");
      WimpTask.Initialise(Main_Task);

      ProgInfo := Toolbox.Create_Object ("ProgInfo",From_Template);
      ToolboxProgInfo.Set_Version (ProgInfo,
                                   MessageTrans.Lookup("VERS",Get_Message_Block(Main_Task)));

      Read_String("UNTITLED",Untitled_String,Get_Message_Block(Main_Task));

      WimpTask.Poll(Main_Task);

   exception
      when e: others => Report_Error("UNTRAPPED",Ada.Exceptions.Exception_Information (e));
   end Main;

   --


end Main;

