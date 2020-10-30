program RandomTest;
var
  a: array[1..200, 1..200] of Boolean;
  id, cmp: array[1..200] of Integer;
  n: Integer;

procedure CreateId;
var
  i, j: Integer;
begin
  FillChar(id, SizeOf(id), 0);
  for i := 1 to n do
    begin
      repeat
       j := Random(n) + 1;
      until id[j] = 0;
      id[j] := i;
    end;
end;

procedure CreateCmp(k: Integer);
var
  i: Integer;
begin
  for i := 1 to n do Cmp[i] := Random(k);
end;

procedure CreateMat;
var
  i, j, k: Integer;
begin
  for i := 1 to n do
    for j := 1 to n do
      if (i <> j) and (Random(20) = 1) then
        begin
          if Cmp[i] = Cmp[j] then a[i, j] := True
          else
            if Cmp[i] < Cmp[j] then a[i, j] := True;
        end;
end;

procedure Save;
var
  m, i, j: Integer;
  f: Text;
begin
  m := 0;
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] then Inc(m);
  Assign(f, 'TRAFFIC.IN0'); Rewrite(f);
  Writeln(f, n, ' ', m);
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] then Writeln(f, id[i], ' ', id[j]);
  Close(f);
end;

begin
  Randomize;
  Write('n = '); Readln(n);
  FillChar(a, SizeOf(a), False);
  CreateId;
  CreateCmp(9);
  CreateMat;
  Save;
end.