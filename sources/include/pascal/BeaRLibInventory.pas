unit BeaRLibInventory;

interface

type
  TItem = record
    ID, X, Y: Cardinal;
  end;

type
  TItems = array of TItem;

// Ground
function Ground_Clear(): Boolean; stdcall; external 'BeaRLibInv.dll';
function Ground_Count(): Cardinal; stdcall; external 'BeaRLibInv.dll';
function Ground_Count_InTile(AX, AY: Cardinal): Cardinal; stdcall; external 'BeaRLibInv.dll';
function Ground_Items(): TItems; stdcall; external 'BeaRLibInv.dll';
function Ground_Items_InTile(AX, AY: Cardinal): TItems; stdcall; external 'BeaRLibInv.dll';
function Ground_Items_Append(AItem: TItem): Boolean; stdcall; external 'BeaRLibInv.dll';
function Ground_Items_Delete(Pos: Cardinal): TItem; stdcall; external 'BeaRLibInv.dll';
function Ground_Items_Delete_InTile(Pos, AX, AY: Cardinal): TItem; stdcall; external 'BeaRLibInv.dll';

// Inventory
function Inventory_Clear(): Boolean; stdcall; external 'BeaRLibInv.dll';
function Inventory_Count(): Cardinal; stdcall; external 'BeaRLibInv.dll';
function Inventory_Items(): TItems; stdcall; external 'BeaRLibInv.dll';
function Inventory_Items_Append(AItem: TItem): Boolean; stdcall; external 'BeaRLibInv.dll';
function Inventory_Items_Delete(Pos: Cardinal): Boolean; stdcall; external 'BeaRLibInv.dll';

implementation

end.
