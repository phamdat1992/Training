program LongestSubSequence;
const
  max = 10000;
var
  a, L, T: array[0..max + 1] of Integer;
  n: Word;

procedure Enter;
var
  i: Word;
begin
  ReadLn(n);
  for i := 1 to n do Read(a[i]);
end;

procedure Optimize;
var
  i, j, jmax: Word;
begin
  a[0] := -32768;
  a[n + 1] := 32767;
  L[n + 1] := 1;
  for i := n downto 0 do
    begin
      jmax := n + 1;
      for j := i + 1 to n + 1 do
        if (a[j] > a[i]) and (L[j] > L[jmax]) then jmax := j;
      L[i] := L[jmax] + 1;
      T[i] := jmax;
    end;
  WriteLn(L[0] - 2);
  i := T[0];
  while i <> n + 1 do
    begin
      WriteLn('a[', i, '] = ', a[i]);
      i := T[i];
    end;
end;

begin
  Assign(Input, 'INCSEQ.INP'); Reset(Input);
  Assign(Output, 'INCSEQ.OUT'); Rewrite(Output);
  Enter;
  Optimize;
  Close(Input); Close(Output);
end.
