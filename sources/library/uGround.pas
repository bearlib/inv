unit uGround;

interface

uses uCommon;   

procedure Items_Ground_Clear(); stdcall;
procedure Items_Ground_MapClear(MapID: Integer); stdcall;
function Items_Ground_MapClearXY(MapID: Integer; AX, AY: Integer; var AItems: TItems): Boolean; stdcall;

function Items_Ground_GetCount(): Integer; stdcall;
function Items_Ground_GetMapCount(MapID: Integer): Integer; stdcall;
function Items_Ground_GetMapCountXY(MapID: Integer; AX, AY: Integer): Integer; stdcall;

function Items_Ground_GetItem(Index: Integer): TItem; stdcall;
function Items_Ground_SetItem(Index: Integer; AItem: TItem): Boolean; stdcall;

procedure Items_Ground_GetItems(var AItems: TItems); stdcall;
procedure Items_Ground_SetItems(var AItems: TItems); stdcall;
function Items_Ground_GetMapItems(MapID: Integer): TItems; stdcall;
function Items_Ground_GetMapItemsXY(MapID: Integer; AX, AY: Integer): TItems; stdcall;

procedure Items_Ground_Items_Append(AItem: TItem); stdcall;
function Items_Ground_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall;
function Items_Ground_Items_DeleteXY(MapID: Integer; Index, AX, AY: Integer; var AItem: TItem): Boolean; stdcall;

implementation

var
  MapItems, TmpItems: TItems;

procedure Items_Ground_Clear();
begin
  SetLength(MapItems, 0);
end;

procedure Items_Ground_MapClear(MapID: Integer);
var
  I, J: Integer;
begin
  for I := 0 to Length(MapItems) - 1 do
    if (MapItems[I].MapID = MapID) then
    begin
      if (Length(MapItems) > 1) then
        for J := I to Length(MapItems) - 2 do
          MapItems[J] := MapItems[J + 1];
      SetLength(MapItems, Length(MapItems) - 1);
    end;
end;

function Items_Ground_MapClearXY(MapID: Integer; AX, AY: Integer; var AItems: TItems): Boolean;
var
  I, J: Integer;
  AItem: TItem;
begin
  Result := False;
  if HasEmpty(MapItems) then Exit;
  SetLength(TmpItems, 0);
  for I := 0 to Length(MapItems) - 1 do
    if HasItem(MapItems, I, MapID, AX, AY) then
    begin
      AItem := MapItems[I];
      if (Length(MapItems) > 1) then
        for J := I to Length(MapItems) - 2 do
          MapItems[J] := MapItems[J + 1];
      SetLength(MapItems, Length(MapItems) - 1);
      Result := True;
      SetLength(TmpItems, Length(TmpItems) + 1);
      TmpItems[Length(TmpItems) - 1] := AItem;
      AItems := TmpItems;
    end;
end;

function Items_Ground_GetCount(): Integer;
begin
  Result := Length(MapItems);
end;

function Items_Ground_GetMapCount(MapID: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(MapItems) - 1 do
    if (MapItems[I].MapID = MapID) then
      Inc(Result);
end;

function Items_Ground_GetMapCountXY(MapID: Integer; AX, AY: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  if HasEmpty(MapItems) then Exit;
  for I := 0 to Length(MapItems) - 1 do
    if HasItem(MapItems, I, MapID, AX, AY) then
      Inc(Result);
end;

function Items_Ground_GetItem(Index: Integer): TItem;
begin
  Result := MapItems[Index];
end;

function Items_Ground_SetItem(Index: Integer; AItem: TItem): Boolean;
begin
  Result := False;
  if IndexInRange(MapItems, Index) then
  begin
    MapItems[Index] := AItem;
    Result := True;
  end;
end;

procedure Items_Ground_GetItems(var AItems: TItems);
begin
  AItems := MapItems;
end;

procedure Items_Ground_SetItems(var AItems: TItems);
begin
  MapItems := AItems;
end;

function Items_Ground_GetMapItems(MapID: Integer): TItems;
var
  I: Integer;
begin
  SetLength(TmpItems, 0);
  Result := TmpItems;
  if HasEmpty(MapItems) then Exit;
  for I := 0 to Length(MapItems) - 1 do
    if (MapItems[I].MapID = MapID) then
    begin
      SetLength(TmpItems, Length(TmpItems) + 1);
      TmpItems[Length(TmpItems) - 1] := MapItems[I];
      Result := TmpItems;
    end;
end;

function Items_Ground_GetMapItemsXY(MapID: Integer; AX, AY: Integer): TItems;
var
  I: Integer;
begin
  SetLength(TmpItems, 0);
  Result := TmpItems;
  if HasEmpty(MapItems) then Exit;
  for I := 0 to Length(MapItems) - 1 do
    if HasItem(MapItems, I, MapID, AX, AY) then
    begin
      SetLength(TmpItems, Length(TmpItems) + 1);
      TmpItems[Length(TmpItems) - 1] := MapItems[I];
    end;
  Result := TmpItems;
end;

procedure Items_Ground_Items_Append(AItem: TItem);
begin
  SetLength(MapItems, Length(MapItems) + 1);
  MapItems[Length(MapItems) - 1] := AItem;
end;

function Items_Ground_Items_Delete(Index: Integer; var AItem: TItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  if not IndexInRange(MapItems, Index) then Exit;
  AItem := MapItems[Index];
  if (Length(MapItems) > 1) then
    for I := Index to Length(MapItems) - 2 do
      MapItems[I] := MapItems[I + 1];
  SetLength(MapItems, Length(MapItems) - 1);
  Result := True;
end;

function Items_Ground_Items_DeleteXY(MapID: Integer; Index, AX, AY: Integer; var AItem: TItem): Boolean;
var
  I, J, P: Integer;
begin
  Result := False;
  if not IndexInRange(MapItems, Index)then Exit;
  P := 0;
  for I := 0 to Length(MapItems) - 1 do
    if HasItem(MapItems, I, MapID, AX, AY) then
    begin
      if (P = Index) then
      begin
        AItem := MapItems[I];
        if (Length(MapItems) > 1) then
          for J := I to Length(MapItems) - 2 do
            MapItems[J] := MapItems[J + 1];
        SetLength(MapItems, Length(MapItems) - 1);
        Result := True;
        Exit;
      end;
      Inc(P);
    end;
end;

end.
