{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program TriangleAnalyses;
const
  InputFile  = 'POLYGON.INP';
  OutputFile = 'POLYGON.OUT';
  max = 50;
type
  Real = Double;
  TBoard = array[1..max, 1..max] of Real;
var
  n: Integer;
  d, b: TBoard;
  Trace: array[1..max, 1..max] of Integer;
  f: Text;

procedure Enter;
var
  f: Text;
  X, Y: Array[1..max] of Real;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Readln(f, X[i], Y[i]);
  for i := 1 to n do
    for j := 1 to n do
      begin
        d[i, j] := Sqrt(Sqr(X[i] - X[j]) + Sqr(Y[i] - Y[j]));
      end;
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  for i := 1 to n - 2 do
    for j := i to i + 2 do b[i, j] := 0;
end;

procedure GetCut(i, j: Integer);
var
  t: Integer;
begin
  b[i, j] := b[i, j - 1] + d[i, j - 1];
  Trace[i, j] := j;

  if b[i, j] > b[i + 1, j] + d[i + 1, j] then
    begin
      b[i, j] := b[i + 1, j] + d[i + 1, j];
      Trace[i, j] := i;
    end;

  for t := i + 2 to j - 2 do
    if b[i, j] > b[i, t] + b[t, j] + d[i, t] + d[t, j] then
      begin
        b[i, j] := b[i, t] + b[t, j] + d[i, t] + d[t, j];
        Trace[i, j] := t;
      end;
end;

procedure Optimize;
var
  i, j, k: Integer;
begin
  for k := 3 to n do
    for i := 1 to n - k do
      begin
        j := i + k;
        GetCut(i, j);
      end;
end;

procedure TraceFrom(i, j: Integer);
begin
  if i + 2 >= j then Exit;
  if Trace[i, j] = j then
    begin
      Writeln(f, i, ' ', j - 1);
      TraceFrom(i, j - 1);
    end
  else
    if Trace[i, j] = i then
      begin
        Writeln(f, i + 1, ' ', j);
        TraceFrom(i + 1, j);
      end
    else
      begin
        Writeln(f, i, ' ', Trace[i, j]);
        TraceFrom(i, Trace[i, j]);
        Writeln(f, Trace[i, j], ' ', j);
        TraceFrom(Trace[i, j], j);
      end;
end;

procedure Result;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, b[1, n]:1:6);
  TraceFrom(1, n);
  Close(f);
end;

begin
  Enter;
  Init;
  Optimize;
  Result;
end.

