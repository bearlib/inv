library BeaRLibItems;

uses      
  uCommon in 'uCommon.pas',
  uMaps in 'uMaps.pas',
  uInventory in 'uInventory.pas';

exports
  // Library
  Items_Open,
  Items_Close,
  Items_GetVersion,
  // Map
  Items_Maps_Clear,
  Items_Maps_MapClear,
  Items_Maps_MapClearXY,

  Items_Maps_GetCount,
  Items_Maps_GetMapCount,
  Items_Maps_GetMapCountXY,

  Items_Maps_GetItemCount,
  Items_Maps_GetMapItemCount,
  Items_Maps_GetMapItemCountXY,

  Items_Maps_SetItem,
  Items_Maps_GetItem,

  Items_Maps_SetItems, 
  Items_Maps_GetItems,
  Items_Maps_GetMapItems,
  Items_Maps_GetMapItemsXY,

  Items_Maps_Items_Append,
  Items_Maps_Items_Delete,
  Items_Maps_Items_DeleteXY,

  // Inventory
  Items_Inventory_Clear,
  Items_Inventory_GetCount,

  Items_Inventory_SetItem,
  Items_Inventory_GetItem,

  Items_Inventory_SetItems,
  Items_Inventory_GetItems,

  Items_Inventory_Items_Append,
  Items_Inventory_Items_Delete;

begin

end.
