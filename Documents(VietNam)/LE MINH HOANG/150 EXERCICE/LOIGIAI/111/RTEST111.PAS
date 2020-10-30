var
  f: Text;
  b, a: array[1..101] of Integer;
  i, n, m, j: Integer;

procedure R(i: Integer);
begin
  Writeln(i);
  a[i] := a[i] - a[i + 1];
  Move(a[i + 2], a[i + 1], (n - i - 1) * SizeOf(a[1]));
  Dec(n);
end;

begin
  Randomize;
  Write('n = '); Readln(n);
  m := n;
  for i := 1 to n do a[i] := Random(100) + 1;
  b := a;
  for i := 1 to n - 1 do
    begin
      j := Random(n - 1) + 1;
      R(j);
    end;
  Assign(f, 'DAY.IN8'); Rewrite(f);
{  Writeln(f, m, ' ', a[1]);
  for i := 1 to m do Write(f, b[i], ' ');}
  Writeln(f, '100 -50');
  for i := 1 to m do Write(f, i, ' ');
  Close(f);
end.
