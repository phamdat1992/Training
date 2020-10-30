program Escape;
const
  InputFile  = 'ESCAPE.INP';
  OutputFile = 'ESCAPE.OUT';
  max = 100;
  dx: array[1..4] of Integer = (1, 0, 0, -1);
  dy: array[1..4] of Integer = (0, 1, -1, 0);
type
  TCell = record
    x, y: Integer;
  end;
  TQueue = array[1..(max + 2) * (max + 2)] of TCell;
var
  Map: array[0..max + 1, 0..max + 1] of Byte;
  Queue: TQueue;
  First, Last, Sx, Sy, m, n: Integer;

procedure Enter;
var
  f: Text;
  i, j: Integer;
  c: Char;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  FillChar(Map, SizeOf(Map), 5); {Chi can <> 0 ma thoi}
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, c);
          case c of
            'E': begin
                   Sx := i; Sy := j;
                   Map[i, j] := 0;
                 end;
            '.': Map[i, j] := 0;
            else Map[i, j] := 5;
          end;
        end;
      Readln(f);
    end;
  Close(f);
end;

procedure Push(r, c: Integer);
begin
  Inc(Last);
  with Queue[Last] do
    begin
      x := r; y := c;
    end;
end;

procedure Pop(var r, c: Integer);
begin
  with Queue[First] do
    begin
      r := x; c := y;
    end;
  Inc(First);
end;

procedure Init;
var
  i, j: Integer;

  procedure PushandMark(r, c: Integer);
  begin
    if Map[r, c] = 0 then
      begin
        Push(r, c);
        Map[r, c] := 6;
      end;
  end;

begin
  Last := 0;
  for i := 1 to m do {bien trai + bien phai}
    begin
      PushandMark(i, 1);
      PushandMark(i, n);
    end;
  for j := 2 to n - 1 do {bien tren + bien duoi}
    begin
      PushandMark(1, j);
      PushandMark(m, j);
    end;
  First := 1;
end;

procedure BreadthFirstSearch;
var
  x, y, newx, newy, d: Integer;
begin
  while First <= Last do
    begin
      Pop(x, y);
      for d := 1 to 4 do  {Xet 4 o lan can}
        begin
          newx := x + dx[d]; newy := y + dy[d];
          if Map[newx, newy] = 0 then
            begin
              Map[newx, newy] := d; {Ghi vet huong di}
              if (Newx = Sx) and (Newy = Sy) then Exit;
              Push(newx, newy);
            end;
        end;
    end;
end;

procedure Result;
var
  f: Text;
  d: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  if Map[Sx, Sy] = 0 then Writeln(f, 'NO')
  else
    begin
      Writeln(f, 'YES');
      repeat
        Writeln(f, Sx, ' ', Sy);
        d := Map[Sx, Sy];
        if d = 6 then Break;
        Sx := Sx - dx[d]; Sy := Sy - dy[d];
      until False;
    end;
  Close(f);
end;

begin
  Enter;
  Init;
  BreadthFirstSearch;
  Result;
end.

10 10
XXXXXXXXXX
XXXXXXXXXX
XX.....XXX
XX.XXX.XXX
XX.EXX...X
XXXXXX.X.X
.......X.X
XXXXXXXX.X
.........X
XXXXXXXXXX
