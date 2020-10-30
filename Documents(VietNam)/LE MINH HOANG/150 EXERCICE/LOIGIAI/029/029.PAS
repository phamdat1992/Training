program Paint;
const
  max = 100;
var
  A: array[0..max + 1, 0..max + 1] of LongInt;
  m, n, i, j: Byte;
  S: LongInt;
  f: Text;
begin
  Assign(f, 'PAINT.INP'); Reset(f);
  FillChar(A, SizeOf(A), 0);
  Readln(f, m, n);
  for i := 1 to m do
    for j := 1 to n do Read(f, A[i, j]);
  Close(f);
  S := 0;
  for i := 0 to m do
    for j := 0 to n do
      begin
        S := S + Abs(A[i, j] - A[i, j + 1]) + Abs (A[i, j] - A[i + 1, j]);
        if A[i, j] <> 0 then Inc(S);
      end;
  Assign(f, 'PAINT.OUT'); Rewrite(f);
  Writeln(f, S);
  Close(f);
end.

2 3
4 3 4
1 2 1
