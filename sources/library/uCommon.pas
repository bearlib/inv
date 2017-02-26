unit uCommon;

interface

{TODO: Ограничение по весу и\или объему [Jesus05]}
{TODO: Стекинг [Jesus05]}

const
  LibVersion = '0.3.0';

type
  TItem = record
    ItemID: Integer;
    X, Y: Integer;
    MapID: Integer;
    Stack: Integer;
    Amount: Integer;
//    Durability: Integer;
//    Weight: Integer;
//    Size: Integer;
  end;

type
  TItems = array of TItem;

// Library
procedure Items_Open();
procedure Items_Close();
function Items_GetVersion(): PChar; stdcall;

// Add
procedure Items_Clear_Item(var AItem: TItem);

// Common
function HasItem(AItems: TItems; Index, AMapID, AX, AY: Integer): Boolean;
function IndexInRange(AItems: TItems; Index: Integer): Boolean;
procedure AddItem(var AItems: TItems; AItem: TItem);
function DelItem(var AItems: TItems; Index: Integer): TItem;
function HasEmpty(AItems: TItems): Boolean;
procedure Empty(var AItems: TItems);

implementation

uses uMaps, uInventory;

// Library

procedure Items_Open();
begin
  Items_Maps_Clear();
  Items_Inventory_Clear();
end;

procedure Items_Close();
begin
  Items_Maps_Clear();
  Items_Inventory_Clear();
end;

function Items_GetVersion(): PChar; stdcall;
begin
  Result := LibVersion;
end;

//Add

procedure Items_Clear_Item(var AItem: TItem);
begin
  with AItem do
  begin
    ItemID := -1;
    X := -1;
    Y := -1;
    MapID := -1;
    Stack := 1;
  end;
end;

// Common

function HasItem(AItems: TItems; Index, AMapID, AX, AY: Integer): Boolean;
begin
  Result := (AItems[Index].MapID = AMapID) and (AItems[Index].X = AX) and (AItems[Index].Y = AY);
end;

function IndexInRange(AItems: TItems; Index: Integer): Boolean;
begin
  Result := (Index >= 0) and (Index < Length(AItems));
end;

procedure AddItem(var AItems: TItems; AItem: TItem);
begin
  SetLength(AItems, Length(AItems) + 1);
  AItems[Length(AItems) - 1] := AItem;
end;

function DelItem(var AItems: TItems; Index: Integer): TItem;
var
  I: Integer;
begin
  Result := AItems[Index];
  if (Length(AItems) > 1) then
    for I := Index to Length(AItems) - 2 do
      AItems[I] := AItems[I + 1];
  SetLength(AItems, Length(AItems) - 1);
end;

function HasEmpty(AItems: TItems): Boolean;
begin
  Result := (Length(AItems) = 0);
end;

procedure Empty(var AItems: TItems);
begin
  SetLength(AItems, 0);
end;

end.
