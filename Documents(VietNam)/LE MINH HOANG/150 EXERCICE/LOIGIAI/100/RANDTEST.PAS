program RandomTest;
var
  Index: array[1..5000] of Integer;
  i, n: Integer;
  f: Text;

procedure CreateIndex;
var
  i, j: Integer;
begin
  FillChar(Index, SizeOf(Index), 0);
  for i := 1 to n do
    begin
      repeat
        j := Random(n) + 1;
      until Index[j] = 0;
      Index[j] := i;
    end;
end;

begin
  Randomize;
  Write('n = '); Readln(n);
  Assign(f, 'WIRES.IN0'); Rewrite(f);
  Writeln(f, n);
  CreateIndex;
  for i := 1 to n do Write(f, Index[i], ' ');
  Writeln(f);
  CreateIndex;
  for i := 1 to n do Write(f, Index[i], ' ');
  Writeln(f);
  Close(f);
end.
