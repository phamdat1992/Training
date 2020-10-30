program RandomTest;
type
  T = set of Byte;
var
  f: Text;
  SX, SY: array[1..255] of T;
  id: array[1..255] of Integer;
  c: array[1..255] of Integer;
  i, j, n, m: Integer;

procedure CreateId;
var
  i, j: Integer;
  k: T;
begin
  for i := 1 to n do
    begin
      j := Random(n) + 1;
      k := SX[i]; SX[i] := SX[j]; SX[j] := k;
    end;
  for i := 1 to n do
    begin
      j := Random(n) + 1;
      k := Sy[i]; SY[i] := SY[j]; SY[j] := k;
    end;
end;

begin
  Randomize;
  Write('n, m = '); Readln(n, m);
  FillChar(c, SizeOf(c), 0);
  for i := 1 to n do
    begin
      repeat
        j := Random(m) + 1;
      until c[j] = 0;
      SX[i] := [j];
      c[j] := 1;
    end;
  SY := SX;
  for i := 1 to n do
    begin
      for j := 1 to m do
        if Random(300) = 0 then Include(SX[i], (j));
      for j := 1 to m do
        if Random(300) = 0 then Include(SY[i], (j));
    end;
  Createid;
  Assign(f, 'OLYMPIC.IN0'); Rewrite(f);
  Writeln(f, n, ' ', m);
  for i := 1 to n do
    begin
      for j := 1 to m do
        if j in SX[i] then Write(f, ' ', j);
      Writeln(f);
    end;
  for i := 1 to n do
    begin
      for j := 1 to m do
        if j in SY[i] then Write(f, ' ', j);
      Writeln(f);
    end;
  Close(f);
end.