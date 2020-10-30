program SubSequence;
const
  InputFile  = 'SUBSEQ.IN0';
  OutputFile = 'SUBSEQ.OU0';
  max = 1000;
  maxV = 10000;
type
  TLine = array[0..maxV] of Integer;
  PLine = ^TLine;
  TSet = set of 0..7;
  TLineTrace = array[0..maxV div 8] of TSet;
var
  a: array[1..max] of Integer;
  b: TLine;
  Save: array[0..10] of PLine;
  Trace: array[0..100] of ^TLineTrace;
  res, n, m: Integer;
  s: LongInt;
  fo: Text;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  s := 0;
  for i := 1 to n do
    begin
      Read(f, a[i]);
      s := s + a[i];
    end;
  Close(f);
end;

procedure AllocMem;
var
  i: Integer;
begin
  for i := 0 to 10 do New(Save[i]);
  for i := 0 to 100 do
    New(Trace[i]);
end;

procedure Optimize;
var
  i, v: Integer;
begin
  if (m < 0) or (m > s) then
    begin
      res := -1;
      Exit;
    end;
  for v := 1 to m do b[v] := max + 1;
  b[0] := 0;
  Save[0]^ := b;
  for i := 1 to n do
    begin
      for v := m downto a[i] do
        if b[v] > b[v - a[i]] + 1 then
          b[v] := b[v - a[i]] + 1;
      if i mod 100 = 0 then
        Save[i div 100]^ := b;
    end;
  if b[m] <> max + 1 then res := b[m]
  else res := -1;
end;

procedure OpenFile;
begin
  Assign(fo, OutputFile); Rewrite(fo);
  Writeln(fo, res);
end;

procedure SetTrace(i, V: Integer);
begin
  Include(Trace[i]^[V shr 3], (V and 7));
end;

function GetTrace(i, V: Integer): Boolean;
begin
  GetTrace := V and 7 in Trace[i]^[V shr 3];
end;

procedure OptimizeAndTracingBack(minN, maxN: Integer; var m: Integer);
var
  i, v: Integer;
begin
  for i := 0 to 100 do
    FillChar(Trace[i]^, SizeOf(Trace[i]^), 0);
  b := Save[minN div 100]^;
  for i := minN + 1 to maxN do
    for v := m downto a[i] do
      if b[v] > b[v - a[i]] + 1 then
        begin
          b[v] := b[v - a[i]] + 1;
          SetTrace(i - minN, V);
        end;
  for i := maxN downto minN + 1 do
    if GetTrace(i - minN, m) then
      begin
        Write(fo, i, ' ');
        m := m - a[i];
      end;
end;

procedure Solve;
var
  minN, maxN: Integer;
begin
  maxN := n;
  minN := 0;
  while minN + 100 < maxN do minN := minN + 100;
  repeat
    OptimizeandTracingBack(minN, maxN, m);
    maxN := minN;
    minN := minN - 100;
  until minN < 0;
end;

begin
  Enter;
  AllocMem;
  Optimize;
  OpenFile;
  if res <> -1 then Solve;
  Close(fo);
end.
