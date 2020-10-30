const
  n = 100;
var
  a: array[1..100, 1..200] of Char;

procedure Border(s, f: Integer);
var
  i: Integer;
begin
  for i := s to f do
    begin
      a[i, s] := '.';
      a[i, f] := '.';
      a[s, i] := '.';
      a[f, i] := '.';
    end;
  a[s + 1, s] := 'X';
  a[s + 2, s + 1] := '.';
  a[s + 2, s + 2] := '.';
end;

procedure Generate;
var
  s, f: Integer;
begin
  s := 2; f := n - 1;
  while s <= f do
    begin
      Border(s, f);
      Inc(s, 2); Dec(f, 2);
    end;
end;

procedure Save;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, 'ESCAPE.IN0'); Rewrite(f);
  Writeln(f, n, ' ', n);
  for i := 1 to n do
    begin
      for j := 1 to n do Write(f, a[i, j]);
      Writeln(f);
    end;
  Close(f);
end;

begin
  FillChar(a, SizeOf(a), 'X');
  Generate;
  Save
end.
