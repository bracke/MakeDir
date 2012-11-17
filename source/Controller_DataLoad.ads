with RASCAL.Toolbox;              use RASCAL.Toolbox;
with RASCAL.OS;                   use RASCAL.OS;
with RASCAL.DragNDrop;            use RASCAL.DragNDrop;

package Controller_DataLoad is

   type MEL_Message_DataLoad is new AMEL_Message_DataLoad with null record;

   procedure Handle (The : in MEL_Message_DataLoad);

end Controller_DataLoad;
