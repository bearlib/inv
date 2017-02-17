unit BeaRLibItems;

interface

type
  TItem = record
    ItemID: Integer;
    X: Integer;
    Y: Integer;
    MapID: Integer;
  end;

type
  TItems = array of TItem;

// Library
function Items_GetVersion(): PChar; stdcall; external 'BeaRLibItems.dll';
// Map
function Items_Ground_Clear(MapID: Integer): Boolean; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Clear_All(): Boolean; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Count(MapID: Integer): Integer; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Count_All(): Integer; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Count_InTile(MapID: Integer; AX, AY: Integer): Integer; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Item_By_Index(Index: Integer): TItem; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Items(MapID: Integer): TItems; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Items_All(): TItems; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Items_InTile(MapID: Integer; AX, AY: Integer): TItems; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Items_Append(AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Items_Delete_InTile(MapID: Integer; Index, AX, AY: Integer; var AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Items_Ground_Items_Delete_All_InTile(MapID: Integer; AX, AY: Integer; var AItems: TItems): Boolean; stdcall; external 'BeaRLibItems.dll';

// Inventory    
procedure Items_Inventory_Clear(); stdcall; external 'BeaRLibItems.dll';
function Items_Inventory_Count(): Integer; stdcall; external 'BeaRLibItems.dll';
procedure Items_Inventory_GetItems(var AItems: TItems); stdcall; external 'BeaRLibItems.dll';
procedure Items_Inventory_SetItems(var AItems: TItems); stdcall; external 'BeaRLibItems.dll';
procedure Items_Inventory_Items_Append(AItem: TItem); stdcall; external 'BeaRLibItems.dll';
function Items_Inventory_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';

implementation

end.
