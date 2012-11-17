with RASCAL.Toolbox;              use RASCAL.Toolbox;
with RASCAL.OS;                   use RASCAL.OS;
with RASCAL.ToolboxSaveas;        use RASCAL.ToolboxSaveas;

package Controller_SaveAs is
   
   type TEL_SaveAs_SaveToFile           is new ATEL_Toolbox_SaveAs_SaveToFile      with null record;

   procedure Handle (The : in TEL_SaveAs_SaveToFile);

end Controller_SaveAs;
