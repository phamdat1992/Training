program LongestSubSequence;
const
  InputFile  = 'INCSEQ.INP';
  OutputFile = 'INCSEQ.OUT';
  max = 5000;
var
  a, L, T: array[0..max + 1] of Integer;
  n: Word;

procedure Enter;		
var
  i: Word;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n);
  for i := 1 to n do Read(f, a[i]);
  Close(f);
end;

procedure Optimize;	
var
  i, j, jmax: Word;
begin
  a[0] := -32768; a[n + 1] := 32767;	
  L[n + 1] := 1;		
  for i := n downto 0 do		
    begin
      
      jmax := n + 1;
      for j := i + 1 to n + 1 do
        if (a[j] > a[i]) and (L[j] > L[jmax]) then jmax := j;
      L[i] := L[jmax] + 1;		
      T[i] := jmax;				
    end;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  WriteLn(f, L[0] - 2);
  i := T[0];
  while i <> n + 1 do
    begin
      WriteLn(f, 'a[', i, '] = ', a[i]);
      i := T[i];
    end;
  Close(f);
end;

begin
  Enter;
  Optimize;
  Result;
end.
11
1 2 3 8 9 4 5 6 20 9 10