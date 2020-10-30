{Free pascal}
{$R+,Q+}
program CargoMoving;
uses crt;
const
  InputFile  = 'CARGO.IN0';
  OutputFile = 'CARGO.OUT';
  max = 101;
  maxC = 100000000;
  dx: array[1..4] of LongInt = (0, 0, -1, 1);
  dy: array[1..4] of LongInt = (-1, 1, 0, 0);
type
  TNode = record
    x, y, d: LongInt;
  end;
  PChainNode = ^TChainNode;
  TChainNode = record
    Symbol: Char;
    link: PChainNode;
  end;
var
  map: array[0..max + 1, 0..max + 1] of Char;
  dis: array[1..max, 1..max, 1..4] of LongInt;
  Trace: array[1..max, 1..max] of LongInt;
  TraceDijkstra: array[1..max, 1..max, 1..4] of TNode;
  TraceAct: array[1..max, 1..max, 1..4] of Char;
  Heap: array[1..max * max * 4] of TNode;
  pos: array[1..max, 1..max, 1..4] of LongInt;
  m, n, C: LongInt;
  xs, ys, xd, yd, xr, yr: LongInt;
  res, nHeap: LongInt;
  xres, yres, dres: LongInt;
  EndAction: Char;
  LastChainNode: PChainNode;

procedure Enter;
var
  f: Text;
  i, j: LongInt;
begin
  FillChar(map, SizeOf(map), '#');
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, c);
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, map[i, j]);
          case map[i, j] of
            '*': begin
                   xr := i; yr := j;
                 end;
            '@': begin
                   xd := i; yd := j;
                 end;
            '$': begin
                   xs := i; ys := j;
                 end;
          end;
        end;
      Readln(f);
    end;
  Close(f);
end;

function BFS(x1, y1, x2, y2, xc, yc: LongInt): LongInt;
label Done;
var
  Qx, Qy, Qd: array[1..max * max] of LongInt;
  first, last, x, y, newx, newy, d, l, res: LongInt;
  temp: Char;
begin
  if (x1 = x2) and (y1 = y2) then
    begin
      BFS := 0;
      Exit;
    end;
  temp := map[xc, yc];
  map[xc, yc] := '#';
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[x1, y1] := -1;
  Qx[1] := x1; Qy[1] := y1; Qd[1] := 0;
  first := 1; last := 1;
  while first <= last do
    begin
      x := Qx[first]; y := Qy[first]; l := Qd[first];
      Inc(first);
      for d := 1 to 4 do
        begin
          newx := x + dx[d]; newy := y + dy[d];
          if (map[newx, newy] <> '#') and (Trace[newx, newy] = 0) then
            begin
              Trace[newx, newy] := d;
              if (newx = x2) and (newy = y2) then
                begin
                  BFS := l + 1;
                  goto Done;
                end;
              Inc(last);
              Qx[last] := newx; Qy[last] := newy; Qd[last] := l + 1;
            end;
        end;
    end;
  BFS := MaxC;

Done:
  map[xc, yc] := temp;
end;

function GetDis(node: TNode): LongInt;
begin
  with node do GetDis := dis[x, y, d];
end;

function GetIdDis(i: LongInt): LongInt;
begin
  GetIdDis := GetDis(heap[i]);
end;

procedure SetHeap(i: LongInt; Node: TNode);
begin
  Heap[i] := Node;
  with Node do
    pos[x, y, d] := i;
end;

procedure PushToHeap(x, y, d: LongInt);
var
  r, c: LongInt;
  V: LongInt;
begin
  c := Pos[x, y, d];
  V := dis[x, y, d];
  if c = 0 then
    begin
      Inc(nHeap); c := nHeap;
    end;
  r := c div 2;
  while (r > 0) and (GetIdDis(r) > V) do
    begin
      SetHeap(c, Heap[r]);
      c := r;
      r := c div 2;
    end;
  Heap[c].x := x; Heap[c].y := y; Heap[c].d := d;
  pos[x, y, d] := c;
