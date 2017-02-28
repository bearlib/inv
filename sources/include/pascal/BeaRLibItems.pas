unit BeaRLibItems;

interface

type
  TItem = record
    ItemID: Integer;
    X: Integer;
    Y: Integer;
    MapID: Integer;
    Stack: Integer;
    Amount: Integer;
  end;

type
  TItems = array of TItem;   

// Library
procedure Items_Open(); stdcall; external 'BeaRLibItems.dll';
procedure Items_Close(); stdcall; external 'BeaRLibItems.dll';
function Items_GetVersion(): PChar; stdcall; external 'BeaRLibItems.dll';

// Maps
procedure Items_Maps_Clear(); stdcall; external 'BeaRLibItems.dll';
procedure Items_Maps_MapClear(MapID: Integer); stdcall; external 'BeaRLibItems.dll';
procedure Items_Maps_MapClearXY(MapID: Integer; AX, AY: Integer); stdcall; external 'BeaRLibItems.dll';

function Items_Maps_GetCount(): Integer; stdcall; external 'BeaRLibItems.dll';
function Items_Maps_GetMapCount(MapID: Integer): Integer; stdcall; external 'BeaRLibItems.dll';
function Items_Maps_GetMapCountXY(MapID: Integer; AX, AY: Integer): Integer; stdcall; external 'BeaRLibItems.dll';

function Items_Maps_GetItemCount(ItemID: Integer): Integer; stdcall; external 'BeaRLibItems.dll';
function Items_Maps_GetMapItemCount(MapID, ItemID: Integer): Integer; stdcall; external 'BeaRLibItems.dll';
function Items_Maps_GetMapItemCountXY(MapID, ItemID: Integer; AX, AY: Integer): Integer; stdcall; external 'BeaRLibItems.dll';

function Items_Maps_SetItem(Index: Integer; AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Items_Maps_GetItem(Index: Integer): TItem; stdcall; external 'BeaRLibItems.dll';

function Items_Maps_SetMapItem(MapID, Index: Integer; AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Items_Maps_GetMapItem(MapID, Index: Integer): TItem; stdcall; external 'BeaRLibItems.dll';

function Items_Maps_SetMapItemXY(MapID, Index: Integer; AX, AY: Integer; AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Items_Maps_GetMapItemXY(MapID, Index: Integer; AX, AY: Integer): TItem; stdcall; external 'BeaRLibItems.dll';

procedure Items_Maps_SetItems(var AItems: TItems); stdcall; external 'BeaRLibItems.dll';
procedure Items_Maps_GetItems(var AItems: TItems); stdcall; external 'BeaRLibItems.dll';
procedure Items_Maps_GetMapItems(MapID: Integer; var AItems: TItems); stdcall; external 'BeaRLibItems.dll';
procedure Items_Maps_GetMapItemsXY(MapID: Integer; AX, AY: Integer; var AItems: TItems); stdcall; external 'BeaRLibItems.dll';

procedure Items_Maps_Items_Append(AItem: TItem); stdcall; external 'BeaRLibItems.dll';
function Items_Maps_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Items_Maps_Items_DeleteXY(MapID: Integer; Index, AX, AY: Integer; var AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';

function Items_Maps_GetMapItemAmountXY(MapID, ItemID, AX, AY: Integer): Integer; stdcall; external 'BeaRLibItems.dll';

// Inventory
procedure Items_Inventory_Clear(); stdcall; external 'BeaRLibItems.dll';
function Items_Inventory_GetCount(): Integer; stdcall; external 'BeaRLibItems.dll';

function Items_Inventory_GetItemCount(ItemID: Integer): Integer; stdcall; external 'BeaRLibItems.dll';
function Items_Inventory_GetItemAmount(ItemID: Integer): Integer; stdcall; external 'BeaRLibItems.dll';

function Items_Inventory_SetItem(Index: Integer; AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Items_Inventory_GetItem(Index: Integer): TItem; stdcall; external 'BeaRLibItems.dll';

procedure Items_Inventory_SetItems(var AItems: TItems); stdcall; external 'BeaRLibItems.dll';
procedure Items_Inventory_GetItems(var AItems: TItems); stdcall; external 'BeaRLibItems.dll';

procedure Items_Inventory_Items_Append(AItem: TItem); stdcall; external 'BeaRLibItems.dll';
function Items_Inventory_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';

implementation

end.
