unit uGround;

interface

uses uItems;

{TODO: ������������� Ground � Map?}
{TODO: ���������� ID ����� � ������ �������? ��� ������������� ������� ������� �����? [Kipar]}
{DONE: �������� ���� ��������� � �����. [Kipar]}
{TODO: ����������� ����� ������� ������ ��� �������� ��� ������ �����}
{TODO: ����������� �� ���� �\��� ������ [Jesus05]}
{TODO: ������� [Jesus05]}

function Ground_Clear(): Boolean; stdcall;
function Ground_Count(): Integer; stdcall;
function Ground_Count_InTile(AX, AY: Word): Integer; stdcall;
function Ground_Item_By_Index(Index: Integer): TItem; stdcall;
function Ground_Items(): TItems; stdcall;
function Ground_Items_InTile(AX, AY: Integer): TItems; stdcall;
function Ground_Items_Append(AItem: TItem): Boolean; stdcall;
function Ground_Items_Delete(Index: Integer; var AItem: TItem): Boolean; stdcall;
function Ground_Items_Delete_InTile(Index, AX, AY: Integer; var AItem: TItem): Boolean; stdcall;
function Ground_Items_Delete_All_InTile(AX, AY: Integer; var AItems: TItems): Boolean; stdcall;

implementation

var
  Items, FItems: TItems;

function Ground_Clear(): Boolean;
begin
  Result := (Length(Items) > 0);
  SetLength(Items, 0);
end;

function Ground_Count(): Integer;
begin
  Result := Length(Items);
end;

function Ground_Count_InTile(AX, AY: Word): Integer;
var
  I: Integer;
begin
  Result := 0;
  if (Length(Items) = 0) then Exit;
  for I := 0 to Length(Items) - 1 do
    if (Items[I].X = AX) and (Items[I].Y = AY) then
      Inc(Result);
end;

function Ground_Item_By_Index(Index: Integer): TItem;
begin
  Result := Items[Index];
end;

function Ground_Items(): TItems;
begin
  Result := Items;
end;

function Ground_Items_InTile(AX, AY: Integer): TItems;
var
  I: Integer;
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

function Ground_Items_Delete(Index: Integer; var AItem: TItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (Length(Items) = 0) or (Index > Length(Items) - 1) then Exit;
  AItem := Items[Index];
  if (Length(Items) > 1) then
    for I := Index to Length(Items) - 2 do
      Items[I] := Items[I + 1];
  SetLength(Items, Length(Items) - 1);
  Result := True;
end;

function Ground_Items_Delete_InTile(Index, AX, AY: Integer; var AItem: TItem): Boolean;
var
  I, J, P: Integer;
begin
  Result := False;
  if (Length(Items) = 0) or (Index > Length(Items) - 1) then Exit;
  P := 0;
  for I := 0 to Length(Items) - 1 do
    if (Items[I].X = AX) and (Items[I].Y = AY) then
    begin
      if (P = Index) then
      begin
        AItem := Items[I];
        if (Length(Items) > 1) then
          for J := I to Length(Items) - 2 do
            Items[J] := Items[J + 1];
        SetLength(Items, Length(Items) - 1);
        Result := True;
        Exit;
      end;
      Inc(P);
    end;
end;

function Ground_Items_Delete_All_InTile(AX, AY: Integer; var AItems: TItems): Boolean;
var
  I, J: Integer;
  AItem: TItem;
begin
  Result := False;
  if (Length(Items) = 0) then Exit;
  SetLength(FItems, 0);
  for I := 0 to Length(Items) - 1 do
    if (Items[I].X = AX) and (Items[I].Y = AY) then
    begin
      AItem := Items[I];
      if (Length(Items) > 1) then
        for J := I to Length(Items) - 2 do
          Items[J] := Items[J + 1];
      SetLength(Items, Length(Items) - 1);
      Result := True;
      SetLength(FItems, Length(FItems) + 1);
      FItems[Length(FItems) - 1] := AItem;
      AItems := FItems;
    end;
end;

end.
