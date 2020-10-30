program randomtest;
var
 f: Text;
 n, i, j: Integer;
 a: array[1..101] of Byte;
 c: array[1..100, 1..100] of Real;

procedure EasyTest;
begin
 Assign(f, 'MONEY.INP'); Rewrite(f);
 Write('n = '); Readln(n);
 Writeln(f, n);
 for i := 1 to n do
  begin
   for j := 1 to n do
    if i <> j then Write(f, 1 - Random / 10 :4:2, ' ')
    else Write(f, '1 ');
   Writeln(f);
  end;
 Close(f);
end;

procedure NosolutionTest;
begin
 Assign(f, 'MONEY.INP'); Rewrite(f);
 Write('n = '); Readln(n);
 Writeln(f, n);
 for i := 1 to n do
  begin
   for j := 1 to n do
   Writeln(f);
  end;
 Close(f);
end;

procedure HardTest;
var
 i, j, k: Byte;
begin
 Write('n = '); Readln(n);
 for i := 1 to n do a[i] := i;
 for i := 1 to n do
  begin
   j := Random(n) + 1;
   k := a[i]; a[i] := a[j]; a[j] := k;
  end;
 a[n + 1] := a[1];
 Assign(f, 'MONEY.INP'); Rewrite(f);
 Writeln(f, n);
 for i := 1 to n do
  begin
   for j := 1 to n do
    if i <> j then c[i, j] := 1 - Random / 10 - 0.1
    else c[i, j] := 1;
  end;
 for i := 1 to n do c[a[i], a[i + 1]] := 1 + Random/10;
 for i := 1 to n do
  begin
   for j := 1 to n do Write(f, c[i, j]:6:2, ' ');
   Writeln(f);
  end;
 Close(f);
end;

begin
 Randomize;
 HardTest;
end.
