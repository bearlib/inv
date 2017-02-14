unit uGround;

interface

uses uItems;

{TODO: Переименовать Ground в Map?}
{TODO: Передавать ID карты в каждую функцию? или устанавливать текущим уровень карты? [Kipar]}
{TODO: Удаление всех предметов в тайле. [Kipar]}
{TODO: Возможность одним методом задать все предметы для уровня карты}
{TODO: Ограничение по весу и\или объему [Jesus05]}
{TODO: Стекинг [Jesus05]}

function Ground_Clear(): Boolean; stdcall;
function Ground_Count(): Cardinal; stdcall;
function Ground_Count_InTile(AX, AY: Word): Cardinal; stdcall;
function Ground_Item_By_Index(Index: Cardinal): TItem; stdcall;
function Ground_Items(): TItems; stdcall;
function Ground_Items_InTile(AX, AY: Cardinal): TItems; stdcall;
function Ground_Items_Append(AItem: TItem): Boolean; stdcall;
function Ground_Items_Delete(Index: Cardinal): TItem; stdcall;
function Ground_Items_Delete_InTile(Index, AX, AY: Cardinal): TItem; stdcall;

implementation

var
  Items, FItems: TItems;

function Ground_Clear(): Boolean;
begin
  Result := (Length(Items) > 0);
  SetLength(Items, 0);
end;

function Ground_Count(): Cardinal;
begin
  Result := Length(Items);
end;

function Ground_Count_InTile(AX, AY: Word): Cardinal;
var
  I: Cardinal;
begin
  Result := 0;
  for I := 0 to Length(Items) - 1 do
    if (Items[I].X = AX) and (Items[I].Y = AY) then
      Inc(Result);
end;

function Ground_Item_By_Index(Index: Cardinal): TItem;
begin
  Result := Items[Index];
end;

function Ground_Items(): TItems;
begin
  Result := Items;
end;

function Ground_Items_InTile(AX, AY: Cardinal): TItems;
var
  I: Cardinal;
begin
  SetLength(FItems, 0);
  Result := FItems;
  if (Length(Items) <= 0) then Exit;
  for I := 0 to Length(Items) - 1 do
    if (Items[I].X = AX) and (Items[I].Y = AY) then
    begin
      SetLength(FItems, Length(FItems) + 1);
      FItems[Length(FItems) - 1] := Items[I];
    end;
  Result := FItems;
end;

function Ground_Items_Append(AItem: TItem): Boolean;
begin
  Result := False;
  SetLength(Items, Length(Items) + 1);
  Items[Length(Items) - 1] := AItem;
end;

function Ground_Items_Delete(Index: Cardinal): TItem;
var
  I: Integer;
  FItem: TItem;
begin
  Result := FItem;
  if (Length(Items) <= 0) or (Index > Length(Items) - 1) then Exit;
  FItem := Items[Index];
  for I := Index to Length(Items) - 2 do
    Items[I] := Items[I + 1];
  SetLength(Items, Length(Items) - 1);
  Result := FItem;
end;

function Ground_Items_Delete_InTile(Index, AX, AY: Cardinal): TItem;
var
  I, J, P: Cardinal;
  FItem: TItem;
begin
  Result := FItem;
  if (Length(Items) <= 0) then Exit;
  P := 0;
  for I := 0 to Length(Items) - 1 do
    if (Items[I].X = AX) and (Items[I].Y = AY) then
    begin
      if (P = Index) then
      begin
        FItem := Items[Index];
        for J := I to Length(Items) - 2 do
          Items[J] := Items[J + 1];
        SetLength(Items, Length(Items) - 1);
        Result := FItem;
        Exit;
      end;
      Inc(P);
    end;
end;

end.
