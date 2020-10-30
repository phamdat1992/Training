program CellsGame;
uses Crt, Cells;
const
  InputFile  = 'CELLS.INP';
  Player1    = 'PLAYER1.DAT';
  Player2    = 'PLAYER2.DAT';
  max = 100;
  Neg: array[1..4] of Integer = (2, 1, 4, 3);
  dx: array[1..4] of Integer = (0, 0, -1, 1);
  dy: array[1..4] of Integer = (1, -1, 0, 0);
  cx1: array[1..4] of Integer = (-1, -1, -1, 0);
  cy1: array[1..4] of Integer = (0, -1, -1, -1);
  cx2: array[1..4] of Integer = (0, 0, -1, 0);
  cy2: array[1..4] of Integer = (0, -1, 0, 0);

type
{  TEdge = (Top, Bottom, Left, Right);}
  TMap = array[0..max + 1, 0..max + 1, 1..4] of Boolean;
  TDeg = array[0..max + 1, 0..max + 1] of Integer;
var
  Map: TMap;
  Deg: TDeg;
  m, n, nCell: Integer;
  Map2: array[1..max, 1..max] of Integer;
  ComponentCount: Integer;
  CountOf: array[1..max * max] of Integer;
  Qx, Qy: array[1..max * max] of Integer;
  First, Last: Integer;

function AddSeg(x1, y1, x2, y2: Integer): Boolean;
const
  Top = 1;
  Bottom = 2;
  Left = 3;
  Right = 4;
var
  mx, my: Integer;
begin
  if y1 = y2 then
    begin
      if x1 < x2 then mx := x2 else mx := x1;
      my := y1 + 1;
      AddSeg := not Map[mx, my][Bottom];
      Map[mx, my][Bottom] := True;
      Inc(Deg[mx, my]);
      Map[mx, my - 1][Top] := True;
      Inc(Deg[mx, my - 1]);
    end
  else
    begin
      mx := x1 + 1;
      if y1 < y2 then my := y2 else my := y1;
      AddSeg := not Map[mx, my][Left];
      Map[mx, my][Left] := True;
      Inc(Deg[mx, my]);
      Map[mx - 1, my][Right] := True;
      Inc(Deg[mx - 1, my]);
    end;
end;

procedure ReadInputFile;
var
  f: Text;
  x, y, x1, y1, x2, y2, mx, my: Integer;
