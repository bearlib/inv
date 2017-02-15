unit uGround;

interface

uses uItems;

{TODO: Переименовать Ground в Map?}
{TODO: Передавать ID карты в каждую функцию? или устанавливать текущим уровень карты? [Kipar]}
{DONE: Удаление всех предметов в тайле. [Kipar]}
{TODO: Возможность одним методом задать все предметы для уровня карты}
{TODO: Ограничение по весу и\или объему [Jesus05]}
{TODO: Стекинг [Jesus05]}

function Ground_Clear(MapID: Integer): Boolean; stdcall;
function Ground_Count(MapID: Integer): Integer; stdcall;
function Ground_Count_InTile(MapID: Integer; AX, AY: Word): Integer; stdcall;
function Ground_Item_By_Index(MapID: Integer; Index: Integer): TItem; stdcall;
function Ground_Items(MapID: Integer): TItems; stdcall;
function Ground_Items_InTile(MapID: Integer; AX, AY: Integer): TItems; stdcall;
function Ground_Items_Append(MapID: Integer; AItem: TItem): Boolean; stdcall;
function Ground_Items_Delete(MapID: Integer; Index: Integer; var AItem: TItem): Boolean; stdcall;
function Ground_Items_Delete_InTile(MapID: Integer; Index, AX, AY: Integer; var AItem: TItem): Boolean; stdcall;
function Ground_Items_Delete_All_InTile(MapID: Integer; AX, AY: Integer; var AItems: TItems): Boolean; stdcall;

implementation

var
  MapItems, TmpItems: TItems;

function Ground_Clear(MapID: Integer): Boolean;
begin
  Result := (Length(MapItems) > 0);
  SetLength(MapItems, 0);
end;

function Ground_Count(MapID: Integer): Integer;
begin
  Result := Length(MapItems);
end;

function Ground_Count_InTile(MapID: Integer; AX, AY: Word): Integer;
var
  I: Integer;
begin
  Result := 0;
  if (Length(MapItems) = 0) then Exit;
  for I := 0 to Length(MapItems) - 1 do
    if (MapItems[I].X = AX) and (MapItems[I].Y = AY) then
      Inc(Result);
end;

function Ground_Item_By_Index(MapID: Integer; Index: Integer): TItem;
begin
  Result := MapItems[Index];
end;

function Ground_Items(MapID: Integer): TItems;
begin
  Result := MapItems;
end;

function Ground_Items_InTile(MapID: Integer; AX, AY: Integer): TItems;
var
  I: Integer;
begin
  SetLength(TmpItems, 0);
  Result := TmpItems;
  if (Length(MapItems) <= 0) then Exit;
  for I := 0 to Length(MapItems) - 1 do
    if (MapItems[I].X = AX) and (MapItems[I].Y = AY) then
    begin
      SetLength(TmpItems, Length(TmpItems) + 1);
      TmpItems[Length(TmpItems) - 1] := MapItems[I];
    end;
  Result := TmpItems;
end;

function Ground_Items_Append(MapID: Integer; AItem: TItem): Boolean;
begin
  Result := False;
  AItem.MapID := MapID;
  SetLength(MapItems, Length(MapItems) + 1);
  MapItems[Length(MapItems) - 1] := AItem;
end;

function Ground_Items_Delete(MapID: Integer; Index: Integer; var AItem: TItem): Boolean;
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

function Ground_Items_Delete_InTile(MapID: Integer; Index, AX, AY: Integer; var AItem: TItem): Boolean;
var
  I, J, P: Integer;
begin
  Result := False;
  if (Length(MapItems) = 0) or (Index > Length(MapItems) - 1) then Exit;
  P := 0;
  for I := 0 to Length(MapItems) - 1 do
    if (MapItems[I].X = AX) and (MapItems[I].Y = AY) then
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

function Ground_Items_Delete_All_InTile(MapID: Integer; AX, AY: Integer; var AItems: TItems): Boolean;
var
  I, J: Integer;
  AItem: TItem;
begin
  Result := False;
  if (Length(MapItems) = 0) then Exit;
  SetLength(TmpItems, 0);
  for I := 0 to Length(MapItems) - 1 do
    if (MapItems[I].X = AX) and (MapItems[I].Y = AY) then
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
