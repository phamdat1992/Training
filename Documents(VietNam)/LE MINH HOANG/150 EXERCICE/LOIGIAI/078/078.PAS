program Chain;
const
  InputFile  = 'CHAIN.INP';
  OutputFile = 'CHAIN.OUT';
  max = 10000;
type
  TIntList = array[1..max + 1] of Integer;
  TAdjLIst = array[1..2 * max - 2] of Integer;
var
  adj: ^TAdjList;
  head, deg: ^TIntList;
  Free: array[1..max] of Boolean;
  Lab: array[1..max] of Integer;
  n, Count: Integer;

procedure Enter;
var
  f: Text;
  i, u, v: Integer;
begin
  New(head); New(deg); New(adj);
  FillChar(deg^, SizeOf(deg^), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n - 1 do
    begin
      Readln(f, u, v);
      Inc(deg^[u]); Inc(deg^[v]);
    end;
  Close(f);
  head^[1] := 1;
  for i := 2 to n + 1 do
    head^[i] := head^[i - 1] + deg^[i - 1];
  FillChar(deg^, SizeOf(deg^), 0);
  Reset(f); Readln(f);
  for i := 1 to n - 1 do
    begin
      Readln(f, u, v);
      Inc(deg^[u]); Inc(deg^[v]);
      adj^[head^[u] + deg^[u] - 1] := v;
      adj^[head^[v] + deg^[v] - 1] := u;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(Free, SizeOf(Free), True);
  FillChar(Lab, SizeOf(Lab), 0);
  Count := 0;
end;

function FindRoot(Prev: Integer): Integer;
var
  i, v: Integer;

  function IsFirst(i: Integer): Boolean;
  var
    j, c: Integer;
  begin
    c := 0;
    for j := head^[i] to head^[i + 1] - 1 do
      if deg^[adj^[j]] > 1 then
        begin
          Inc(c);
          if c >= 2 then Break;
        end;
    IsFirst := c < 2;
  end;

begin
  if Prev = 0 then
    begin
      for i := 1 to n do
        if (deg^[i] > 1) and IsFirst(i) then
          begin
            FindRoot := i;
            Exit;
          end;
    end
  else
    for i := head^[prev] to head^[prev + 1] - 1 do
      begin
        v := adj^[i];
        if Free[v] and (deg^[v] > 1) then
          begin
            FindRoot := v;
            Exit;
          end;
      end;
  FindRoot := 0;
end;

procedure FillLabel(root: Integer);
var
  i: Integer;
begin
  for i := 1 to n do
    if Lab[i] <> 0 then Lab[i] := Count + 2 - Lab[i];
  Lab[root] := 1;
  Inc(Count);
  for i := head^[root] to head^[root + 1] - 1 do
    if deg^[adj^[i]] = 1 then
      begin
        Inc(Count);
        Lab[adj^[i]] := Count;
      end;
end;

procedure Solve;
var
  p: Integer;
begin
  p := FindRoot(0);
  repeat
    FillLabel(p);
    Free[p] := False;
    p := FindRoot(p);
  until p = 0;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  for i := 1 to n do Write(f, Lab[i], ' ');
  Close(f);
end;

procedure SelfTest;
var
  i, j, v, k: Integer;
begin
  FillChar(Free, SizeOf(Free), True);
  for i := 1 to n do
    for j := head^[i] to head^[i + 1] - 1 do
      begin
        v := adj^[j];
        k := Abs(Lab[i] - Lab[v]);
        if not Free[k] then
          begin
            Writeln(k, ' Error!');
            Halt;
          end;
      end;
  Writeln('OK');
end;

begin
  Enter;
  Init;
  Solve;
  Result;
  
end.
13
1 2
1 5
1 6
1 9
1 10
2 7
2 11
2 3
3 4
4 8
4 12
4 13
