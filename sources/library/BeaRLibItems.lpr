library BeaRLibItems;

{$mode objfpc}{$H+}

uses
  uCommon in 'uCommon.pas',
  uLibrary in 'uLibrary.pas',
  uDungeon in 'uDungeon.pas',
  uInventory in 'uInventory.pas';

exports
  // Library
  Items_Open,
  Items_Close,
  Items_GetVersion,

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
  Items_Dungeon_DeleteItemXY,

  Items_Dungeon_GetMapItemAmountXY,

  // Inventory
  Items_Inventory_Clear,
  Items_Inventory_GetCount,

  Items_Inventory_GetItemCount,
  Items_Inventory_GetItemAmount,

  Items_Inventory_SetItem,
  Items_Inventory_GetItem,

  Items_Inventory_AppendItem,
  Items_Inventory_DeleteItem;

begin

end.
