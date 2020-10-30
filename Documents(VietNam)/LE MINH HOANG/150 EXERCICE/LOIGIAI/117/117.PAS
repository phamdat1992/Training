program Traffic;
const
  InputFile  = 'TRAFFIC.IN0';
  OutputFile = 'TRAFFIC.OUT';
  max = 200;
var
  a: array[1..max, 1..max] of Byte;
  Numbering, Low, Stack: array[1..max] of Integer;
  Exist: array[1..max] of Boolean;
  Res, n, Count, nStack: Integer;
  FirstHead, LastHead: Integer;

procedure Enter;
var
  f: Text;
  m, i, u, v: Integer;
begin
  FillChar(a, SizeOf(a), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      a[u, v] := 1;
    end;
  Close(f);
end;

function Min(x, y: Integer): Integer;
begin
  if x < y then Min := x else Min := y;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Inc(Count);
  Numbering[u] := Count; Low[u] := Count;
  Inc(nStack);
  Stack[nStack] := u;
  for v := 1 to n do
    if Exist[v] and (a[u, v] <> 0) then
      if (Numbering[v] <> 0) then
        Low[u] := Min(Low[u], Numbering[v])
      else
        begin
          Visit(v);
          Low[u] := Min(Low[u], Low[v]);
        end;
  if Low[u] = Numbering[u] then {u is the header of strong connected cmp}
    begin
      LastHead := u;
      if FirstHead = 0 then FirstHead := u;
      repeat
        v := Stack[nStack]; Dec(nStack); {Pop}
        Exist[v] := False;  {Remove}
      until v = u;
    end;
end;

procedure Number;
var
  u: Integer;
begin
  Count := 0;
  FillChar(Numbering, SizeOf(Numbering), 0);
  FillChar(Exist, SizeOf(Exist), True);
  nStack := 0;
  FirstHead := 0;
  for u := 1 to n do
    if Numbering[u] = 0 then Visit(u);
end;

procedure Solve;
begin
  repeat
    Number;
    if FirstHead = LastHead then Exit; {Only 1 head, Graph is strong connected}
    Inc(Res);
    a[FirstHead, LastHead] := 2;  {Add Arc from First to Last Head}
  until False;
end;

procedure Result;
var
  f: Text;
  u, v: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Res);
  for u := 1 to n do
    for v := 1 to n do
      if a[u, v] = 2 then Writeln(f, u, ' ', v);
  Close(f);
end;

begin
  Enter;
  Res := 0;
  Solve;
  Result;
end.

13 15
1 9
1 12
2 3
3 4
4 1
4 5
5 2
6 7
7 1
7 8
8 6
9 10
10 11
11 9
12 13