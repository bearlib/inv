unit uLibrary;

interface

// Library
procedure Items_Open();
procedure Items_Close();
function Items_GetVersion(): PChar; stdcall;

implementation

uses uDungeon, uInventory;

const
  LibVersion = '0.4.0';

// Library

procedure Items_Open();
begin
  Items_Dungeon_Clear();
  Items_Inventory_Clear();
end;

procedure Items_Close();
begin
  Items_Dungeon_Clear();
  Items_Inventory_Clear();
end;

function Items_GetVersion(): PChar; stdcall;
begin
  Result := LibVersion;
end;

end.
