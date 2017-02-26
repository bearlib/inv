program test;

{$mode objfpc}{$H+}

uses
  Classes, SysUtils, Dialogs, ConioEngine, Math, CRT,
  BeaRLibItems in '..\include\pascal\BeaRLibItems.pas';

var
  X, Y: Integer;
  CurrentMap: Integer = 0;
  Player: TPoint;

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
  BaseItemsAmount = 7;

const
  ItemBase: array [0..BaseItemsAmount - 1] of TItemBase = (
  (ID: 1;  Char: '('; Color: 10; Name: 'Short Sword'),
  (ID: 2;  Char: '/'; Color: 11; Name: 'Long Sword'),
  (ID: 3;  Char: '('; Color: 12; Name: 'Dark Axe'),
  (ID: 4;  Char: '}'; Color: 13; Name: 'Bow'),
  (ID: 5;  Char: '\'; Color: 14; Name: 'Spear'),
  (ID: 6;  Char: '$'; Color: 14; Name: 'Gold'),
  (ID: 7;  Char: '`'; Color: 14; Name: 'Key')
  );

  procedure AddRandomItems(MapID, C: Integer);
  var
    I: Integer;
    FItem: TItem;
  begin
    for I := 1 to C do
    begin
      FItem.ItemID := Math.RandomRange(0, BaseItemsAmount) + 1;
      FItem.MapID := MapID;
      FItem.X := Math.RandomRange(1, MapWidth - 1);
      FItem.Y := Math.RandomRange(1, MapHeight - 1);
      case FItem.ItemID of
        6: // Gold
        begin
          FItem.Stack := 10;
          FItem.Amount := Math.RandomRange(0, 10) + 1;
        end;
        7: // Key
        begin
          FItem.Stack := 5;
          FItem.Amount := Math.RandomRange(0, 5) + 1;
        end;
        else
        begin
          FItem.Stack := 1;
          FItem.Amount := 1;
        end;
      end;
      Items_Maps_Items_Append(FItem);
    end;
  end;

  procedure RenderMapsItems(MapID: Integer);
  var
    I: Integer;
    FItems: TItems;
  begin
    Items_Maps_GetMapItems(MapID, FItems);
    for I := Items_Maps_GetMapCount(MapID) - 1 downto 0 do
      ConioEngineWriteChar(FItems[I].X + 1, FItems[I].Y + 1,
        ItemBase[FItems[I].ItemID - 1].Char, ItemBase[FItems[I].ItemID - 1].Color);
  end;

  procedure RenderTileInfo(MapID: Integer);
  var
    I, C, X, Y: Integer;
    FItems: TItems;
    S: string;
  begin
    if (Items_Maps_GetMapCount(MapID) = 0) then Exit;
    C := Items_Maps_GetMapCountXY(MapID, Player.X, Player.Y);
    if (C <= 0) then Exit;
    if (C > 26) then C := 26;
    Items_Maps_GetMapItemsXY(MapID, Player.X, Player.Y, FItems);

    ConioEngineWriteString(MapWidth + 2, 4, 'Items on tile (' + IntToStr(Items_Maps_GetMapCountXY(MapID, Player.X, Player.Y)) + '):', 15);

    X := 0;
    Y := 0;
    for I := 0 to C - 1 do
    begin
      S := ''; if (FItems[I].Stack > 1) then S := ' (' + IntToStr(FItems[I].Amount) + ')';
      ConioEngineWriteString(MapWidth + X + 2, Y + 5, '[' + Chr(I + 97) + ']', 15);
      ConioEngineWriteString(MapWidth + X + 6, Y + 5, ItemBase[FItems[I].ItemID - 1].Name
        + S, ItemBase[FItems[I].ItemID - 1].Color);
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
  if Items_Maps_Items_DeleteXY(MapID, Index - 97, Player.X, Player.Y, AItem) then
    Items_Inventory_Items_Append(AItem);
end;

procedure Drop(MapID, Index: Integer);
var
  AItem: TItem;
begin
  if Items_Inventory_Items_Delete(Index - 97, AItem) then
  begin
    AItem.X := Player.X;
    AItem.Y := Player.Y;
    AItem.MapID := MapID;
    Items_Maps_Items_Append(AItem);
  end;
end;

procedure RenderInventoryItems();
var
  I: Integer;
  FItems: TItems;
  S: string;
begin
  Items_Inventory_GetItems(FItems);
  for I := 0 to Items_Inventory_GetCount() - 1 do
  begin
    S := ''; if (FItems[I].Stack > 1) then S := ' (' + IntToStr(FItems[I].Amount) + ')';
    ConioEngineWriteString(4 + 2, I + 2, '[' + Chr(I + 97) + ']', 15);
    ConioEngineWriteString(4 + 6, I + 2, ItemBase[FItems[I].ItemID - 1].Name + S, ItemBase[FItems[I].ItemID - 1].Color);
  end;
end;

var
  I: Byte;
  Key: Char;
  FItems: TItems;

begin
  Randomize;
  Items_Open;
  UConioEngineInit;
  Player := Point(9, 9);

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

        RenderMapsItems(CurrentMap);

        ConioEngineWriteChar(Player.X + 1, Player.Y + 1, '@', 12);
        ConioEngineWriteString(MapWidth + 8, 1,
          '[2,4,6,8] Move, [SPACE] Inventory, [Esc] Close', 15);
        ConioEngineWriteString(MapWidth + 2, 1, IntToStr(Player.X)
          + ':' + IntToStr(Player.Y), 15);
        ConioEngineWriteString(MapWidth + 2, 2, 'Items on cur. map: '
          + IntToStr(Items_Maps_GetMapCount(CurrentMap)) + ' [+,-] Select cur. map: '
          + IntToStr(CurrentMap), 15);

        RenderTileInfo(CurrentMap);
      end;

      ConioEngineWriteString(70, 24, 'v.' + Items_GetVersion(), 4);

      UConioEngineRefresh;
      IsRefresh := False;
    end;

    if KeyPressed then
    begin
      Key := ReadKey;
      if IsInventory then
        case Key of
          'a'..'z': Drop(CurrentMap, ord(Key));
          chr(27), ' ': IsInventory := False;
        end
      else
        case Key of
          '1': begin
                 Items_Maps_MapClearXY(CurrentMap, Player.X, Player.Y, FItems);
               end;
          '+': if (CurrentMap < MapDeep - 1) then CurrentMap := CurrentMap + 1;
          '-': if (CurrentMap > 0) then CurrentMap := CurrentMap - 1;
          '2': Inc(Player.Y);
          '4': Dec(Player.X);
          '6': Inc(Player.X);
          '8': Dec(Player.Y);
          'a'..'z': Pickup(CurrentMap, ord(Key));
          ' ': IsInventory := True;
          chr(27): break;
        end;
      IsRefresh := True;
    end;

    Sleep(10);

  until False;
  Items_Close;
end.



