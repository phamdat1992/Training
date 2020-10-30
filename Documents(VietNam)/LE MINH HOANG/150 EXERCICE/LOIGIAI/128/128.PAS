program Fair; {Dijkstra voi cau truc Heap}
const
  InputFile  = 'FAIR.INP';
  OutputFile = 'FAIR.OUT';
  dx: array[1..4] of Integer = (1, -1, 0, 0);
  dy: array[1..4] of Integer = (0, 0, 1, -1);
  max = 200;
  maxk = 20;
  maxC = 40001;
type
  TByteBoard = array[-maxk..max + maxk, -maxk..max + maxk] of Byte;
  TWordLine = array[1..max] of Word;
  TWordBoard = array[1..max] of ^TWordLine;
  THeapCmp = array[1..max * max] of Byte;
var
  a: ^TByteBoard;
  Pos, d, Trace: TWordBoard;
  heapX, heapY: ^THeapCmp;
  resx, resy, distance, m, n, k, nHeap: Word;

procedure MemAlloc;
var
  i: Integer;
begin
  New(a);
  for i := 1 to max do
    begin
      New(Pos[i]);
      New(d[i]);
      New(Trace[i]);
      FillChar(Trace[i]^, SizeOf(Trace[i]^), 0);
    end;
  New(heapX); New(heapY);
  FillChar(heapX^, SizeOf(heapX^), 0);
  FillChar(heapY^, SizeOf(heapY^), 0);
end;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, k);
  FillChar(a^, SizeOf(a^), $FF);
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, a^[i, j]);
      Readln(f);
    end;
  Close(f);
end;

procedure Push(x, y: Integer);
var
  r, c, tx, ty: Word;
begin
  c := pos[x]^[y];
  if c = 0 then
    begin
      Inc(nHeap);
      c := nHeap;
    end;
  r := c shr 1;
  while r > 0 do
    begin
      tx := heapX^[r]; ty := heapY^[r];
      if d[tx]^[ty] <= d[x]^[y] then Break;
      heapX^[c] := heapX^[r];
      heapY^[c] := heapY^[r];
      pos[tx]^[ty] := c;
      c := r;
      r := c shr 1;
    end;
  heapX^[c] := x;
  heapY^[c] := y;
  pos[x]^[y] := c;
end;

procedure Pop(var x, y: Integer);
var
  tx, ty, r, c: Integer;
begin
  x := heapX^[1];
  y := heapY^[1];
  tx := heapX^[nHeap];
  ty := heapY^[nHeap];
  Dec(nHeap);
  r := 1;
  while r shl 1 <= nHeap do
    begin
      c := r shl 1;
      if (c < nHeap) and
         (d[heapX^[c]]^[heapY^[c]] > d[heapX^[c + 1]]^[heapY^[c + 1]]) then
           Inc(c);
      if d[tx]^[ty] <= d[heapX^[c]]^[heapY^[c]] then Break;
      heapX^[r] := heapX^[c];
      heapY^[r] := heapY^[c];
      Pos[heapX^[r]]^[heapY^[r]] := r;
      r := c;
    end;
  heapX^[r] := tx;
  heapY^[r] := ty;
  Pos[tx]^[ty] := r;
end;

procedure Init;
var
  i, j: Integer;
begin
  for i := 1 to m do
    begin
      for j := 1 to n do d[i]^[j] := maxC;
      FillChar(Pos[i]^, SizeOf(Pos[i]^), 0);
    end;
  nHeap := 0;
  for i := 1 to m do
    begin
      d[i]^[1] := a^[i, 1];
      Push(i, 1);
    end;
end;

procedure BFS1(tx, ty: Integer);
var
  i, j, di: Integer;
  td, TraceCode: Word;
begin
  td := d[tx]^[ty];
  TraceCode := LongInt(tx) shl 8 + ty;
  if a^[tx, ty] = 0 then
    begin
      for i := - k to k do
        for j := -(k - Abs(i)) to (k - Abs(i)) do
          if (a^[tx + i, ty + j] <> $FF) and (d[tx + i]^[ty + j] > td) then
            begin
              d[tx + i]^[ty + j] := td;
              Trace[tx + i]^[ty + j] := TraceCode;
              Push(tx + i, ty + j);
            end;
    end
  else
    for di := 1 to 4 do
      begin
        i := tx + dx[di]; j := ty + dy[di];
        if (a^[i, j] <> $FF) and (d[i]^[j] > td + a^[i, j]) then
          begin
            d[i]^[j] := td + a^[i, j];
            Trace[i]^[j] := TraceCode;
            Push(i, j);
          end;
      end;
end;

procedure Dijkstra;
var
  tx, ty: Integer;
begin
  repeat
    Pop(tx, ty);
    if ty = n then
      begin
        ResX := tx; ResY := ty;
        Break;
      end;
    BFS1(tx, ty);
    a^[tx][ty] := $FF;
  until False;
end;

function Adjance(x1, y1, x2, y2: Integer): Boolean;
begin
  Adjance := Abs(x1 - x2) + Abs(y1 - y2) = 1;
end;

procedure Move(var sx, sy: Integer; tx, ty: Integer);
begin
  if sx <> tx then
    begin
      if sx < tx then Inc(sx) else Dec(sx);
      Exit;
    end;
  if sy < ty then Inc(sy) else Dec(sy);
end;

procedure Result;
var
  f: Text;
  i: Word;
  x, y, tx, ty: Integer;
begin
  Distance := d[resX]^[resY];
  tx := resX; ty := resY;
  nHeap := 0;
  repeat
    Inc(nHeap);
    heapX^[nHeap] := tx; heapY^[nHeap] := ty;
    x := Trace[tx]^[ty] shr 8;
    y := Trace[tx]^[ty] and 255;
    while not Adjance(x, y, tx, ty) do
      begin
        Move(tx, ty, x, y);
        Inc(nHeap);
        HeapX^[nHeap] := tx;
        HeapY^[nHeap] := ty;
      end;
    tx := x; ty := y;
  until ty = 1;
  Inc(nHeap);
  HeapX^[nHeap] := tx;
  HeapY^[nHeap] := ty;
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Distance);
  for i := nHeap downto 1 do Writeln(f, heapX^[i], ' ', heapY^[i]);
  Close(f);
end;

begin
  MemAlloc;
  Enter;
  Init;
  Dijkstra;
  Result;
end.
6 4 2
 5  1  1  1
 0  7  7  7
 9  2  2  1
10  1 10 10
10  1  2  3
10 10 10 10

6 7 2
1  5  1  1  1  1 17
4  0  7  7  7  1 12
9  9  2  2  1  1 10
9 10 10 10  1 10 10
9 10 10 10  1  2  3
9 10 10 10 10 10 10
