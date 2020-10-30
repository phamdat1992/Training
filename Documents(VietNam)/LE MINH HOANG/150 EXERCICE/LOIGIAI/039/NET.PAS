program Net;
const
 InputFile  = 'NET.INP';
 OutputFile = 'NET.OUT';
 maxReal = 1E38;
 maxV = 1000;
 maxE = 10000;
var
 X, Y: array[1..maxV] of Real;
 p, q: array[1..maxE] of Word;
 d: array[1..maxV] of Real;
 Trace: array[1..maxV] of Word;
 Free: array[1..maxV] of Boolean;
 n, m, PermanentV: Word;

procedure Enter;
var
 f: Text;
 i: Word;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n, m);
 for i := 1 to n do Readln(f, x[i], y[i]);
 for i := 1 to m do Readln(f, p[i], q[i]);
 Close(f);
end;

procedure Init;
var
 i: Word;
begin
 FillChar(Free, n, True);
 d[1] := 0;
 for i := 2 to n do d[i] := MaxReal;
end;

procedure FixLabel;
var
 v: Word;
 Min: Real;
begin
 Min := MaxReal;
 PermanentV := 0;
 for v := 1 to n do
  if Free[v] and (d[v] < Min) then
   begin
    Min := d[v];
    PermanentV := v;
   end;
 if PermanentV <> 0 then Free[PermanentV] := False;
end;

function Distance(u, v: Word): Real;
var
 i: Word;
begin
 for i := 1 to m do
  if (p[i] = u) and (q[i] = v) or (p[i] = v) and (q[i] = u) then
   begin
    Distance := 0;
    Exit;
   end;
 Distance := Sqrt(Sqr(X[u] - X[v]) + Sqr(Y[u] - Y[v]));
end;

procedure ChangeLabel;
var
 v: Word;
 t: Real;
begin
 for v := 1 to n do
  if Free[v] then
   begin
    t := Distance(PermanentV, v);
    if d[v] > t then
     begin
      d[v] := t;
      Trace[v] := PermanentV;
     end;
   end;
end;

procedure FindMinimalSpanningTree;
begin
 Init;
 repeat
  FixLabel;
  if PermanentV = 0 then Break;
  ChangeLabel;
 until False;
end;

procedure Result;
var
 v, K: Word;
 L: Real;
 f: Text;
begin
 K := 0; L := 0;
 for v := 1 to n do
  if d[v] <> 0 then
   begin
    Inc(K); L := L + d[v];
   end;
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, K, ' ', L:1:6);
 for v := 2 to n do
  if d[v] <> 0 then Writeln(f, Trace[v], ' ', v);
 Close(f);
end;

begin
 Enter;
 FindMinimalSpanningTree;
 Result;
end.
9 5
100.0 100.0
200.0 100.0
400.0 100.0
100.0 200.0
200.0 200.0
400.0 200.0
100.0 300.0
200.0 300.0
400.0 300.0
1 4
2 3
4 7
5 8
6 9
