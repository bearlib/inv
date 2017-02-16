unit uGround;

interface

uses uItems;

{TODO: Переименовать Ground в Map?}
{DONE: Передавать ID карты в каждую функцию? или устанавливать текущим уровень карты? [Kipar]}
{DONE: Удаление всех предметов в тайле. [Kipar]}
{TODO: Возможность одним методом задать все предметы для уровня карты}
{TODO: Ограничение по весу и\или объему [Jesus05]}
{TODO: Стекинг [Jesus05]}

function Items_Ground_Clear(MapID: Integer): Boolean; stdcall;
function Items_Ground_Clear_All(): Boolean; stdcall;
function Items_Ground_Count(MapID: Integer): Integer; stdcall;
function Items_Ground_Count_All(): Integer; stdcall;
function Items_Ground_Count_InTile(MapID: Integer; AX, AY: Integer): Integer; stdcall;
function Items_Ground_Item_By_Index(Index: Integer): TItem; stdcall;
function Items_Ground_Items(MapID: Integer): TItems; stdcall;
function Items_Ground_Items_All(): TItems; stdcall;
function Items_Ground_Items_InTile(MapID: Integer; AX, AY: Integer): TItems; stdcall;
function Items_Ground_Items_Append(AItem: TItem): Boolean; stdcall;
function Items_Ground_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall;
function Items_Ground_Items_Delete_InTile(MapID: Integer; Index, AX, AY: Integer; var AItem: TItem): Boolean; stdcall;
function Items_Ground_Items_Delete_All_InTile(MapID: Integer; AX, AY: Integer; var AItems: TItems): Boolean; stdcall;

implementation

var
  MapItems, TmpItems: TItems;

function IsMapItem(N, MapID, AX, AY: Integer): Boolean;
begin
  Result := (MapItems[N].MapID = MapID) and (MapItems[N].X = AX) and (MapItems[N].Y = AY);
end;

function Items_Ground_Clear(MapID: Integer): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  for I := 0 to Length(MapItems) - 1 do
    if (MapItems[I].MapID = MapID) then
    begin
      if (Length(MapItems) > 1) then
        for J := I to Length(MapItems) - 2 do
          MapItems[J] := MapItems[J + 1];
      SetLength(MapItems, Length(MapItems) - 1);
      Result := True;
    end;
end;

function Items_Ground_Clear_All(): Boolean;
begin
  Result := (Length(MapItems) > 0);
  SetLength(MapItems, 0);
end;

function Items_Ground_Count(MapID: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(MapItems) - 1 do
    if (MapItems[I].MapID = MapID) then
      Inc(Result);
end;

function Items_Ground_Count_All(): Integer;
begin
  Result := Length(MapItems);
end;

function Items_Ground_Count_InTile(MapID: Integer; AX, AY: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  if (Length(MapItems) = 0) then Exit;
  for I := 0 to Length(MapItems) - 1 do
    if IsMapItem(I, MapID, AX, AY) then
      Inc(Result);
end;

function Items_Ground_Item_By_Index(Index: Integer): TItem;
begin
  Result := MapItems[Index];
end;

function Items_Ground_Items(MapID: Integer): TItems;
var
  I: Integer;
begin
  SetLength(TmpItems, 0);
  Result := TmpItems;
  if (Length(MapItems) = 0) then Exit;
  for I := 0 to Length(MapItems) - 1 do
    if (MapItems[I].MapID = MapID) then
    begin
      SetLength(TmpItems, Length(TmpItems) + 1);
      TmpItems[Length(TmpItems) - 1] := MapItems[I];
      Result := TmpItems;
    end;
end;

function Items_Ground_Items_All(): TItems;
begin
  Result := MapItems;
end;

function Items_Ground_Items_InTile(MapID: Integer; AX, AY: Integer): TItems;
var
  I: Integer;
begin
  SetLength(TmpItems, 0);
  Result := TmpItems;
  if (Length(MapItems) <= 0) then Exit;
  for I := 0 to Length(MapItems) - 1 do
    if IsMapItem(I, MapID, AX, AY) then
    begin
      SetLength(TmpItems, Length(TmpItems) + 1);
      TmpItems[Length(TmpItems) - 1] := MapItems[I];
    end;
  Result := TmpItems;
end;

function Items_Ground_Items_Append(AItem: TItem): Boolean;
begin
  Result := False;
  SetLength(MapItems, Length(MapItems) + 1);
  MapItems[Length(MapItems) - 1] := AItem;
end;

function Items_Ground_Items_Delete(Index: Integer; var AItem: TItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (Length(MapItems) = 0) or (Index > Length(MapItems) - 1) then Exit;
  AItem := MapItems[Index];
  if (Length(MapItems) > 1) then
    for I := Index to Length(MapItems) - 2 do
      MapItems[I] := MapItems[I + 1];
  SetLength(MapItems, Length(MapItems) - 1);
  Result := True;
end;

function Items_Ground_Items_Delete_InTile(MapID: Integer; Index, AX, AY: Integer; var AItem: TItem): Boolean;
var
  I, J, P: Integer;
begin
  Result := False;
  if (Length(MapItems) = 0) or (Index > Length(MapItems) - 1) then Exit;
  P := 0;
  for I := 0 to Length(MapItems) - 1 do
    if IsMapItem(I, MapID, AX, AY) then
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

function Items_Ground_Items_Delete_All_InTile(MapID: Integer; AX, AY: Integer; var AItems: TItems): Boolean;
var
  I, J: Integer;
  AItem: TItem;
begin
  Result := False;
  if (Length(MapItems) = 0) then Exit;
  SetLength(TmpItems, 0);
  for I := 0 to Length(MapItems) - 1 do
    if IsMapItem(I, MapID, AX, AY) then
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

end.
