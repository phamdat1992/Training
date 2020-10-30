{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R-,S+,T-,V+,X+}
{$M 65520,0,655360}
const
  fi = 'horses.in8';
  fo = 'horses.out';
  H1: array[1..8] of ShortInt = (1, 1, 2, 2, -1, -1, -2, -2);
  H2: array[1..8] of ShortInt = (2, -2, 1, -1, 2, -2, 1, -1);
  MaxLong = 1000000000;
type
  Rec = record
    u, v: ShortInt;
  end;
  queue = array[1..10000] of Rec;
var
  a: array[-1..102, -1..102] of Char;
  q: ^queue;
  luuD, luuM: array[1..100] of Rec;
  Fx, Fy: array[1..100] of LongInt;
  Mx, My, Trace: array[1..100] of Byte;
  Vx, Vy: array[1..100] of Boolean;
  bD, bM: array[1..100, 1..100] of Byte;
  c: array[1..100, 1..100] of Word;
  Time: LongInt absolute 0:$46C;
  OldTime: LongInt;
  n, m: ShortInt;
  f: Text;

procedure ReadFile;
var
  i, j: ShortInt;
  ch: Char;
begin
  Assign(f, fi); Reset(f);
  FillChar(a, SizeOf(a), 'C');
  Readln(f, n);
  for i := 1 to n do
  begin
    for j := 1 to n do Read(f, a[i, j]);
    Readln(f);
  end;
  Close(f);
end;

procedure Bfs(sx, sy: ShortInt);
var
  u, v, lu, lv, k: ShortInt;
  d: array[1..10000] of Integer;
  Free: array[1..100, 1..100] of Boolean;
  l, r, New: Integer;
begin
  FillChar(Free, SizeOf(Free), True);
  l := 1;
  r := 1;
  q^[1].u := sx;
  q^[1].v := sy;
  Free[sx, sy] := False;
  d[1] := 0;
  repeat
    lu := q^[l].u;
    lv := q^[l].v;
    New := d[l] + 1;
    Inc(l);
    for k := 1 to 8 do
    begin
      u := lu + H1[k];
      v := lv + H2[k];
      if (a[u, v] <> 'C') and Free[u, v] then
      begin
        Free[u, v] := False;
        Inc(r);
        q^[r].u := u;
        q^[r].v := v;
        d[r] := New;
        if bD[u, v] <> 0 then c[bM[sx, sy], bD[u, v]] := New;
      end;
    end;
  until l > r;
end;

procedure Init;
var
  u, v, i: ShortInt;
begin
  New(q);
  m := 0;
  FillChar(bD, SizeOf(bD), 0);
  for u := 1 to n do
    for v := 1 to n do
      if a[u, v] = 'D' then
      begin
        Inc(m);
        bD[u, v] := m;
        luuD[m].u := u;
        luuD[m].v := v;
      end;
  m := 0;
  FillChar(bM, SizeOf(bM), 0);
  for u := 1 to n do
    for v := 1 to n do
      if a[u, v] = 'S' then
      begin
        Inc(m);
        bM[u, v] := m;
        luuM[m].u := u;
        luuM[m].v := v;
      end;
  for u := 1 to m do
    for v := 1 to m do c[u, v] := MaxInt;
  for i := 1 to m do
    Bfs(luuM[i].u, luuM[i].v);
end;

procedure InitMatch;
var
  i, j: ShortInt;
begin
  for i := 1 to n do
  begin
    Fx[i] := MaxLong;
    for j := 1 to n do
      if c[i, j] < Fx[i] then Fx[i] := c[i, j];
  end;
  FillChar(Fy, SizeOf(Fy), 0);
  FillChar(Mx, SizeOf(Mx), 0);
  FillChar(My, SizeOf(My), 0);
end;

