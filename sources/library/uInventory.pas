unit uInventory;

interface

uses uCommon;

procedure Items_Inventory_Clear(); stdcall;
function Items_Inventory_GetCount(): Integer; stdcall;

procedure Items_Inventory_GetItems(var AItems: TItems); stdcall;
procedure Items_Inventory_SetItems(var AItems: TItems); stdcall;

procedure Items_Inventory_Items_Append(AItem: TItem); stdcall;
function Items_Inventory_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall;

implementation

var
  InvItems: TItems;

procedure Items_Inventory_Clear();
begin
  SetLength(InvItems, 0);
end;

function Items_Inventory_GetCount(): Integer;
begin
  Result := Length(InvItems);
end;

procedure Items_Inventory_GetItems(var AItems: TItems);
begin
  AItems := InvItems;
end;

procedure Items_Inventory_SetItems(var AItems: TItems);
begin
  InvItems := AItems;
end;

procedure Items_Inventory_Items_Append(AItem: TItem);
begin
  SetLength(InvItems, Length(InvItems) + 1);
  InvItems[Length(InvItems) - 1] := AItem;
end;

function Items_Inventory_Items_Delete(Index: Integer; var AItem: TItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  if not IndexInRange(InvItems, Index) then Exit;
  Result := True;
  AItem := InvItems[Index];
  for I := Index to Length(InvItems) - 2 do
    InvItems[I] := InvItems[I + 1];
  SetLength(InvItems, Length(InvItems) - 1);
end;

end.
