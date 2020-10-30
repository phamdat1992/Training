program Randomtest;
type
  T = array[1..10000] of LongInt;
  TI = array[1..10000] of Integer;
var
  f: Text;
  x, y, id: ^TI;
  d: T;
  Mark: array[1..10000] of Boolean;
  i, n, c, m, j, k: Integer;
  a: Real;

function Check(i: Integer): Boolean;
var
  j : Integer;
begin
  for j := i - 1 downto 1 do
    begin
      if (x^[j] = x^[i]) and (y^[j] = y^[i]) then
        begin
          Check := False; Exit;
        end;
      if d[i] <> d[j] then Break;
    end;
  Check := True;
end;

begin
  Randomize;
  Write('n = '); Readln(n);
  c := 1;
  Mark[1] := True;
  m := n + Random(n div 2);
  Mark[1] := True;
  for i := 2 to m do
    begin
      Mark[i] := not Odd(i);
      if Mark[i] then Inc(c) else Dec(c);
    end;
  for i := m + 1 to 2 * n do
    begin
      Mark[i] := c < 0;
      if Mark[i] then Inc(c) else Dec(c);
    end;
  for j := 1 to 2 * n do d[j] := j;
  for j := 10 to 2 * n do
   if Random(100) = 1 then d[j - 1] := d[j];
  New(x); New(y);
  for j := 1 to 2 * n do
    begin
      repeat
        a := Random * 2 * Pi;
        x^[j] := Round(d[j] * cos(a));
        y^[j] := Round(d[j] * sin(a));
      until Check(j);
    end;
  New(id);
  for i := 1 to 2 * n do id^[i] := i;
  for i := 1 to 2 * n do
    begin
      j := Random(2 * n) + 1;
      k := id^[i]; id^[i] := id^[j]; id^[j] := k;
    end;
  Assign(f, 'CIRCLE.IN0'); Rewrite(f);
  Writeln(f, n);
  for j := 1 to 2 * n do
    if Mark[id^[j]] then Writeln(f, x^[id^[j]], ' ', y^[id^[j]]);
  for j := 1 to 2 * n do
    if not Mark[id^[j]] then Writeln(f, x^[id^[j]], ' ', y^[id^[j]]);
  Close(f);
end.