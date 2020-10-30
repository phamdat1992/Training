{$N+,E+}
program circle;
const
  InputFile  = 'CIRCLE.INP';
  OutputFile = 'CIRCLE.OUT';
  max = 5000;
var
  d: array[1..2 * max + 1] of LongInt;
  Blue: array[1..2 * max + 1] of Boolean;
  n: Integer;
  Radius: Extended;

procedure Enter;
var
  f: Text;
  i, x, y: LongInt;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    begin
      Readln(f, x, y);
      d[i] := Sqr(x) + Sqr(y);
      blue[i] := True;
    end;
  for i := 1 to n do
    begin
      Readln(f, x, y);
      d[i + n] := Sqr(x) + Sqr(y);
      blue[i + n] := False;
    end;
end;


procedure Swap(i, j: Integer);
var
  t: LongInt;
  b: Boolean;
begin
  t := d[i]; d[i] := d[j]; d[j] := t;
  b := Blue[i]; Blue[i] := Blue[j]; Blue[j] := b;
end;

procedure QSort(L, H: Integer);
var
  t, i, j: Integer;
  tmp: LongInt;
begin
  if L >= H then Exit;
  tmp := d[L + Random(H - L + 1)];
  i := L; j := H;
  repeat
    while d[i] < tmp do Inc(i);
    while d[j] > tmp do Dec(j);
    if i <= j then
      begin
        Swap(i, j);
        Inc(i); Dec(j);
      end;
  until i > j;
  QSort(L, j); QSort(i, H);
end;

procedure GetRadius;
var
  i: Integer;
  Count: Integer;
begin
  Count := 0;
  for i := 1 to 2 * n do
    begin
      if Blue[i] then Inc(Count) else Dec(Count);
      if (d[i] <> d[i + 1]) and (Count = 0) then
        begin
          Radius := d[i];
          Break;
        end;
    end;
  Radius := Sqrt(Radius);
end;

procedure Result;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Radius:1:6);
  Close(f);
end;

begin
  Enter;
  QSort(1, 2 * n);
  GetRadius;
  Result;
end.
4
2 0
0 3
0 -3
4 -4
1 1
0 2
-3 0
-3 3