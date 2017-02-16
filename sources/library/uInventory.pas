unit uInventory;

interface

uses uItems, Dialogs, SysUtils;

function Items_Inventory_Clear(): Boolean; stdcall;
function Items_Inventory_Count(): Integer; stdcall;
function Items_Inventory_Items(): TItems; stdcall;
function Items_Inventory_Items_Append(AItem: TItem): Boolean; stdcall;
function Items_Inventory_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall;

implementation

var
  InvItems: TItems;

function Items_Inventory_Clear(): Boolean;
begin
  Result := (Length(InvItems) > 0);
  SetLength(InvItems, 0);
end;

function Items_Inventory_Count(): Integer;
begin
  Result := Length(InvItems);
end;

function Items_Inventory_Items(): TItems;
begin
  Result := InvItems;
end;

function Items_Inventory_Items_Append(AItem: TItem): Boolean;
begin
  Result := False;
  SetLength(InvItems, Length(InvItems) + 1);
  InvItems[Length(InvItems) - 1] := AItem;
  Result := True;
end;

function Items_Inventory_Items_Delete(Index: Integer; var AItem: TItem): Boolean;
var
  I: Integer;
begin
  ShowMessage(IntToStr(Index));
  Result := False;
  if (Length(InvItems) = 0) or (Index > Length(InvItems) - 1) then Exit;
  Result := True;


  AItem := InvItems[Index];
  for I := Index to Length(InvItems) - 2 do
    InvItems[I] := InvItems[I + 1];
  SetLength(InvItems, Length(InvItems) - 1);
end;

end.
