program DispatchMessages;
const
  InputFile  = 'MESSAGE.INP';
  OutputFile = 'MESSAGE.OUT';
  max = 700;
type
  TLine = array[1..max] of Boolean;
  PLine = ^TLine;
var
  a: array[1..max] of PLine;
  Free: array[1..max] of Boolean;
  Index: array[1..max] of Integer;
  Count, n: Integer;
  Renumber: Boolean;
  Time: LongInt absolute 0:$46C;
  Start: LongInt;

procedure Enter;
var
  f: Text;
  u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for u := 1 to n do
    begin
      New(a[u]);
      FillChar(a[u]^, SizeOf(a[u]^), False);
    end;
  while not SeekEof(f) do
    begin
      Readln(f, u, v);
      a[u]^[v] := True;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(Free, SizeOf(Free), True);
  Count := 0;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Free[u] := False;
  for v := 1 to n do
    if Free[v] and a[u]^[v] then Visit(v);
  if Renumber then
    begin
      Inc(Count);
      Index[Count] := u;
    end;
end;

procedure Solve;
var
  Selected: array[1..max] of Integer;
  i, nSelected: Integer;
  f: Text;
begin
  {Danh so lai}
  Renumber := True;
  Init;
  for i := 1 to n do
    if Free[i] then Visit(i);
  {DFS mot lan nua}
  nSelected := 0;
  Renumber := False;
  Init;
  for i := n downto 1 do
    if Free[Index[i]] then
      begin
        Inc(nSelected); Selected[nSelected] := Index[i];
        Visit(Index[i]);
      end;
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, nSelected);
  for i := 1 to nSelected do Write(f, Selected[i], ' ');
  Close(f);
end;

begin
  Start := Time;
  Enter;
  Solve;
  Writeln((Time - Start) / 18.2:1:4);
end.

12
1 3
3 6
6 1
6 8
8 12
12 9
9 6
2 4
4 5
5 2
4 6
7 10
10 11
11 7
10 9
