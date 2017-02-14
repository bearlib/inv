unit uInventory;

interface

uses uItems;

function Inventory_Clear(): Boolean; stdcall;
function Inventory_Count(): Cardinal; stdcall;
function Inventory_Items(): TItems; stdcall;
function Inventory_Items_Append(AItem: TItem): Boolean; stdcall;
function Inventory_Items_Delete(Index: Cardinal): Boolean; stdcall;

implementation

var
  Items: TItems;

function Inventory_Clear(): Boolean;
begin
  Result := (Length(Items) > 0);
  SetLength(Items, 0);
end;

function Inventory_Count(): Cardinal;
begin
  Result := Length(Items);
end;

function Inventory_Items(): TItems;
begin
  Result := Items;
end;

function Inventory_Items_Append(AItem: TItem): Boolean;
begin
  Result := False;
  SetLength(Items, Length(Items) + 1);
  Items[Length(Items) - 1] := AItem;
  Result := True;
end;

function Inventory_Items_Delete(Index: Cardinal): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (Length(Items) <= 0) or (Index > Length(Items) - 1) then Exit;
  for I := Index to Length(Items) - 2 do
    Items[I] := Items[I + 1];
  SetLength(Items, Length(Items) - 1);
  Result := True;
end;

end.