begin
  FillChar(Map, SizeOf(Map), False);
  FillChar(Deg, SizeOf(Deg), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  while not SeekEof(f) do
    begin
      Readln(f, x1, y1, x2, y2);
      AddSeg(x1, y1, x2, y2);
    end;
  Close(f);
end;

procedure ImportFrom(FileName: String);
var
  f: Text;
  x1, y1, x2, y2: Integer;

  procedure Check(x1, y1, x2, y2: Integer);
  var
    Err: Boolean;
  begin
    Err :=  (x1 < 0) or (x1 > m) or
            (x2 < 0) or (x2 > m) or
            (y1 < 0) or (y1 > n) or
            (y2 < 0) or (y2 > n);
    Err := Err or (Abs(x1 - x2) + Abs(y1 - y2) <> 1);
    Err := Err or not AddSeg(x1, y1, x2, y2);
    if Err then
      begin
        Writeln('Error Segment: ');
        Writeln('  (', x1, ', ', y1, ')ÄÄ(', x2, ', ', y2, ')');
        Halt;
      end;
  end;

begin
  Assign(f, FileName); Reset(f);
  while not SeekEof(f) do
    begin
      Readln(f, x1, y1, x2, y2);
      Check(x1, y1, x2, y2);
    end;
  Close(f);
end;

procedure Push(x, y: Integer);
begin
  Inc(Last);
  Qx[Last] := x; Qy[Last] := y;
end;

procedure Pop(var x, y: Integer);
begin
  x := Qx[first]; y := Qy[first];
  Inc(first);
end;

procedure CreateMap2(var resx, resy: Integer);
var
  x, y: Integer;
  t, min: Integer;

  function BFSFrom(x, y: Integer): Integer;
  var
    d, ax, ay: Integer;
  begin
    first := 1; last := 1;
    Qx[1] := x; Qy[1] := y;
    Map2[x, y] := ComponentCount;
    while first <= last do
      begin
        Pop(x, y);
        for d := 1 to 4 do
          if not Map[x, y, d] then
            begin
              ax := x + dx[d]; ay := y + dy[d];
              if (ax >= 1) and (ax <= m) and (ay >= 1) and (ay <= n) and
                 (Map2[ax, ay] = 0) and (Deg[ax, ay] = 2) then
                begin
                  Map2[ax, ay] := ComponentCount;
                  Push(ax, ay);
                end;
            end;
      end;
    BFSFrom := last;
  end;

begin
  FillChar(Map2, SizeOf(Map2), 0);
  ComponentCount := 0;
  FillChar(CountOf, SizeOf(CountOf), 0);
  Min := max * max;
  resx := 0; resy := 0;
  for x := 1 to m do
    for y := 1 to n do
      if (Map2[x, y] = 0) and (Deg[x, y] = 2) then
        begin
          Inc(ComponentCount);
          t := BFSFrom(x, y);
          if min > t then
            begin
              min := t;
              resx := x; resy := y;
            end;
        end;
end;

procedure Thirty_Six_Stratagem(FileName: string);
label Done;
var
  x, y, ax, ay, d: Integer;
  f: Text;

  function FindEdge(x, y: Integer): Integer;
  var
    d: Integer;
  begin
    for d := 1 to 4 do
      if not Map[x, y][d] then
        begin
          FindEdge := d;
          Exit;
        end;
    FindEdge := 0;
  end;

begin
  Assign(f, FileName); Rewrite(f);
{First Stratagem: eat everything I can}
  First := 1; Last := 0;
  for x := 1 to m do
    for y := 1 to n do
      if Deg[x, y] = 3 then
        Push(x, y);
  while First <= Last do
    begin
      Pop(x, y);
      if Deg[x, y] = 3 then
        begin
          d := FindEdge(x, y);
          ax := x + dx[d]; ay := y + dy[d];
          Map[x, y][d] := True;
          Map[ax, ay][Neg[d]] := True;
          Inc(Deg[x, y]);
          Inc(Deg[ax, ay]);
          Writeln(f, x + cx1[d], ' ', y + cy1[d], ' ',
                     x + cx2[d], ' ', y + cy2[d]);
          if Deg[ax, ay] = 3 then Push(ax, ay);
        end;
    end;
{Second Stratagem: whatever I can't eat => you can't}
  for x := 1 to m do
    for y := 1 to n do
      if deg[x, y] < 2 then
        for d := 1 to 4 do
          if not Map[x, y, d] then
            begin
              ax := x + dx[d]; ay := y + dy[d];
              if deg[ax, ay] < 2 then
                begin
                  Map[x, y][d] := True;
                  Map[ax, ay][Neg[d]] := True;
                  Inc(Deg[x, y]);
                  Inc(Deg[ax, ay]);
                  Writeln(f, x + cx1[d], ' ', y + cy1[d], ' ',
                             x + cx2[d], ' ', y + cy2[d]);
                  goto Done;
                end;
            end;
{Third Stratagem: wait for your mistake}
  CreateMap2(x, y);
  if (x <> 0) then
    begin
      d := FindEdge(x, y);
      ax := x + dx[d]; ay := y + dy[d];
      Map[x, y][d] := True;
      Map[ax, ay][Neg[d]] := True;
      Inc(Deg[x, y]);
      Inc(Deg[ax, ay]);
      Writeln(f, x + cx1[d], ' ', y + cy1[d], ' ',
                 x + cx2[d], ' ', y + cy2[d]);

    end;
Done:
  Close(f);
end;


begin
  ReadInputFile;
  repeat
    Thirty_Six_Stratagem('PLAYER1.DAT');
    InterChange;
    Importfrom('PLAYER2.DAT');
  until False;
end.
