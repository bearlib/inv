program test;

{$mode objfpc}{$H+}

uses
  Classes, SysUtils, Dialogs, ConioEngine, Math, CRT, BeaRLibInventory;

var
  X, Y: Integer;
  PlayerX: Integer = 9;
  PlayerY: Integer = 9;
  CurrentMap: Integer = 0;

const
  MapWidth = 25;
  MapHeight = 25;
  MapDeep = 3;

var
  Map: array[0..MapWidth - 1, 0..MapHeight - 1]of Char;

var
  IsRefresh: Boolean = True;
  IsInventory: Boolean = False;

type
  TItemBase = record
    ID: Word;
    Char: Char;
    Color: Byte;
    Name: string;
  end;

const
  BaseItemsAmount = 5;

const
  ItemBase: array [0..BaseItemsAmount - 1] of TItemBase = (
  (ID: 1;  Char: '('; Color: 10; Name: 'Short Sword'),
  (ID: 2;  Char: '/'; Color: 11; Name: 'Long Sword'),
  (ID: 3;  Char: '('; Color: 12; Name: 'Dark Axe'),
  (ID: 4;  Char: '}'; Color: 13; Name: 'Bow'),
  (ID: 5;  Char: '\'; Color: 14; Name: 'Spear')
  );

  procedure AddRandomItems(MapID, C: Integer);
  var
    I: Integer;
    FItem: TItem;
  begin
    for I := 1 to C do
    begin
      FItem.ItemID := Math.RandomRange(0, BaseItemsAmount) + 1;
      FItem.X := Math.RandomRange(1, MapWidth - 1);
      FItem.Y := Math.RandomRange(1, MapHeight - 1);
      Ground_Items_Append(MapID, FItem);
    end;
  end;

  procedure RenderGroundItems(MapID: Integer);
  var
    I: Integer;
    FItems: TItems;
  begin
    FItems := Ground_Items(MapID);
    for I := Ground_Count(MapID) - 1 downto 0 do
      ConioEngineWriteChar(FItems[I].X + 1, FItems[I].Y + 1,
        ItemBase[FItems[I].ItemID - 1].Char, ItemBase[FItems[I].ItemID - 1].Color);
  end;

  procedure RenderTileInfo(MapID: Integer);
  var
    I, C, X, Y: Integer;
    FItems: TItems;
  begin
    if (Ground_Count(MapID) = 0) then Exit;
    C := Ground_Count_InTile(MapID, PlayerX, PlayerY);
    if (C <= 0) then Exit;
    if (C > 26) then C := 26;
    FItems := Ground_Items_InTile(MapID, PlayerX, PlayerY);

    ConioEngineWriteString(MapWidth + 2, 4, 'Items on tile (' + IntToStr(Ground_Count_InTile(MapID, PlayerX, PlayerY)) + '):', 15);

    X := 0;
    Y := 0;
    for I := 0 to C - 1 do
    begin
      ConioEngineWriteString(MapWidth + X + 2, Y + 5, '[' + Chr(I + 97) + ']', 15);
      ConioEngineWriteString(MapWidth + X + 6, Y + 5, ItemBase[FItems[I].ItemID - 1].Name, ItemBase[FItems[I].ItemID - 1].Color);
      Inc(Y);
      if (Y > 19) then
      begin
        X := 30;
        Y := 0;
      end;
    end;
  end;

  procedure Pickup(MapID, Index: Integer);
  var
    AItem: TItem;
  begin
    if Ground_Items_Delete_InTile(MapID, Index - 97, PlayerX, PlayerY, AItem) then
      Inventory_Items_Append(AItem);
  end;

procedure RenderInventoryItems();
var
  I: Integer;
  FItems: TItems;
begin
  FItems := Inventory_Items();
  for I := 0 to Inventory_Count() - 1 do
  begin
    ConioEngineWriteString(4 + 2, I + 2, '[' + Chr(I + 97) + ']', 15);
    ConioEngineWriteString(4 + 6, I + 2, ItemBase[FItems[I].ItemID - 1].Name, ItemBase[FItems[I].ItemID - 1].Color);
  end;
end;

var
  I: Byte;
  Key: Char;
  FItems: TItems;

begin
  Randomize;
  UConioEngineInit;

  for Y := 0 to MapHeight - 1 do
    for X := 0 to MapWidth - 1 do
      Map[X, Y] := '.';


  for I := 0 to MapDeep - 1 do
    AddRandomItems(I, 100);

  repeat
    if IsRefresh then
    begin
      ConioEngineClear;

      if IsInventory then
      begin
        // Inventory screen
        ConioEngineWriteString(MapWidth + 8, 1,
          '[SPACE, Esc] Close inventory', 15);

        RenderInventoryItems();

      end else begin
        // Map screen
        for Y := 0 to MapHeight - 1 do
          for X := 0 to MapWidth - 1 do
            ConioEngineWriteChar(X + 1, Y + 1, Map[X, Y], 7);

        RenderGroundItems(CurrentMap);

        ConioEngineWriteChar(PlayerX + 1, PlayerY + 1, '@', 12);
        ConioEngineWriteString(MapWidth + 8, 1,
          '[2,4,6,8] Move, [SPACE] Inventory, [Esc] Close', 15);
        ConioEngineWriteString(MapWidth + 2, 1, IntToStr(PlayerX)
          + ':' + IntToStr(PlayerY), 15);
        ConioEngineWriteString(MapWidth + 2, 2, 'Items on cur. map: '
          + IntToStr(Ground_Count(CurrentMap)) + ' [+,-] Select cur. map: '
          + IntToStr(CurrentMap), 15);

        RenderTileInfo(CurrentMap);
      end;

      UConioEngineRefresh;
      IsRefresh := False;
    end;

    if KeyPressed then
    begin
      Key := ReadKey;
      if IsInventory then
        case Key of
          //'a'..'z': Pickup(ord(Key));
          chr(27), ' ': IsInventory := False;
        end
      else
        case Key of
          '1': begin
                 Ground_Items_Delete_All_InTile(CurrentMap, PlayerX, PlayerY, FItems);
               end;
          '+': if (CurrentMap < MapDeep - 1) then CurrentMap := CurrentMap + 1;
          '-': if (CurrentMap > 0) then CurrentMap := CurrentMap - 1;
          '2': Inc(PlayerY);
          '4': Dec(PlayerX);
          '6': Inc(PlayerX);
          '8': Dec(PlayerY);
          'a'..'z': Pickup(CurrentMap, ord(Key));
          ' ': IsInventory := True;
          chr(27): break;
        end;
      IsRefresh := True;
    end;

    Sleep(10);

  until False;
end.



