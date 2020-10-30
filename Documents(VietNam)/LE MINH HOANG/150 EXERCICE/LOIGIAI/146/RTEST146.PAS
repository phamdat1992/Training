program RandomTest;
var
  f: Text;
  e: array[0..15000] of LongInt;

procedure Assign(var f: Text; name: string);
begin
  Writeln('Creating ', name , '...');
  System.Assign(f, name);
end;

procedure Sort(L, H: Integer);
var
  tmp, t: LongInt;
  i, j: Integer;
begin
  if L >= H then Exit;
  tmp := e[Random(H - L + 1) + L];
  i := L; j := H;
  repeat
    while e[i] < tmp do Inc(i);
    while e[j] > tmp do Dec(j);
    if i <= j then
      begin
        t := e[i]; e[i] := e[j]; e[j] := t;
        Inc(i); Dec(j);
      end;
  until i > j;
  Sort(L, j); Sort(i, H);
end;

procedure CreateTest(FileName: string; n, m, max: Integer);
var
  i, x, y, m1: Integer;
begin
  e[0] := 0;
  for y := 2 to n do
    begin
      x := Random(y - 1) + 1;
      e[y - 1] := x + LongInt(y) * 10001;
    end;
  for i := n to m do
    begin
      repeat
        x := Random(n) + 1;
        y := Random(n) + 1;
      until x < y;
      e[i] := x + LongInt(y) * 10001;
    end;
  Sort(1, m);
  m1 := 0;
  for i := 1 to m do
    if e[i] <> e[i - 1] then Inc(m1);
  Assign(f, FileName); Rewrite(f);
  Writeln(f, n, ' ', m1);
  for i := 1 to m do
    if e[i] <> e[i - 1] then
      Writeln(f, e[i] mod 10001, ' ', e[i] div 10001, ' ', Random(max + 1));
  Close(f);
end;

begin
  Randomize;
  CreateTest('MST.IN1', 5, 9, 9);
  CreateTest('MST.IN2', 10, 20, 10);
  CreateTest('MST.IN3', 100, 300, 100);
  CreateTest('MST.IN4', 100, 1000, 10000);
  CreateTest('MST.IN5', 1000, 2000, 10000);
  CreateTest('MST.IN6', 1000, 5000, 9999);
  CreateTest('MST.IN7', 3000, 7000, 9999);
  CreateTest('MST.IN8', 4000, 10000, 9999);
  CreateTest('MST.IN9', 9999, 9999, 10000);
  CreateTest('MST.IN0', 10000, 15000, 10000);
end.