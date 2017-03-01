unit uInventory;

interface

uses uCommon;

procedure Items_Inventory_Clear(); stdcall;

function Items_Inventory_GetCount(): Integer; stdcall;
function Items_Inventory_GetItemCount(ItemID: Integer): Integer; stdcall;

function Items_Inventory_GetWeight(): Integer; stdcall;
function Items_Inventory_GetItemWeight(ItemID: Integer): Integer; stdcall;

function Items_Inventory_GetSize(): Integer; stdcall;
function Items_Inventory_GetItemSize(ItemID: Integer): Integer; stdcall;

function Items_Inventory_GetItemAmount(ItemID: Integer): Integer; stdcall;

function Items_Inventory_SetItem(Index: Integer; AItem: Item): Boolean; stdcall;
function Items_Inventory_GetItem(Index: Integer): Item; stdcall;

procedure Items_Inventory_AppendItem(AItem: Item); stdcall;
function Items_Inventory_DeleteItem(Index: Integer; var AItem: Item): Boolean; stdcall;

implementation

var
  InvItems: TItems;

procedure Items_Inventory_Clear(); stdcall;
begin
  Empty(InvItems);
end;

function Items_Inventory_GetCount(): Integer; stdcall;
begin
  Result := Length(InvItems);
end;

function Items_Inventory_GetItemCount(ItemID: Integer): Integer; stdcall;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(InvItems) - 1 do
    if (InvItems[I].ItemID = ItemID) then
      Inc(Result);
end;

function Items_Inventory_GetWeight(): Integer; stdcall;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(InvItems) - 1 do
    Inc(Result, InvItems[I].Weight);
end;

function Items_Inventory_GetItemWeight(ItemID: Integer): Integer; stdcall;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(InvItems) - 1 do
    if (InvItems[I].ItemID = ItemID) then
      Inc(Result, InvItems[I].Weight);
end;

function Items_Inventory_GetSize(): Integer; stdcall;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(InvItems) - 1 do
    Inc(Result, InvItems[I].Size);
end;

function Items_Inventory_GetItemSize(ItemID: Integer): Integer; stdcall;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(InvItems) - 1 do
    if (InvItems[I].ItemID = ItemID) then
      Inc(Result, InvItems[I].Size);
end;

function Items_Inventory_GetItemAmount(ItemID: Integer): Integer; stdcall;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(InvItems) - 1 do
    if (InvItems[I].ItemID = ItemID) then
      Inc(Result, InvItems[I].Amount);
end;

function Items_Inventory_GetItem(Index: Integer): Item; stdcall;
begin
  Result := InvItems[Index];
end;

function Items_Inventory_SetItem(Index: Integer; AItem: Item): Boolean; stdcall;
begin
  Result := False;
  if IndexInRange(InvItems, Index) then
  begin
    InvItems[Index] := AItem;
    Result := True;
  end;
end;

procedure Items_Inventory_AppendItem(AItem: Item); stdcall;
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

function Items_Inventory_DeleteItem(Index: Integer; var AItem: Item): Boolean; stdcall;
begin
  Result := False;
  if IndexInRange(InvItems, Index) then
  begin
    AItem := DelItem(InvItems, Index);
    Result := True;
  end;
end;

end.
