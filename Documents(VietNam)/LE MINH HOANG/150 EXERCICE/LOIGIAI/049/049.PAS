program DispatchMessage;
const
  InputFile  = 'MESSAGE.INP';
  OutputFile = 'MESSAGE.OUT';
  max = 100;
  maxV = 20001;
var
  n: Integer;
  S, D: Integer;
  c: array[1..max, 1..max] of Integer;
  DLabel: array[1..max] of Word;
  Trace1, Trace2: array[1..max] of Integer;
  Solution: Boolean;
  Distance1, Distance2: Word;

procedure Enter;
var
  f: Text;
  m, i: Integer;
  u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m, S, D);
  for u := 1 to n do
    for v := 1 to n do
      c[u, v] := maxV;
  for i := 1 to m do
    begin
      Readln(f, u, v, c[u, v]);
      c[v, u] := c[u, v];
    end;
  Close(f);
end;

procedure Init;
begin
end;

procedure Dijkstra;
var
  Free: array[1..max] of Boolean;
  u, v: Integer;
  min: Word;
begin
  FillChar(Free, SizeOf(Free), True);
  for v := 1 to n do DLabel[v] := maxV;
  DLabel[S] := 0;
  repeat
    min := maxV; u := 0;
    for v := 1 to n do
      if Free[v] and (DLabel[v] < min) then
        begin
          min := DLabel[v];
          u := v;
        end;
    if (u = 0) or (u = D) then
      begin
        Solution := u = D;
        Exit;
      end;
    Free[u] := False;
    for v := 1 to n do
      if Free[v] and (DLabel[v] > DLabel[u] + c[u, v]) then
        begin
          DLabel[v] := DLabel[u] + c[u, v];
          Trace1[v] := u;
        end;
  until False;
end;

procedure ResetMatrix;
var
  u, v: Integer;
begin
  v := D;
  repeat
    u := Trace1[v];
    c[v, u] := - c[v, u];
    c[u, v] := maxV;
    v := u;
  until u = S;
end;

procedure FordBellman;
var
  u, v, k: Integer;
  Stop: Boolean;
begin
  for v := 1 to n do DLabel[v] := maxV;
  DLabel[S] := 0;
  for k := 1 to n do
    begin
      Stop := True;
      for u := 1 to n do
        for v := 1 to n do
          if DLabel[v] > DLabel[u] + c[u, v] then
            begin
              DLabel[v] := DLabel[u] + c[u, v];
              Trace2[v] := u;
              Stop := False;
            end;
      if Stop then Break;
    end;
  Solution := Solution and (DLabel[D] <> maxV);
end;

procedure Result;
var
  f: Text;
  u, v, np, i: Integer;
  T1, T2, p: array[1..max] of Integer;
  FirstPath: Boolean;
begin
  Assign(f, OutputFile); Rewrite(f);
  if not Solution then Writeln(f, 'NO SOLUTION')
  else
    begin
      Writeln(f, Distance1 + Distance2);
      FillChar(T1, SizeOf(T1), 0); FillChar(T2, SizeOf(T2), 0);
      {Ford-Bellman Trace}
      FirstPath := True;
      v := D;
      repeat
        u := Trace2[v];
        if c[u, v] < 0 then
          begin
            c[u, v] := - c[u, v];
            FirstPath := not FirstPath;
          end
        else
          if FirstPath then T1[v] := u else T2[v] := u;
        v := u;
      until v = S;
      {Dijkstra Trace}
      FirstPath := False;
      v := D;
      repeat
        u := Trace1[v];
        if c[v, u] > 0 then
            FirstPath := not FirstPath
        else
          if FirstPath then T1[v] := u else T2[v] := u;
        v := u;
      until v = S;
      {Write First Path}
      v := D;
      np := 0;
      repeat
        Inc(np);
        p[np] := v;
        v := T1[v];
      until v = 0;
      for i := np downto 1 do Write(f, p[i], ' ');
      Writeln(f);
      {Write Second Path}
      v := D;
      np := 0;
      repeat
        Inc(np);
        p[np] := v;
        v := T2[v];
      until v = 0;
      for i := np downto 1 do Write(f, p[i], ' ');
    end;
  Close(f);
end;

begin
  Enter;
  Init;
  Dijkstra;
  if Solution then
    begin
      Distance1 := DLabel[D];
      ResetMatrix;
      FordBellman;
      Distance2 := DLabel[D];
    end;
  Result;
end.
5 7 1 5
1 2 3
1 4 8
2 3 5
2 4 4
3 5 5
4 3 8
4 5 3
