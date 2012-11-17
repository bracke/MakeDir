with RASCAL.OS;                  use RASCAL.OS;
with RASCAL.Utility;             use RASCAL.Utility;
with RASCAL.FileName;            use RASCAL.FileName;
with RASCAL.FileExternal;        use RASCAL.FileExternal;
with RASCAL.WimpTask;            use RASCAL.WimpTask;
with RASCAL.ToolboxSaveAs;       use RASCAL.ToolboxSaveAs;
with RASCAL.MessageTrans;        use RASCAL.MessageTrans;
with RASCAL.Error;               use RASCAL.Error;

with Interfaces.C;               use Interfaces.C;
with Main;                       use Main;
with Ada.Exceptions;

package body Controller_DataLoad is

   --

   package OS            renames RASCAL.OS;
   package Utility       renames RASCAL.Utility;      
   package FileName      renames RASCAL.FileName;     
   package FileExternal  renames RASCAL.FileExternal; 
   package WimpTask      renames RASCAL.WimpTask;     
   package ToolboxSaveAs renames RASCAL.ToolboxSaveAs;
   package MessageTrans  renames RASCAL.MessageTrans; 
   package Error         renames RASCAL.Error;

   --

   procedure Read_Choices is

      MCB    : Messages_Handle_Type  := Open_File(Choices_Read);
      E      : Error.Error_Pointer   := Get_Error(Main_Task);
      M      : Error_Message_Pointer := new Error_Message_Type;
      R      : Error_Return_Type;
   begin
      Remove_Pling     := Boolean'Value(Lookup("PLING",MCB));
      Lower_Case       := Boolean'Value(Lookup("CASE",MCB));
      Remove_Extension := Boolean'Value(Lookup("EXTENSION",MCB));
      Close_File(MCB);

   exception
      when Messages_File_Is_Closed => M.all.Token(1..9) := "MSGCLOSED";
                                      R := Show_Message(E,M);
      when e2 : others => Report_Error("CHOICES",Ada.Exceptions.Exception_Information (e2));
   end Read_Choices;

   --

   procedure Handle (The : in MEL_Message_DataLoad) is

      Name : UString := U(FileName.Get_Leaf(To_Ada(The.Event.all.Full_Path)));
   begin
      if FileExternal.Exists (Choices_Read) then
         Read_Choices;
      end if;
      if Remove_Pling then
         Name := U(FileName.App_To_Dir (S(Name)));
      end if;
      Name := U(FileName.Dos_To_RISCOS (S(Name),Remove_Extension,Lower_Case));

      Set_FileName(SaveAs_ObjectId,S(Name));
      Show_Object(Object => SaveAs_ObjectId,Show => AtPointer);
   exception
      when e : others => Report_Error("PROCESSING",Ada.Exceptions.Exception_Information (e));
   end Handle;

   --

end Controller_DataLoad;
