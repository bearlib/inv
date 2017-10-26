library BeaRLibItems;

uses
  uBearLibItemsCommon in 'uBearLibItemsCommon.pas',
  uBearLibItemsDungeon in 'uBearLibItemsDungeon.pas',
  uBearLibItemsInventory in 'uBearLibItemsInventory.pas';

exports
  // Library
  Items_Open,
  Items_Close,
  Items_GetVersion,
  Items_Clear_Item,

  // Map
  Items_Dungeon_Clear,
  Items_Dungeon_MapClear,
  Items_Dungeon_MapClearXY,

  Items_Dungeon_GetCount,
  Items_Dungeon_GetMapCount,
  Items_Dungeon_GetMapCountXY,

  Items_Dungeon_GetItemCount,
  Items_Dungeon_GetMapItemCount,
  Items_Dungeon_GetMapItemCountXY,

  Items_Dungeon_SetItem,
  Items_Dungeon_GetItem,

  Items_Dungeon_SetMapItem,
  Items_Dungeon_GetMapItem,

  Items_Dungeon_SetMapItemXY,
  Items_Dungeon_GetMapItemXY,

  Items_Dungeon_AppendItem,

  Items_Dungeon_DeleteItem,
  Items_Dungeon_DeleteMapItem,
  Items_Dungeon_DeleteMapItemXY,

  Items_Dungeon_GetMapItemAmountXY,

  // Inventory
  Items_Inventory_Clear,

  Items_Inventory_GetCount,
  Items_Inventory_GetItemCount,

  Items_Inventory_GetWeight,
  Items_Inventory_GetItemWeight,

  Items_Inventory_GetSize,
  Items_Inventory_GetItemSize,

  Items_Inventory_GetItemAmount,
  Items_Inventory_DeleteItemAmount,
  
  Items_Inventory_SetItem,
  Items_Inventory_GetItem,

  Items_Inventory_AppendItem,
  Items_Inventory_DeleteItem,

  Items_Inventory_EquipItem,
  Items_Inventory_UnEquipItem,

  Items_Inventory_SetMaxSlotCount,
  Items_Inventory_GetMaxSlotCount,

  Items_Inventory_SetMaxWeight,
  Items_Inventory_GetMaxWeight,

  Items_Inventory_SetMaxSize,
  Items_Inventory_GetMaxSize;

begin

end.
