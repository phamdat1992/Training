program SubSequence;
const
  InputFile  = 'SUBSEQ.INP';
  OutputFile = 'SUBSEQ.OUT';
  maxN = 1000;
  maxK = 50;
var
  a: array[1..maxN] of Integer;
  f: array[0..maxN, 0..maxK - 1] of Byte;
  n, k: Integer;

procedure Enter;
var
  fi: Text;
  i: Integer;
begin
  Assign(fi, InputFile); Reset(fi);
  Readln(fi, n, k);
  for i := 1 to n do Read(fi, a[i]);
  Close(fi);
end;

function Sub(x, y: Integer): Integer;
var
  tmp: Integer;
begin
  tmp := (x - y) mod k;
  if tmp >= 0 then Sub := tmp
  else Sub := tmp + k;
end;

procedure Optimize;
var
  i, t: Integer;
begin
  FillChar(f[0], SizeOf(f[0]), $FF);
  f[0, 0] := 0;
  for i := 1 to n do
    for t := 0 to k - 1 do
      if f[i - 1, t] < f[i - 1, Sub(t, a[i])] + 1 then
        f[i, t] := f[i - 1, t]
      else
        f[i, t] := f[i - 1, Sub(t, a[i])] + 1;
end;

procedure Result;
var
  fo: Text;
  i, t: Integer;
  SumAll, Sum: LongInt;
begin
  SumAll := 0;
  for i := 1 to n do SumAll := SumAll + a[i];
  Assign(fo, OutputFile); Rewrite(fo);
  Writeln(fo, n - f[n, SumAll mod k]);
  i := n; t := SumAll mod k;
  Sum := 0;
  for i := n downto 1 do
    if f[i, t] = f[i - 1, t] then
      begin
        Writeln(fo, 'a[', i, '] = ', a[i]);
        Sum := Sum + a[i];
      end
    else
      t := Sub(t, a[i]);
  Writeln(fo, 'Sum = ', Sum);
  Close(fo);
end;

begin
  Enter;
  Optimize;
  Result;
end.
10 5
1 6 11 5 10 15 20 2 4 9