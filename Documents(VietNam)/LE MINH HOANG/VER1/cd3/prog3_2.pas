program The_Bag;
const
  max = 100;
var
  W, V: Array[1..max] of Integer;
  F: array[0..max, 0..max] of Integer;
  n, M: Integer;

procedure Enter;
var
  i: Integer;
begin
  Readln(n, M);
  for i := 1 to n do Readln(W[i], V[i]);
end;

procedure Optimize;
var
  i, j: Integer;
begin
  FillChar(F[0], SizeOf(F[0]), 0);
  for i := 1 to n do
    for j := 0 to M do
      begin
        F[i, j] := F[i - 1, j];
        if (j >= W[i]) and
              (F[i, j] < F[i - 1, j - W[i]] + V[i]) then
                      F[i, j] := F[i - 1, j - W[i]] + V[i];
      end;
end;

procedure Trace;
begin
  Writeln(F[n, M]);
  while n <> 0 do
    begin
      if F[n, M] <> F[n - 1, M] then
        begin
          Write(n, ' ');
          M := M - W[n];
        end;
      Dec(n);
    end;
end;

begin
  Assign(Input, 'BAG.INP'); Reset(Input);
  Assign(Output, 'BAG.OUT'); Rewrite(Output);
  Enter;
  Optimize;
  Trace;
  Close(Input); Close(Output);
end.
5 11
3 3
4 4
5 4
9 10
4 4
