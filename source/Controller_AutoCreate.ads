with RASCAL.Toolbox;              use RASCAL.Toolbox;
with RASCAL.OS;                   use RASCAL.OS;

package Controller_AutoCreate is
   
   type TEL_Toolbox_ObjectAutoCreated   is new ATEL_Toolbox_ObjectAutoCreated      with null record;

   procedure Handle (The : in TEL_Toolbox_ObjectAutoCreated);

end Controller_AutoCreate;
