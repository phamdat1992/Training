program Thetour;
const
  InputFile  = 'TOUR.INP';
  OutputFile = 'TOUR.OUT';
  max = 100;
  maxLong = 1000000001;
type
  TDistance = array[1..max, 1..max] of LongInt;
  PDistance = ^TDistance;
var
  c: TDistance;
  d: PDistance;
  Trace: array[1..max] of Byte;
  n, Start, Finish: Integer;
  minCost: LongInt;

procedure Enter;
var
  i, m, x, y, t: LongInt;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for x := 1 to n do
    for y := 1 to n do
      if x = y then c[x, y] := 0
      else c[x, y] := maxLong;
  for i := 1 to m do
    begin
      Readln(f, x, y, t);
      if c[x, y] > t then
        begin
          c[x, y] := t;
          c[y, x] := t;
        end;
    end;
  Close(f);
end;

procedure Floyd;
var
  u, v, k: Integer;
begin
  New(d);
  d^ := c;
  for k := 1 to n do
    for u := 1 to n do
      for v := u + 1 to n do
        if d^[u, v] > d^[u, k] + d^[k, v] then
          begin
            d^[u, v] := d^[u, k] + d^[k, v];
            d^[v, u] := d^[u, v];
          end;
end;

function Dijkstra(S, T: Integer): LongInt;
var
  d: array[1..max] of LongInt;
  OpSet: array[1..max] of Byte;
  p, u, v, umin, nSet, tmp: Integer;
begin
  for u := 1 to n do d[u] := maxLong;
  d[S] := 0; OpSet[1] := S; nSet := 1;
  repeat
    umin := 1;
    for u := 1 to nSet do
      if d[OpSet[u]] < d[OpSet[umin]] then umin := u;
    p := OpSet[umin];
    if p = T then Break;
    OpSet[umin] := OpSet[nSet];
    Dec(nSet);
    for v := 1 to n do
      if d[v] > d[p] + c[p, v] then
        begin
          if d[v] = maxLong then
            begin
              Inc(nSet);
              OpSet[nSet] := v;
            end;
          d[v] := d[p] + c[p, v];
          Trace[v] := p;
        end;
  until nSet = 0;
  Dijkstra := d[T];
end;

procedure Solve;
var
  u, v: Integer;
  Cost, SaveC: LongInt;
begin
  minCost := maxLong;
  for u := 1 to n do
    for v := u + 1 to n do
      if c[u, v] + d^[v, u] < minCost then
        begin
          if d^[v, u] <> c[v, u] then Cost := c[u, v] + d^[v, u]
          else
            begin
              SaveC := c[u, v];
              c[u, v] := maxLong;
              Cost := SaveC + Dijkstra(u, v);
              c[u, v] := SaveC;
            end;
          if minCost > Cost then
            begin
              minCost := Cost;
              Start := u; Finish := v;
            end;
        end;
end;

procedure Result;
var
  f: Text;
  t, count: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  if minCost = maxLong then Writeln(f, 0)
  else
    begin
      Writeln(f, 1);
      Writeln(f, minCost);
      c[Start, Finish] := maxLong;
      Dijkstra(Start, Finish);
      count := 0;
      t := Finish;
      repeat
        Inc(count);
        t := Trace[t];
      until t = Start;
      Writeln(f, count + 1);
      t := Finish;
      repeat
        Write(f, t, ' ');
        t := Trace[t];
      until t = Start;
      Writeln(f, Start);
    end;
  Close(f);
end;

begin
  Enter;
  Floyd;
  Solve;
  Result;
end.
5 5
1 3 2
2 4 2
3 5 2
4 1 2
5 2 2
1 2 3
2 3 3
3 4 3
4 5 3
5 1 3
