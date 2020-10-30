program LongestSubSequence;
const
  InputFile  = 'INCSEQ.INP';
  OutputFile = 'INCSEQ.OUT';
const
  max = 5000;
var
  a, L, T, StartOf: array[0..max + 1] of Integer;
  n, m: Integer;

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

procedure Init;
begin
  a[0] := -32768;
  a[n + 1] := 32767;
  m := 1;
  L[n + 1] := 1;
  StartOf[1] := n + 1;
end;

function Find(i: Integer): Integer;
var
  inf, sup, median, j: Integer;
begin
  inf := 1; sup := m + 1;
  repeat
    median := (inf + sup) div 2;
    j := StartOf[median];
    if a[j] > a[i] then inf := median
    else sup := median;
  until inf + 1 = sup;
  Find := StartOf[inf];
end;

procedure Optimize;
var
  i, j, k: Integer;
begin
  for i := n downto 0 do
    begin
      j := Find(i);
      k := L[j] + 1;
      if k > m then
        begin
          m := k;
          StartOf[k] := i;
        end
      else
        if a[StartOf[k]] < a[i] then
          StartOf[k] := i;
      L[i] := k;
      T[i] := j;
    end;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, m - 2);
  i := T[0];
  while i <> n + 1 do
    begin
      Writeln(f, 'a[', i, '] = ', a[i]);
      i := T[i];
    end;
  Close(f);
end;

begin
  Enter;
  Init;
  Optimize;
  Result;
end.
11
1 2 3 8 9 4 5 6 20 9 10