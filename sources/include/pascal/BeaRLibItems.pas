unit BeaRLibItems;

interface

type
  Item = record
    ItemID: Integer;    
    X: Integer;
    Y: Integer;
    MapID: Integer;
    Identify: Integer;
    Stack: Integer;
    Amount: Integer;
    MinDamage: Integer;
    MaxDamage: Integer;
    Defense: Integer;
    Durability: Integer;
    MaxDurability: Integer;
    Weight: Integer;
    Size: Integer;
    SlotID: Integer;
    Equipment: Integer;
    Price: Integer;
    Attributes: Cardinal;
    Bonus: Cardinal;
    Color: Cardinal;
  end;

// Library
procedure Items_Open(); stdcall; external 'BeaRLibItems';
procedure Items_Close(); stdcall; external 'BeaRLibItems';
function Items_GetVersion(): PWideChar; stdcall; external 'BeaRLibItems';
procedure Items_Clear_Item(var AItem: Item); external 'BeaRLibItems';

// Dungeon
procedure Items_Dungeon_Clear(); stdcall; external 'BeaRLibItems';
procedure Items_Dungeon_MapClear(MapID: Integer); stdcall; external 'BeaRLibItems';
procedure Items_Dungeon_MapClearXY(MapID: Integer; AX, AY: Integer); stdcall; external 'BeaRLibItems';

function Items_Dungeon_GetCount(): Integer; stdcall; external 'BeaRLibItems';
function Items_Dungeon_GetMapCount(MapID: Integer): Integer; stdcall; external 'BeaRLibItems';
function Items_Dungeon_GetMapCountXY(MapID: Integer; AX, AY: Integer): Integer; stdcall; external 'BeaRLibItems';

function Items_Dungeon_GetItemCount(ItemID: Integer): Integer; stdcall; external 'BeaRLibItems';
function Items_Dungeon_GetMapItemCount(MapID, ItemID: Integer): Integer; stdcall; external 'BeaRLibItems';
function Items_Dungeon_GetMapItemCountXY(MapID, ItemID: Integer; AX, AY: Integer): Integer; stdcall; external 'BeaRLibItems';

function Items_Dungeon_SetItem(Index: Integer; AItem: Item): Integer; stdcall; external 'BeaRLibItems';
function Items_Dungeon_GetItem(Index: Integer): Item; stdcall; external 'BeaRLibItems';

function Items_Dungeon_SetMapItem(MapID, Index: Integer; AItem: Item): Integer; stdcall; external 'BeaRLibItems';
function Items_Dungeon_GetMapItem(MapID, Index: Integer): Item; stdcall; external 'BeaRLibItems';

function Items_Dungeon_SetMapItemXY(MapID, Index: Integer; AX, AY: Integer; AItem: Item): Integer; stdcall; external 'BeaRLibItems';
function Items_Dungeon_GetMapItemXY(MapID, Index: Integer; AX, AY: Integer): Item; stdcall; external 'BeaRLibItems';

procedure Items_Dungeon_AppendItem(AItem: Item; InHead: Boolean = False); stdcall; external 'BeaRLibItems';

function Items_Dungeon_DeleteItem(Index: Integer; var AItem: Item): Integer; stdcall; external 'BeaRLibItems';
function Items_Dungeon_DeleteMapItem(MapID: Integer; Index: Integer; var AItem: Item): Integer; stdcall; external 'BeaRLibItems';
function Items_Dungeon_DeleteMapItemXY(MapID: Integer; Index, AX, AY: Integer; var AItem: Item): Integer; stdcall; external 'BeaRLibItems';

function Items_Dungeon_GetMapItemAmountXY(MapID, ItemID, AX, AY: Integer): Integer; stdcall; external 'BeaRLibItems';

// Inventory
procedure Items_Inventory_Clear(); stdcall; external 'BeaRLibItems';

function Items_Inventory_GetCount(): Integer; stdcall; external 'BeaRLibItems';
function Items_Inventory_GetItemCount(ItemID: Integer): Integer; stdcall; external 'BeaRLibItems';

function Items_Inventory_GetWeight(): Integer; stdcall; external 'BeaRLibItems';
function Items_Inventory_GetItemWeight(ItemID: Integer): Integer; stdcall; external 'BeaRLibItems';

function Items_Inventory_GetSize(): Integer; stdcall; external 'BeaRLibItems';
function Items_Inventory_GetItemSize(ItemID: Integer): Integer; stdcall; external 'BeaRLibItems';

function Items_Inventory_GetItemAmount(ItemID: Integer): Integer; stdcall; external 'BeaRLibItems';
function Items_Inventory_DeleteItemAmount(ItemID, Amount: Integer): Integer; stdcall; external 'BeaRLibItems';

function Items_Inventory_SetItem(Index: Integer; AItem: Item): Integer; stdcall; external 'BeaRLibItems';
function Items_Inventory_GetItem(Index: Integer): Item; stdcall; external 'BeaRLibItems';

procedure Items_Inventory_AppendItem(AItem: Item); stdcall; external 'BeaRLibItems';
function Items_Inventory_DeleteItem(Index: Integer; var AItem: Item): Integer; stdcall; external 'BeaRLibItems';

function Items_Inventory_EquipItem(Index: Integer): Integer; stdcall; external 'BeaRLibItems';
function Items_Inventory_UnEquipItem(Index: Integer): Integer; stdcall; external 'BeaRLibItems';

procedure Items_Inventory_SetMaxSlotCount(ACount: Integer); stdcall; external 'BeaRLibItems';
function Items_Inventory_GetMaxSlotCount: Integer; stdcall; external 'BeaRLibItems';

procedure Items_Inventory_SetMaxWeight(const Value: Integer); stdcall; external 'BeaRLibItems';
function Items_Inventory_GetMaxWeight: Integer; stdcall; external 'BeaRLibItems';

procedure Items_Inventory_SetMaxSize(const Value: Integer); stdcall; external 'BeaRLibItems';
function Items_Inventory_GetMaxSize: Integer; stdcall; external 'BeaRLibItems';

implementation

end.
