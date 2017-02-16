unit BeaRLibItems;

interface

type
  TItem = record
    MapID: Integer;
    ItemID: Integer;
    X, Y: Integer;
  end;

type
  TItems = array of TItem;

// Ground
function Ground_Clear(MapID: Integer): Boolean; stdcall; external 'BeaRLibItems.dll';
function Ground_Count(MapID: Integer): Integer; stdcall; external 'BeaRLibItems.dll';
function Ground_Count_InTile(MapID: Integer; AX, AY: Integer): Integer; stdcall; external 'BeaRLibItems.dll';
function Ground_Item_By_Index(MapID: Integer; Index: Integer): TItem; stdcall; external 'BeaRLibItems.dll';
function Ground_Items(MapID: Integer): TItems; stdcall; external 'BeaRLibItems.dll';
function Ground_Items_InTile(MapID: Integer; AX, AY: Integer): TItems; stdcall; external 'BeaRLibItems.dll';
function Ground_Items_Append(MapID: Integer; AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Ground_Items_Delete(MapID: Integer; Index: Integer; var AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Ground_Items_Delete_InTile(MapID: Integer; Index, AX, AY: Integer; var AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Ground_Items_Delete_All_InTile(MapID: Integer; AX, AY: Integer; var AItems: TItems): Boolean; stdcall; external 'BeaRLibItems.dll';

// Inventory
function Inventory_Clear(): Boolean; stdcall; external 'BeaRLibItems.dll';
function Inventory_Count(): Integer; stdcall; external 'BeaRLibItems.dll';
function Inventory_Items(): TItems; stdcall; external 'BeaRLibItems.dll';
function Inventory_Items_Append(AItem: TItem): Boolean; stdcall; external 'BeaRLibItems.dll';
function Inventory_Items_Delete(Index: Integer): Boolean; stdcall; external 'BeaRLibItems.dll';

implementation

end.
