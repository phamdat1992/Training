program RandomTest;
const
  name = 'KMOVE.IN0';
  n = 100;
  k = 100;
  xs = 1; ys = 100;
  xf = 100; yf = 1;
  xt = 40; yt = 60;
  dx: array[1..8] of Integer = (1, -1, 1, -1, 2, -2, 2, -2);
  dy: array[1..8] of Integer = (2, 2, -2, -2, 1, 1, -1, -1);
var
  a: array[1..100, 1..100] of Char;

procedure Create(c: Char);
var
  d, count, x, y: Integer;
begin
  count := 1;
  repeat
    x := Random(n) + 1; y := Random(n) + 1;
    if a[x, y] <> c then Continue;
    d := Random(8) + 1;
    x := x + dx[d]; y := y + dy[d];
    if (x >= 1) and (x <= n) and (y >= 1) and (y <= n) and (a[x, y] = '#')
      then
        begin
          a[x, y] := c;
          Inc(count);
        end;
  until count = k;
end;

procedure CreatePath;
var
  d, x, y: Integer;
  f1, f2: Boolean;
begin
  f1 := False; f2 := False;
  repeat
    x := Random(n) + 1; y := Random(n) + 1;
    if a[x, y] <> '.' then Continue;
    d := Random(8) + 1;
    x := x + dx[d]; y := y + dy[d];
    if (x >= 1) and (x <= n) and (y >= 1) and (y <= n) then
      begin
        if a[x, y] = '#' then a[x, y] := '.';
        f1 := f1 or (a[x, y] = '$');
        f2 := f2 or (a[x, y] = '@');
      end;
  until f1 and f2;
  for x := 1 to n do
    for y := 1 to n do
      if (a[x, y] = '#') and (Random(10) = 1) then a[x, y] := '.';
end;

procedure WriteFile;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, name); Rewrite(f);
  Writeln(f, n);
  for i := 1 to n do
    begin
      for j := 1 to n do Write(f, a[i, j]);
      Writeln(f);
    end;
  Close(f);
end;

begin
  Randomize;
  FillChar(a, SizeOf(a), '#');
  a[xs, ys] := '$'; a[xf, yf] := '@'; a[xt, yt] := '.';
  Create('$');
  Create('@');
  CreatePath;
  WriteFile;
end.