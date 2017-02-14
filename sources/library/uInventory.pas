unit uInventory;

interface

uses uItems;

function Inventory_Clear(): Boolean; stdcall;
function Inventory_Count(): Integer; stdcall;
function Inventory_Items(): TItems; stdcall;
function Inventory_Items_Append(AItem: TItem): Boolean; stdcall;
function Inventory_Items_Delete(Index: Integer): Boolean; stdcall;

implementation

var
  InvItems: TItems;

function Inventory_Clear(): Boolean;
begin
  Result := (Length(InvItems) > 0);
  SetLength(InvItems, 0);
end;

function Inventory_Count(): Integer;
begin
  Result := Length(InvItems);
end;

function Inventory_Items(): TItems;
begin
  Result := InvItems;
end;

function Inventory_Items_Append(AItem: TItem): Boolean;
begin
  Result := False;
  SetLength(InvItems, Length(InvItems) + 1);
  InvItems[Length(InvItems) - 1] := AItem;
  Result := True;
end;

function Inventory_Items_Delete(Index: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (Length(InvItems) <= 0) or (Index > Length(InvItems) - 1) then Exit;
  for I := Index to Length(InvItems) - 2 do
    InvItems[I] := InvItems[I + 1];
  SetLength(InvItems, Length(InvItems) - 1);
  Result := True;
end;

end.
