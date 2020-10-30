program SubSequence;
const
  InputFile  = 'SUBSEQ.INP';
  OutputFile = 'SUBSEQ.OUT';
  maxN = 1000;
  maxK = 50;
var
  a: array[1..maxN] of Integer;
  Count: array[0..maxK - 1] of Integer;
  f, Trace: array[0..maxK - 1, 0..maxK - 1] of Integer;
  n, k: Integer;

procedure Enter;
var
  fi: Text;
  i: Integer;
begin
  Assign(fi, InputFile); Reset(fi);
  Readln(fi, n, k);
  FillChar(Count, SizeOf(Count), 0);
  for i := 1 to n do
    begin
      Read(fi, a[i]);
      Inc(Count[a[i] mod k]);
    end;
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
  i, j, t: Integer;
begin
  FillChar(f, SizeOf(f), 0);
  f[0, 0] := Count[0];
  FillChar(Trace, SizeOf(Trace), $FF);
  Trace[0, 0] := Count[0];
  for i := 1 to k - 1 do
    for t := 0 to k - 1 do
      for j := 0 to Count[i] do
        if (Trace[i - 1, Sub(t, j * i)] <> -1) and
           (f[i, t] < f[i - 1, Sub(t, j * i)] + j) then
          begin
            f[i, t] := f[i - 1, Sub(t, j * i)] + j;
            Trace[i, t] := j;
          end;
end;

procedure Result;
var
  fo: Text;
  i, t, j: Integer;
  Sum: LongInt;
begin
  t := 0;
  for i := k - 1 downto 0 do
    begin
      j := Trace[i, t];
      t := Sub(t, j * i);
      Count[i] := j;
    end;
  Assign(fo, OutputFile); Rewrite(fo);
  Writeln(fo, f[k - 1, 0]);
  Sum := 0;
  for i := 1 to n do
    begin
      t := a[i] mod k;
      if Count[t] > 0 then
        begin
          Writeln(fo, 'a[', i, '] = ', a[i]);
          Dec(Count[t]);
          Sum := Sum + a[i];
        end;
    end;
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
