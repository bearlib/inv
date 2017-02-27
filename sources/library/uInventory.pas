unit uInventory;

interface

uses uCommon;

procedure Items_Inventory_Clear(); stdcall;
function Items_Inventory_GetCount(): Integer; stdcall;

function Items_Inventory_GetItemCount(ItemID: Integer): Integer; stdcall;

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

function Items_Inventory_GetItemCount(ItemID: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(InvItems) - 1 do
    if (InvItems[I].ItemID = ItemID) then
      Inc(Result);
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
var
  I, J, A: Integer;
begin
  if (AItem.Stack > 1) then
  begin
    if (Items_Inventory_GetItemCount(AItem.ItemID) > 0) then
    begin
      A := AItem.Amount;
      if not HasEmpty(InvItems) then
        for I := 0 to Length(InvItems) - 1 do
          if (InvItems[I].ItemID = AItem.ItemID) then
          begin
            if (InvItems[I].Amount < AItem.Stack) then
            begin
              J := AItem.Stack - InvItems[I].Amount;
              if (A - J < 0) then J := A;
              Dec(A, J);
              Inc(InvItems[I].Amount, J);
            end;
          end;
      while (A > 0) do
      begin
        J := AItem.Stack;
        if (A - J < 0) then J := A;
        Dec(A, J);
        AItem.Amount := J;
        AddItem(InvItems, AItem);
      end;
    end else AddItem(InvItems, AItem);
  end else AddItem(InvItems, AItem);
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
