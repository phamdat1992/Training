program TheTours;
const
  InputFile  = 'THI.INP';
  OutputFile = 'THI.OUT';
  max = 100;
type
  TBoard = array[1..2 * max, 1..2 * max] of Boolean;
var
  a, Havef: ^TBoard;
  Queue, Trace: array[1..2 * max] of Integer;
  Go: array[0..2 * max] of Integer;
  n, k, nGo, first, last: Integer;

{anh xa:
1 -> 1, 2
2 -> 3, 4
3 -> 5, 6
...
x -> x * 2 - 1, x * 2
}

procedure Enter;
var
  f: Text;
  m, i, u, v, t: Integer;
begin
  New(a); New(Havef);
  FillChar(a^, SizeOf(a^), False);
  FillChar(Havef^, SizeOf(Havef^), False);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m, k);
  n := n shl 1;
  for i := 1 to n do a^[i shl 1 - 1, i shl 1] := True;
  for i := 1 to m do
    begin
      Readln(f, u, v);
      a^[u shl 1, v shl 1 - 1] := True;
      a^[v shl 1, u shl 1 - 1] := True;
    end;
  Close(f);
  for i := 1 to n do
    begin
      a^[i, 1] := False; a^[1, i] := False;
      a^[i, n] := False; a^[n, i] := False;
    end;
end;

function FindPath(Start, Finish: Integer): Boolean;
var
  u, v: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[Start] := n + 1;
  Queue[1] := Start; first := 1; last := 1;
  repeat
    u := Queue[first]; Inc(first);
    for v := 1 to n do
      if Trace[v] = 0 then
        begin
          if a^[u, v] and not Havef^[u, v] then Trace[v] := u;
          if a^[v, u] and Havef^[v, u] then Trace[v] := -u;
          if Trace[v] <> 0 then
            begin
              if v = Finish then
                begin
                  FindPath := True;
                  Exit;
                end;
              Inc(last); Queue[last] := v;
            end;
        end;
  until first > last;
  FindPath := False;
end;

procedure IncFlow(Start, Finish: Integer);
var
  t, prev: Integer;
begin
  t := Finish;
  repeat
    prev := Trace[t]; {prev -> t}
    if prev > 0 then Havef^[prev, t] := True
    else Havef^[t, Abs(prev)] := False;
    t := Abs(prev);
  until t = Start;
end;

procedure GoOut;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Write(f, 'NO');
  Close(f);
  Halt;
end;

procedure refine; forward;

procedure FindMaxFlow;
var
  i: Integer;
begin
  for i := 1 to 2 * k do
    if FindPath(2, n - 1) then IncFlow(2, n - 1)
    else
      begin

          refine;
                  GoOut;
      end;
end;

procedure Refine;
var
  i, j, u, v: Integer;
begin
  FillChar(a^, SizeOf(a^), 0);
  for i := 1 to n do
    for j := 1 to n do
      begin
        u := (i + 1) shr 1; v := (j + 1) shr 1;
        if Havef^[i, j] then a^[u, v] := True;
      end;
  n := n shr 1;
  for u := 1 to n do
    for v := 1 to n do
      if a^[u, v] and a^[v, u] then
        begin
          a^[u, v] := False; a^[v, u] := False;
        end;
  FillChar(Havef^, SizeOf(Havef^), False);
end;

procedure BFS(Start, Finish: Integer);
var
  u, v: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[Start] := n + 1;
  Queue[1] := Start; first := 1; last := 1;
  repeat
    u := Queue[first]; Inc(first);
    for v := 1 to n do
      if a^[u, v] and (Trace[v] = 0) then
        begin
          Trace[v] := u;
          if v = Finish then Exit;
          Inc(last); Queue[last] := v;
        end;
  until first > last;
end;

procedure TracePath;
var
  t, prev: Integer;
begin
  nGo := 0;
  BFS(1, n);
  t := n;
  repeat
    Inc(nGo);
    Go[nGo] := t;
    prev := Trace[t];
    if prev <> n + 1 then
      begin
        a^[prev, t] := False;
        a^[t, prev] := False;
      end;
    t := prev;
  until t = n + 1;
end;

procedure Result;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, 'YES');
  Go[0] := 0;
  for i := 1 to k do
    begin
      TracePath;
      for j := nGo downto 1 do
        if Go[j] <> Go[j - 1] then Write(f, Go[j], ' ');
      Writeln(f);
      TracePath;
      for j := 1 to nGo do
        if Go[j] <> Go[j - 1] then Write(f, Go[j], ' ');
      Writeln(f);
    end;
  Close(f);
end;

begin
  Enter;
  FindMaxFlow;
  Refine;
  Result;
end.
10 17 2
1 2
1 3
1 4
1 5
2 4
2 8
3 5
3 9
4 6
4 7
5 6
6 8
6 10
7 9
7 10
8 10
9 10
