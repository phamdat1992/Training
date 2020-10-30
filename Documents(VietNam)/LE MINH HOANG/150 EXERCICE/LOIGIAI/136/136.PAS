program Traffic;
const
  InputFile  = 'TRAFFIC.INP';
  OutputFile = 'TRAFFIC.OUT';
  max = 100;
  maxC = 60000;
  dx: array[1..4] of Integer = (0, 0, 1, -1);
  dy: array[1..4] of Integer = (1, -1, 0, 0);
  direction: array[1..4] of Char = 'EWSN';
  cc: Integer = 99;
type
  Tdistance = array[1..max, 1..max] of Word;
  TTrace = array[1..max, 1..max] of ShortInt;
  THeap = array[1..max * max, 1..2] of Byte;
var
  a: array[1..max, 1..max] of Byte;
  pos: array[1..max, 1..max] of Word;
  t1, t2, Trace: ^TTrace;
  d1, d2, din, dout: ^Tdistance;
  heap: ^THeap;
  m, n, S, nHeap, resX, resY: Integer;
  res: Word;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n, cc, S);
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, a[i, j]);
      Readln(f);
    end;
  Close(f);
end;

procedure Init(x, y: Integer);
var
  i, j: Integer;
begin
  for i := 1 to m do
    for j := 1 to n do
      begin
        din^[i, j] := maxC;
        dout^[i, j] := MaxC;
      end;
  din^[x, y] := S;
  dout^[x, y] := S;
  nHeap := 1;
  heap^[nHeap, 1] := x; heap^[nHeap, 2] := y;
  FillChar(pos, SizeOf(pos), 0);
  pos[x, y] := 1;
end;

function GetD(i: Integer): Word;
begin
  GetD := dout^[heap^[i, 1], heap^[i, 2]];
end;

procedure Pop(var x, y: Integer);
var
  tmp: Word;
  r, c: Integer;
begin
  x := heap^[1, 1]; y := heap^[1, 2];
  tmp := GetD(nHeap);
  r := 1;
  while r * 2 < nHeap do
    begin
      c := r * 2;
      if (c + 1 < nHeap) and (GetD(c + 1) < GetD(c)) then Inc(c);
      if tmp <= GetD(c) then Break;
      heap^[r] := heap^[c];
      pos[heap^[r, 1], heap^[r, 2]] := r;
      r := c;
    end;
  heap^[r] := heap^[nHeap];
  pos[heap^[r, 1], heap^[r, 2]] := r;
  Dec(nHeap);
end;

procedure Push(x, y: Integer);
var
  r, c: Integer;
  tmp: Word;
begin
  c := Pos[x, y];
  if c = 0 then
    begin
      Inc(nHeap); c := nHeap;
    end;
  tmp := dout^[x, y];
  r := c div 2;
  while (r > 0) and (GetD(r) > tmp) do
    begin
      heap^[c] := heap^[r];
      pos[heap^[c, 1], heap^[c, 2]] := c;
      c := r;
      r := c div 2;
    end;
  heap^[c, 1] := x; heap^[c, 2] := y;
  pos[x, y] := c;
end;

procedure Update(x, y: Integer);
var
  d, newx, newy, signal: Integer;
  newd: Word;

  function Inside(i, j: Integer): Boolean;
  begin
    Inside := (i >= 1) and (i <= m) and (j >= 1) and (j <= n);
  end;

begin
  for d := 1 to 4 do
    begin
      newx := x + dx[d]; newy := y + dy[d];
      if Inside(newx, newy) then
        begin
          newd := dout^[x, y] + cc;
          if newd < din^[newx, newy] then
            begin
              din^[newx, newy] := newd;
              Trace^[newx, newy] := Trace^[newx, newy] and $0F or (d shl 4);
            end;
          if a[newx, newy] <> 0 then
            begin
              signal := newd div a[newx, newy];
              if odd(signal) and (d <= 2)
                 or not odd(signal) and (d >= 3) then
                   newd := (signal + 1) * a[newx, newy];
            end;
          if newd < dout^[newx, newy] then
            begin
              dout^[newx, newy] := newd;
              Trace^[newx, newy] := Trace^[newx, newy] and $F0 or d;
              Push(newx, newy);
            end;
        end;
    end;
end;

procedure Dijkstra(startX, startY: Integer);
var
  x, y: Integer;
begin
  Init(startX, startY);
  repeat
    Pop(x, y);
    Update(x, y);
  until nHeap = 0;
end;

procedure GetPos;
var
  i, j: Integer;
  time1, time2, Local: Word;
begin
  Res := MaxC;
  for i := 1 to m do
    for j := 1 to n do
      begin
        time1 := d1^[i, j]; time2 := d2^[i, j];
        if time1 > time2 then Local := time1 else Local := time2;
        if Local < Res then
          begin
            Res := Local;
            resX := i; resY := j;
          end;
      end;
end;

procedure Result;
var
  f: Text;
  x, y, d, i: Integer;
  path: array[1..max * max] of Char;
  nPath: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, res);
  Trace := t1;
  x := resx; y := resy; npath := 0;
  if (x <> 1) or (y <> 1) then
    begin
      d := Trace^[x, y] shr 4;
      Inc(nPath); Path[nPath] := direction[d];
      x := x - dx[d]; y := y - dy[d];
      while (x <> 1) or (y <> 1) do
        begin
          d := Trace^[x, y] and $0F;
          Inc(nPath); Path[nPath] := direction[d];
          x := x - dx[d]; y := y - dy[d];
        end;
    end;
  for i := nPath downto 1 do Write(f, path[i]);
  writeln(f);

  Trace := t2;
  x := resx; y := resy; npath := 0;
  if (x <> m) or (y <> n) then
    begin
      d := Trace^[x, y] shr 4;
      Inc(nPath); Path[nPath] := direction[d];
      x := x - dx[d]; y := y - dy[d];
      while (x <> m) or (y <> n) do
        begin
          d := Trace^[x, y] and $0F;
          Inc(nPath); Path[nPath] := direction[d];
          x := x - dx[d]; y := y - dy[d];
        end;
    end;
  for i := nPath downto 1 do Write(f, path[i]);

  Close(f);
end;

begin
  Enter;
  New(heap);
  New(dout);
  New(din); New(Trace);
  Dijkstra(1, 1);
  d1 := din; t1 := Trace;

  New(din); New(Trace);
  Dijkstra(m, n);
  d2 := din; t2 := Trace;
  GetPos;
  Result;
end.
3 4 100
0   100 100 100
100 0   0   0
100 0   0   0