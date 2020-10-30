program Schedule;
const
  InputFile  = 'SCHEDULE.INP';
  OutputFile = 'SCHEDULE.OUT';
  max = 200;
var
  a: array[1..max, 1..max] of Boolean;
  d, list, lab: array[1..max] of Integer;
  n, T, nP: Integer;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for j := 1 to n do
    begin
      repeat
        Read(f, i);
        if i = 0 then Break;
        a[i, j] := True;
      until False;
      Readln(f);
    end;
  Close(f);
end;

procedure Numbering;
var
  first, last: Integer;
  i, j: Integer;
  deg: array[1..max] of Integer;
begin
  FillChar(deg, SizeOf(deg), 0);
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] then Inc(deg[j]);
  last := 0;
  for i := 1 to n do
    if deg[i] = 0 then
      begin
        Inc(last);
        list[last] := i;
        Deg[i] := MaxInt;
      end;
  for first := 1 to n do
    begin
      i := list[first];
      for j := 1 to n do
        if a[i, j] then
          begin
            Dec(deg[j]);
            if deg[j] = 0 then
              begin
                Inc(last); List[last] := j;
                deg[j] := MaxInt;
              end;
          end;
    end;
end;

procedure FindLongestPath;
var
  i, j, u, v: Integer;
begin
  for i := 1 to n do d[i] := 1;
  for i := 1 to n do
    for j := i + 1 to n do
      begin
        u := List[i]; v := List[j];
        if a[u, v] and (d[v] < d[u] + 1) then d[v] := d[u] + 1;
      end;
  T := 0;
  for i := 1 to n do
    if d[i] > T then T := d[i];
end;

procedure SortByLongestPath;
var
  c: array[1..max] of Integer;
  i: Integer;
begin
  FillChar(c, SizeOf(c), 0);
  for i := 1 to n do Inc(c[d[i]]);
  for i := 2 to n do c[i] := c[i - 1] + c[i];
  for i := 1 to n do
    begin
      List[c[d[i]]] := i;
      Dec(c[d[i]]);
    end;
end;

function Arrange(k: Integer): Boolean;
var
  count: array[1..max] of Integer;
  i, u, v, tm: Integer;
begin
  FillChar(count, SizeOf(count), 0);
  for i := n downto 1 do
    begin
      u := List[i];
      tm := T + 1;
      for v := 1 to n do
        if a[u, v] and (Lab[v] < tm) then tm := Lab[v];
      Dec(tm);
      while (tm > 0) and (count[tm] = k) do Dec(tm);
      if tm = 0 then
        begin
          Arrange := False;
          Exit;
        end;
      Lab[u] := tm;
      Inc(count[tm]);
    end;
end;

procedure Solve;
var
  inf, sup, median: Integer;
begin
  inf := 0; sup := n;
  repeat
    median := (inf + sup) div 2;
    if Arrange(median) then sup := median
    else inf := median;
  until inf + 1 >= sup;
  nP := sup;
  Arrange(nP);
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, T, ' ', np);
  for i := 1 to n do Writeln(f, Lab[i]);
  Close(f);
end;

begin
  Enter;
  Numbering;
  FindLongestPath;
  SortByLongestPath;
  Solve;
  Result;
end.
7
0
0
1 2 0
0
2 3 4 0
5 0
4 5 0