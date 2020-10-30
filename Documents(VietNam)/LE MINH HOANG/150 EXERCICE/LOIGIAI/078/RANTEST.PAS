uses Crt;
const
  Test: string[10] = '1234567890';
  Length: array[1..10] of Integer = (20, 50, 80, 300, 500, 700, 2000, 5000, 7000, 10000);
  fi = 'chain.in';
  MaxN = 10000;
var
  Index, Eye, Count: array[1..MaxN] of Integer;
  i, j, k, n, m: Integer;
  t: Byte;
  f: Text;

procedure InitIndex;
var
  i: Integer;
begin
  for i := 1 to n do Index[i] := i;
end;

procedure InitCount;
var
  i, n1: Integer;
begin
  n1 := n;
  for i := 1 to m - 1 do
  begin
    Count[i] := Random(n1 div ((m - i + 1) div 2));
    Dec(n1, Count[i]);
  end;
  Count[m] := n1;
end;

procedure RandomTest;
begin
  InitIndex;
  for i := 1 to m do
  begin
    k := Random(n - i + 1) + 1;
    Eye[i] := Index[k];
    Move(Index[k + 1], Index[k], (n - k) shl 1);
    Dec(n);
  end;
  InitCount;
  Assign(f, fi + Test[t]); Rewrite(f);
  Writeln(f, n + m);
  for i := 2 to m do Writeln(f, Eye[i], ' ', Eye[i - 1]);
  for i := 1 to m do
    for j := 1 to Count[i] do
    begin
      k := Random(n) + 1;
      Writeln(f, Eye[i], ' ', Index[k]);
      Move(Index[k + 1], Index[k], (n - k) shl 1 );
      Dec(n);
    end;
  Close(f);
end;

begin
  TextBackGround(0);
  ClrScr;
  Randomize;
  for t := 1 to 10 do
  begin
    TextColor(2);
    Write(fi + Test[t] + ':');
    n := Length[t]; Write('  N = ', n:5);
    m := n div (Random(4) + 4); Write('  M = ', m:4);
    Randomtest;
    TextColor(4);
    Writeln('  Ok!');
  end;
  TextColor(7);
  repeat until keyPressed;
  ClrScr;
end.