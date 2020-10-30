program Network;
uses crt, graph;
const
  InputFile  = 'NET.IN1';
  OutputFile = 'NET.OUT';
  max = 100;
  dx: array[1..4] of Integer = (1, 0, 0, -1);
  dy: array[1..4] of Integer = (0, -1, 1, 0);
type
  TAdj = set of 1..4;
var
  map: array[0..max, 0..max] of TAdj;
  res, m, n, nV: Integer;
  Lab: array[0..(max + 1) * (max + 1) - 1] of Integer;
  gd, gm: Integer;

procedure Enter;
var
  f: Text;
  x1, y1, x2, y2, d: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  FillChar(map, SizeOf(map), 0);
  while not SeekEof(f) do
    begin
      Readln(f, x1, y1, x2, y2);
      for d := 1 to 4 do
        if (x1 + dx[d] = x2) and (y1 + dy[d] = y2) then Break;
      Include(map[x1, y1], d);
      Include(map[x2, y2], 5 - d);
    end;
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  nV := n * (m + 1) + m;
  for i := 0 to nV do Lab[i] := -1;
end;

function Encode(x, y: Integer): Integer;
begin
  Encode := y * (m + 1) + x;
end;

procedure Decode(v: Integer; var x, y: Integer);
begin
  x := v mod (m + 1);
  y := v div (m + 1);
end;

function GetRoot(u: Integer): Integer;
begin
  while Lab[u] >= 0 do u := Lab[u];
  GetRoot := u;
end;

procedure Union(r1, r2: Integer);
var
  x: Integer;
begin
  x := Lab[r1] + Lab[r2];
  if Lab[r1] < Lab[r2] then
    begin
      Lab[r2] := r1;
      Lab[r1] := x;
    end
  else
    begin
      Lab[r1] := r2;
      Lab[r2] := x;
    end;
end;

procedure Kruskal;
label Done1, Done;
var
  x1, y1, x2, y2, d, Count: Integer;
  u, v, r1, r2: Integer;
  f: Text;
begin
  Count := 0;
  for x1 := 0 to m do
    for y1 := 0 to n do
      for d := 1 to 4 do
        if d in map[x1, y1] then
          begin
            x2 := x1 + dx[d]; y2 := y1 + dy[d];
            u := Encode(x1, y1); v := Encode(x2, y2);
            r1 := GetRoot(u); r2 := GetRoot(v);
            if r1 <> r2 then
              begin
                Inc(count);
                if Count = nV then Goto Done1;
                Union(r1, r2);
              end;
          end;

Done1:
  Assign(f, OutputFile); Rewrite(f);
  res := nV - Count;
  Writeln(f, res);
  if res = 0 then Goto Done;
  for x1 := 0 to m do
    for y1 := 0 to n do
      for d := 1 to 2 do
        if not (d in map[x1, y1]) then
          begin
            x2 := x1 + dx[d]; y2 := y1 + dy[d];
            if (x2 >= 0) and (x2 <= m) and (y2 >= 0) and (y2 <= n) then
              begin
                u := Encode(x1, y1); v := Encode(x2, y2);
                r1 := GetRoot(u); r2 := GetRoot(v);
                if r1 <> r2 then
                  begin
                    Union(r1, r2);
                    Writeln(f, x1, ' ', y1, ' ', x2, ' ', y2);
                    Inc(count);
                    if Count = nV then goto Done;
                  end;
              end;
          end;
Done:
  Close(f);
end;

procedure Display;
var
  i, j, rx, ry, r, x1, y1, x2, y2: Integer;
  f: Text;
begin
  gd := 0;
  InitGraph(gd, gm, '');
  rx := 620 div m;
  ry := 420 div n;
  SetViewport(10, 10, 11, 11, False);
  if rx < ry then r := rx else r := ry;
  SetColor(8);
  Assign(f, InputFile); Reset(f);
  Readln(f);
  while not SeekEof(f) do
    begin
      Readln(f, x1, y1, x2, y2);
      Line(x1 * r, 440 - y1 * r, x2 * r, 440 - y2 * r);
    end;
  Close(f);
  SetColor(10);
  Assign(f, OutputFile); Reset(f);
  Readln(f);
  while not SeekEof(f) do
    begin
      Readln(f, x1, y1, x2, y2);
      Line(x1 * r, 440 - y1 * r, x2 * r, 440 - y2 * r);
    end;
  Close(f);
  for x1 := 0 to m do
    for y1 := 0 to n do
      for i := - 1 to 1 do
        for j := - 1 to 1 do
         if Abs(i) + abs(j) <= 1 then
           PutPixel(x1 * r + i, 440 - (y1 * r) + j, 14);
  Readkey;
  closeGraph;
end;

begin
  Enter;
  Init;
  Kruskal;
  Display;

end.
2 3
0 0 0 1
1 0 2 0
1 0 1 1
2 0 2 1
0 1 1 1
1 1 2 1
1 2 2 2
0 3 1 3