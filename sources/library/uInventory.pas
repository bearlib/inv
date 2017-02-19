unit uInventory;

interface

uses uCommon;

procedure Items_Inventory_Clear(); stdcall;
function Items_Inventory_GetCount(): Integer; stdcall;

function Items_Inventory_SetItem(Index: Integer; AItem: TItem): Boolean; stdcall;
function Items_Inventory_GetItem(Index: Integer): TItem; stdcall;

procedure Items_Inventory_GetItems(var AItems: TItems); stdcall;
procedure Items_Inventory_SetItems(var AItems: TItems); stdcall;

procedure Items_Inventory_Items_Append(AItem: TItem); stdcall;
function Items_Inventory_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall;

implementation

var
  InvItems: TItems;

procedure Items_Inventory_Clear();
begin
  Empty(InvItems);
end;

function Items_Inventory_GetCount(): Integer;
begin
  Result := Length(InvItems);
end;

function Items_Inventory_GetItem(Index: Integer): TItem;
begin
  Result := InvItems[Index];
end;

function Items_Inventory_SetItem(Index: Integer; AItem: TItem): Boolean;
begin
  Result := False;
  if IndexInRange(InvItems, Index) then
  begin
    InvItems[Index] := AItem;
    Result := True;
  end;
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
  AddItem(InvItems, AItem);
end;

function Items_Inventory_Items_Delete(Index: Integer; var AItem: TItem): Boolean;
begin
  Result := False;
  if IndexInRange(InvItems, Index) then
  begin
    AItem := DelItem(InvItems, Index);
    Result := True;
  end;
end;

end.
