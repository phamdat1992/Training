program InternationalWomenDay;
const
 InputFile  = 'FLOWERS.INP';
 OutputFile = 'FLOWERS.OUT';
 max = 200;
var
 a: array[1..max, 1..max] of Boolean;
 Numbering, Low, cCount: array[1..max] of Integer;
 n, count, nFlowers, FoundHead: Integer;

procedure Enter;
var
 f: Text;
 u, v: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 FillChar(a, SizeOf(a), False);
 while not SeekEof(f) do
  begin
   Readln(f, u, v);
   a[u, v] := True;
  end;
 Close(f);
end;

procedure Init;
begin
 FillChar(Numbering, SizeOf(Numbering), 0);
 count := 0;
end;

function Min(a, b: Integer): Integer;
begin
 if a < b then Min := a else Min := b;
end;

procedure Visit(u: Integer);
var
 v: Integer;
begin
 Inc(Count);
 Numbering[u] := Count; Low[u] := Numbering[u];
 CCount[u] := 1;
 for v := 1 to n do
  if a[u, v] then
   if Numbering[v] <> 0 then Low[u] := Min(Low[u], Numbering[v])
   else
    begin
     Visit(v);
     Low[u] := Min(Low[u], Low[v]);
     CCount[u] := CCount[u] + CCount[v];
    end;
end;

procedure Solve;
var
 u : Integer;
begin
 for u := 1 to n do
  if Numbering[u] = 0 then Visit(u);
 nFlowers := maxInt;
 for u := 1 to n do
  if (Low[u] = Numbering[u]) and (CCount[u] < nFlowers) then
   begin
    nFlowers := CCount[u];
    FoundHead := u;
   end;
end;

procedure Result;
var
 f: Text;
 Selected, notSelected: set of Byte;
 u: Integer;
 procedure DFS(u: Integer);
 var
  v: Integer;
 begin
  Include(Selected, (u)); Exclude(notSelected, (u));
  for v := 1 to n do
   if (v in notSelected) and a[u, v] then DFS(v);
 end;

begin
 Selected := []; notSelected := [1..n];
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, nFlowers);
 DFS(FoundHead);
 for u := 1 to n do
  if u in Selected then Write(f, u, ' ');
 Close(f);
end;

begin
 Enter;
 Init;
 Solve;
 Result;
end.
12
1 2
1 3
1 4
2 10
3 8
3 10
4 5
5 6
6 7
7 4
8 9
9 3
10 11
11 12
12 2
12 10