end;

procedure PopFromHeap(var tx, ty, td: LongInt);
var
  Node: TNode;
  r, c, l: LongInt;
begin
  with Heap[1] do
    begin
      tx := x; ty := y; td := d;
    end;
  Node := Heap[nHeap];
  l := GetDis(Node);
  Dec(nHeap);
  r := 1;
  while r * 2 <= nHeap do
    begin
      c := r * 2;
      if (c < nHeap) and (GetIDDis(c + 1) < GetIDDis(c)) then Inc(c);
      if l <= GetIDDis(c) then Break;
      SetHeap(r, Heap[c]);
      r := c;
    end;
  SetHeap(r, Node);
end;

procedure InitDijkstra;
var
  i, j, d: LongInt;
begin
  for i := 1 to m do
    for j := 1 to n do
      for d := 1 to 4 do dis[i, j, d] := maxC;
  nHeap := 0;
  FillChar(Pos, SizeOf(Pos), 0);
  FillChar(TraceAct, SizeOf(TraceAct), 0);
  for d := 1 to 4 do
    if map[xs + dx[d], ys + dy[d]] <> '#' then
      begin
        dis[xs, ys, d] := BFS(xr, yr, xs + dx[d], ys + dy[d], xs, ys);
        if dis[xs, ys, d] <> maxC then
          begin
            PushtoHeap(xs, ys, d);
            TraceAct[xs, ys, d] := #255;
          end;
      end;
end;

procedure AroundUpdate(x, y, di: LongInt; BaseNode: TNode; BaseAction: Char);
var
  d, xs, ys: LongInt;
  l, base: LongInt;
begin
  base := dis[x, y, di];
  xs := x + dx[di]; ys := y + dy[di];
  for d := 1 to 4 do
    if map[x + dx[d], y + dy[d]] <> '#' then
      begin
        l := BFS(xs, ys, x + dx[d], y + dy[d], x, y);
        if dis[x, y, d] > base + l then
          begin
            dis[x, y, d] := base + l;
            PushToHeap(x, y, d);
            TraceDijkstra[x, y, d] := BaseNode;
            TraceAct[x, y, d] := BaseAction;
          end;
      end;
end;

procedure MovingUpdate(base: LongInt; xr, yr, xc, yc: LongInt;
          BaseNode: TNode; BaseAction: Char);
var
  d: LongInt;
  l: LongInt;
begin
  for d := 1 to 4 do
    if (map[xc + dx[d], yc + dy[d]] <> '#') then
      begin
        l := BFS(xr, yr, xc + dx[d], yc + dy[d], xc, yc);
        if dis[xc, yc, d] > base + l then
          begin
            dis[xc, yc, d] := base + l;
            PushToHeap(xc, yc, d);
            TraceDijkstra[xc, yc, d] := BaseNode;
            TraceAct[xc, yc, d] := BaseAction;
          end;
      end;
end;

procedure Update(x, y, d: LongInt);
var
  nextx, nexty, nextd: LongInt;
  base, l, cost: LongInt;
  baseNode: TNode;
begin
  baseNode.x := x; baseNode.y := y; baseNode.d := d;
  base := dis[x, y, d];
  {+}
  nextx := x; nexty := y;
  cost := 0;
  while map[nextx - dx[d], nexty - dy[d]] <> '#' do
    begin
      nextx := nextx - dx[d]; nexty := nexty - dy[d];
      cost := C;
    end;
  MovingUpdate(base + cost, x + dx[d], y + dy[d], nextx, nexty, baseNode, '+');
  {-}
  nextx := x + dx[d]; nexty := y + dy[d];
  if (map[nextx + dx[d], nexty + dy[d]] <> '#') then
    begin
      if (dis[nextx, nexty, d] > base + C) then
        begin
          dis[nextx, nexty, d] := base + C;
          PushToHeap(nextx, nexty, d);
          TraceDijkstra[nextx, nexty, d] := baseNode;
          TraceAct[nextx, nexty, d] := '-';
        end;
      AroundUpdate(nextx, nexty, d, BaseNode, '-');
    end;
