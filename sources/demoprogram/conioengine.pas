{**********************************
      Console Input\Output module
      v 1.0
***********************************}
unit ConioEngine;

interface

uses Video, Crt;

procedure UConioEngineInit;
procedure UConioEngineDone;
procedure UConioEngineRefresh;
procedure ConioEngineWriteChar(X,Y:integer; c:char; color:byte);
procedure ConioEngineWriteString(X,Y : integer;s : string;color: byte);
function GetScreenHeight:integer;
function GetScreenWidth:integer;

procedure ConioEngineClear;



implementation


//инициирует графику
procedure UConioEngineInit;
begin
  InitVideo;
  CursorOff;
end;

procedure ConioEngineClear;
begin
  FillByte(VideoBuf^, GetScreenWidth*GetScreenHeight*2, 0);
end;

procedure UConioEngineDone;
begin
  DoneVideo;
end;

procedure ConioEngineWriteChar(X,Y:integer; c:char; color:byte);
var
   P:integer;
begin
  if (X < 1) or (X > ScreenWidth) or (Y < 1) or (Y > ScreenHeight) then exit;
  P:=((X-1)+(Y-1)*ScreenWidth);
  if VideoBuf^[P]<>Ord(c) + (color shl 8) then
      VideoBuf^[P]:=Ord(c) + (color shl 8) ;
end;

procedure UConioEngineRefresh;
begin
   UpdateScreen(true);
end;

function GetScreenHeight:integer;
begin
  GetScreenHeight:=SCREENHEIGHT;
end;

function GetScreenWidth:integer;
begin
  GetScreenWidth:=SCREENWIDTH;
end;

Procedure ConioEngineWriteString(X,Y : integer;s : string;color: byte);
Var
  W,P,I,M : Word;
begin
  P:=((X-1)+(Y-1)*ScreenWidth);
  M:=Length(S);
  If P+M>ScreenWidth*ScreenHeight then
    M:=ScreenWidth*ScreenHeight-P;
  For I:=1 to M do
    if VideoBuf^[P+I-1]<>Ord(S[i]) + (color shl 8) then
        VideoBuf^[P+I-1]:=Ord(S[i]) + (color shl 8);
end;


end.
