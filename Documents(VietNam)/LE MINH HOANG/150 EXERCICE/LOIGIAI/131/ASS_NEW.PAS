{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program Assignment;
const
  fi = 'assign.inp';
  fo = 'assign.out';
  Max = 400;
  MaxC = 4000001;
type
  ArrA = array[1..Max] of Integer;
var
  a: array[0..Max] of ^ArrA;
  Loai, Mx, My, Trace, q, lm, lt: array[1..Max] of Integer;
  fx, fy, Dis: array[1..Max] of LongInt;
  CMin: ArrA;
  n, m, k, r, Finish, Start, lo, hi, sl0: Integer;
  Sum: LongInt;
  f: Text;

procedure ReadFile;
var
  u, v: Integer;
begin
  for u := 0 to Max do
  begin
    New(a[u]);
    for v := 1 to Max do a[u]^[v] := -1;
  end;
  Assign(f, fi); Reset(f);
  ReadLn(f, m, n, r);
  for u := 1 to m do
    Read(f, Loai[u]);
  ReadLn(f);
  while not SeekEof(f) do
    ReadLn(f, u, v, a[u]^[v]);
  Close(f);
end;

procedure CommonInit;
var
  x, y: Integer;
begin
  if m > n then k := m
  else k := n;
  for x := m + 1 to k do
    Loai[x] := 0; { neu m < n thi can phai thue sieu nhan }
  for y := 1 to n do
  begin
    CMin[y] := MaxInt;
    for x := 1 to r do
      if (a[x]^[y] <> -1) and (a[x]^[y] < CMin[y]) then
      begin
        CMin[y] := a[x]^[y];
        lm[y] := x;
      end;
  end;
  a[0]^ := CMin; { Sieu nhan lam viec gi cung tot bang nguoi tot nhat }
end;

function c(x, y: Integer): LongInt;
begin
  if a[Loai[x]]^[y] = -1 then c := MaxC
  else c := a[Loai[x]]^[y];
end;

procedure Init;
var
  x, y: Integer;
begin
  FillChar(Mx, SizeOf(Mx), 0);
  FillChar(My, SizeOf(My), 0);
  for x := 1 to k do
  begin
    fx[x] := MaxC;
    for y := 1 to k do
      if c(x, y) < fx[x] then fx[x] := c(x, y);
  end;
  for y := 1 to k do
  begin
    fy[y] := MaxC;
    for x := 1 to k do
      if c(x, y) - fx[x] < fy[y] then fy[y] := c(x, y) - fx[x];
  end;
end;

procedure InitBfs;
var
  y: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  lo := 1; hi := 1;
  q[1] := Start;
  for y := 1 to k do
  begin
    Dis[y] := MaxC;
    lt[y] := Start;
  end;
end;

procedure FindPath;
var
  u, v: Integer;
  t: LongInt;
begin
  while lo <= hi do
  begin
    u := q[lo];
    Inc(lo);
    for v := 1 to k do
      if Trace[v] = 0 then
      begin
        t := c(u, v) - fx[u] - fy[v];
        if (Mx[u] <> v) and (t = 0) then
        begin
          Trace[v] := u;
          if My[v] = 0 then
          begin
            Finish := v;
            Exit;
          end;
          Inc(hi);
          q[hi] := My[v];
        end
        else
          if t < Dis[v] then
          begin
            Dis[v] := t;
            lt[v] := u;
          end;
      end;
  end;
end;

procedure Update;
var
  delta: LongInt;
  x, y: Integer;
begin
  delta := MaxC;
  for y := 1 to k do
    if (Trace[y] = 0) and (Dis[y] < delta) then delta := Dis[y];
  Inc(fx[Start], delta);
  for y := 1 to k do
    if Trace[y] <> 0 then
    begin
      x := My[y];
      Inc(fx[x], delta);
      Dec(fy[y], delta);
    end;
  for y := 1 to k do
    if Trace[y] = 0 then
    begin
      Dec(Dis[y], delta);
      if Dis[y] = 0 then
      begin
        Trace[y] := lt[y];
        if My[y] = 0 then
        begin
          Finish := y; { tim duoc duong roi ta se init queue lai tu dau }
          Exit;
        end;
        Inc(hi);
        q[hi] := My[y];
      end;
    end;
end;

procedure Enlarge(y: Integer);
var
  x, Next: Integer;
begin
  repeat
    x := Trace[y];
    Next := Mx[x];
    Mx[x] := y;
    My[y] := x;
    y := Next;
  until y = 0;
end;

procedure FindMatch;
var
  i: Integer;
begin
  for i := 1 to k do
  begin
    Start := i;
    InitBfs;
    Finish := 0;
    repeat
      FindPath;
      if Finish = 0 then Update;
    until Finish > 0;
    Enlarge(Finish);
  end;
end;

procedure Done;
var
  x, y, l: Integer;
begin
  for x := 1 to k do
  begin
    y := Mx[x];
    if c(x, y) = MaxC then Loai[x] := 0;
  end;
  l := 0;
  for x := 1 to k do
    if Loai[x] <> 0 then
    begin
      Inc(l);
      Loai[l] := Loai[x];
    end;
  for x := l + 1 to n do Loai[x] := 0;
  k := n;
  Init;
  FindMatch;
end;

procedure WriteFile;
var
  sl, x, y: Integer;
begin
  sl := 0;
  Sum := 0;
  for y := 1 to n do
  begin
    x := My[y];
    Inc(Sum, c(x, y));
    if Loai[x] = 0 then
    begin
      Inc(sl);
      Loai[x] := lm[y];
    end;
  end;
  Assign(f, fo); Rewrite(f);
  WriteLn(f, sl, ' ', Sum);
  for y := 1 to n do
    WriteLn(f, Loai[My[y]]);
  Close(f);
end;

begin
  ReadFile;
  CommonInit;
  Init;
  FindMatch;
  Done;
  WriteFile;
end.