unit BeaRLibInventory;

interface

type
  TItem = record
    ID, X, Y: Integer;
  end;

type
  TItems = array of TItem;

// Ground
function Ground_Clear(): Boolean; stdcall; external 'BeaRLibInv.dll';
function Ground_Count(): Integer; stdcall; external 'BeaRLibInv.dll';
function Ground_Count_InTile(AX, AY: Integer): Integer; stdcall; external 'BeaRLibInv.dll';
function Ground_Item_By_Index(Index: Integer): TItem; stdcall; external 'BeaRLibInv.dll';
function Ground_Items(): TItems; stdcall; external 'BeaRLibInv.dll';
function Ground_Items_InTile(AX, AY: Integer): TItems; stdcall; external 'BeaRLibInv.dll';
function Ground_Items_Append(AItem: TItem): Boolean; stdcall; external 'BeaRLibInv.dll';
function Ground_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall; external 'BeaRLibInv.dll';
function Ground_Items_Delete_InTile(Index, AX, AY: Integer; var AItem: TItem): Boolean; stdcall; external 'BeaRLibInv.dll';
function Ground_Items_Delete_All_InTile(AX, AY: Integer; var AItems: TItems): Boolean; stdcall; external 'BeaRLibInv.dll';

// Inventory
function Inventory_Clear(): Boolean; stdcall; external 'BeaRLibInv.dll';
function Inventory_Count(): Integer; stdcall; external 'BeaRLibInv.dll';
function Inventory_Items(): TItems; stdcall; external 'BeaRLibInv.dll';
function Inventory_Items_Append(AItem: TItem): Boolean; stdcall; external 'BeaRLibInv.dll';
function Inventory_Items_Delete(Index: Integer): Boolean; stdcall; external 'BeaRLibInv.dll';

implementation

end.
