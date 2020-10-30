{$M 65520 0 655360}
program LinkedKnights;
const
  InputFile  = 'KMOVE.INP';
  OutputFile = 'KMOVE.OUT';
  max = 100;
  dx: array[1..8] of Integer = (1, -1, 1, -1, 2, -2, 2, -2);
  dy: array[1..8] of Integer = (2, 2, -2, -2, 1, 1, -1, -1);

type
  TBoard = array[-1..max + 2, -1..max + 2] of Char;
  TCell = record
    x, y: Integer;
  end;
  TIntBoard = array[1..max, 1..max] of Byte;
var
  a, b: TBoard;
  Trace: TIntBoard;
  List: array[1..max] of TCell;
  first, last: Integer;
  RootS, RootF: TCell;
  n, k: Integer;
  fout: Text;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  FillChar(a, SizeOf(a), '#');
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    begin
      for j := 1 to n do Read(f, a[i, j]);
      Readln(f);
    end;
  Close(f);
  Assign(fout, OutputFile); Rewrite(fout);
end;

procedure FindShortestPath; {BFS}
var
  x, y, newx, newy, d: Integer;
  Q: array[1..max * max] of TCell;
begin
  b := a;
  first := 1; last := 0;
  for x := 1 to n do
    for y := 1 to n do
      if b[x, y] = '@' then
        begin
          Inc(last);
          Q[last].x := x; Q[last].y := y;
          b[x, y] := '#';
        end;
  repeat
    x := Q[first].x; y := Q[first].y; Inc(first);
    for d := 1 to 8 do
      begin
        newx := x + dx[d]; newy := y + dy[d];
        if b[newx, newy] <> '#' then
          begin
            Trace[newx, newy] := d;
            if b[newx, newy] = '$' then Break;
            Inc(last);
            Q[last].x := newx; Q[last].y := newy;
            b[newx, newy] := '#';
          end;
      end;
    if b[newx, newy] = '$' then Break;
  until False;
  RootS.x := newx; RootS.y := newy;
  repeat
    d := Trace[newx, newy];
    newx := newx - dx[d]; newy := newy - dy[d];
  until a[newx, newy] = '@';
  RootF.x := newx; RootF.y := newy;
end;

procedure CreateList;

  procedure DFS(x, y: Integer);
  var
    d, newx, newy: Integer;
  begin
    Inc(k);
    List[k].x := x; List[k].y := y;
    b[x, y] := '#';
    for d := 1 to 8 do
      begin
        newx := x + dx[d]; newy := y + dy[d];
        if b[newx, newy] = '$' then DFS(newx, newy);
      end;
  end;

begin
  k := 0;
  b := a;
  DFS(RootS.x, RootS.y);
end;

procedure MoveChain(knight, x1, y1, x2, y2: Integer);
var
  i: Integer;
begin
  for i := knight to k do
    if Abs(x1 - x2) * Abs(y1 - y2) = 2 then
      begin
        List[i].x := x2; List[i].y := y2;
        Write(fout, ' ', x1, ' ', y1, ' ', x2, ' ', y2, ' ');
        x2 := x1; y2 := y1;
        if i < k then
          begin
            x1 := List[i + 1].x; y1 := List[i + 1].y;
          end;
      end
    else Break;
  Writeln(fout);
end;

procedure MoveToRootF;
var
  x1, y1, x2, y2, d: Integer;
begin
  x1 := RootS.x; y1 := RootS.y;
  repeat
    d := Trace[x1, y1];
    x2 := x1 - dx[d]; y2 := y1 - dy[d];
    MoveChain(1, x1, y1, x2, y2);
    x1 := x2; y1 := y2;
  until a[x1, y1] = '@';
end;

procedure Punch;
var
  knight: Integer;

  procedure DFS(x, y: Integer);
  var
    newx, newy, d: Integer;
  begin
    b[x, y] := '#';
    for d := 1 to 8 do
      begin
        newx := x + dx[d]; newy := y + dy[d];
        if b[newx, newy] = '@' then
          begin
            MoveChain(knight, x, y, newx, newy);
            DFS(newx, newy);
            Inc(knight);
          end;
      end;
  end;

begin
  knight := 1;
  b := a;
  DFS(RootF.x, RootF.y);
end;

begin
  Enter;
  FindShortestPath;
  CreateList;
  MoveToRootF;
  Punch;
  Close(fout);
end.

7
######
$##@##
##$###
$###@#
######
###@##
######