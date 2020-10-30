program Fair; {Dijkstra voi cau truc Heap}
const
  InputFile  = 'FAIR.INP';
  OutputFile = 'FAIR.OUT';
  dx: array[1..4] of Integer = (1, -1, 0, 0);
  dy: array[1..4] of Integer = (0, 0, 1, -1);
  max = 100;
  maxC = 10001;
type
  TMatrix = array[0..max + 1, 0..max + 2] of Integer;
  Tarray = array[1..max * (max + 1), 1..2] of Integer;
var
  a, d, Trace: TMatrix;
  Heap: ^Tarray; {Heap^ luu toa do cac o dang duoc toi uu nhan}
  p: ^TMatrix;   {p^[i, j] la vi tri o (i, j) trong mang Heap^}
  resx, resy, distance, m, n, nHeap: Integer;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for i := 0 to m + 1 do
    for j := 0 to n + 2 do a[i, j] := -1;
  for i := 1 to m do
    begin
      for j := 1 to n do Read(f, a[i, j]);
      Readln(f);
    end;
  for i := 1 to m do a[i, n + 1] := 0;
  Inc(n);
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  New(p); New(Heap);
  FillChar(p^, SizeOf(p^), 0);
  for i := 1 to m do
    for j := 1 to n - 1 do d[i, j] := maxC;
  nHeap := 0;
  for i := 1 to m do
    begin
      d[i, n] := a[i, n];
      Inc(nHeap);
      Heap^[nHeap, 1] := i;
      Heap^[nHeap, 2] := n;
      p^[i, n] := nHeap;
    end;
end;

procedure Adjust(r: Integer);
var
  c: Integer;
  kx, ky, dkey: Integer;
begin
  kx := Heap^[r, 1]; ky := Heap^[r, 2];
  dkey := d[kx, ky];
  while r * 2 <= nHeap do
    begin
      c := r * 2;
      if (c < nHeap) and
         (d[Heap^[c, 1], Heap^[c, 2]] > d[Heap^[c + 1, 1], Heap^[c + 1, 2]])
           then Inc(c);
      if dkey <= d[Heap^[c, 1], Heap^[c, 2]] then Break;
      Heap^[r] := Heap^[c];
      p^[Heap^[r, 1], Heap^[r, 2]] := r;
      r := c;
    end;
  Heap^[r, 1] := kx; Heap^[r, 2] := ky;
  p^[Heap^[r, 1], Heap^[r, 2]] := r;
end;

procedure ChangeLabel(x, y, newLab: Integer);
var
  r, c, kx, ky, dkey: Integer;
begin
  if p^[x, y] = 0 then
    begin
      Inc(nHeap);
      Heap^[nHeap, 1] := x; Heap^[nHeap, 2] := y;
      p^[x, y] := nHeap;
      c := nHeap;
    end
  else c := p^[x, y];
  d[x, y] := newLab;
  dkey := d[x, y];
  r := c div 2;
  while (r > 0) and (d[Heap^[r, 1], Heap^[r, 2]] > dkey) do
    begin
      Heap^[c] := Heap^[r];
      p^[Heap^[c, 1], Heap^[c, 2]] := c;
      c := r; r := r div 2;
    end;
  Heap^[c, 1] := x; Heap^[c, 2] := y;
  p^[x, y] := c;
end;

{procedure PrintMap;
var
  i, j: Integer;
begin
  for i := 1 to m do
    begin
      for j := 1 to n do
        if d[i, j] = maxC then Write('X':4)
        else Write(d[i, j]:4);
      Writeln;
    end;
  Writeln;
end;}

procedure Dijkstra;
var
  di, ux, uy, vx, vy: Integer;
begin
  repeat
    ux := Heap^[1, 1]; uy := Heap^[1, 2];
    Heap^[1] := Heap^[nHeap];
    Dec(nHeap);
    Adjust(1);
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
            ChangeLabel(vx, vy, d[ux, uy] + a[vx, vy]);
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
  Close(f);
end;

begin
  Enter;
  Init;
  Dijkstra;
  Result;
end.
6 5
 5  1  1  1 17
 9  7  7  1 12
 9  2  1  1 10
10 10  1 10 10
10 10  1  2  3
10 10 10 10 10
