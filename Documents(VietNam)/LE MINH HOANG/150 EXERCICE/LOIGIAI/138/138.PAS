program RobotMoving;
const
  InputFile  = 'RMOVE.INP';
  OutputFile = 'RMOVE.OUT';
  max = 100;
  maxC = max * max + 1;
type
  TList = array[1..max * max] of Byte;
var
  c: array[1..max, 1..max] of Word;
  a: array[1..max, 1..max] of Boolean;
  Qx, Qy: ^TList;
  n, m, SA, SB: Integer;
  first, last, res: Word;

procedure Enter;
var
  f: Text;
  i, u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m, SA, SB);
  FillChar(a, SizeOf(a), False);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      a[u, v] := True;
    end;
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  New(Qx); New(Qy);
  for i := 1 to n do
    for j := 1 to n do
      if i = j then c[i, j] := 0
      else c[i, j] := maxC;
  for i := 1 to n do
    begin
      Qx^[i] := i; Qy^[i] := i;
    end;
  first := 1; last := n;
end;

procedure Push(x, y: Integer);
begin
  Inc(last);
  Qx^[last] := x; Qy^[last] := y;
end;

procedure Pop(var x, y: Integer);
begin
  x := Qx^[first]; y := Qy^[first];
  Inc(first);
end;

procedure BFS;
var
  u, v, u1, v1: Integer;
begin
  repeat
    Pop(u, v);
    for u1 := 1 to n do
      if a[u1, u] then
        for v1 := 1 to n do
          if a[v1, v] and (c[u1, v1] = maxC) then
            begin
              c[u1, v1] := c[u, v] + 1;
              if (u1 = SA) and (v1 = SB) then Exit;
              Push(u1, v1);
            end;
  until False; {always have solution}
end;

procedure TracingBack;
var
  f: Text;
  x, y, u, v: Integer;

  procedure FindNext(var x, y: Integer);
  var
    i, j: Integer;
  begin
    for i := 1 to n do
      if a[x, i] then
        for j := 1 to n do
          if a[x, i] and (c[i, j] = c[x, y] - 1) then
            begin
              x := i; y := j;
              Exit;
            end;
  end;

begin
  res := c[SA, SB];
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, res);
  x := SA; y := SB;
  while x <> y do
    begin
      Write(f, x, ' ');
      FindNext(x, y);
    end;
  Writeln(f, x);
  x := SA; y := SB;
  while x <> y do
    begin
      Write(f, y, ' ');
      FindNext(x, y);
    end;
  Writeln(f, y);
  Close(f);
end;

begin
  Enter;
  Init;
  BFS;
  TracingBack;
end.
4 5 1 2
1 2
2 1
2 4
3 2
4 3