{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O+,P+,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program City;
const
  fi = 'city.inp';
  fo = 'city.out';
  MaxN = 200;
  MaxLong = 1000111000;
type
  Line = array[1..MaxN] of LongInt;
var
  d: array[1..MaxN] of ^Line;
  a: array[1..MaxN, 1..MaxN] of Boolean;
  PMark: Pointer;
  n, m: Integer;
  f: Text;

  OldTime: LongInt;
  Time: LongInt absolute 0:$46C;

procedure ReadFile;
var
  i: Integer;
  u, v: Byte;
begin
  Mark(PMark);
  for u := 1 to MaxN do
  begin
    New(d[u]);
    for v := 1 to MaxN do d[u]^[v] := MaxLong;
  end;
  Assign(f, fi); Reset(f);
  Readln(f, n, m);
  FillChar(a, SizeOf(a), False);
  for i := 1 to m do
  begin
    Readln(f, u, v, d[u]^[v]);
    d[v]^[u] := d[u]^[v];
    a[u, v] := True;
    a[v, u] := True;
  end;
  Close(f);
end;

procedure Floy;
var
  i, j, k: Byte;
begin
  for k := 1 to n do
    for i := 1 to n - 1 do
      if d[i]^[k] < MaxLong then
        for j := i + 1 to n do
          if (j <> k) and (d[i]^[j] >= d[i]^[k] + d[k]^[j]) then
          begin
            d[i]^[j] := d[i]^[k] + d[k]^[j];
            d[j]^[i] := d[i]^[j];
            a[i, j] := False;
            a[j, i] := False;
          end;
end;

procedure WriteFile;
var
  Count, Sum: LongInt;
  i, j: Byte;
begin
  Count := 0;
  Sum := 0;
  for i := 1 to n - 1 do
    for j := i + 1 to n do
      if a[i, j] then
      begin
        Inc(Sum, d[i]^[j]);
        Inc(Count);
      end;
  Assign(f, fo); Rewrite(f);
  Writeln(f, Count, ' ', Sum);
  for i := 1 to n - 1 do
    for j := i + 1 to n do
      if a[i, j] then Writeln(f, i, ' ', j);
  Close(f);
  Release(PMark);
end;

begin
  OldTime := Time;
  ReadFile;
  Floy;
  WriteFile;
  Writeln(Time - OldTime);
end.