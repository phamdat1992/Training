program Fair; {Dijkstra thuan tuy}
const
  InputFile  = 'FAIR.INP';
  OutputFile = 'FAIR.OUT';
  dx: array[1..4] of Integer = (1, -1, 0, 0);
  dy: array[1..4] of Integer = (0, 0, 1, -1);
  max = 100;
  maxC = 10001;
type
  TMatrix = array[0..max + 1, 0..max + 1] of Integer;
var
  a, d, Trace: TMatrix;
  resx, resy, distance, m, n, nHeap: Integer;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for i := 0 to m + 1 do
    for j := 0 to n + 1 do a[i, j] := -1;
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, a[i, j]);
      Readln(f);
    end;
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  for i := 1 to m do
    for j := 1 to n - 1 do d[i, j] := maxC;
  for i := 1 to m do
    d[i, n] := a[i, n];
end;

procedure Dijkstra;
var
  di, ux, uy, vx, vy, i, j, min: Integer;
begin
  repeat
    min := maxC;
    for i := 1 to m do
      for j := 1 to n do
        if (a[i, j] >= 0) and (d[i, j] < min) then
          begin
            min := d[i, j];
            ux := i; uy := j;
          end;
    if uy = 1 then
      begin
        resx := ux;
        resy := uy;
        Exit;
      end;
    a[ux, uy] := -1;
    for di := 1 to 4 do
      begin
        vx := ux + dx[di]; vy := uy + dy[di];
        if (a[vx, vy] >= 0) and (d[vx, vy] > d[ux, uy] + a[vx, vy]) then
          begin
            d[vx, vy] := d[ux, uy] + a[vx, vy];
            Trace[vx, vy] := di;
          end;
      end;
  until False;
end;

procedure Result;
var
  f: Text;
  nextx, nexty, di: Integer;
begin
  Distance := d[resx, resy];
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Distance);
  repeat
    Writeln(f, resx, ' ', resy);
    di := Trace[resx, resy];
    resx := resx - dx[di];
    resy := resy - dy[di];
  until resy = n;
  Writeln(f, resx, ' ', resy);
  Close(f);
end;

begin
  Enter;
  Init;
  Dijkstra;
  Result;
end.
6 5
 1  1  1  1 17
 9  7  7  1 12
 9  2  1  1 10
10 10  1 10 10
10 10  1  2  3
10 10 10 10 10
