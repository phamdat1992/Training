program FriendShip;
const
  InputFile  = 'FRIEND.INP';
  OutputFile = 'FRIEND.OUT';
  max = 100;
  maxC = 1001;
  maxT = max * maxC;
type
  TLab = array[1..max] of LongInt;
  TTrace = array[1..max] of Integer;
var
  c: array[1..max, 1..max] of Integer;
  s1, f1, s2, f2, n, m: Integer;
  d, d1, d2, d3, d4: TLab;
  Trace: TTrace;
  Path: array[1..max] of Integer;
  nPath: Integer;
  TM, Time1, Time2: LongInt;
  Position: Integer;

procedure Enter;
var
  f: Text;
  i, u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  Readln(f, s1, f1, s2, f2);
  for u := 1 to n do
    for v := 1 to n do c[u, v] := maxC;
  for i := 1 to m do
    begin
      Readln(f, u, v, c[u, v]);
      c[v, u] := c[u, v];
    end;
  Close(f);
end;

procedure Dijkstra(Start: Integer; var d: TLab);
var
  p, v: Integer;
  min: LongInt;
  Free: array[1..max] of Boolean;
begin
  for v := 1 to n do d[v] := maxT;
  FillChar(Free, SizeOf(Free), True);
  d[Start] := 0;
  repeat
    p := 0; min := maxT;
    for v := 1 to n do
      if Free[v] and (d[v] < min) then
        begin
          p := v;
          min := d[v];
        end;
    if p = 0 then Exit;
    Free[p] := False;
    for v := 1 to n do
      if Free[v] and (c[p, v] <> maxC) and (d[v] > d[p] + c[p, v]) then
        begin
          d[v] := d[p] + c[p, v];
          Trace[v] := p;
        end;
  until False;
end;

procedure Solve;
var
  u: Integer;
begin
  Dijkstra(s1, d1);
  Dijkstra(s2, d2);
  Dijkstra(f1, d3);
  Dijkstra(f2, d4);
  Time1 := d1[f1]; Time2 := d2[f2];
  TM := maxT; Position := 0;
  for u := 1 to n do
    if (d1[u] + d3[u] = Time1) and (d2[u] + d4[u] = Time2) and
       (d1[u] = d2[u]) and (d1[u] < TM) then
         begin
           TM := d1[u];
           Position := u;
         end;
  if Position <> 0 then Dijkstra(Position, d);
end;

procedure result;
var
  f: Text;
  t, i, step: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  if Position = 0 then Writeln(f, 'NO')
  else
    begin
      Writeln(f, 'YES');
      for step := 1 to 2 do
        begin
          Writeln(f, Time1);
          t := s1;
          while t <> Position do
            begin
              Write(f, t, ' ');
              t := Trace[t];
            end;
          Write(f, Position, ' ');
          nPath := 0;
          t := f1;
          while t <> Position do
            begin
              Inc(nPath); Path[nPath] := t;
              t := Trace[t];
            end;
          for i := nPath downto 1 do Write(f, Path[i], ' ');
          Writeln(f);
          Time1 := Time2; s1 := s2; f1:= f2;
        end;
      Writeln(f, Position);
      Writeln(f, TM);
    end;
  Close(f);
end;

begin
  Enter;
  Solve;
  Result;
end.
6 7
1 6 2 5
1 3 10
1 4 10
2 3 5
3 4 5
3 6 15
4 5 20
4 6 15

