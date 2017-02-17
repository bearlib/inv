unit uCommon;

interface

{TODO: Переименовать Ground в Map?}
{TODO: Ограничение по весу и\или объему [Jesus05]}
{TODO: Стекинг [Jesus05]}

const
  LibVersion = '0.3.0';

type
  TItem = record
    ItemID: Integer;
    X, Y: Integer;
    MapID: Integer;
  end;

type
  TItems = array of TItem;

// Library
function Items_GetVersion(): PChar; stdcall;

// Common
function HasItem(AItems: TItems; Index, AMapID, AX, AY: Integer): Boolean;
function IndexInRange(AItems: TItems; Index: Integer): Boolean;
function HasEmpty(AItems: TItems): Boolean;
//procedure DelItem();

implementation

function Items_GetVersion(): PChar; stdcall;
begin
  Result := LibVersion;
end;

function HasItem(AItems: TItems; Index, AMapID, AX, AY: Integer): Boolean;
begin
  Result := (AItems[Index].MapID = AMapID) and (AItems[Index].X = AX) and (AItems[Index].Y = AY);
end;

function IndexInRange(AItems: TItems; Index: Integer): Boolean;
begin
  Result := (Index >= 0) and (Index < Length(AItems));
end;

function HasEmpty(AItems: TItems): Boolean;
begin
  Result := (Length(AItems) = 0);
end;

end.
