program RollingCube;
const
  InputFile  = 'ROLL.INP';
  OutputFile = 'ROLL.OUT';
  max = 80;
  LeftCode: array[1..6, 1..6] of Byte =
  (
  (0, 4, 2, 5, 3, 0),
  (3, 0, 6, 1, 0, 4),
  (5, 1, 0, 0, 6, 2),
  (2, 6, 0, 0, 1, 5),
  (4, 0, 1, 6, 0, 3),
  (0, 3, 5, 2, 4, 0)
  );
type
  TLayer = array[1..max, 1..max] of Word;
  PLayer = ^TLayer;
  THeapCmp = array[1..max * max * 4] of Byte;
  PHeapCmp = ^THeapCmp;
var
  map: array[0..max + 1, 0..max + 1] of Byte;
  Trace: array[1..6, 1..max, 1..max] of Byte;
  d, pos: array[1..6] of PLayer;
  heapK, heapX, heapY: PHeapCmp;
  m, n, xStart, yStart, nHeap: Word;

procedure Enter;
var
  f: Text;
  i, j: Word;
begin
  FillChar(map, SizeOf(map), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, xStart, yStart);
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, map[i, j]);
      Readln(f);
    end;
  Close(f);
end;

procedure InitMem;
var
  l: Word;
  tmp: LongInt;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  tmp := MemAvail;
  for l := 1 to 6 do
    begin
      New(d[l]);
      New(pos[l]);
      FillChar(pos[l]^, SizeOf(pos[l]^), 0);
      FillChar(d[l]^, SizeOf(d[l]^), $FF);
    end;
  New(HeapK); New(HeapX); New(HeapY);
  Writeln('Heap memory used: ', (tmp - MemAvail) shr 10, ' (KB)');
end;

procedure GetValue(p: Word; var k, x, y: Word);
begin
  k := heapK^[p];
  x := heapX^[p];
  y := heapY^[p];
end;

procedure SetValue(p: Word; k, x, y: Word);
begin
  heapK^[p] := k;
  heapX^[p] := x;
  heapY^[p] := y;
  pos[k]^[x, y] := p;
end;

function Higher(p1, p2: Word): Boolean;
var
  k1, x1, y1, k2, x2, y2: Word;
begin
  GetValue(p1, k1, x1, y1); GetValue(p2, k2, x2, y2);
  Higher := d[k1]^[x1, y1] < d[k2]^[x2, y2];
end;

procedure Push(k, x, y: Word);
var
  c, r: Word;
  pk, px, py: Word;
begin
  c := Pos[k]^[x, y];
  if c = 0 then {Add}
    begin
      Inc(nHeap);
      c := nHeap;
    end;
  r := c shr 1;
  while r <> 0 do
    begin
      GetValue(r, pk, px, py);
      if d[pk]^[px, py] <= d[k]^[x, y] then Break;
      SetValue(c, heapK^[r], heapX^[r], heapY^[r]);
      c := r;
      r := c shr 1;
    end;
  SetValue(c, k, x, y);
end;

procedure Pop(var k, x, y: Word);
var
  r, c: Word;
  pk, px, py: Word;
  dtmp: Word;
begin
  GetValue(1, k, x, y);
  GetValue(nHeap, pk, px, py);
  dtmp := d[pk]^[px, py];
  Dec(nHeap);
  r := 1;
  while r shl 1 <= nHeap do
    begin
      c := r shl 1;
      if (c < nHeap) and (Higher(c + 1, c)) then Inc(c);
      if not Higher(c, nHeap + 1) then Break;
      SetValue(r, heapK^[c], heapX^[c], heapY^[c]);
      r := c;
    end;
  SetValue(r, pk, px, py);
end;

procedure DijkstraInit;
var
  i, j, k: Word;

  function Check(k, x, y: Word): Boolean;
  begin
    Check := (map[x, y] <> 0) and (map[x, y] <> k) and
             (map[x, y] <> 7 - k);
  end;

