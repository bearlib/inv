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
  TItemBase = packed record
    ID: Word;
    Char: Char;
    Color: Byte;
    MaxDurability: Word;
    Name: string;
  end;

const
  BaseItemsAmount = 9;

const
  ItemBase: array [0..BaseItemsAmount - 1] of TItemBase = (
  (ID: 1;  Char: '('; Color: 10; MaxDurability: 30; Name: 'Short Sword'),
  (ID: 2;  Char: '/'; Color: 11; MaxDurability: 30; Name: 'Long Staff'),
  (ID: 3;  Char: '('; Color: 11; MaxDurability: 35; Name: 'Dark Axe'),
  (ID: 4;  Char: '/'; Color: 12; MaxDurability: 45; Name: 'Long Sword'),
  (ID: 5;  Char: '}'; Color: 13; MaxDurability: 10; Name: 'Short Bow'),
  (ID: 6;  Char: '\'; Color: 14; MaxDurability: 12; Name: 'Spear'),
  (ID: 7;  Char: '$'; Color: 14; MaxDurability:  0; Name: 'Gold'),
  (ID: 8;  Char: '`'; Color: 14; MaxDurability:  0; Name: 'Key'),
  (ID: 9;  Char: '"'; Color: 14; MaxDurability:  0; Name: 'Arrows')
  );

  procedure AddRandomItems(MapID, C: Integer);
  var
    I, D: Integer;
    FItem: Item;
  begin
    for I := 1 to C do
    begin
      FItem.ItemID := Math.RandomRange(0, BaseItemsAmount) + 1;
      FItem.MapID := MapID;
      FItem.X := Math.RandomRange(1, MapWidth - 1);
      FItem.Y := Math.RandomRange(1, MapHeight - 1);
      case FItem.ItemID of
        // Weapons
        7: // Gold
        begin
          FItem.Stack := 10;
          FItem.Amount := Math.RandomRange(0, 25) + 1;
        end;
        8: // Keys
        begin
          FItem.Stack := 5;
          FItem.Amount := Math.RandomRange(0, 5) + 1;
        end;
        9: // Arrows
        begin
          FItem.Stack := 50;
          FItem.Amount := Math.RandomRange(0, 100) + 1;
        end;
        else
        begin
          FItem.Stack := 1;
          FItem.Amount := 1;
        end;
      end;
      if (FItem.Stack = 1) then
      begin
        D := ItemBase[FItem.ItemID - 1].MaxDurability;
        FItem.Durability := Math.RandomRange(D div 5, D) + 1;
      end;
      Items_Dungeon_AppendItem(FItem);
    end;
  end;

  procedure RenderDungeonItems(MapID: Integer);
  var
    I, Index, Count: Integer;
    FItem: Item;
  begin
    Count := Items_Dungeon_GetMapCount(MapID);
    for I := Count - 1 downto 0 do
    begin
      FItem := Items_Dungeon_GetMapItem(MapID, I);
      Index := FItem.ItemID - 1;
      ConioEngineWriteChar(FItem.X + 1, FItem.Y + 1,
        ItemBase[Index].Char, ItemBase[Index].Color);
    end;
  end;

  procedure RenderItemInfo(X, Y, I: Integer; AItem: Item);
  var
    N: Integer;
    S: string;
  begin
    N := AItem.ItemID - 1;
    S := '';
    if (AItem.Stack > 1) then
      // Amount
      S := '(' + IntToStr(AItem.Amount) + ')'
      // Durability
      else
        S := '(' + IntToStr(AItem.Durability) + '/' + IntToStr(ItemBase[N].MaxDurability) + ')';
    ConioEngineWriteString(X, Y, '[' + Chr(I + 97) + ']', 15);
    ConioEngineWriteString(X + 4, Y, ItemBase[N].Name, ItemBase[N].Color);
    ConioEngineWriteString(X + Length(ItemBase[N].Name) + 5, Y, S, 8);
  end;

  procedure RenderTileInfo(MapID: Integer);
  var
    I, Count, X, Y: Integer;
    FItem: Item;
  begin
    if (Items_Dungeon_GetMapCount(MapID) = 0) then Exit;
    Count := Items_Dungeon_GetMapCountXY(MapID, Player.X, Player.Y);
    if (Count <= 0) then Exit;
    if (Count > 26) then Count := 26;

    ConioEngineWriteString(MapWidth + 2, 4, 'Items on tile (' + IntToStr(Items_Dungeon_GetMapCountXY(MapID, Player.X, Player.Y)) + '):', 15);

    X := 0;
    Y := 0;
    for I := 0 to Count - 1 do
    begin
      FItem := Items_Dungeon_GetMapItemXY(MapID, I, Player.X, Player.Y);
      RenderItemInfo(MapWidth + X + 2, Y + 5, I, FItem);
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
  AItem: Item;
  N: Integer;
begin
  Index := Index - 97;
  AItem := Items_Dungeon_GetMapItemXY(MapID, Index, Player.X, Player.Y);
  if (AItem.Stack > 1) and (AItem.Amount > 1) then
  begin
    GoToXY(50, 4);
    Write('Enter amount:');
    ReadLn(N);
    if (N > 0) and (N <= AItem.Amount) then
    begin
      AItem.Amount := AItem.Amount - N;
      if (AItem.Amount <= 0) then
      begin
        if (Items_Dungeon_DeleteMapItemXY(MapID, Index, Player.X, Player.Y, AItem) > 0)  then
          Items_Inventory_AppendItem(AItem);
        Exit;
      end;
      if (Items_Dungeon_SetMapItemXY(MapID, Index, Player.X, Player.Y, AItem) = 0) then Exit;
      AItem.Amount := N;
      Items_Inventory_AppendItem(AItem);
    end;
    Exit;
  end;
  if (Items_Dungeon_DeleteMapItemXY(MapID, Index, Player.X, Player.Y, AItem) > 0) then
    Items_Inventory_AppendItem(AItem);
end;

procedure Drop(MapID, Index: Integer);
var
  AItem: Item;
  N: Integer;

  procedure DeleteItem;
  begin
    if (Items_Inventory_DeleteItem(Index, AItem) > 0) then
    begin
      AItem.X := Player.X;
      AItem.Y := Player.Y;
      AItem.MapID := MapID;
      Items_Dungeon_AppendItem(AItem);
    end;
  end;

begin
  Index := Index - 97;
  AItem := Items_Inventory_GetItem(Index);
  if (AItem.Stack > 1) and (AItem.Amount > 1) then
  begin
    GoToXY(50, 4);
    Write('Enter amount:');
    ReadLn(N);
    if (N > 0) and (N <= AItem.Amount) then
    begin
      AItem.Amount := AItem.Amount - N;
      if (AItem.Amount <= 0) then
      begin
        DeleteItem;
        Exit;
      end;
      if (Items_Inventory_SetItem(Index, AItem) = 0) then Exit;
      AItem.X := Player.X;
      AItem.Y := Player.Y;
      AItem.MapID := MapID;
      AItem.Amount := N;
      Items_Dungeon_AppendItem(AItem);
    end;
    Exit;
  end else DeleteItem;
end;

procedure RenderInventoryItems();
var
  I, Count: Integer;
  FItem: Item;
begin
  Count := Items_Inventory_GetCount();
  for I := 0 to Count - 1 do
  begin
    FItem := Items_Inventory_GetItem(I);
    RenderItemInfo(7, I + 2, I, FItem);
  end;
  ConioEngineWriteString(33, 3, 'GOLD: ' + IntToStr(Items_Inventory_GetItemAmount(7)), 14);
end;

var
  I: Byte;
  Key: Char;

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

        RenderDungeonItems(CurrentMap);

        ConioEngineWriteChar(Player.X + 1, Player.Y + 1, '@', 12);
        ConioEngineWriteString(MapWidth + 8, 1,
          '[2,4,6,8] Move, [SPACE] Inventory, [Esc] Close', 15);
        ConioEngineWriteString(MapWidth + 2, 1, IntToStr(Player.X)
          + ':' + IntToStr(Player.Y), 15);
        ConioEngineWriteString(MapWidth + 2, 2, 'Items on cur. map: '
          + IntToStr(Items_Dungeon_GetMapCount(CurrentMap)) + ' [+,-] Select cur. map: '
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



