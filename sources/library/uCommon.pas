unit uCommon;

interface

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

implementation

function Items_GetVersion(): PChar; stdcall;
begin
  Result := LibVersion;
end;

function HasItem(AItems: TItems; Index, AMapID, AX, AY: Integer): Boolean;
begin
  Result := (AItems[Index].MapID = AMapID) and (AItems[Index].X = AX) and (AItems[Index].Y = AY);
end;

end.