begin
  for k := 1 to 6 do
    begin
      for i := 1 to m do
        begin
          if Check(k, i, 1) then d[k]^[i, 1] := 7 - map[i, 1];
          if Check(k, i, n) then d[k]^[i, n] := 7 - map[i, n];
        end;
      for j := 2 to n - 1 do
        begin
          if Check(k, 1, j) then d[k]^[1, j] := 7 - map[1, j];
          if Check(k, m, j) then d[k]^[m, j] := 7 - map[m, j];
        end;
    end;
  nHeap := 0;
  for i := 1 to m do
    for k := 1 to 6 do
      begin
        if d[k]^[i, 1] <> $FFFF then Push(k, i, 1);
        if d[k]^[i, n] <> $FFFF then Push(k, i, n);
    end;
  for j := 2 to n - 1 do
    for k := 1 to 6 do
      begin
        if d[k]^[1, j] <> $FFFF then Push(k, 1, j);
        if d[k]^[m, j] <> $FFFF then Push(k, m, j);
      end;
end;

function Up(sk, sx, sy: Word; var rk, rx, ry: Word): Boolean;
var
  Face: Word;
begin
  Face := sk;
  rx := sx - 1; ry := sy;
  if map[rx, ry] <> Face then Up := False
  else
    begin
      rk := 7 - map[sx, sy];
      Up := True;
    end;
end;

function Down(sk, sx, sy: Word; var rk, rx, ry: Word): Boolean;
var
  Face: Word;
begin
  Face := 7 - sk;
  rx := sx + 1; ry := sy;
  if map[rx, ry] <> Face then Down := False
  else
    begin
      rk := map[sx, sy];
      Down := True;
    end;
end;

function Left(sk, sx, sy: Word; var rk, rx, ry: Word): Boolean;
var
  Face: Word;
begin
  Face := LeftCode[map[sx, sy], sk];
  rx := sx; ry := sy - 1;
  if map[rx, ry] <> Face then Left := False
  else
    begin
      rk := sk;
      Left := True;
    end;
end;

function Right(sk, sx, sy: Word; var rk, rx, ry: Word): Boolean;
var
  Face: Word;
begin
  Face := 7 - LeftCode[map[sx, sy], sk];
  rx := sx; ry := sy + 1;
  if map[rx, ry] <> Face then Right := False
  else
    begin
      rk := sk;
      Right := True;
    end;
end;

procedure Update(pk, px, py: Word);
var
  k, x, y: Word;
  dp: Word;
begin
  dp := d[pk]^[px, py];
  if Up(pk, px, py, k, x, y) and (d[k]^[x, y] > dp + 7 - map[x, y]) then
    begin
      d[k]^[x, y] := dp + 7 - map[x, y];
      Push(k, x, y);
      Trace[k, x, y] := 1;
    end;
  if Down(pk, px, py, k, x, y) and (d[k]^[x, y] > dp + 7 - map[x, y]) then
    begin
      d[k]^[x, y] := dp + 7 - map[x, y];
      Push(k, x, y);
      Trace[k, x, y] := 2;
    end;
  if Left(pk, px, py, k, x, y) and (d[k]^[x, y] > dp + 7 - map[x, y]) then
    begin
      d[k]^[x, y] := dp + 7 - map[x, y];
      Push(k, x, y);
      Trace[k, x, y] := 3;
    end;
  if Right(pk, px, py, k, x, y) and (d[k]^[x, y] > dp + 7 - map[x, y]) then
    begin
      d[k]^[x, y] := dp + 7 - map[x, y];
      Push(k, x, y);
      Trace[k, x, y] := 4;
    end;
end;

procedure DijkstraSolve;
var
  pk, px, py: Word;
begin
  repeat
    Pop(pk, px, py);
    if (pk = 2) and (px = xStart) and (py = yStart) then Break;
    Update(pk, px, py);
  until nHeap = 0;
end;

procedure Result;
const
  Back: array[1..4] of Char = 'DURL'; {Code = 'UDLR'}
var
  f: Text;
  x, y, k, d: Word;
begin
  Assign(f, OutputFile); Rewrite(f);
  k := 2; x := xStart; y := yStart;
  repeat
    d := Trace[k, x, y];
    Write(f, Back[d]);
    case Back[d] of
      'D': Down(k, x, y, k, x, y);
      'U': Up(k, x, y, k, x, y);
      'R': Right(k, x, y, k, x, y);
      'L': Left(k, x, y, k, x, y);
    end;
  until Trace[k, x, y] = 0;
  Close(f);
end;

begin
  Writeln;
  Enter;
  InitMem;
  DijkstraInit;
  DijkstraSolve;
  Result;
end.

9 6 3 3
0 0 0 0 0 0
0 0 2 4 0 0
1 4 6 6 6 6
0 0 2 3 0 0
0 0 0 1 0 0
0 0 0 4 0 0
0 0 0 6 0 0
0 0 0 3 0 0