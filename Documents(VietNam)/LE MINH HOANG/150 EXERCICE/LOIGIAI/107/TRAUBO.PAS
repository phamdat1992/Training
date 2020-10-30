program HeapDemo; {Thoat toan "Trau cay ngua keo"}
const
  InputFile  = 'IO.INP';
  OutputFile = 'IO.OUT';
  max = 15000;
type
  TArr = array[1..max] of LongInt;
var
  a: TArr;
  b: ^TArr;
  n, nRes: Integer;
  Flag: Byte;

procedure Init;
begin
  n := 0;
  Flag := 0;
end;

procedure Push(V: LongInt);
begin
  if n = max then Exit;
  Inc(n);
  a[n] := V;
end;

procedure Pop;
var
  Value: LongInt;
  i, j: Integer;
begin
  if n = 0 then Exit;
  Value := a[1];
  for i := 2 to n do
    if a[i] > Value then Value := a[i];
  j := 0;
  for i := 1 to n do
    if a[i] <> Value then
      begin
        Inc(j); a[j] := a[i];
      end;
  n := j;
end;

procedure QSort(L, H: Integer);
var
  i, j: Integer;
  Key, temp: LongInt;
begin
  if L >= H then Exit;
  Key := a[L + Random(H - L + 1)];
  i := L; j := H;
  repeat
    while a[i] > Key do Inc(i);
    while a[j] < Key do Dec(j);
    if i <= j then
      begin
        temp := a[i]; a[i] := a[j]; a[j] := temp;
        Inc(i); Dec(j);
      end;
  until i > j;
  QSort(L, j); QSort(i, H);
end;

procedure Solve;
var
  ch: Char;
  i: Integer;
  V, Last: LongInt;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  while not SeekEof(f) do
    begin
      Read(f, ch);
      if ch = '-' then
        begin
          Pop;
          Readln(f);
        end
      else
        begin
          Readln(f, V);
          Push(V);
        end;
    end;
  Close(f);
  QSort(1, n);
  Last := -1;
  nRes := 0;
  New(b);
  for i := 1 to n do
    begin
      V := a[i];
      if V <> Last then
        begin
          Inc(nRes);
          b^[nRes] := V;
        end;
      Last := V;
    end;
end;

procedure Result;
var
  i: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, nRes);
  for i := 1 to nRes do Write(f, b^[i], ' ');
  Close(f);
end;

begin
  Init;
  Solve;
  Result;
end.
+1
+3
+2
+3
-
+4
+4
-
+2
+7
+8
+9
-
