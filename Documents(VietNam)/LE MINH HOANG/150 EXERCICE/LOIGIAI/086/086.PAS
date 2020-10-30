program CityRoad;
const
 InputFile  = 'CITY.INP';
 OutputFile = 'CITY.OUT';
 max = 200;
 maxC = 2000000001;
type
 TLine  = array[1..max] of LongInt;
var
 c: array[1..max] of ^TLine;
 a: array[1..max, 1..max] of Boolean;
 n: Integer;

procedure Enter;
var
 f: Text;
 i, m, u, v: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n, m);
 FillChar(a, SizeOf(a), False);
 for u := 1 to n do
  begin
   New(c[u]);
   for v := 1 to n do
    if u = v then c[u]^[v] := 0 else c[u]^[v] := maxC;
  end;
 for i := 1 to m do
  begin
   Readln(f, u, v, c[u]^[v]);
   c[v]^[u] := c[u]^[v];
   a[u, v] := True; a[v, u] := True;
  end;
 Close(f);
end;

procedure Floyd;
var
 k, u, v: Integer;
begin
 for k := 1 to n do
  for u := 1 to n do
   if (u <> k) and (c[u]^[k] <> maxC) then
    for v := u + 1 to n do
     if (k <> v) and (c[k]^[v] <> maxC) and
        (c[u]^[v] >= c[u]^[k] + c[k]^[v]) then
      begin
       c[u]^[v] := c[u]^[k] + c[k]^[v];
       c[v]^[u] := c[u]^[v];
       a[u, v] := False;
       a[v, u] := False;
      end;
end;

procedure Result;
var
 f: Text;
 u, v, count: Integer;
 Total: LongInt;
begin
 Total := 0; count := 0;
 for u := 1 to n do
  for v := u + 1 to n do
   if a[u, v] then
    begin
     Inc(count);
     Total := Total + c[u]^[v];
    end;
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, count, ' ', Total);
 for u := 1 to n do
  for v := u + 1 to n do
   if a[u, v] then Writeln(f, u, ' ', v);
 Close(f);
end;

begin
 Enter;
 Floyd;
 Result;
end.

10 12
1 2 1
1 5 1
2 6 7
3 4 1
3 7 2
4 8 8
5 6 3
6 7 1
6 9 2
7 8 5
7 10 8
9 10 4

10 13
1 2 1
2 3 1
3 4 1
1 4 3
4 5 1
5 6 1
6 7 1
4 7 3
7 8 1
8 9 2
9 10 3
7 10 6
1 10 12
