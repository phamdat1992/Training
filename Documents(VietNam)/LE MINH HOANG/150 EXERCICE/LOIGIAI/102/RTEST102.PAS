program RandomTest;
const
  dx: array[1..4] of Integer = (0, 1, -1, 0);
  dy: array[1..4] of Integer = (1, 0, 0, -1);
var
  f: Text;
  m, n, sx, sy, x, y: Integer;
  stepcount: LongInt;
  a: array[1..100, 1..100] of Char;

procedure Enter;
begin
  Randomize;
  Write('m, n, sx, sy, stepcount = '); Readln(m, n, sx, sy, stepcount);
  FillChar(a, SizeOf(a), 'X');
  a[sx, sy] := '.';
end;

function Inside(x, y: Integer): Boolean;
begin
  Inside := (x > 1) and (x < m) and (y > 1) and (y < n);
end;

{function GetDeg(x, y: Integer): Integer;
var
  c, d: Integer;
begin
  c := 0;
  for d := 1 to 4 do
    if Inside(x + dx[d], y + dy[d]) and (a[x + dx[d], y + dy[d]] = '.')
       then Inc(c);
  GetDeg := c;
end;}

function GetDeg(x, y: Integer): Integer;
var
  c, i, j: Integer;
begin
  c := 0;
  for i := -3 to 3 do
    for j := -3 to 3 do
      if Inside(x + i, y + j) and (a[x + i, y + j] = '.')
        then Inc(c);
  GetDeg := c;
end;

procedure Generate;
var
  d, newx, newy: Integer;
  step: LongInt;
begin
  x := sx; y := sy;
  for step := 1 to stepcount do
    begin
      repeat
        d := Random(4) + 1;
        newx := x + dx[d]; newy := y + dy[d];
      until Inside(newx, newy) and
            ((a[newx, newy] = '.') or (GetDeg(newx, newy) <= 7));
      a[newx, newy] := '.';
      x := newx; y := newy;
    end;
end;

procedure Save;
var
  f: Text;
  i, j: Integer;
begin
  a[sx, sy] := 'E';
  Assign(f, 'ESCAPE.IN9'); Rewrite(f);
  Writeln(f, m, ' ', n);
  for i := 1 to m do
    begin
      for j := 1 to n do Write(f, a[i, j]);
      Writeln(f);
    end;

  Close(f);
end;

begin
  Enter;
  generate;
  Save;
end.