function FindPath(Start: ShortInt): ShortInt;
var
  q: array[1..100] of ShortInt;
  l, r, x, y: Byte;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  FillChar(Vx, SizeOf(Vx), False);
  FillChar(Vy, SizeOf(Vy), False);
  l := 1;
  r := 1;
  q[1] := Start;
  Vx[Start] := True;
  repeat
    x := q[l];
    Inc(l);
    for y := 1 to m do
      if (Trace[y] = 0) and (My[y] <> x) and
        (c[x, y] < MaxInt) and (Fx[x] + Fy[y] = LongInt(c[x, y])) then
      begin
        Trace[y] := x;
        if My[y] = 0 then
        begin
          FindPath := y;
          Exit;
        end;
        Vy[y] := True;
        Vx[My[y]] := True;
        Inc(r);
        q[r] := My[y];
      end;
  until l > r;
  FindPath := 0;
end;

procedure GoOut;
begin
  Assign(f, fo); Rewrite(f);
  Write(f, -1);
  Close(f);
  Writeln(Time - OldTime);
  Halt;
end;

procedure Fix;
var
  Delta: LongInt;
  x, y: ShortInt;
begin
  Delta := MaxLong;
  for x := 1 to m do
    if Vx[x] then
      for y := 1 to m do
        if not Vy[y] and (c[x, y] < MaxInt) and (Delta > LongInt(c[x, y]) - Fx[x] - Fy[y]) then
          Delta := c[x, y] - Fx[x] - Fy[y];
  if Delta = MaxLong then GoOut;
  for x := 1 to m do
    if Vx[x] then Inc(Fx[x], Delta);
  for y := 1 to m do
    if Vy[y] then Dec(Fy[y], Delta);
end;

procedure IncMatch(y: ShortInt);
var
  x, Next: ShortInt;
begin
  repeat
    x := Trace[y];
    Next := Mx[x];
    Mx[x] := y;
    My[y] := x;
    y := Next;
  until y = 0;
end;

procedure Process;
var
  i, j: ShortInt;
begin
  InitMatch;
  for i := 1 to m do
  begin
    repeat
      j := FindPath(i);
      if j <> 0 then Break;
      Fix;
    until False;
    IncMatch(j);
  end;
end;

procedure GoBack(sx, sy, fx, fy: ShortInt);
var
  l, r: Integer;
  Trace: array[1..100, 1..100] of Rec;
  Free: array[1..100, 1..100] of Boolean;
  u, v, lu, lv, k: ShortInt;
begin
  FillChar(Free, SizeOf(Free), True);
  l := 1;
  r := 1;
  q^[1].u := fx;
  q^[1].v := fy;
  Free[fx, fy] := False;
  Trace[fx, fy].u := 0;
  Trace[fx, fy].v := 0;
  while Free[sx, sy] do
  begin
    lu := q^[l].u;
    lv := q^[l].v;
    Inc(l);
    for k := 1 to 8 do
    begin
      u := lu + H1[k];
      v := lv + H2[k];
      if (a[u, v] <> 'C') and Free[u, v] then
      begin
        Free[u, v] := False;
        Inc(r);
        q^[r].u := u;
        q^[r].v := v;
        Trace[u, v].u := lu;
        Trace[u, v].v := lv;
      end;
    end;
  end;
  while Trace[sx, sy].u <> 0 do
  begin
    Writeln(f, sx, ' ', sy, ' ', Trace[sx, sy].u, ' ', Trace[sx, sy].v);
    lu := sx;
    lv := sy;
    sx := Trace[lu, lv].u;
    sy := Trace[lu, lv].v;
  end;
end;

procedure WriteFile;
var
  i, j: ShortInt;
  Sum: LongInt;
begin
  Assign(f, fo); Rewrite(f);
  Sum := 0;
  for i := 1 to m do Inc(Sum, c[i, Mx[i]]);
  if Sum >= MaxLong then Write(f, -1)
  else
  begin
    Writeln(f, Sum);
    for i := 1 to m do
    begin
      j := Mx[i];
      GoBack(LuuM[i].u, LuuM[i].v, LuuD[j].u, LuuD[j].v);
    end;
  end;
  Close(f);
  Dispose(q);
end;

begin
  OldTime := Time;
  ReadFile;
  Init;
  Process;
  WriteFile;
  Writeln(Time - OldTime);
end.