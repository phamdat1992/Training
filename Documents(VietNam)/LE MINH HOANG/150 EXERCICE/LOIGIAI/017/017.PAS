program Board;
const
  InputFile  = 'BOARD.INP';
  OutputFile = 'BOARD.OUT';
  MapFile    = 'BOARD.MAP';
  max = 80;
  dx: array[1..8] of ShortInt = (1, -1, 1, -1, 2, -2, 2, -2);
  dy: array[1..8] of ShortInt = (2, 2, -2, -2, 1, 1, -1, -1);
type
  TBoard = array[1..max, 1..max] of Integer;
  PBoard = ^TBoard;
  TPos = record
    x, y: ShortInt;
  end;
  TListPos = array[1..max * max] of TPos;
  PListPos = ^TListPos;
var
  a, trace: PBoard;
  along: TBoard;
  List: PListPos;
  Position: TListPos;
  total, m, n: Integer;
  fout: Text;

procedure InitMem;
begin
  new(a); new(trace); new(List);
end;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, a^[i, j]);
          Inc(a^[i, j]);
          with Position[a^[i, j]] do
            begin
              x := i; y := j;
            end;
        end;
      Readln(f);
    end;
  Close(f);
  total := m * n + 1;
end;

procedure Numbering;
var
  first, last, x, y, newx, newy, d: Integer;
begin
  FillChar(List^, sizeOf(List^), 0);
  List^[1].x := m div 2; List^[1].y := n div 2;
  a^[m div 2, n div 2] := a^[m div 2, n div 2] + total;
  Trace^[m div 2, n div 2] := 0;
  first := 1; last := 1;
  repeat
    x := List^[first].x; y := List^[first].y;
    Inc(first);
    for d := 1 to 8 do
      begin
        newx := x + dx[d]; newy := y + dy[d];
        if (1 <= newx) and (newx <= m)
           and (1 <= newy) and (newy <= n) and (a^[newx, newy] < total) then
             begin
               a^[newx, newy] := a^[newx, newy] + total;
               Trace^[newx, newy] := x shl 8 + y;
               Inc(last);
               List^[last].x := newx; List^[last].y := newy;
             end;
      end;
  until first > last;
  for x := 1 to m do
    for y := 1 to n do
      a^[x, y] := a^[x, y] - total;
end;

procedure OpenFile;
begin
  Assign(fout, OutputFile); Rewrite(fout);
end;

procedure CloseFile;
begin
  Close(fout);
end;

procedure InterChange(x1, y1, x2, y2: Integer);
var
  t: Integer;
begin
  Writeln(fout, x1 - 1, ' ', y1 - 1, ' ', x2 - 1, ' ', y2 - 1);
  t := a^[x1, y1]; a^[x1, y1] := a^[x2, y2]; a^[x2, y2] := t;
  with Position[a^[x1, y1]] do
    begin
      x := x1; y := y1;
    end;
  with Position[a^[x2, y2]] do
    begin
      x := x2; y := y2;
    end;
end;

procedure NumberGoto(x1, y1, x2, y2: Integer);
var
  x, y, px, py, t: Integer;
begin
  if (x1 = x2) and (y1 = y2) then Exit;
  x := x1; y := y1;
  repeat
    t := Trace^[x, y];
    if t = 0 then Break;
    Along[x, y] := t;
    x := Hi(t); y := Lo(t);
  until False;
  x := x2; y := y2;
  repeat
    t := Trace^[x, y];
    if t = 0 then Break;
    px := Hi(t); py := Lo(t);
    Along[px, py] := x shl 8 + y;
    x := px; y := py;
  until False;
  x := x1; y := y1;
  repeat
    t := Along[x, y];
    px := Hi(t); py := Lo(t);
    InterChange(x, y, px, py);
    x := px; y := py;
  until (x = x2) and (y = y2);
end;

procedure AutoCorrect(x, y: Integer);
var
  code: Integer;
  oldx, oldy: Integer;
begin
  code := (x - 1) * n + y;
  oldx := Position[code].x;
  oldy := Position[code].y;
  NumberGoto(oldx, oldy, x, y);
end;

procedure Solve;
var
  i, x, y: Integer;
begin
  for i := m * n downto 1 do
    begin
      x := List^[i].x;
      y := List^[i].y;
      AutoCorrect(x, y);
    end;
end;

procedure SelTest;
var
  i, j, x1, y1, x2, y2, t: Integer;
  f: Text;
begin
  Enter;
  Reset(fout);
  while not SeekEof(fout) do
    begin
      Readln(fout, x1, y1, x2, y2);
      Inc(x1); Inc(x2); Inc(y1); Inc(y2);
      t := a^[x1, y1]; a^[x1, y1] := a^[x2, y2];
      a^[x2, y2] := t;
    end;
  Close(fout);
  Assign(f, MapFile); Rewrite(f);
  for i := 1 to m do
    begin
      for j := 1 to n do Write(f, a^[i, j] - 1:5);
      Writeln(f);
    end;
  Close(f);
end;

begin
  InitMem;
  Enter;
  Numbering;
  OpenFile;
  Solve;
  CloseFile;
{  SelTest;}
end.