end;

function CheckSuccess(x, y, d: LongInt): Boolean;
var
  nextx, nexty: LongInt;
  base: LongInt;
begin
  base := dis[x, y, d];
  {+}
  nextx := x; nexty := y;
  while (map[nextx - dx[d], nexty - dy[d]] <> '#') do
    begin
      nextx := nextx - dx[d]; nexty := nexty - dy[d];
    end;
  if (nextx = xd) and (nexty = yd) then
    begin
      res := base + C;
      CheckSuccess := True;
      xres := x; yres := y; dres := d;
      EndAction := '+';
      Exit;
    end;
  {-}
  nextx := x + dx[d]; nexty := y + dy[d];
  if (nextx = xd) and (nexty = yd) and
     (map[nextx + dx[d], nexty + dy[d]] <> '#') then
      begin
        res := base + C;
        CheckSuccess := True;
        xres := x; yres := y; dres := d;
        EndAction := '-';
        Exit;
      end;
  CheckSuccess := False;
end;

procedure Dijkstra;
var
  x, y, d: LongInt;
begin
  repeat
    PopFromHeap(x, y, d);
    if CheckSuccess(x, y, d) then
      Break;
    Update(x, y, d);
  until False;
end;

procedure AddToChain(V: Char);
var
  p: PChainNode;
begin
  New(p);
  p^.Symbol := V;
  p^.Link := LastChainNode;
  LastChainNode := p;
end;

procedure Result;
const
  ds: array[1..4] of Char = 'LRUD';
var
  f: Text;
  nextx, nexty, nextd: LongInt;
  p: PChainNode;
  act: char;

  procedure Trace1(x1, y1, x2, y2, xc, yc: LongInt);
  var
    d: LongInt;
  begin
    BFS(x1, y1, x2, y2, xc, yc);
    while (x2 <> x1) or (y2 <> y1) do
      begin
        d := Trace[x2, y2];
        AddToChain(DS[d]);
        x2 := x2 - dx[d]; y2 := y2 - dy[d];
      end;
  end;

  procedure Trace2(x1, y1, d1, x2, y2, d2: LongInt; act: Char);
  begin
    case act of
      '+':
         begin
           Trace1(x1 + dx[d1], y1 + dy[d1], x2 + dx[d2], y2 + dy[d2],
                  x2, y2);
           AddToChain(act);
         end;

      '-':
         begin
           Trace1(x1 + 2 * dx[d1], y1 + 2 * dy[d1], x2 + dx[d2], y2 + dy[d2],
                  x1 + dx[d1], y1 + dy[d1]);
           AddToChain(act);
         end;
    end;
  end;

begin
  New(LastChainNode);
  with LastChainNode^ do
    begin
      Symbol := EndAction;
      Link := nil;
    end;
  repeat
    if TraceAct[xres, yres, dres] = #255 then Break;
    with TraceDijkstra[xres, yres, dres] do
      begin
        nextx := x; nexty := y; nextd := d;
      end;
    act := TraceAct[xres, yres, dres];
    Trace2(nextx, nexty, nextd, xres, yres, dres, act);
    xres := nextx; yres := nexty; dres := nextd;
  until False;
  Trace1(xr, yr, xres + dx[dres], yres + dy[dres], xs, ys);
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, res);
  p := LastChainNode;
  while p <> nil do
    begin
      Write(f, p^.Symbol);
      p := p^.Link;
    end;
  Close(f);
end;

begin
  Clrscr;
  Enter;
  InitDijkstra;
  Dijkstra;
  Result;
end.
4 7 3
#######
#*$..@#
#######
#######
