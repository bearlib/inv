unit uLibrary;

interface

// Library
procedure Items_Open(); stdcall;
procedure Items_Close(); stdcall;
function Items_GetVersion(): PWideChar; stdcall;

implementation

uses uDungeon, uInventory;

const
  LibVersion = '0.4.0';

// Library

procedure Items_Open(); stdcall;
begin
  Items_Dungeon_Clear();
  Items_Inventory_Clear();
end;

procedure Items_Close(); stdcall;
begin
  Items_Dungeon_Clear();
  Items_Inventory_Clear();
end;

function Items_GetVersion(): PWideChar; stdcall;
begin
  Result := LibVersion;
end;

end.
