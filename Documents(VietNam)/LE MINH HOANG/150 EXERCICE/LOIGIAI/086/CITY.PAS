{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program City; { Bai chay cuc rua. }
const
  fi = 'city.inp';
  fo = 'city.out';
  MaxN = 200;
  MaxM = MaxN * (MaxN - 1) div 2;
  MaxLong = 100000000;
type
  Canh = record
    u, v: Byte;
  end;
  Arra = array[1..MaxM] of Integer;
  Line = array[1..MaxN] of LongInt;
var
  a: array[1..MaxM] of Canh;
  d: array[1..MaxN] of ^Line;
  b: ^Arra;
  n, m, Count: Integer;
  Sum: LongInt;
  f: Text;

  OldTime: LongInt;
  Time: LongInt absolute 0:$46C;

procedure ReadFile;
var
  k, c: integer;
begin
  New(b);
  for k := 1 to MaxN do New(d[k]);
  Assign(f, fi); Reset(f);
  Readln(f, n, m);
  for k := 1 to m do
    with a[k] do Readln(f, u, v, b^[k]);
  Close(f);
end;

procedure Swap(i, j: Integer);
var
  temp: Canh;
  t: Integer;
begin
  t := b^[i]; b^[i] := b^[j]; b^[j] := t;
  temp := a[i]; a[i] := a[j]; a[j] := temp;
end;

procedure RSort(l, r, Mask: Integer);
var
  i, j: Integer;
begin
  i := l;
  j := r;
  repeat
    while (i <= j) and (b^[i] and Mask = 0) do Inc(i);
    while (i <= j) and (b^[j] and Mask > 0) do Dec(j);
    if i < j then
    begin
      Swap(i, j);
      Inc(i); Dec(j);
    end;
  until i > j;
  if Mask > 1 then
  begin
    Mask := Mask shr 1;
    if i < r then RSort(i, r, Mask);
    if j > l then RSort(l, j, Mask);
  end;
end;

procedure Update(u, v: Byte);
var
  i, j: LongInt;
  iv, iu, uv: LongInt;
begin
  uv := d[u]^[v];
  for i := 1 to n - 1 do
  begin
    if d[i]^[u] > d[i]^[v] + uv then
    begin
      d[i]^[u] := d[i]^[v] + uv;
      d[u]^[i] := d[i]^[u];
    end;
    if d[i]^[v] > d[i]^[u] + uv then
    begin
      d[i]^[v] := d[i]^[u] + uv;
      d[v]^[i] := d[i]^[v];
    end;
    iu := d[i]^[u];
    iv := d[i]^[v];
    if (iu < MaxLong) or (iv < MaxLong) then
    for j := i + 1 to n do
    begin
      if d[i]^[j] > iu + uv + d[v]^[j] then
      begin
        d[i]^[j] := iu + uv + d[v]^[j];
        d[j]^[i] := d[i]^[j];
      end;
      if d[j]^[i] > d[j]^[u] + uv + iv then
      begin
        d[j]^[i] := d[j]^[u] + uv + iv;
        d[i]^[j] := d[j]^[i];
      end;
    end;
  end;
end;

procedure Tree;
var
  i: Integer;
  x, y: Byte;
begin
  for x := 1 to n - 1 do
  begin
    d[x]^[x] := 0;
    for y := x + 1 to n do
    begin
      d[x]^[y] := MaxLong;
      d[y]^[x] := MaxLong;
    end;
  end;
  Count := 0; Sum := 0;
  for i := 1 to m do
    with a[i] do
    begin
      if d[u]^[v] > b^[i] then
      begin
        d[u]^[v] := b^[i];
        d[v]^[u] := b^[i];
        Inc(Sum, b^[i]);
        b^[i] := -b^[i];
        Inc(Count);
        Update(u, v);
      end;
    end;
end;

procedure WriteFile;
var
  i: Integer;
begin
  Assign(f, fo); Rewrite(f);
  Writeln(f, Count, ' ', Sum);
  for i := 1 to m do
    if b^[i] < 0 then Writeln(f, a[i].u, ' ', a[i].v);
  Close(f);
  Dispose(b);
  for i := 1 to MaxN do Dispose(d[i]);
end;

begin
  OldTime := Time;
  ReadFile;
  RSort(1, m, 1 shl 13);
  Tree;
  WriteFile;
  Writeln(Time - OldTime);
end.